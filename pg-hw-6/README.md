# Homework 6 – Weekly Timetable

## Decisions

**One `lesson` row = one cell of the timetable.** It says which class has which subject, with which teacher, in which room, on which day and period. Everything else is just there so `lesson` can point to it.

**One lookup table instead of many small ones.** Weekdays, subjects and rooms are just a name, so instead of 3 almost identical tables I put them all in `lookup_value`, grouped by `lookup` (1 = weekday, 2 = subject, 3 = room). Teachers and classes have more than one field, so they got their own tables.

**Making the lookup safe.** The problem with one shared table is that `room_id = 1` could accidentally point to a subject. To stop that, `lesson` has `room_type_id`, `subject_type_id` and `weekday_type_id` columns. They have a default and a `CHECK` that locks them (room is always 3, and so on). The foreign key is on both columns: `(room_type_id, room_id) → lookup_value(lookup_id, id)`. This way a room id can only point to a room.

**Clashes are blocked by the database, not by me being careful.** There are three UNIQUE constraints on `lesson`, all on `(something, weekday_id, period)`:

- `one_lesson_per_class_slot`: a class can't have 2 lessons at once
- `one_lesson_per_teacher_slot`: a teacher can't be in 2 rooms at once
- `one_class_per_room_slot`: a room can't hold 2 classes at once

**Weekday is a lookup, not text.** Because it has an id, Monday–Friday sort in the right order, a 6th day doesn't exist, and I can list every possible slot (days × `generate_series(1, 7)`) to find when a room is free.

**Period is just a number 1–7** with a `CHECK`. I didn't store bell times because no query needs them.

**No dates.** The timetable is the same every week, so a DATE column would be wrong.

**`(grade, class)` is unique**, so there can't be two 11A classes.

**Not stored on purpose:** students, and which teacher is allowed to teach which subject. None of the questions need them.

## Proof it works

11A already has a lesson on Monday, period 1:

```sql
INSERT INTO lesson (class_id, teacher_id, period, weekday_id, subject_id, room_id)
VALUES (1, 4, 1, 1, 3, 3);
```

```
ERROR:  duplicate key value violates unique constraint "one_lesson_per_class_slot"
DETAIL:  Key (class_id, weekday_id, period)=(1, 1, 1) already exists.
```

These also fail:

- class 99: `lesson_class_id_fkey`
- period 8: `lesson_period_check`
- weekday 6: `lesson_lookup_weekday_fkey`
