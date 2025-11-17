# Uts-STDT

# nomer 1
CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

# Nomer 2
sequenceDiagram
    participant C as Client (Web/Mobile)
    participant G as GraphQL Gateway
    participant U as User Service
    participant O as Order Service
    participant K as Message Bus<br>(Kafka/RabbitMQ)

    C->>G: Kirim GraphQL Query<br>user(id) & ordersByUser(id)
    G->>U: HTTP/gRPC Request<br>Get User Data
    U-->>G: Return User Response

    G->>O: HTTP/gRPC Request<br>Get Orders by User ID
    O-->>G: Return Orders Response

    Note over G: GraphQL melakukan agregasi data<br>dan membentuk response final

    G-->>C: Hasil Query GraphQL (User + Orders)

    %% Contoh proses asinkron setelah order dibuat
    C->>G: GraphQL Mutation<br>createOrder
    G->>O: Request Create Order
    O-->>G: Confirm Order Created

    O->>K: Publish Event<br>order_created
    K->>U: Deliver Event<br>(Consume order_created)

    U-->>K: Processed Event Ack
