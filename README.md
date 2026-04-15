[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=23572390&assignment_repo_type=AssignmentRepo)
# Day 10 Lab: Data Pipeline & Data Observability

**Student Email:** nguyenhieu@student.university.edu
**Name:** Nguyễn Ngọc Hiếu

---

## Mo ta

Xây dựng một Data Pipeline tự động (Extract, Validate, Transform, Load) để xử lý dữ liệu và đánh giá ảnh hưởng của Data Quality (dữ liệu rác) đối với Agent (AI) qua tác vụ phân tích, làm nổi bật tầm quan trọng của việc làm sạch dữ liệu.

---

## Cach chay (How to Run)

### Prerequisites
```bash
pip install pandas
```

### Chay ETL Pipeline
```bash
python solution.py
```

### Chay Agent Simulation (Stress Test)
```bash
# Mo ta cach ban chay thi nghiem Clean vs Garbage data
```

---

## Cau truc thu muc

```
├── solution.py              # ETL Pipeline script
├── processed_data.csv       # Output cua pipeline
├── experiment_report.md     # Bao cao thi nghiem
└── README.md                # File nay
```

---

## Ket qua

Pipeline đã xử lý thành công `raw_data.json`:
- **3** records hợp lệ đã được transform và lưu vào `processed_data.csv`.
- **2** records lỗi bị loại bỏ (do giá âm hoặc rỗng `category`).
- Quá trình chạy thí nghiệm Garbage Data cho thấy Agent đã trả lời sai hoàn toàn khi gặp dữ liệu không qua validation.
