# Uts-STDT

CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

+----------------+
|                |
|     Client     |
| (Web/Mobile App)|
|                |
+-------+--------+
        |
        | HTTP/HTTPS (GraphQL Query)
        V
+---------------------+
|                     |
|  GraphQL Gateway    |
| (API Agregator/Edge)|
|                     |
+---+--------+--------+
    |        |        |
    |        |        | Internal RPC (gRPC, REST, Message Queues)
    V        V        V
+---------+  +----------+  +----------+  +---------+
|         |  |          |  |          |  |         |
| Auth    |  | Product  |  | Order    |  | User    |
| Service |  | Service  |  | Service  |  | Database|
|         |  |          |  |          |  |         |
+---------+  +----------+  +----------+  +---------+
