# FIFO Design Verification Project (SystemVerilog)

## 📌 Overview

This project implements and verifies an 8-bit synchronous FIFO using Verilog RTL and a SystemVerilog self-checking testbench.

The verification environment follows a UVM-inspired architecture (UVM-lite), including stimulus generation, driving, monitoring, and automated checking.

---

## 🧱 RTL Architecture

modA → FIFO → modB → Output

* **modA** : Write controller
* **FIFO** : 8-depth memory buffer
* **modB** : Read controller (FSM-based)

---

## 🧪 Verification Components

| Component   | Role                        |
| ----------- | --------------------------- |
| Transaction | Data packet                 |
| Generator   | Random stimulus creation    |
| Driver      | Drives DUT inputs           |
| Monitor     | Observes DUT outputs        |
| Scoreboard  | Compares expected vs actual |

---

## 🔁 Verification Flow

Generator → Driver → DUT → Monitor → Scoreboard

Self-checking ensures functional correctness automatically.

---

## 🛠 Tools Used

* Vivado XSim Simulator
* Verilog (RTL)
* SystemVerilog (Testbench)

---

## 📊 Features Verified

* FIFO write/read functionality
* Data ordering integrity
* Reset behavior
* Pipeline latency handling

---

## 📷 Sample Waveform
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1f926d26-6582-45aa-b213-dfdae3b882a6" />
<img width="599" height="132" alt="image" src="https://github.com/user-attachments/assets/c6d52af9-9b93-45b3-942f-ca9f28c846b5" />


---

## 🚀 Future Improvements

* Assertions
* Functional Coverage
* Interface abstraction
* UVM migration

---

## 👨‍💻 Author

Advait Rao
B.Tech Electronics (VLSI Design)
Neuromorphic ML Enthusiast & Design Verification Amateur 
