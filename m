From: Linda Knippers <linda.knippers@hpe.com>
Subject: [PATCH 3/3] nfit: Adjust for different _FIT and NFIT headers
Date: Fri, 20 Nov 2015 19:05:49 -0500
Message-ID: <03fba073944c91810f89e321cb7fa024f8e9e2c1.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6220.austin.hp.com ([15.73.96.84]:40465 "EHLO
	g1t6220.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760371AbbKUAG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2015 19:06:26 -0500
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, toshi.kani@hpe.com, elliott@hpe.com, rafael.j.wysocki@intel.com

When support for _FIT was added, the code presumed that the data
returned by the _FIT method is identical to the NFIT table, which
starts with an acpi_table_header.  However, the _FIT is defined
to return a data in the format of a series of NFIT type structure
entries and as a method, has an acpi_object header rather tahn
an acpi_table_header.

To address the differences, explicitly save the acpi_table_header
from the NFIT, since it is accessible through /sys, and change
the nfit pointer in the acpi_desc structure to point to the
table entries rather than the headers.

Reported-by: Jeff Moyer (jmoyer@redhat.com>
Signed-off-by: Linda Knippers <linda.knippers@hpe.com>
---
 drivers/acpi/nfit.c | 47 +++++++++++++++++++++++++++++++++++------------
 drivers/acpi/nfit.h |  3 ++-
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index c140194d..b1fae13 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -679,7 +679,7 @@ static ssize_t revision_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%d\n", acpi_desc->nfit->header.revision);
+	return sprintf(buf, "%d\n", acpi_desc->acpi_header.revision);
 }
 static DEVICE_ATTR_RO(revision);
 
@@ -1676,7 +1676,6 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
 
 	data = (u8 *) acpi_desc->nfit;
 	end = data + sz;
-	data += sizeof(struct acpi_table_nfit);
 	while (!IS_ERR_OR_NULL(data))
 		data = add_table(acpi_desc, &prev, data, end);
 
@@ -1772,13 +1771,29 @@ static int acpi_nfit_add(struct acpi_device *adev)
 		return PTR_ERR(acpi_desc);
 	}
 
-	acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
+	/*
+	 * Save the acpi header for later and then skip it,
+	 * making nfit point to the first nfit table header.
+	 */
+	acpi_desc->acpi_header = *tbl;
+	acpi_desc->nfit = (void *) tbl + sizeof(struct acpi_table_nfit);
+	sz -= sizeof(struct acpi_table_nfit);
 
 	/* Evaluate _FIT and override with that if present */
 	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
 	if (ACPI_SUCCESS(status) && buf.length > 0) {
-		acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
-		sz = buf.length;
+		union acpi_object *obj;
+		/*
+		 * Adjust for the acpi_object header of the _FIT
+		 */
+		obj = buf.pointer;
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			acpi_desc->nfit =
+				(struct acpi_nfit_header *)obj->buffer.pointer;
+			sz = obj->buffer.length;
+		} else
+			dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
+				 __func__, (int) obj->type);
 	}
 
 	rc = acpi_nfit_init(acpi_desc, sz);
@@ -1801,7 +1816,8 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(&adev->dev);
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_table_nfit *nfit_saved;
+	struct acpi_nfit_header *nfit_saved;
+	union acpi_object *obj;
 	struct device *dev = &adev->dev;
 	acpi_status status;
 	int ret;
@@ -1832,12 +1848,19 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 	}
 
 	nfit_saved = acpi_desc->nfit;
-	acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
-	ret = acpi_nfit_init(acpi_desc, buf.length);
-	if (ret) {
-		/* Merge failed, restore old nfit, and exit */
-		acpi_desc->nfit = nfit_saved;
-		dev_err(dev, "failed to merge updated NFIT\n");
+	obj = buf.pointer;
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		acpi_desc->nfit =
+			(struct acpi_nfit_header *)obj->buffer.pointer;
+		ret = acpi_nfit_init(acpi_desc, obj->buffer.length);
+		if (ret) {
+			/* Merge failed, restore old nfit, and exit */
+			acpi_desc->nfit = nfit_saved;
+			dev_err(dev, "failed to merge updated NFIT\n");
+		}
+	} else {
+		/* Bad _FIT, restore old nfit */
+		dev_err(dev, "Invalid _FIT\n");
 	}
 	kfree(buf.pointer);
 
diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
index 2ea5c07..3d549a3 100644
--- a/drivers/acpi/nfit.h
+++ b/drivers/acpi/nfit.h
@@ -96,7 +96,8 @@ struct nfit_mem {
 
 struct acpi_nfit_desc {
 	struct nvdimm_bus_descriptor nd_desc;
-	struct acpi_table_nfit *nfit;
+	struct acpi_table_header acpi_header;
+	struct acpi_nfit_header *nfit;
 	struct mutex spa_map_mutex;
 	struct mutex init_mutex;
 	struct list_head spa_maps;
-- 
1.8.3.1

