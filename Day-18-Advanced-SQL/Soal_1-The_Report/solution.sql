with tmp as (
    SELECT
        case
            when grade < 8 then 'NULL'
            else name
        end as name,
        grade,
        marks
    from students s
    join grades g
        on s.marks between g.min_mark and g.max_mark
)

SELECT *
from tmp
order by 
    grade desc, 
    name
