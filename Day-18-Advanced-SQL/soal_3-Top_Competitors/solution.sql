with tmp as (
    select
        h.hacker_id,
        h.name,
        s.challenge_id,
        s.score,
        d.score as max_score
    from hackers h
    join submissions s
        on h.hacker_id = s.hacker_id
    join challenges c
        on s.challenge_id = c.challenge_id
    JOIN difficulty d
        on c.difficulty_level = d.difficulty_level
),

full_score as (
    select
        hacker_id,
        name,
        challenge_id
    from tmp
    where score = max_score
)

select
    hacker_id,
    name
from full_score
group by
    hacker_id,
    name
having count(distinct challenge_id) > 1
order by
    count(distinct challenge_id) desc,
    hacker_id
