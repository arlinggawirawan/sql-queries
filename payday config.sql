SELECT a.category, a.key, a.value
FROM komodo.configs a
where a.category in
('industry', 'occupation', 'salary_method', 'work');