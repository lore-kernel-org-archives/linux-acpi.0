From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 4/5] ACPI, APEI, Fix error path for memory allocation
Date: Sun, 19 Sep 2010 11:00:34 +0800
Message-ID: <1284865235-29920-5-git-send-email-ying.huang@intel.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

In ERST debug/test support patch, a dynamic allocated buffer is
used. The may-failed memory allocation should be tried firstly before
free the previous buffer.

APEI resource management memory allocation related error path is fixed
too.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/apei-base.c |   25 ++++++++++++++++++++-----
 drivers/acpi/apei/erst-dbg.c  |   16 ++++++++++------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 73fd0c7..6bf11f9 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -445,11 +445,15 @@ EXPORT_SYMBOL_GPL(apei_resources_sub);
 int apei_resources_request(struct apei_resources *resources,
 			   const char *desc)
 {
-	struct apei_res *res, *res_bak;
+	struct apei_res *res, *res_bak = NULL;
 	struct resource *r;
+	int rc;
 
-	apei_resources_sub(resources, &apei_resources_all);
+	rc = apei_resources_sub(resources, &apei_resources_all);
+	if (rc)
+		return rc;
 
+	rc = -EINVAL;
 	list_for_each_entry(res, &resources->iomem, list) {
 		r = request_mem_region(res->start, res->end - res->start,
 				       desc);
@@ -475,7 +479,13 @@ int apei_resources_request(struct apei_resources *resources,
 		}
 	}
 
-	apei_resources_merge(&apei_resources_all, resources);
+	rc = apei_resources_merge(&apei_resources_all, resources);
+	if (rc) {
+		pr_err(APEI_PFX
+"Error in APEI internal resource management, there may be inconsistent "
+"between APEI internal and system resource management.");
+		goto err_unmap_ioport;
+	}
 
 	return 0;
 err_unmap_ioport:
@@ -491,12 +501,13 @@ err_unmap_iomem:
 			break;
 		release_mem_region(res->start, res->end - res->start);
 	}
-	return -EINVAL;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(apei_resources_request);
 
 void apei_resources_release(struct apei_resources *resources)
 {
+	int rc;
 	struct apei_res *res;
 
 	list_for_each_entry(res, &resources->iomem, list)
@@ -504,7 +515,11 @@ void apei_resources_release(struct apei_resources *resources)
 	list_for_each_entry(res, &resources->ioport, list)
 		release_region(res->start, res->end - res->start);
 
-	apei_resources_sub(&apei_resources_all, resources);
+	rc = apei_resources_sub(&apei_resources_all, resources);
+	if (rc)
+		pr_err(APEI_PFX
+"Error in APEI internal resource management, there may be inconsistent "
+"between APEI internal and system resource management.");
 }
 EXPORT_SYMBOL_GPL(apei_resources_release);
 
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 98ffa29..da1228a 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -111,11 +111,13 @@ retry:
 		goto out;
 	}
 	if (len > erst_dbg_buf_len) {
-		kfree(erst_dbg_buf);
+		void *p;
 		rc = -ENOMEM;
-		erst_dbg_buf = kmalloc(len, GFP_KERNEL);
-		if (!erst_dbg_buf)
+		p = kmalloc(len, GFP_KERNEL);
+		if (!p)
 			goto out;
+		kfree(erst_dbg_buf);
+		erst_dbg_buf = p;
 		erst_dbg_buf_len = len;
 		goto retry;
 	}
@@ -150,11 +152,13 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
 	if (mutex_lock_interruptible(&erst_dbg_mutex))
 		return -EINTR;
 	if (usize > erst_dbg_buf_len) {
-		kfree(erst_dbg_buf);
+		void *p;
 		rc = -ENOMEM;
-		erst_dbg_buf = kmalloc(usize, GFP_KERNEL);
-		if (!erst_dbg_buf)
+		p = kmalloc(usize, GFP_KERNEL);
+		if (!p)
 			goto out;
+		kfree(erst_dbg_buf);
+		erst_dbg_buf = p;
 		erst_dbg_buf_len = usize;
 	}
 	rc = copy_from_user(erst_dbg_buf, ubuf, usize);
-- 
1.7.1
