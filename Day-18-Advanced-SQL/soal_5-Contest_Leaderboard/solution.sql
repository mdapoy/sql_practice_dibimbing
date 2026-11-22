with max_scores as (
    select
        hacker_id,
        challenge_id,
        max(score) as max_score
    from Submissions
    group by hacker_id, challenge_id
),
hacker_scores as (
    select
        h.hacker_id,
        h.name,
        m.max_score
    from Hackers h
    join max_scores m
        on h.hacker_id = m.hacker_id
)
select
    hacker_id,
    name,
    sum(max_score) as score
from hacker_scores
group by hacker_id, name
having sum(max_score) > 0
order by
    score DESC,
    hacker_id;
