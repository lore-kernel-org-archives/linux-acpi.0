From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ACPI, APEI, EINJ: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Fri, 30 Nov 2018 12:01:06 -0500
Message-ID: <20181130170106.4031-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/acpi/apei/einj.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index b38737c83a24..fcccbfdbdd1a 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -607,17 +607,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int available_error_type_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, available_error_type_show, NULL);
-}
-
-static const struct file_operations available_error_type_fops = {
-	.open		= available_error_type_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
 static int error_type_get(void *data, u64 *val)
 {
-- 
2.17.0
