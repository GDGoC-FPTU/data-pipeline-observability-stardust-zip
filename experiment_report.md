# Experiment Report: Data Quality Impact on AI Agent

**Student ID:** 2A202600187
**Name:** Nguyễn Ngọc Hiếu
**Date:** 2026-04-15

---

## 1. Ket qua thi nghiem

Chay `agent_simulation.py` voi 2 bo du lieu va ghi lai ket qua:

| Scenario | Agent Response | Accuracy (1-10) | Notes |
|----------|----------------|-----------------|-------|
| Clean Data (`processed_data.csv`) | Agent: Based on my data, the best choice is Laptop at $1200. | 10 | Trả về kết quả đúng (Laptop) thuộc category electronics |
| Garbage Data (`garbage_data.csv`) | Agent: Based on my data, the best choice is Nuclear Reactor at $999999. | 0 | Trả về outlier (Nuclear Reactor), do Agent chọn price lớn nhất mà dữ liệu không bị chặn bởi validate |

---

## 2. Phan tich & nhan xet

### Tai sao Agent tra loi sai khi dung Garbage Data?

Agent đã trả lời sai vì bộ dữ liệu `garbage_data.csv` chứa các record hoàn toàn phi lý (ví dụ: Nuclear Reactor với giá $999999), không hề đi qua bước validation. Cơ chế của Agent phụ thuộc vào việc tìm kiếm giá lớn nhất trong category electronics, do đó nó tin vào outlier này và trả về kết quả sai lệch. Điều này cho thấy hậu quả của mô hình nhiễm độc khi thiếu quy trình kiểm nghiệm chất lượng dữ liệu.

---

## 3. Ket luan

**Quality Data > Quality Prompt?** Đồng ý.

Mặc dù Prompt tốt có thể tối ưu Output, nhưng với một tập dữ liệu đầu vào chứa toàn Rác (Garbage Data), AI sẽ bị mất định hướng hoặc đưa ra những câu trả lời vô nghĩa hoặc sai nhưng cực kỳ thuyết phục (Garbage in - Garbage out). Do đó Data Quality mang tính sống còn đối với sự chính xác của một hệ thống AI.
