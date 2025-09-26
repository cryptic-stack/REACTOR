# REACTOR - Portable SIEM Stack

A complete Docker-based Security Information and Event Management (SIEM) solution for cybersecurity professionals, researchers, and organizations.

## 🚀 Features

REACTOR provides a comprehensive security monitoring and incident response platform with the following components:

### Core Components
- **Elasticsearch** - Search and analytics engine for log data
- **Kibana** - Data visualization and dashboard platform
- **Logstash** - Data processing and ingestion pipeline
- **Nginx** - Reverse proxy with SSL termination

### Security Tools
- **Arkime** - Full packet capture and network traffic analysis
- **Zeek** - Network security monitoring framework
- **The Hive** - Security incident response platform
- **Cortex** - Observable analysis engine
- **MISP** - Malware information sharing platform
- **MITRE Caldera** - Automated adversary emulation framework

### Infrastructure
- **RabbitMQ** - Message broker for reliable data processing
- **MySQL** - Database backend for MISP

## 📋 Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- At least 8GB RAM (16GB recommended)
- 50GB free disk space
- Linux/macOS/Windows with WSL2

## 🔧 Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/cryptic-stack/REACTOR.git
   cd REACTOR
   ```

2. **Start the stack:**
   ```bash
   ./scripts/start.sh
   ```

3. **Initialize services:**
   ```bash
   ./scripts/init-all.sh
   ```

4. **Add DNS entries to your `/etc/hosts` file:**
   ```
   127.0.0.1 reactor.local
   127.0.0.1 kibana.reactor.local
   127.0.0.1 thehive.reactor.local
   127.0.0.1 misp.reactor.local
   127.0.0.1 caldera.reactor.local
   127.0.0.1 arkime.reactor.local
   ```

## 🌐 Access URLs

| Service | URL | Default Credentials |
|---------|-----|-------------------|
| Main Dashboard | https://localhost | elastic / ReactorElastic123! |
| Kibana | https://kibana.reactor.local | elastic / ReactorElastic123! |
| The Hive | https://thehive.reactor.local | admin@reactor.local / ReactorHive123! |
| Cortex | http://localhost:9001 | admin@reactor.local / ReactorCortex123! |
| MISP | https://misp.reactor.local | admin@reactor.local / ReactorMisp123! |
| Caldera | https://caldera.reactor.local | red/ReactorCalderaRed123! |
| Arkime | https://arkime.reactor.local | admin / ReactorArkime123! |
| RabbitMQ | http://localhost:15672 | reactor / ReactorRabbit123! |

## 📊 Default Users and Passwords

### Elasticsearch/Kibana
- **Username:** elastic
- **Password:** ReactorElastic123!

### The Hive
- **Username:** admin@reactor.local
- **Password:** ReactorHive123!

### Cortex
- **Username:** admin@reactor.local
- **Password:** ReactorCortex123!

### MISP
- **Username:** admin@reactor.local
- **Password:** ReactorMisp123!

### Caldera
- **Red Team:** red / ReactorCalderaRed123!
- **Blue Team:** blue / ReactorCalderaBlue123!

### Arkime
- **Username:** admin
- **Password:** ReactorArkime123!

### RabbitMQ
- **Username:** reactor
- **Password:** ReactorRabbit123!

## 🛠️ Management Scripts

| Script | Purpose |
|--------|---------|
| `scripts/start.sh` | Start all services |
| `scripts/stop.sh` | Stop all services |
| `scripts/status.sh` | Check service status |
| `scripts/init-all.sh` | Initialize all services |

## 📁 Configuration

All service configurations are stored in the `config/` directory:

```
config/
├── elasticsearch/     # Elasticsearch configuration
├── kibana/           # Kibana configuration
├── logstash/         # Logstash pipelines and config
├── nginx/            # Reverse proxy configuration
├── zeek/             # Zeek network monitoring rules
├── arkime/           # Arkime packet capture config
├── thehive/          # The Hive incident response
├── cortex/           # Cortex observable analysis
├── misp/             # MISP threat intelligence
├── caldera/          # Caldera adversary emulation
└── rabbitmq/         # Message broker configuration
```

## 🔒 Security Considerations

### Development vs Production

This configuration is designed for **development and testing environments**. For production use:

1. **Change all default passwords**
2. **Use proper SSL certificates** (replace self-signed certs in `certs/`)
3. **Enable authentication** on all services
4. **Configure firewalls** and network segmentation
5. **Enable audit logging**
6. **Regular security updates**

### SSL/TLS Configuration

The stack uses self-signed certificates for development. Replace certificates in the `certs/` directory for production use.

## 📈 Monitoring and Logging

### Log Sources
- System logs via Syslog (TCP/UDP 5000)
- Beats input (TCP 5044)
- HTTP input (TCP 8080)
- Zeek network logs
- Application logs from all services

### Index Patterns
- `reactor-logs-*` - General application logs
- `reactor-zeek-*` - Zeek network monitoring logs
- `reactor-beats-*` - Beats agent logs

## 🔍 Threat Intelligence Integration

REACTOR integrates multiple threat intelligence sources:

1. **MISP** - Malware information sharing
2. **Zeek Intel Framework** - Network-based indicators
3. **Cortex Analyzers** - Observable analysis
4. **Custom feeds** - Add your own indicators

## ⚡ Performance Tuning

### Memory Requirements
- **Minimum:** 8GB RAM
- **Recommended:** 16GB+ RAM
- **Heavy usage:** 32GB+ RAM

### Disk Space
- **Logs retention:** Configure in Elasticsearch
- **PCAP storage:** Configure Arkime retention
- **Database growth:** Monitor MISP/Hive databases

## 🐛 Troubleshooting

### Common Issues

1. **Services not starting:**
   ```bash
   docker-compose logs [service-name]
   ```

2. **Elasticsearch memory errors:**
   - Increase Docker memory limit
   - Adjust `ES_JAVA_OPTS` in docker-compose.yml

3. **SSL certificate errors:**
   - Regenerate certificates in `certs/` directory
   - Add hostnames to `/etc/hosts`

4. **Permission errors:**
   ```bash
   sudo chown -R $USER:$USER .
   chmod +x scripts/*.sh
   ```

### Service Dependencies

Services start in the following order:
1. Elasticsearch, RabbitMQ, MISP-DB
2. Kibana, Logstash, MISP
3. The Hive, Cortex
4. Arkime, Zeek, Caldera
5. Nginx

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Elastic Stack (Elasticsearch, Kibana, Logstash)
- Arkime Network Forensics
- Zeek Network Security Monitor
- The Hive Project
- MISP Project
- MITRE Caldera
- Docker Community

## 📞 Support

For issues and questions:
1. Check the [troubleshooting section](#-troubleshooting)
2. Review [GitHub Issues](https://github.com/cryptic-stack/REACTOR/issues)
3. Create a new issue with detailed information

---

**⚠️ Security Notice:** This stack contains powerful security tools. Use responsibly and in accordance with all applicable laws and regulations.
