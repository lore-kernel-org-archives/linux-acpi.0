From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / debugger: Fix a redundant mutex unlock issue in acpi_aml_open()
Date: Fri, 25 Dec 2015 11:22:32 +0800
Message-ID: <75c5d460bbe5f0d55c442c2d2e144adfc4fe7da2.1451013194.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446790780.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Fix a double mutex_unlock() issue where acpi_initialize_debugger() is
called with the mutex already unlocked.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_dbg.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index fa18bd0..9c31b08 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -514,7 +514,7 @@ static int acpi_aml_open(struct inode *inode, struct file *file)
 		if (ACPI_FAILURE(status)) {
 			pr_err("Failed to initialize debugger.\n");
 			ret = -EINVAL;
-			goto err_lock;
+			goto err_exit;
 		}
 		pr_debug("Debugger thread initialized.\n");
 
@@ -531,6 +531,7 @@ err_lock:
 			acpi_aml_active_reader = NULL;
 	}
 	mutex_unlock(&acpi_aml_io.lock);
+err_exit:
 	return ret;
 }
 
-- 
1.7.10
