# OpenAI Terminal Assistant

A Bash script that integrates OpenAI's API into your terminal workflow. It accepts system and user prompts, interacts with OpenAI models, and returns concise text responses. Results can be piped into other tools like **Gotify** for mobile notifications.

## Bring AI to Your Terminal

Unleash the power of AI directly from your terminal! This script integrates OpenAI's API with everyday tools and commands, making it easier to analyze logs, summarize reports, monitor systems, and optimize your workflows—all from the command line.

With just a few keystrokes, you can:

- Automate tedious analysis tasks.
- Gain actionable insights from raw data.
- Simplify complex logs and outputs into clear summaries.
- Leverage AI-powered assistance to manage and monitor your system efficiently.

Say goodbye to manual parsing and hello to smarter, faster terminal operations with **OpenAI Terminal Assistant**!

---

## Features

- **Prompt Flexibility**: Supports system and user prompts, either inline or from files.
- **Customizable AI Model**: Choose from various OpenAI models (`gpt-4o`, `gpt-4o-mini`, etc.).
- **Cross-Platform**: Compatible with Linux, macOS, and Windows (via WSL or Git Bash).
- **Easy Installation**: Installable with a single command.

---

## Installation Instructions

### Prerequisites

Ensure you have the following tools installed:

- **curl**: For making API requests.
- **jq**: For JSON parsing and formatting.
- **sed**: For processing text efficiently.

#### Ubuntu/Linux

Ensure `curl`, `jq` and `sed` are installed:

```bash
sudo apt update && sudo apt install curl jq sed -y
```

#### macOS

Install **Homebrew** if not already installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install `curl`, `jq` and `sed`:

```bash
brew install curl jq sed
```

#### Windows (via WSL or Git Bash)

Install `curl`, `jq` and `sed`:

```bash
sudo apt update && sudo apt install curl jq sed -y
```

---

### One-Liner Installation

Run the following command to download, install, and set up the script:

```bash
curl -o /usr/local/bin/openai https://raw.githubusercontent.com/worthable/openai-terminal-assistant/master/openai.sh && chmod +x /usr/local/bin/openai
```

### Configure OpenAI API Key

1. Add your API key to your `.bashrc` or `.zshrc` file:

   ```bash
   echo "export OPENAI_API_KEY=your_openai_api_key" >> ~/.bashrc
   source ~/.bashrc
   ```

2. For macOS users with Zsh:

   ```bash
   echo "export OPENAI_API_KEY=your_openai_api_key" >> ~/.zshrc
   source ~/.zshrc
   ```

3. For Windows (Git Bash):
   ```bash
   echo "export OPENAI_API_KEY=your_openai_api_key" >> ~/.bash_profile
   source ~/.bash_profile
   ```

---

## Usage

### Basic Syntax

```bash
openai <system-prompt or system-prompt-file-path.prompt> <human-prompt or human-prompt-file-path.prompt> [--model=gpt-4] [--temperature=0.7]
```

### Examples

#### Summarize a File

```bash
cat example.txt | openai "You are a summarization assistant." "Summarize this text into bullet points." | gotify
```

#### Inline Prompts

```bash
openai "You are a productivity assistant." "Reorganize these tasks based on urgency." --model=gpt-4 --temperature=0.8
```

#### Using Prompt Files

```bash
openai system-prompt.txt human-prompt.txt --model=gpt-4o-mini --temperature=0.7
```

---

## Advanced Configuration

### Change Default Model or Temperature

Modify the script to set your default model and temperature:

```bash
MODEL="gpt-4o"
TEMPERATURE="0.7"
```

## Real-World Scenarios with API Requests, Logs, and Gotify Integration

- **Fetch Latest News and Summarize**: Use `curl` to fetch news articles, summarize, and send to your mobile via Gotify.

  ```bash
  curl -s "https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_NEWS_API_KEY" | openai "You are a summarization assistant." "Summarize the top news headlines in bullet points." | gotify
  ```

- **Summarize System Logs**: Analyze critical system logs with `grep` and summarize issues.

  ```bash
  grep "CRITICAL" /var/log/syslog | openai "You are a system monitoring assistant." "Summarize the critical system logs." | gotify
  ```

- **Monitor Disk Usage**: Check disk space usage and summarize any partitions running low on space.

  ```bash
  df -h | openai "You are a system monitoring assistant." "Summarize disk partitions with low free space." | gotify
  ```

- **Fetch Weather Data and Summarize**: Use `curl` to fetch raw weather data, summarize the forecast, and notify your mobile.

  ```bash
  curl -s "https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY" | openai "You are a weather assistant." "Summarize today's weather forecast." | gotify
  ```

- **Analyze Application Logs**: Use `tail` to monitor application logs in real-time and summarize issues.

  ```bash
  tail -n 50 /var/log/myapp.log | openai "You are a log analysis assistant." "Summarize the errors and warnings in these application logs." | gotify
  ```

- **Summarize Running Processes**: Use `ps` to check running processes and summarize CPU-intensive ones.

  ```bash
  ps aux | sort -nrk 3,3 | head -n 10 | openai "You are a system assistant." "Summarize the top CPU-consuming processes." | gotify
  ```

- **Monitor Network Activity**: Use `netstat` to list active connections and summarize any suspicious activity.

  ```bash
  netstat -ant | openai "You are a network monitoring assistant." "Summarize suspicious or unusual network activity." | gotify
  ```

- **Analyze Firewall Logs**: Extract blocked attempts from firewall logs and summarize trends.

  ```bash
  grep "BLOCKED" /var/log/firewall.log | openai "You are a security assistant." "Summarize blocked attempts and any trends from the firewall logs." | gotify
  ```

- **Fetch and Summarize GitHub Notifications**: Use `curl` to fetch GitHub notifications and summarize.

  ```bash
  curl -s -H "Authorization: token YOUR_GITHUB_TOKEN" https://api.github.com/notifications | openai "You are a GitHub assistant." "Summarize the unread notifications." | gotify
  ```

- **Track Uptime and Summarize Issues**: Use `uptime` to fetch system performance and notify high load averages.

  ```bash
  uptime | openai "You are a system performance assistant." "Summarize system load and performance issues." | gotify
  ```

- **Tailscale Exit Node Status**: Check the status of Tailscale and summarize exit node availability.

  ```bash
  tailscale status | openai "You are a Tailscale assistant." "Summarize the status of exit nodes and their availability." | gotify
  ```

- **Check and Summarize Active SSH Sessions**: Monitor active SSH sessions and summarize connections.

  ```bash
  who | grep ssh | openai "You are a system assistant." "Summarize the active SSH sessions including users and hostnames." | gotify
  ```

- **Summarize Docker Containers**: Fetch a list of running Docker containers and summarize their statuses.

  ```bash
  docker ps | openai "You are a Docker assistant." "Summarize the running Docker containers and their status." | gotify
  ```

- **Monitor Failed Systemd Services**: Check failed services using `systemctl` and summarize issues.

  ```bash
  systemctl --failed | openai "You are a system assistant." "Summarize the failed services and possible reasons." | gotify
  ```

- **Monitor Tailscale Device List**: Get a list of devices connected to Tailscale and summarize device statuses.

  ```bash
  tailscale status | openai "You are a Tailscale assistant." "Summarize the devices connected to the network and their statuses." | gotify
  ```

- **Summarize Battery Status**: Fetch battery status on a laptop and summarize any issues.

  ```bash
  upower -i $(upower -e | grep BAT) | openai "You are a system assistant." "Summarize the current battery status and any issues." | gotify
  ```

- **Summarize Website Status**: Use `curl` to check the status of a website and summarize the HTTP response.

  ```bash
  curl -s -o /dev/null -w "%{http_code}" https://example.com | openai "You are a website assistant." "Summarize the website's HTTP status." | gotify
  ```

- **Analyze Cron Job Logs**: Summarize recent cron job executions from logs.

  ```bash
  grep CRON /var/log/syslog | tail -n 50 | openai "You are a system assistant." "Summarize the status of recent cron job executions." | gotify
  ```

- **Monitor Network Bandwidth Usage**: Use `iftop` to monitor bandwidth and summarize heavy users.

  ```bash
  iftop -t -s 10 | openai "You are a network monitoring assistant." "Summarize the top bandwidth-consuming connections." | gotify
  ```

- **Summarize Recent Package Updates**: List recently updated packages and summarize their changes.

  ```bash
  grep " upgrade " /var/log/dpkg.log | tail -n 10 | openai "You are a system assistant." "Summarize the most recent package updates." | gotify
  ```

- **Detect and Summarize Network Interface Errors**: Use `ifconfig` or `ip` to check for interface errors and summarize.

  ```bash
  ifconfig | grep errors | openai "You are a network monitoring assistant." "Summarize network interface errors and their sources." | gotify
  ```

- **Summarize Disk I/O Performance**: Use `iostat` to fetch disk I/O stats and summarize performance issues.

  ```bash
  iostat | openai "You are a system monitoring assistant." "Summarize the disk I/O performance and identify bottlenecks." | gotify
  ```

- **Summarize OpenVPN Status**: Check OpenVPN client or server status and summarize active connections.

  ```bash
  cat /var/log/openvpn-status.log | openai "You are a VPN assistant." "Summarize the status of active OpenVPN connections." | gotify
  ```

- **Summarize Failed Login Attempts**: Extract failed login attempts from logs and notify about unusual activity.

  ```bash
  grep "Failed password" /var/log/auth.log | openai "You are a security assistant." "Summarize failed login attempts and potential suspicious activity." | gotify
  ```

- **Analyze Tailscale Logs**: Check recent Tailscale logs for issues or unusual activity.

  ```bash
  journalctl -u tailscaled | tail -n 50 | openai "You are a Tailscale assistant." "Analyze these logs and identify any potential issues or unusual activity."
  ```

- **Summarize Disk Usage**: Identify directories consuming the most disk space.

  ```bash
  du -sh /* | sort -rh | head -n 10 | openai "You are a system assistant." "Summarize the top directories consuming disk space and recommend actions."
  ```

- **Analyze Firewall Rules**: Summarize active firewall rules for understanding or troubleshooting.

  ```bash
  sudo iptables -L -v -n | openai "You are a network security assistant." "Analyze these firewall rules and summarize their impact."
  ```

- **Inspect Recent User Activity**: Review recent user activity from `auth.log` and highlight unusual behavior.

  ```bash
  grep "session opened" /var/log/auth.log | tail -n 50 | openai "You are a security assistant." "Summarize recent user activity and identify anything unusual."
  ```

- **Check Open Ports**: Analyze open ports on the system and their corresponding services.

  ```bash
  sudo netstat -tuln | openai "You are a network assistant." "Summarize the open ports and associated services on this system."
  ```

- **Monitor System Performance**: Analyze CPU and memory usage from `top` or `htop`.

  ```bash
  top -b -n 1 | head -n 20 | openai "You are a system monitoring assistant." "Summarize the CPU and memory usage and identify any potential issues."
  ```

- **Inspect Active Cron Jobs**: List and summarize all active cron jobs for a specific user.

  ```bash
  crontab -l | openai "You are a system assistant." "Analyze the active cron jobs and identify their purposes."
  ```

- **Summarize System Uptime and Load**: Review uptime and load average and suggest optimizations.

  ```bash
  uptime | openai "You are a system performance assistant." "Analyze the uptime and load average and suggest optimizations if needed."
  ```

- **Check Software Updates**: Analyze available software updates and their criticality.

  ```bash
  sudo apt list --upgradable | openai "You are a package management assistant." "Summarize the available software updates and highlight critical ones."
  ```

- **Inspect SSH Configuration**: Analyze the SSH server configuration for potential security risks.

  ```bash
  cat /etc/ssh/sshd_config | openai "You are a security assistant." "Analyze the SSH configuration and suggest improvements for security."
  ```

- **Audit User Accounts**: List all user accounts and identify any inactive or suspicious accounts.

  ```bash
  cut -d: -f1 /etc/passwd | openai "You are a system administrator assistant." "Analyze this list of user accounts and suggest any inactive or suspicious accounts."
  ```

- **Analyze Swap Usage**: Check swap usage statistics and suggest optimizations.

  ```bash
  free -h | openai "You are a system performance assistant." "Analyze the swap usage and suggest optimizations if necessary."
  ```

- **Review Kernel Logs**: Summarize recent kernel logs for warnings or errors.

  ```bash
  dmesg | tail -n 50 | openai "You are a system assistant." "Summarize any warnings or errors from these kernel logs."
  ```

- **Analyze Docker Logs**: Extract and summarize logs from a specific Docker container.
  ```bash
  docker logs my-container | tail -n 50 | openai "You are a Docker assistant." "Analyze the logs and identify any potential issues with the container."
  ```

## Contribution

Feel free to submit issues or feature requests to improve this script. Contributions via pull requests are welcome.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
