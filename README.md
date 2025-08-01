# Enterprise G Automation

Thư mục này chứa các script và workflow giúp tạo bản ISO Windows Enterprise G tự động thông qua UUP Dump và GitHub Actions/GitLab Runner.

## Cấu trúc thư mục

- `.github/workflows/build.yml` – workflow chạy trên runner Windows để tải UUP Dump, chuyển đổi install.wim sang Enterprise G, áp dụng các tuỳ chỉnh debloat và đóng gói lại ISO.
- `ConvertConfig.ini` – cấu hình UUP Dump (AddUpdates=0, SkipApps=1, AppsLevel=1).
- `regedit.reg`, `defender.reg`, `edge.reg` – các tập tin registry dùng để vô hiệu hoá nhiều chức năng bloatware, sửa đổi Windows Defender và Edge.
- `labconfig.reg` – thêm khoá LabConfig để bỏ qua yêu cầu phần cứng (TPM, SecureBoot, RAM, CPU, Storage) khi cài Windows 11.
- `RemoveEdge.cmd` – script gỡ Microsoft Edge và Edge WebView.
- `debloat.ps1` – script PowerShell loại bỏ nhiều ứng dụng cài sẵn (Weather, Solitaire, Xbox, Your Phone, v.v.) và OneDrive.
- `SetupComplete.cmd` – script chạy sau khi cài đặt Windows để gọi các script debloat, gỡ Edge, import registry và kích hoạt (nếu có).
- `convert_to_enterpriseG.cmd` – script sử dụng DISM để mount install.wim, chuyển edition sang Enterprise G, import các file `.reg`, thêm LabConfig, copy script vào `Windows\Setup\Scripts` rồi commit lại.

## Sử dụng workflow

1. Nhận ID UUP và edition cần tải từ [uupdump.net](https://uupdump.net). Ví dụ: `uup_id=ed43e7f7` và `edition=Professional`.
2. Đẩy toàn bộ thư mục `enterprise_g_automation` và nội dung `.github` vào kho Git của bạn. Giữ nguyên cấu trúc.
3. Trên GitHub, vào tab **Actions** và chạy workflow `Build Enterprise G ISO`. Nhập giá trị `uup_id` và `edition` theo yêu cầu.
4. Workflow sẽ tải UUP, tạo ISO/WIM gốc, chuyển đổi sang Enterprise G, áp dụng debloat, copy script vào ISO, bỏ qua yêu cầu phần cứng qua `LabConfig`, và đóng gói ISO cuối cùng. ISO sẽ được lưu dưới dạng artifact.

## Cảnh báo

- Việc gỡ Defender, Edge và các ứng dụng hệ thống sẽ làm giảm tính bảo mật và ổn định của Windows. Chỉ sử dụng cho mục đích thử nghiệm.
- Các phím sản phẩm được sử dụng để chuyển edition sang Enterprise G không phải là chìa khoá kích hoạt; bạn cần tuân thủ quy định bản quyền của Microsoft.
- Script bypass phần cứng (`labconfig.reg`) có thể giúp cài Windows 11 trên máy không đáp ứng yêu cầu tối thiểu, nhưng nó không được Microsoft hỗ trợ.
#   e n t e r p r i s e G - a u t o m a t i o n  
 