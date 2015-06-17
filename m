From: Wang Long <long.wanglong@huawei.com>
Subject: [PATCH v2 2/2] apei/erst-dbg: Define pr_fmt macro to avoid the duplication of ERST_DBG_PFX
Date: Wed, 17 Jun 2015 01:30:12 +0000
Message-ID: <1434504612-40011-2-git-send-email-long.wanglong@huawei.com>
References: <1434504612-40011-1-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:16423 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051AbbFQBeK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2015 21:34:10 -0400
In-Reply-To: <1434504612-40011-1-git-send-email-long.wanglong@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, joe@perches.com
Cc: tony.luck@intel.com, bp@suse.de, gong.chen@linux.intel.com, long.wanglong@huawei.com, tomasz.nowicki@linaro.org, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, wanglong@laoqinren.net, peifeiyue@huawei.com

Define pr_fmt macro with {ERST DBG: } prefix, then remove all use
of ERST_DBG_PFX in the pr_* functions.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 drivers/acpi/apei/erst-dbg.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 3a57ffb..c38133a 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -31,8 +33,6 @@
 
 #include "apei-internal.h"
 
-#define ERST_DBG_PFX			"ERST DBG: "
-
 #define ERST_DBG_RECORD_LEN_MAX		0x4000
 
 static void *erst_dbg_buf;
@@ -130,8 +130,7 @@ retry:
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
-		pr_warn(ERST_DBG_PFX
-			   "Record (ID: 0x%llx) length is too long: %zd\n",
+		pr_warn("Record (ID: 0x%llx) length is too long: %zd\n",
 			   id, len);
 		rc = -EIO;
 		goto out;
@@ -171,7 +170,7 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
 		return -EPERM;
 
 	if (usize > ERST_DBG_RECORD_LEN_MAX) {
-		pr_err(ERST_DBG_PFX "Too long record to be written\n");
+		pr_err("Too long record to be written\n");
 		return -EINVAL;
 	}
 
@@ -223,7 +222,7 @@ static struct miscdevice erst_dbg_dev = {
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

