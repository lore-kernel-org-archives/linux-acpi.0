From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 4/5] ACPI, APEI, Fix error path for memory allocation
Date: Wed, 29 Sep 2010 19:53:54 +0800
Message-ID: <1285761235-4751-5-git-send-email-ying.huang@intel.com>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

In ERST debug/test support patch, a dynamic allocated buffer is
used. The may-failed memory allocation should be tried firstly before
free the previous buffer.

APEI resource management memory allocation related error path is fixed
too.

v2:

- Fix error messages for APEI resources management

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/apei-base.c |   21 ++++++++++++++++-----
 drivers/acpi/apei/erst-dbg.c  |   16 ++++++++++------
 2 files changed, 26 insertions(+), 11 deletions(-)

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
@@ -475,7 +479,11 @@ int apei_resources_request(struct apei_r
 		}
 	}
 
-	apei_resources_merge(&apei_resources_all, resources);
+	rc = apei_resources_merge(&apei_resources_all, resources);
+	if (rc) {
+		pr_err(APEI_PFX "Fail to merge resources!\n");
+		goto err_unmap_ioport;
+	}
 
 	return 0;
 err_unmap_ioport:
@@ -491,12 +499,13 @@ err_unmap_iomem:
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
@@ -504,7 +513,9 @@ void apei_resources_release(struct apei_
 	list_for_each_entry(res, &resources->ioport, list)
 		release_region(res->start, res->end - res->start);
 
-	apei_resources_sub(&apei_resources_all, resources);
+	rc = apei_resources_sub(&apei_resources_all, resources);
+	if (rc)
+		pr_err(APEI_PFX "Fail to sub resources!\n");
 }
 EXPORT_SYMBOL_GPL(apei_resources_release);
 
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
@@ -150,11 +152,13 @@ static ssize_t erst_dbg_write(struct fil
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
