with tmp as (
    select
        w.id,
        w.code,
        w.coins_needed,
        w.power,
        wp.age,
        wp.is_evil
    from wands w
    join wands_property wp
        on w.code = wp.code
),

min_coins as (
    select
        age,
        power,
        min(coins_needed) as min_coins
    from tmp
    where is_evil = 0
    group by age, power
)

select
    t.id,
    t.age,
    t.coins_needed,
    t.power
from tmp t
join min_coins m
    on t.age = m.age
    and t.power = m.power
    and t.coins_needed = m.min_coins
where t.is_evil = 0
order by
    t.power desc,
    t.age desc;
