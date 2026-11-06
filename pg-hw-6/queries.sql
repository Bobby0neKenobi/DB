SELECT
  l.id,
  w.value AS weekday,
  l.period,
  c.grade || '"' || c.class || '"' AS class,
  t.first_name || ' ' || t.last_name AS teacher,
  s.value AS subject,
  r.value AS room
FROM
  lesson l
  JOIN class c
    ON c.id = l.class_id
  JOIN teacher t
    ON t.id = l.teacher_id
  JOIN lookup_value w
    ON w.lookup_id = l.weekday_type_id
	  AND w.id = l.weekday_id
  JOIN lookup_value s
    ON s.lookup_id = l.subject_type_id
	  AND s.id = l.subject_id
  JOIN lookup_value r
    ON r.lookup_id = l.room_type_id
	  AND r.id = l.room_id
  WHERE
  	c.grade || '"' || c.class || '"' = '11"B"'
	  AND w.value = 'Monday'
  ORDER BY
    l.weekday_id ASC, 
		l.class_id DESC,
  	l.period ASC;

SELECT
  l.id,
  w.value AS weekday,
  l.period,
  c.grade || '"' || c.class || '"' AS class,
  t.first_name || ' ' || t.last_name AS teacher,
  s.value AS subject,
  r.value AS room
FROM
  lesson l
  JOIN class c
    ON c.id = l.class_id
  JOIN teacher t
    ON t.id = l.teacher_id
  JOIN lookup_value w
    ON w.lookup_id = l.weekday_type_id
	AND w.id = l.weekday_id
  JOIN lookup_value s
    ON s.lookup_id = l.subject_type_id
	AND s.id = l.subject_id
  JOIN lookup_value r
    ON r.lookup_id = l.room_type_id
	  AND r.id = l.room_id
  WHERE
  	r.value = '105'
  ORDER BY
    l.weekday_id ASC, 
	  l.class_id DESC,
  	l.period ASC;

SELECT
  w.id,
  w.value AS weekday,
  p.period
FROM
  lookup_value w
  CROSS JOIN generate_series(1, 7) AS p(period)
  WHERE
    w.lookup_id = 1
EXCEPT
SELECT
  w.id,
  w.value AS weekday,
  l.period
FROM
  lesson l
  JOIN lookup_value w
  	ON w.id = l.weekday_id
  JOIN lookup_value r
    ON r.id = l.room_id
  WHERE
    r.value = '105'
  ORDER BY
    id,
    period;
