From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] acpi: remove a meaningless null check before debugfs_remove
Date: Sat, 18 Aug 2018 18:49:20 +0800
Message-ID: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

debugfs_remove has taken null pointer into account. So it is safe
to remove the check before debugfs_remove.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/acpi/custom_method.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index e967c11..4451877 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -92,8 +92,7 @@ static int __init acpi_custom_method_init(void)
 
 static void __exit acpi_custom_method_exit(void)
 {
-	if (cm_dentry)
-		debugfs_remove(cm_dentry);
+	debugfs_remove(cm_dentry);
 }
 
 module_init(acpi_custom_method_init);
-- 
1.7.12.4
