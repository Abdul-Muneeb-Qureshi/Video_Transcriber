

# 📄 Transcriber System – Setup & Configuration Guide (Backend & Frontend)

## 📚 Table of Contents

* [📄 Transcriber System – Setup & Configuration Guide (Backend)](#-transcriber-system--setup--configuration-guide-backend)

  * [🧰 Prerequisites](#-prerequisites)
  * [⚙️ Setup Instructions](#-setup-instructions)

    * [1. Unzip the Project](#1-unzip-the-project)
    * [2. Create & Activate Virtual Environment](#2-create--activate-virtual-environment)
    * [3. Install Dependencies](#3-install-dependencies)
    * [4. MySQL Database Setup](#4-mysql-database-setup)
    * [5. Configure Transcript Download Path](#5-configure-transcript-download-path)
    * [6. Update YouTube Service Logic](#6-update-youtube-service-logic)
    * [🎞️ Installing FFmpeg](#️-installing-ffmpeg)
  * [✅ Final Checks](#-final-checks)
  * [🛠️ Troubleshooting](#️-troubleshooting)

* [🌐 Frontend – Setup & Configuration](#-frontend--setup--configuration)

  * [1. 🧱 Install Node.js and npm](#1--install-nodejs-and-npm)
  * [2. 📦 Unzip the Frontend Project](#2--unzip-the-frontend-project)
  * [3. 📁 Navigate to the Project Directory](#3--navigate-to-the-project-directory)
  * [4. 📥 Install Dependencies](#4--install-dependencies)
  * [✅ Final Note](#-final-note)

---

## 📄 Transcriber System – Setup & Configuration Guide (Backend)

### 🧰 Prerequisites

* Python 3.8+
* MySQL Workbench
* `ffmpeg` installed
* Operating System: Windows or Linux/Ubuntu

---

### ⚙️ Setup Instructions

#### 1. Unzip the Project

Unzip the `backend` project folder into your desired directory.

---

#### 2. Create & Activate Virtual Environment

```bash
cd backend
python -m venv venv

# Activate:
# Windows:
venv\Scripts\activate

# Linux/macOS:
source venv/bin/activate
```

---

#### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

---

#### 4. MySQL Database Setup

##### a. Create Database

Open MySQL Workbench and run the `query.sql` script.

##### b. Update Database Connection

Edit `task_db.py`:

```python
import pymysql
from pymysql.err import MySQLError

def get_connection():
    try:
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="password",  # Replace with actual password
            database="youtube_tasks_db",
            connect_timeout=5
        )
        print("MySQL connection established")
        return conn
    except MySQLError as e:
        print(f"Error connecting to MySQL: {e}")
        return None
```

---

#### 5. Configure Transcript Download Path

Edit `app/routes/youtuberoutes.py`:

```python
@youtube_bp.route('/download/transcript/<path:transcript_link>', methods=['GET'])
def download_transcript(transcript_link):
    filename = os.path.basename(transcript_link)

    transcript_folder = r'D:\Internship\Task2\backend\downloaded_audio'
    file_path = os.path.join(transcript_folder, filename)

    if not os.path.exists(file_path):
        return jsonify({"error": "Transcript file not found"}), 404

    return send_file(file_path, as_attachment=True)
```

---

#### 6. Update YouTube Service Logic

Edit `app/services/youtube_service.py`:

```python
def download_audio_from_youtube(url, task_id):
    ...
    output_folder = "downloaded_audio"
    os.makedirs(output_folder, exist_ok=True)

    ffmpeg_path = r"D:\Application\ffmpeg\ffmpeg-master-latest-win64-gpl\bin"
    
    output_file = os.path.join(output_folder, f"{sanitized_title}.mp3")
    command = f'yt-dlp -x --audio-format mp3 --ffmpeg-location "{ffmpeg_path}" -o "{output_file}" {url}'
    subprocess.run(command, shell=True, check=True)
    ...
```

> 🔄 For Linux:

```python
ffmpeg_path = "/usr/bin"
```

Install ffmpeg:

```bash
sudo apt update
sudo apt install ffmpeg
```

---

### 🎞️ Installing FFmpeg

#### ✅ For **Windows**:

Download from [BtbN](https://github.com/BtbN/FFmpeg-Builds/releases)

> 🔗 **Direct Download**:
> [FFmpeg Build (zip) win64](https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip)
> **SHA-256**: `038fcb7bb46d386aff3a51ce1e31c35647857d070b81f9f057b1d8f8bc3c732d`

After downloading:

1. Extract to a folder like: `D:\Application\ffmpeg`

2. Update your code path to:

   ```python
   ffmpeg_path = r"D:\Application\ffmpeg\ffmpeg-master-latest-win64-gpl\bin"
   ```

3. Optionally, add it to System Environment Variables under `Path`.

---

### ✅ Final Checks

* Verify `ffmpeg`, `yt-dlp`, Python, and database setup.
* Ensure `downloaded_audio` exists and is writable.
* Tables created successfully from `query.sql`.

---

### 🛠️ Troubleshooting

| Issue                     | Cause                       | Solution                                             |
| ------------------------- | --------------------------- | ---------------------------------------------------- |
| Transcript file not found | Incorrect folder path       | Check `transcript_folder` in `youtuberoutes.py`      |
| MP3 file not found        | Failed download or bad path | Verify `yt-dlp` installed and `ffmpeg_path` is valid |
| MySQL connection error    | Wrong credentials or host   | Verify DB settings in `get_connection()`             |

---

## 🌐 Frontend – Setup & Configuration

---

### 1. 🧱 Install Node.js and npm

Recommended:

* **Node.js**: `v20.15.0`
* **npm**: `v10.7.0`

Download from: [https://nodejs.org/](https://nodejs.org/)

Verify installation:

```bash
node -v
npm -v
```

---

### 2. 📦 Unzip the Frontend Project

Extract the `frontend` folder to your workspace.

---

### 3. 📁 Navigate to the Project Directory

```bash
cd frontend
```

---

### 4. 📥 Install Dependencies

```bash
npm install
```

---

### ✅ Final Note

Start the frontend server:

```bash
npm start
```

> Ensure the **backend server is running** before launching the frontend.



