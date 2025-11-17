# Uts-STDT

# nomer 1
CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

# nomer 2
README.md
docker-compose.yml
primary/
└─ init-primary.sql
replica/
└─ entrypoint-replica.sh
└─ create-replica.conf.template
.env
sequenceDiagram
participant Client
participant GraphQL_Gateway as Gateway
participant SvcA
participant SvcB
participant Cache


Client->>Gateway: GraphQL query { post(id:1) { id, author { name }, comments { text } }}
Gateway->>Cache: check cache for post:1
alt hit
Cache-->>Gateway: cached post
else miss
Gateway->>SvcA: GET /posts/1 (HTTP/gRPC)
Gateway->>SvcB: GET /posts/1/comments (HTTP/gRPC)
SvcA-->>Gateway: post-data
SvcB-->>Gateway: comments-data
Gateway->>Cache: store aggregated result
end
Gateway-->>Client: merged response JSON

# nomer 3
POSTGRES_PASSWORD=postgrespw
REPLICATION_USER=replicator
REPLICATION_PASSWORD=replicapw
PG_MAJOR=15
