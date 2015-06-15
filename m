From: Wang Long <long.wanglong@huawei.com>
Subject: [PATCH 2/2] apei/erst-dbg: Define pr_fmt macro to avoid the duplication of ERST_DBG_PFX
Date: Mon, 15 Jun 2015 09:57:30 +0000
Message-ID: <1434362250-217135-2-git-send-email-long.wanglong@huawei.com>
References: <1434362250-217135-1-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434362250-217135-1-git-send-email-long.wanglong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: tony.luck@intel.com, bp@suse.de, gong.chen@linux.intel.com, long.wanglong@huawei.com, tomasz.nowicki@linaro.org, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, wanglong@laoqinren.net, peifeiyue@huawei.com
List-Id: linux-acpi@vger.kernel.org

Define pr_fmt macro with {ERST DBG: } prefix, then remove all use
of ERST_DBG_PFXin the pr_* functions.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 drivers/acpi/apei/erst-dbg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 3a57ffb..48e9490 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -31,7 +31,8 @@
 
 #include "apei-internal.h"
 
-#define ERST_DBG_PFX			"ERST DBG: "
+#undef pr_fmt
+#define pr_fmt(fmt) "ERST DBG: " fmt
 
 #define ERST_DBG_RECORD_LEN_MAX		0x4000
 
@@ -130,8 +131,7 @@ retry:
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
-		pr_warn(ERST_DBG_PFX
-			   "Record (ID: 0x%llx) length is too long: %zd\n",
+		pr_warn("Record (ID: 0x%llx) length is too long: %zd\n",
 			   id, len);
 		rc = -EIO;
 		goto out;
@@ -171,7 +171,7 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
 		return -EPERM;
 
 	if (usize > ERST_DBG_RECORD_LEN_MAX) {
-		pr_err(ERST_DBG_PFX "Too long record to be written\n");
+		pr_err("Too long record to be written\n");
 		return -EINVAL;
 	}
 
@@ -223,7 +223,7 @@ static struct miscdevice erst_dbg_dev = {
 static __init int erst_dbg_init(void)
 {
 	if (erst_disable) {
-		pr_info(ERST_DBG_PFX "ERST support is disabled.\n");
+		pr_info("ERST support is disabled.\n");
 		return -ENODEV;
 	}
 	return misc_register(&erst_dbg_dev);
-- 
1.8.3.4
