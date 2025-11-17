# Uts-STDT

# nomer 1
CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

# nomer 2
flowchart TD
  subgraph Client
    A[Browser / Mobile Client]
  end

  subgraph Gateway[GraphQL Gateway]
    G(GraphQL Endpoint / Apollo Server)
  end

  subgraph SyncServices[Microservices (synchronous)]
    S1(Service A - Users) -->|HTTP/gRPC| DB1[(User DB)]
    S2(Service B - Orders) -->|HTTP/gRPC| DB2[(Order DB)]
  end

  subgraph AsyncBus[Async Messaging]
    K[Kafka / RabbitMQ]
  end

  A -->|GraphQL Query / Mutation| G
  G -->|Fetch User| S1
  G -->|Fetch Orders| S2
  S2 -->|Publish Event order_created| K
  S1 -->|Consume Event| K

  classDef gateway fill:#f9f,stroke:#333,stroke-width:1px;
  class G gateway;
