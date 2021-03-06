STP (Spanning Tree Protocol)  Протокол связующего (основного) дерева


 - Radia Perlman
 - Автоматическое отключение дублирующих сооединений в Ethernet
 - Связующее дерево - подграф без циклов, содержащий все вершины исходного графа
 - IEEE 802.1D
 - Надежность соединений между коммутаторами 
 - Защита от ошибок конфигурации
 - L2
 - BPDU (Bridge Protocol Data Units) отправляются каждые 2 сек на групповой адрес STP 01:80:C2:00:00:00
 - Переход от Listening до Forwarding - 30 сек. т.е.достаточно долго для современных сетей
----
Этапы
 - Выбор корневого коммутатора
 - Определение кратчайших путей до корневого коммутатора (количество промежуточных коммутаторов и скорость соединения)
 - Отключение всех остальных соединений
----
Расчет кратчайших путей в STP IEEE 802.1D
- 4  Mbit/s  - 250
- 10  Mbit/s - 100
- 16  Mbit/s - 62
- 100 Mbit/s - 19
- 1   Gbit/s - 4
- 2   Gbit/s - 3
- 10  Gbit/s - 2
----
Состояния портов
 - Lisening - порт обрабатывает BPDU, данные не передаются
 - Learning - порт не передает кадры, но изучает MAC-адреса в поступающих кадрах и формирует таблицу коммутации
 - Forwarding - порт принимает и передает данные и BPDU
 - Blocking - порт заблокирован чтобы избежать кольца
 - Disabled - порт выключен админом
----
Виды
 - RSTP (Rapid Spanning Tree Protocol)
   - улучшенная версия STP
   - срабатывает быстрее при подключении оборудования и изменения конфигуации сети (пару сек.)
   - IEEE 802.1w
 - STP и VLAN
   - Multiple Spanning Tree Protocol (MSTP) 802.1s
   - Отдельное связующее дерево для каждого VLAN
   
