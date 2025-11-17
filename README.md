# Uts-STDT

CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

sequenceDiagram
    participant Client
    participant GraphQL_Server
    participant UserService
    participant OrderService

    Client->>GraphQL_Server: Query { user(id:1) { name orders { total } } }
    GraphQL_Server->>UserService: getUser(1)
    UserService-->>GraphQL_Server: { id:1, name:"Rafi" }

    GraphQL_Server->>OrderService: getOrdersByUser(1)
    OrderService-->>GraphQL_Server: [{id:101, total:20000}]

    GraphQL_Server-->>Client: { user:{ name:"Rafi", orders:[{total:20000}] } }
