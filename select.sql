-- 1.количество исполнителей в каждом жанре;
SELECT genres_name, COUNT(singer_id) cs FROM genres g 
LEFT JOIN singer_genres sg ON g.genres_id = sg.genres_id 
GROUP BY g.genres_name 
ORDER BY cs DESC;

-- 2.количество треков, вошедших в альбомы 2019-2020 годов;
SELECT a.release_date, COUNT(track_id) ct FROM album a 
LEFT JOIN track t ON a.album_id = t.album_id 
WHERE a.release_date BETWEEN 2019 AND 2020
GROUP BY a.release_date
ORDER BY ct DESC; 

-- 3.средняя продолжительность треков по каждому альбому;
SELECT a.album_name, AVG(track_time) att FROM album a 
LEFT JOIN track t ON a.album_id = t.album_id
GROUP BY a.album_name
ORDER BY att DESC;

-- 4.все исполнители, которые не выпустили альбомы в 2020 году;
SELECT singer_name sn FROM singer s 
JOIN album_singer als ON s.singer_id = als.singer_id 
JOIN album a ON als.album_id = a.album_id 
WHERE a.release_date != 2020
GROUP BY sn
ORDER BY sn;

-- 5.названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT collection_name cn FROM collection c 
JOIN collection_track ct ON c.collection_id = ct.collection_id 
JOIN track t ON ct.track_id = t.track_id 
JOIN album a ON t.album_id = a.album_id 
JOIN album_singer als ON a.album_id = als.album_id 
JOIN singer s ON als.singer_id = s.singer_id 
WHERE s.singer_name LIKE '%Король и шут%'
GROUP BY cn;

-- 6.название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT a.album_name FROM album a 
JOIN album_singer als ON a.album_id = als.album_id 
JOIN singer s ON als.singer_id = s.singer_id 
JOIN singer_genres sg ON s.singer_id = sg.singer_id 
JOIN genres g ON sg.genres_id = g.genres_id 
GROUP BY a.album_name
HAVING COUNT(DISTINCT g.genres_name) > 1
ORDER BY a.album_name DESC;

-- 7.наименование треков, которые не входят в сборники;
SELECT track_name FROM track t 
LEFT JOIN collection_track ct ON t.track_id = ct.track_id 
WHERE ct.track_id IS NULL;

--8.исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT singer_name sn, t.track_time FROM singer s 
JOIN album_singer als ON s.singer_id = als.singer_id 
JOIN album a ON als.album_id = a.album_id 
JOIN track t ON a.album_id = t.album_id 
WHERE t.track_time = (
	SELECT MIN(track_time)
	FROM track)
GROUP BY sn, t.track_time
ORDER BY t.track_time DESC; 

--9.название альбомов, содержащих наименьшее количество треков.
SELECT a.album_name FROM album a 
JOIN track t ON a.album_id = t.album_id 
GROUP BY a.album_name
HAVING COUNT(t.track_name) = (
	SELECT COUNT(t.track_name) FROM track
	ORDER BY COUNT(t.track_name) LIMIT 1);




  

