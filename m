From: Linda Knippers <linda.knippers@hpe.com>
Subject: [RFC PATCH] Fix _FIT vs. NFIT processing breakage
Date: Wed, 18 Nov 2015 12:54:00 -0500
Message-ID: <20151118175359.GA2209@ljk840.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4625.austin.hp.com ([15.73.212.76]:53942 "EHLO
	g2t4625.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbKRRyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2015 12:54:12 -0500
Received: from g2t4622.austin.hp.com (g2t4622.austin.hp.com [15.73.212.79])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t4625.austin.hp.com (Postfix) with ESMTPS id 22AC169D8
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2015 17:54:12 +0000 (UTC)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, toshi.kani@hpe.com, elliott@hpe.com, rafael.j.wysocki@intel.com


Since commit 209851649dc4f7900a6bfe1de5e2640ab2c7d931, we no longer
see NVDIMM devices on our systems.  The NFIT/_FIT processing at
initialization gets a table from _FIT but doesn't like it.

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

This is an RFC patch for several reasons.
1) I've only tested the boot path, not the code path gets
gets a _FIT later.
2) There is some debug information that we probably don't
want to keep in there.
3) I'm not even sure we should be checking _FIT at boot time
4) While this fixes my platform, it probably breaks the tests
that were used to test the original commit.

If we need to have a long discussion about whether our firmware
is correct, then perhaps we can remove the _FIT code from acpi_nfit_add()
while we sort it out.

Reported-by: Jeff Moyer (jmoyer@redhat.com>
Signed-off-by: Linda Knippers <linda.knippers@hp.com>
---
 drivers/acpi/nfit.c | 55 +++++++++++++++++++++++++++++++++++++++++------------
 drivers/acpi/nfit.h |  3 ++-
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index f7dab53..ad95113 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -655,7 +655,7 @@ static ssize_t revision_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%d\n", acpi_desc->nfit->header.revision);
+	return sprintf(buf, "%d\n", acpi_desc->acpi_header.revision);
 }
 static DEVICE_ATTR_RO(revision);
 
@@ -1652,7 +1652,6 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
 
 	data = (u8 *) acpi_desc->nfit;
 	end = data + sz;
-	data += sizeof(struct acpi_table_nfit);
 	while (!IS_ERR_OR_NULL(data))
 		data = add_table(acpi_desc, &prev, data, end);
 
@@ -1748,13 +1747,34 @@ static int acpi_nfit_add(struct acpi_device *adev)
 		return PTR_ERR(acpi_desc);
 	}
 
-	acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
+	/*
+	 * Save the acpi header for later and then skip it, make
+	 * nfit point to the first nfit table header.
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
+
+		dev_dbg(dev, "%s _FIT ptr %p, length: %d\n",
+			__func__, buf.pointer, (int)buf.length);
+		print_hex_dump_debug("_FIT: ", DUMP_PREFIX_OFFSET, 16, 1,
+			buf.pointer, buf.length, true);
+
+		/*
+		 * Adjust for the acpi_object header of the _FIT
+		 */
+		obj = buf.pointer;
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			acpi_desc->nfit = (struct acpi_nfit_header *)obj->buffer.pointer;
+			sz = obj->buffer.length;
+		} else
+			dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
+				__func__, (int) obj->type);
 	}
 
 	rc = acpi_nfit_init(acpi_desc, sz);
@@ -1777,8 +1796,9 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(&adev->dev);
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_table_nfit *nfit_saved;
+	struct acpi_nfit_header *nfit_saved;
 	struct device *dev = &adev->dev;
+	union acpi_object *obj;
 	acpi_status status;
 	int ret;
 
@@ -1807,13 +1827,24 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 		goto out_unlock;
 	}
 
+	dev_dbg(dev, "%s _FIT ptr %p, length: %d\n",
+		__func__, buf.pointer, (int)buf.length);
+	print_hex_dump_debug("_FIT: ", DUMP_PREFIX_OFFSET, 16, 1,
+		buf.pointer, buf.length, true);
+
 	nfit_saved = acpi_desc->nfit;
-	acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
-	ret = acpi_nfit_init(acpi_desc, buf.length);
-	if (!ret) {
-		/* Merge failed, restore old nfit, and exit */
-		acpi_desc->nfit = nfit_saved;
-		dev_err(dev, "failed to merge updated NFIT\n");
+	obj = buf.pointer;
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		acpi_desc->nfit = (struct acpi_nfit_header *)obj->buffer.pointer;
+		ret = acpi_nfit_init(acpi_desc, obj->buffer.length);
+		if (!ret) {
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


