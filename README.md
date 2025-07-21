# Albion Arbitrage Calculator

Sistema completo de cálculo de arbitragem para Albion Online, com backend Node.js + TypeScript e frontend React + Material-UI.

## 🚀 Tecnologias

### Backend

- **Node.js** + **TypeScript**
- **Express** - Framework web
- **PostgreSQL** - Banco de dados principal
- **Redis** - Cache em tempo real
- **NATS** - Sistema de mensageria para dados do Albion
- **Socket.io** - Comunicação em tempo real

### Frontend

- **React** + **TypeScript**
- **Vite** - Build tool
- **Material-UI** - Componentes UI
- **React Router** - Navegação
- **Axios** - Cliente HTTP
- **Recharts** - Gráficos

## 📋 Pré-requisitos

- Node.js 18+
- PostgreSQL 12+
- Redis 6+
- NATS Server (opcional)

## 🛠️ Instalação

### 1. Clone o repositório

```bash
git clone <repository-url>
cd novo-site-precos
```

### 2. Instale as dependências do backend

```bash
npm install
```

### 3. Instale as dependências do frontend

```bash
cd frontend
npm install
cd ..
```

### 4. Configure o banco de dados

#### PostgreSQL

```sql
-- Conecte ao PostgreSQL
psql -U postgres

-- Crie o banco de dados
CREATE DATABASE albion_arbitrage;

-- Conecte ao banco criado
\c albion_arbitrage

-- Execute os scripts SQL (veja pasta sql/)
```

#### Redis

```bash
# Inicie o Redis na porta 6380
redis-server --port 6380
```

### 5. Configure as variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=albion_arbitrage
DB_USER=postgres
DB_PASSWORD=sua_senha

# Redis
REDIS_URL=redis://localhost:6380

# NATS
NATS_SERVERS=nats://localhost:4222

# Server
PORT=5000
FRONTEND_URL=http://localhost:3000
```

## 🚀 Executando o projeto

### Desenvolvimento

#### Backend apenas

```bash
npm run dev
```

#### Frontend apenas

```bash
cd frontend
npm run dev
```

#### Backend + Frontend (recomendado)

```bash
npm run dev:full
```

### Produção

#### Build do backend

```bash
npm run build
npm start
```

#### Build do frontend

```bash
cd frontend
npm run build
```

## 📊 Estrutura do Projeto

```
novo-site-precos/
├── src/
│   ├── app.ts                 # Aplicação principal
│   ├── routes/                # Rotas da API
│   │   ├── arbitrageRoutes.ts
│   │   └── marketRoutes.ts
│   ├── services/              # Serviços
│   │   ├── arbitrage_service.ts
│   │   ├── database_service.ts
│   │   ├── nats_service.ts
│   │   └── redis_service.ts
│   └── utils/
│       └── logger.ts
├── frontend/
│   ├── src/
│   │   ├── components/        # Componentes React
│   │   │   └── Header.tsx
│   │   ├── pages/            # Páginas da aplicação
│   │   │   ├── Dashboard.tsx
│   │   │   ├── Arbitrage.tsx
│   │   │   ├── Market.tsx
│   │   │   └── Settings.tsx
│   │   ├── services/         # Serviços de API
│   │   │   └── api.ts
│   │   ├── App.tsx           # Componente principal
│   │   └── main.tsx          # Entry point
│   ├── package.json
│   └── vite.config.ts
├── package.json
└── tsconfig.json
```

## 🔌 APIs Disponíveis

### Market APIs

- `GET /api/market/ingredients` - Lista ingredientes
- `GET /api/market/cities` - Lista cidades
- `GET /api/market/prices` - Preços de mercado
- `GET /api/market/price-history` - Histórico de preços

### Arbitrage APIs

- `GET /api/arbitrage/top` - Top oportunidades
- `GET /api/arbitrage/filtered` - Oportunidades filtradas
- `GET /api/arbitrage/filters-info` - Informações de filtros

## 🎯 Funcionalidades

### Dashboard

- Visão geral das oportunidades
- Estatísticas em tempo real
- Status do sistema

### Arbitragem

- Lista de oportunidades de arbitragem
- Filtros avançados
- Cálculo de lucro
- Tabela responsiva

### Mercado

- Dados de ingredientes
- Preços por cidade
- Histórico de preços
- Informações de qualidade

### Configurações

- Status do sistema
- Informações da aplicação
- Configurações de desenvolvimento

## 🔧 Configuração Avançada

### NATS (Dados em Tempo Real)

Para receber dados em tempo real do Albion Data Project:

1. Instale o NATS Server
2. Configure as credenciais no `.env`
3. O sistema automaticamente se conectará e processará os dados

### Banco de Dados

O sistema usa PostgreSQL para:

- Armazenar ingredientes e cidades
- Registrar preços de mercado
- Calcular oportunidades de arbitragem
- Manter histórico de preços

### Cache Redis

O Redis é usado para:

- Cache de dados frequentes
- Sessões de usuário
- Dados em tempo real

## 🐛 Troubleshooting

### Erro de conexão com PostgreSQL

```bash
# Verifique se o PostgreSQL está rodando
pg_ctl status

# Verifique as credenciais no .env
# Teste a conexão
psql -h localhost -U postgres -d albion_arbitrage
```

### Erro de conexão com Redis

```bash
# Verifique se o Redis está rodando na porta 6380
redis-cli -p 6380 ping

# Se não estiver, inicie:
redis-server --port 6380
```

### Erro de NATS

O sistema funciona sem NATS, mas sem dados em tempo real. Para resolver:

1. Instale NATS Server
2. Configure as credenciais
3. Verifique a conectividade

## 📝 Scripts SQL

Execute estes scripts no PostgreSQL para criar as tabelas:

```sql
-- Tabela de ingredientes
CREATE TABLE alchemy_ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    item_type_id VARCHAR(255) UNIQUE NOT NULL,
    tier INTEGER NOT NULL,
    enchantment INTEGER DEFAULT 0
);

-- Tabela de cidades
CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL
);

-- Tabela de preços de mercado
CREATE TABLE market_prices (
    id SERIAL PRIMARY KEY,
    item_type_id VARCHAR(255) NOT NULL,
    city_id INTEGER REFERENCES cities(id),
    quality INTEGER DEFAULT 1,
    sell_price_min INTEGER,
    sell_price_max INTEGER,
    buy_price_max INTEGER,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de oportunidades de arbitragem
CREATE TABLE arbitrage_opportunities (
    id SERIAL PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    buy_city VARCHAR(255) NOT NULL,
    sell_city VARCHAR(255) NOT NULL,
    buy_price INTEGER NOT NULL,
    sell_price INTEGER NOT NULL,
    profit INTEGER NOT NULL,
    profit_percentage DECIMAL(5,2) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de histórico de preços
CREATE TABLE price_history (
    id SERIAL PRIMARY KEY,
    item_type_id VARCHAR(255) NOT NULL,
    city_id INTEGER REFERENCES cities(id),
    quality INTEGER DEFAULT 1,
    price INTEGER NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença ISC. Veja o arquivo `LICENSE` para mais detalhes.

## 🆘 Suporte

Se você encontrar algum problema ou tiver dúvidas:

1. Verifique a seção de troubleshooting
2. Consulte os logs do console
3. Verifique se todas as dependências estão instaladas
4. Confirme se as configurações do `.env` estão corretas

## 🎮 Albion Online

Este projeto é uma ferramenta para jogadores de Albion Online que desejam:

- Identificar oportunidades de arbitragem
- Monitorar preços de mercado
- Analisar tendências de preços
- Maximizar lucros no mercado

**Nota:** Este é um projeto educacional e não está afiliado oficialmente ao Albion Online.
