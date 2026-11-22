with tmp as (
    select
        w.id,
        w.code,
        w.coins_needed,
        w.power,
        wp.age,
        wp.is_evil,
        min(w.coins_needed) over (
            partition by wp.age, w.power
        ) as coins_min
    from wands w
    join wands_property wp
        on w.code = wp.code
    where wp.is_evil = 0
)

select
    id,
    age,
    coins_needed,
    power
from tmp
where coins_needed = coins_min
order by
    power desc,
    age desc;
