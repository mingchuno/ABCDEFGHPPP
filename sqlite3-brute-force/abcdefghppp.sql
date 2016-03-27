CREATE TEMP TABLE digits (n INT PRIMARY KEY);
INSERT INTO digits VALUES (0), (2), (3), (4), (5), (6), (7), (8), (9);

SELECT (10*a.n+b.n) || '-' || (10*c.n+d.n) || '=' || (10*e.n+f.n) || '+' || (10*g.n+h.n) || '=111'
    FROM digits e
    JOIN digits f ON e.n <> f.n
    JOIN digits g ON g.n NOT IN (e.n, f.n, 0)
    JOIN digits h ON h.n NOT IN (e.n, f.n, g.n) AND (10*e.n+f.n) + (10*g.n+h.n) = 111
    JOIN digits a ON a.n NOT IN (e.n, f.n, g.n, h.n, 0)
    JOIN digits b ON b.n NOT IN (e.n, f.n, g.n, h.n, a.n)
    JOIN digits c ON c.n NOT IN (e.n, f.n, g.n, h.n, a.n, b.n, 0)
    JOIN digits d ON d.n NOT IN (e.n, f.n, g.n, h.n, a.n, b.n, c.n) AND (10*a.n+b.n) - (10*c.n+d.n) == (10*e.n+f.n)
WHERE e.n <> 0;

