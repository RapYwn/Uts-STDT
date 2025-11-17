# Uts-STDT

# nomer 1
CAP (Consistency, Availability, Partition tolerance) teorema yang menyatakan pada sistem terdistribusi, pada saat terjadi partisi jaringan (network partition), sebuah sistem hanya bisa menjamin dua dari tiga properti berikut secara bersamaan
Contoh : 
- Sistem perbankan (favor C over A): Lebih baik menolak transaksi (menurun availability) daripada membiarkan inconsistent balances.
- Sosial media timeline (favor A over C): Lebih baik menampilkan konten meskipun mungkin belum konsisten di semua node.

BASE (Basically Available, Soft state, Eventual consistency) adalah filosofi desain database terdistribusi yang berlawanan gaya dengan ACID tradisional
Misalkan sebuah layanan komentar pada posting (microblog). Kita punya 3 node database terdistribusi dan satu pembaca menulis komentar baru ke Node A

# Nomer 2
flowchart TD

  %% Client Section
  subgraph Client
    A[Client App<br>(Web / Mobile)]
  end

  %% GraphQL Gateway
  subgraph Gateway[GraphQL API Gateway]
    G(GraphQL Server / Apollo / Yoga)
  end

  %% Microservices block
  subgraph Microservices[Distributed Microservices]
    direction LR
    S1[Service User<br>REST / gRPC] --> DB1[(User DB)]
    S2[Service Order<br>REST / gRPC] --> DB2[(Order DB)]
  end

  %% Message broker
  subgraph MessageBus[Message Bus (Async IPC)]
    K[Kafka / RabbitMQ]
  end

  %% Flows
  A -->|GraphQL Query / Mutation| G
  G -->|Fetch user data| S1
  G -->|Fetch order data| S2

  S2 -->|Publish event: order_created| K
  S1 -->|Consume event| K

  %% Styling
  classDef gateway fill:#f9f,stroke:#333,stroke-width:1px,border-radius:6px;
  class G gateway;
