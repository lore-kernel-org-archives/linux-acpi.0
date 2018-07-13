From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ACPI: button: hide unused procfs helpers
Date: Fri, 13 Jul 2018 15:19:59 +0800
Message-ID: <20180713071959.11220-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-acpi@vger.kernel.org

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/acpi/button.c:255:12: warning: ‘acpi_button_state_seq_show’ defined but not used [-Wunused-function]
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
            ^
fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/acpi/button.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5e..8538e25 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -252,6 +252,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	return ret;
 }
 
+#ifdef CONFIG_PROC_FS
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_device *device = seq->private;
@@ -262,6 +263,7 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
 	return 0;
 }
+#endif
 
 static int acpi_button_add_fs(struct acpi_device *device)
 {
-- 
2.7.0
