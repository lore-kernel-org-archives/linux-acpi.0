From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Tue, 27 Oct 2015 16:58:27 -0600
Message-ID: <1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8291 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355AbbJ0W6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2015 18:58:53 -0400
In-Reply-To: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

Add a .notify callback to the acpi_nfit_driver that gets called on a
hotplug event. From this, evaluate the _FIT ACPI method which returns
the updated NFIT with handles for the hot-plugged NVDIMM.

Iterate over the new NFIT, and add any new tables found, and
register/enable the corresponding regions.

In the nfit test framework, after normal initialization, update the NFIT
with a new hot-plugged NVDIMM, and directly call into the driver to
update its view of the available regions.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Elliott, Robert <elliott@hpe.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-nvdimm@lists.01.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit.c              | 301 +++++++++++++++++++++++++++++++--------
 drivers/acpi/nfit.h              |   2 +
 tools/testing/nvdimm/test/nfit.c | 164 ++++++++++++++++++++-
 3 files changed, 407 insertions(+), 60 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 35b4b56..869f279 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -33,6 +33,15 @@ static bool force_enable_dimms;
 module_param(force_enable_dimms, bool, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(force_enable_dimms, "Ignore _STA (ACPI DIMM device) status");
 
+struct nfit_table_prev {
+	struct list_head spas;
+	struct list_head memdevs;
+	struct list_head dcrs;
+	struct list_head bdws;
+	struct list_head idts;
+	struct list_head flushes;
+};
+
 static u8 nfit_uuid[NFIT_UUID_MAX][16];
 
 const u8 *to_nfit_uuid(enum nfit_uuids id)
@@ -221,12 +230,20 @@ static int nfit_spa_type(struct acpi_nfit_system_address *spa)
 }
 
 static bool add_spa(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_system_address *spa)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_spa *nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa),
-			GFP_KERNEL);
+	struct nfit_spa *nfit_spa;
+
+	list_for_each_entry(nfit_spa, &prev->spas, list) {
+		if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0) {
+			list_move_tail(&nfit_spa->list, &acpi_desc->spas);
+			return true;
+		}
+	}
 
+	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa), GFP_KERNEL);
 	if (!nfit_spa)
 		return false;
 	INIT_LIST_HEAD(&nfit_spa->list);
@@ -239,12 +256,19 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 }
 
 static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_memory_map *memdev)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_memdev *nfit_memdev = devm_kzalloc(dev,
-			sizeof(*nfit_memdev), GFP_KERNEL);
+	struct nfit_memdev *nfit_memdev;
 
+	list_for_each_entry(nfit_memdev, &prev->memdevs, list)
+		if (memcmp(nfit_memdev->memdev, memdev, sizeof(*memdev)) == 0) {
+			list_move_tail(&nfit_memdev->list, &acpi_desc->memdevs);
+			return true;
+		}
+
+	nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev), GFP_KERNEL);
 	if (!nfit_memdev)
 		return false;
 	INIT_LIST_HEAD(&nfit_memdev->list);
@@ -257,12 +281,19 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 }
 
 static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_control_region *dcr)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_dcr *nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr),
-			GFP_KERNEL);
+	struct nfit_dcr *nfit_dcr;
+
+	list_for_each_entry(nfit_dcr, &prev->dcrs, list)
+		if (memcmp(nfit_dcr->dcr, dcr, sizeof(*dcr)) == 0) {
+			list_move_tail(&nfit_dcr->list, &acpi_desc->dcrs);
+			return true;
+		}
 
+	nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr), GFP_KERNEL);
 	if (!nfit_dcr)
 		return false;
 	INIT_LIST_HEAD(&nfit_dcr->list);
@@ -274,12 +305,19 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
 }
 
 static bool add_bdw(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_data_region *bdw)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_bdw *nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw),
-			GFP_KERNEL);
+	struct nfit_bdw *nfit_bdw;
+
+	list_for_each_entry(nfit_bdw, &prev->bdws, list)
+		if (memcmp(nfit_bdw->bdw, bdw, sizeof(*bdw)) == 0) {
+			list_move_tail(&nfit_bdw->list, &acpi_desc->bdws);
+			return true;
+		}
 
+	nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw), GFP_KERNEL);
 	if (!nfit_bdw)
 		return false;
 	INIT_LIST_HEAD(&nfit_bdw->list);
@@ -291,12 +329,19 @@ static bool add_bdw(struct acpi_nfit_desc *acpi_desc,
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_interleave *idt)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_idt *nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt),
-			GFP_KERNEL);
+	struct nfit_idt *nfit_idt;
+
+	list_for_each_entry(nfit_idt, &prev->idts, list)
+		if (memcmp(nfit_idt->idt, idt, sizeof(*idt)) == 0) {
+			list_move_tail(&nfit_idt->list, &acpi_desc->idts);
+			return true;
+		}
 
+	nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt), GFP_KERNEL);
 	if (!nfit_idt)
 		return false;
 	INIT_LIST_HEAD(&nfit_idt->list);
@@ -308,12 +353,19 @@ static bool add_idt(struct acpi_nfit_desc *acpi_desc,
 }
 
 static bool add_flush(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev,
 		struct acpi_nfit_flush_address *flush)
 {
 	struct device *dev = acpi_desc->dev;
-	struct nfit_flush *nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush),
-			GFP_KERNEL);
+	struct nfit_flush *nfit_flush;
 
+	list_for_each_entry(nfit_flush, &prev->flushes, list)
+		if (memcmp(nfit_flush->flush, flush, sizeof(*flush)) == 0) {
+			list_move_tail(&nfit_flush->list, &acpi_desc->flushes);
+			return true;
+		}
+
+	nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush), GFP_KERNEL);
 	if (!nfit_flush)
 		return false;
 	INIT_LIST_HEAD(&nfit_flush->list);
@@ -324,8 +376,8 @@ static bool add_flush(struct acpi_nfit_desc *acpi_desc,
 	return true;
 }
 
-static void *add_table(struct acpi_nfit_desc *acpi_desc, void *table,
-		const void *end)
+static void *add_table(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev, void *table, const void *end)
 {
 	struct device *dev = acpi_desc->dev;
 	struct acpi_nfit_header *hdr;
@@ -343,27 +395,27 @@ static void *add_table(struct acpi_nfit_desc *acpi_desc, void *table,
 
 	switch (hdr->type) {
 	case ACPI_NFIT_TYPE_SYSTEM_ADDRESS:
-		if (!add_spa(acpi_desc, table))
+		if (!add_spa(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_MEMORY_MAP:
-		if (!add_memdev(acpi_desc, table))
+		if (!add_memdev(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_CONTROL_REGION:
-		if (!add_dcr(acpi_desc, table))
+		if (!add_dcr(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_DATA_REGION:
-		if (!add_bdw(acpi_desc, table))
+		if (!add_bdw(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_INTERLEAVE:
-		if (!add_idt(acpi_desc, table))
+		if (!add_idt(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_FLUSH_ADDRESS:
-		if (!add_flush(acpi_desc, table))
+		if (!add_flush(acpi_desc, prev, table))
 			return err;
 		break;
 	case ACPI_NFIT_TYPE_SMBIOS:
@@ -808,12 +860,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 		device_handle = __to_nfit_memdev(nfit_mem)->device_handle;
 		nvdimm = acpi_nfit_dimm_by_handle(acpi_desc, device_handle);
 		if (nvdimm) {
-			/*
-			 * If for some reason we find multiple DCRs the
-			 * first one wins
-			 */
-			dev_err(acpi_desc->dev, "duplicate DCR detected: %s\n",
-					nvdimm_name(nvdimm));
+			dimm_count++;
 			continue;
 		}
 
@@ -1482,6 +1529,9 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	struct resource res;
 	int count = 0, rc;
 
+	if (nfit_spa->is_registered)
+		return 0;
+
 	if (spa->range_index == 0) {
 		dev_dbg(acpi_desc->dev, "%s: detected invalid spa index\n",
 				__func__);
@@ -1535,6 +1585,8 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 		if (!nvdimm_volatile_region_create(nvdimm_bus, ndr_desc))
 			return -ENOMEM;
 	}
+
+	nfit_spa->is_registered = 1;
 	return 0;
 }
 
@@ -1551,71 +1603,101 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 	return 0;
 }
 
+static int acpi_nfit_check_deletions(struct acpi_nfit_desc *acpi_desc,
+		struct nfit_table_prev *prev)
+{
+	struct device *dev = acpi_desc->dev;
+
+	if (!list_empty(&prev->spas) ||
+			!list_empty(&prev->memdevs) ||
+			!list_empty(&prev->dcrs) ||
+			!list_empty(&prev->bdws) ||
+			!list_empty(&prev->idts) ||
+			!list_empty(&prev->flushes)) {
+		dev_err(dev, "new nfit deletes entries (unsupported)\n");
+		return -ENXIO;
+	}
+	return 0;
+}
+
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
 {
 	struct device *dev = acpi_desc->dev;
+	struct nfit_table_prev prev;
 	const void *end;
 	u8 *data;
 	int rc;
 
-	INIT_LIST_HEAD(&acpi_desc->spa_maps);
-	INIT_LIST_HEAD(&acpi_desc->spas);
-	INIT_LIST_HEAD(&acpi_desc->dcrs);
-	INIT_LIST_HEAD(&acpi_desc->bdws);
-	INIT_LIST_HEAD(&acpi_desc->idts);
-	INIT_LIST_HEAD(&acpi_desc->flushes);
-	INIT_LIST_HEAD(&acpi_desc->memdevs);
-	INIT_LIST_HEAD(&acpi_desc->dimms);
-	mutex_init(&acpi_desc->spa_map_mutex);
+	mutex_lock(&acpi_desc->init_mutex);
+
+	INIT_LIST_HEAD(&prev.spas);
+	INIT_LIST_HEAD(&prev.memdevs);
+	INIT_LIST_HEAD(&prev.dcrs);
+	INIT_LIST_HEAD(&prev.bdws);
+	INIT_LIST_HEAD(&prev.idts);
+	INIT_LIST_HEAD(&prev.flushes);
+
+	list_cut_position(&prev.spas, &acpi_desc->spas,
+				acpi_desc->spas.prev);
+	list_cut_position(&prev.memdevs, &acpi_desc->memdevs,
+				acpi_desc->memdevs.prev);
+	list_cut_position(&prev.dcrs, &acpi_desc->dcrs,
+				acpi_desc->dcrs.prev);
+	list_cut_position(&prev.bdws, &acpi_desc->bdws,
+				acpi_desc->bdws.prev);
+	list_cut_position(&prev.idts, &acpi_desc->idts,
+				acpi_desc->idts.prev);
+	list_cut_position(&prev.flushes, &acpi_desc->flushes,
+				acpi_desc->flushes.prev);
 
 	data = (u8 *) acpi_desc->nfit;
 	end = data + sz;
 	data += sizeof(struct acpi_table_nfit);
 	while (!IS_ERR_OR_NULL(data))
-		data = add_table(acpi_desc, data, end);
+		data = add_table(acpi_desc, &prev, data, end);
 
 	if (IS_ERR(data)) {
 		dev_dbg(dev, "%s: nfit table parsing error: %ld\n", __func__,
 				PTR_ERR(data));
-		return PTR_ERR(data);
+		rc = PTR_ERR(data);
+		goto out_unlock;
 	}
 
-	if (nfit_mem_init(acpi_desc) != 0)
-		return -ENOMEM;
+	rc = acpi_nfit_check_deletions(acpi_desc, &prev);
+	if (rc)
+		goto out_unlock;
+
+	if (nfit_mem_init(acpi_desc) != 0) {
+		rc = -ENOMEM;
+		goto out_unlock;
+	}
 
 	acpi_nfit_init_dsms(acpi_desc);
 
 	rc = acpi_nfit_register_dimms(acpi_desc);
 	if (rc)
-		return rc;
+		goto out_unlock;
+
+	rc = acpi_nfit_register_regions(acpi_desc);
 
-	return acpi_nfit_register_regions(acpi_desc);
+ out_unlock:
+	mutex_unlock(&acpi_desc->init_mutex);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_init);
 
-static int acpi_nfit_add(struct acpi_device *adev)
+static struct acpi_nfit_desc *acpi_nfit_desc_init(struct acpi_device *adev)
 {
 	struct nvdimm_bus_descriptor *nd_desc;
 	struct acpi_nfit_desc *acpi_desc;
 	struct device *dev = &adev->dev;
-	struct acpi_table_header *tbl;
-	acpi_status status = AE_OK;
-	acpi_size sz;
-	int rc;
-
-	status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "failed to find NFIT\n");
-		return -ENXIO;
-	}
 
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev_set_drvdata(dev, acpi_desc);
 	acpi_desc->dev = dev;
-	acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
 	acpi_desc->blk_do_io = acpi_nfit_blk_region_do_io;
 	nd_desc = &acpi_desc->nd_desc;
 	nd_desc->provider_name = "ACPI.NFIT";
@@ -1623,15 +1705,69 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	nd_desc->attr_groups = acpi_nfit_attribute_groups;
 
 	acpi_desc->nvdimm_bus = nvdimm_bus_register(dev, nd_desc);
-	if (!acpi_desc->nvdimm_bus)
-		return -ENXIO;
+	if (!acpi_desc->nvdimm_bus) {
+		devm_kfree(dev, acpi_desc);
+		return ERR_PTR(-ENXIO);
+	}
+
+	INIT_LIST_HEAD(&acpi_desc->spa_maps);
+	INIT_LIST_HEAD(&acpi_desc->spas);
+	INIT_LIST_HEAD(&acpi_desc->dcrs);
+	INIT_LIST_HEAD(&acpi_desc->bdws);
+	INIT_LIST_HEAD(&acpi_desc->idts);
+	INIT_LIST_HEAD(&acpi_desc->flushes);
+	INIT_LIST_HEAD(&acpi_desc->memdevs);
+	INIT_LIST_HEAD(&acpi_desc->dimms);
+	mutex_init(&acpi_desc->spa_map_mutex);
+	mutex_init(&acpi_desc->init_mutex);
+
+	return acpi_desc;
+}
+
+static int acpi_nfit_add(struct acpi_device *adev)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_nfit_desc *acpi_desc;
+	struct device *dev = &adev->dev;
+	struct acpi_table_header *tbl;
+	acpi_status status = AE_OK;
+	acpi_size sz;
+	int rc = 0;
+
+	device_lock(dev);
+	status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
+	if (ACPI_FAILURE(status)) {
+		/* This is ok, we could have an nvdimm hotplugged later */
+		dev_dbg(dev, "failed to find NFIT at startup\n");
+		goto out_unlock;
+	}
+
+	acpi_desc = acpi_nfit_desc_init(adev);
+	if (IS_ERR(acpi_desc)) {
+		dev_err(dev, "%s: error initializing acpi_desc: %ld\n",
+				__func__, PTR_ERR(acpi_desc));
+		rc = PTR_ERR(acpi_desc);
+		goto out_unlock;
+	}
+
+	acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
+
+	/* Evaluate _FIT and override with that if present */
+	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
+	if (ACPI_SUCCESS(status) && buf.length > 0) {
+		acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
+		sz = buf.length;
+	}
 
 	rc = acpi_nfit_init(acpi_desc, sz);
 	if (rc) {
 		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
-		return rc;
+		goto out_unlock;
 	}
-	return 0;
+
+ out_unlock:
+	device_unlock(dev);
+	return rc;
 }
 
 static int acpi_nfit_remove(struct acpi_device *adev)
@@ -1642,6 +1778,54 @@ static int acpi_nfit_remove(struct acpi_device *adev)
 	return 0;
 }
 
+static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
+{
+	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(&adev->dev);
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_table_nfit *nfit_saved;
+	struct device *dev = &adev->dev;
+	acpi_status status;
+	int ret;
+
+	dev_dbg(dev, "%s: event: %d\n", __func__, event);
+
+	device_lock(dev);
+	if (!dev->driver) {
+		/* dev->driver may be null if we're being removed */
+		dev_dbg(dev, "%s: no driver found for dev\n", __func__);
+		return;
+	}
+
+	if (!acpi_desc) {
+		acpi_desc = acpi_nfit_desc_init(adev);
+		if (IS_ERR(acpi_desc)) {
+			dev_err(dev, "%s: error initializing acpi_desc: %ld\n",
+				__func__, PTR_ERR(acpi_desc));
+			goto out_unlock;
+		}
+	}
+
+	/* Evaluate _FIT */
+	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to evaluate _FIT\n");
+		goto out_unlock;
+	}
+
+	nfit_saved = acpi_desc->nfit;
+	acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
+	ret = acpi_nfit_init(acpi_desc, buf.length);
+	if (!ret) {
+		/* Merge failed, restore old nfit, and exit */
+		acpi_desc->nfit = nfit_saved;
+		dev_err(dev, "failed to merge updated NFIT\n");
+	}
+	kfree(buf.pointer);
+
+ out_unlock:
+	device_unlock(dev);
+}
+
 static const struct acpi_device_id acpi_nfit_ids[] = {
 	{ "ACPI0012", 0 },
 	{ "", 0 },
@@ -1654,6 +1838,7 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ops = {
 		.add = acpi_nfit_add,
 		.remove = acpi_nfit_remove,
+		.notify = acpi_nfit_notify,
 	},
 };
 
diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
index 7e74015..beb4632 100644
--- a/drivers/acpi/nfit.h
+++ b/drivers/acpi/nfit.h
@@ -48,6 +48,7 @@ enum {
 struct nfit_spa {
 	struct acpi_nfit_system_address *spa;
 	struct list_head list;
+	int is_registered;
 };
 
 struct nfit_dcr {
@@ -97,6 +98,7 @@ struct acpi_nfit_desc {
 	struct nvdimm_bus_descriptor nd_desc;
 	struct acpi_table_nfit *nfit;
 	struct mutex spa_map_mutex;
+	struct mutex init_mutex;
 	struct list_head spa_maps;
 	struct list_head memdevs;
 	struct list_head flushes;
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 021e6f9..dce346a 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -17,8 +17,10 @@
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/ndctl.h>
 #include <linux/sizes.h>
+#include <linux/list.h>
 #include <linux/slab.h>
 #include <nfit.h>
 #include <nd.h>
@@ -44,6 +46,15 @@
  * +------+  |                 blk5.0             |  pm1.0  |    3      region5
  *           +-------------------------+----------+-+-------+
  *
+ * +--+---+
+ * | cpu1 |
+ * +--+---+                   (Hotplug DIMM)
+ *    |      +----------------------------------------------+
+ * +--+---+  |                 blk6.0/pm7.0                 |    4      region6/7
+ * | imc0 +--+----------------------------------------------+
+ * +------+
+ *
+ *
  * *) In this layout we have four dimms and two memory controllers in one
  *    socket.  Each unique interface (BLK or PMEM) to DPA space
  *    is identified by a region device with a dynamically assigned id.
@@ -85,8 +96,8 @@
  *    reference an NVDIMM.
  */
 enum {
-	NUM_PM  = 2,
-	NUM_DCR = 4,
+	NUM_PM  = 3,
+	NUM_DCR = 5,
 	NUM_BDW = NUM_DCR,
 	NUM_SPA = NUM_PM + NUM_DCR + NUM_BDW,
 	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */ + 4 /* spa1 iset */,
@@ -115,6 +126,7 @@ static u32 handle[NUM_DCR] = {
 	[1] = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
 	[2] = NFIT_DIMM_HANDLE(0, 0, 1, 0, 0),
 	[3] = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
+	[4] = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
 };
 
 struct nfit_test {
@@ -138,6 +150,7 @@ struct nfit_test {
 	dma_addr_t *dcr_dma;
 	int (*alloc)(struct nfit_test *t);
 	void (*setup)(struct nfit_test *t);
+	int setup_hotplug;
 };
 
 static struct nfit_test *to_nfit_test(struct device *dev)
@@ -428,6 +441,10 @@ static int nfit_test0_alloc(struct nfit_test *t)
 	if (!t->spa_set[1])
 		return -ENOMEM;
 
+	t->spa_set[2] = test_alloc_coherent(t, SPA0_SIZE, &t->spa_set_dma[2]);
+	if (!t->spa_set[2])
+		return -ENOMEM;
+
 	for (i = 0; i < NUM_DCR; i++) {
 		t->dimm[i] = test_alloc(t, DIMM_SIZE, &t->dimm_dma[i]);
 		if (!t->dimm[i])
@@ -950,6 +967,126 @@ static void nfit_test0_setup(struct nfit_test *t)
 	flush->hint_count = 1;
 	flush->hint_address[0] = t->flush_dma[3];
 
+	if (t->setup_hotplug) {
+		offset = offset + sizeof(struct acpi_nfit_flush_address) * 4;
+		/* dcr-descriptor4 */
+		dcr = nfit_buf + offset;
+		dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
+		dcr->header.length = sizeof(struct acpi_nfit_control_region);
+		dcr->region_index = 4+1;
+		dcr->vendor_id = 0xabcd;
+		dcr->device_id = 0;
+		dcr->revision_id = 1;
+		dcr->serial_number = ~handle[4];
+		dcr->windows = 1;
+		dcr->window_size = DCR_SIZE;
+		dcr->command_offset = 0;
+		dcr->command_size = 8;
+		dcr->status_offset = 8;
+		dcr->status_size = 4;
+
+		offset = offset + sizeof(struct acpi_nfit_control_region);
+		/* bdw4 (spa/dcr4, dimm4) */
+		bdw = nfit_buf + offset;
+		bdw->header.type = ACPI_NFIT_TYPE_DATA_REGION;
+		bdw->header.length = sizeof(struct acpi_nfit_data_region);
+		bdw->region_index = 4+1;
+		bdw->windows = 1;
+		bdw->offset = 0;
+		bdw->size = BDW_SIZE;
+		bdw->capacity = DIMM_SIZE;
+		bdw->start_address = 0;
+
+		offset = offset + sizeof(struct acpi_nfit_data_region);
+		/* spa10 (dcr4) dimm4 */
+		spa = nfit_buf + offset;
+		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
+		spa->header.length = sizeof(*spa);
+		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
+		spa->range_index = 10+1;
+		spa->address = t->dcr_dma[4];
+		spa->length = DCR_SIZE;
+
+		/*
+		 * spa11 (single-dimm interleave for hotplug, note storage
+		 * does not actually alias the related block-data-window
+		 * regions)
+		 */
+		spa = nfit_buf + offset + sizeof(*spa);
+		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
+		spa->header.length = sizeof(*spa);
+		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
+		spa->range_index = 11+1;
+		spa->address = t->spa_set_dma[2];
+		spa->length = SPA0_SIZE;
+
+		/* spa12 (bdw for dcr4) dimm4 */
+		spa = nfit_buf + offset + sizeof(*spa) * 2;
+		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
+		spa->header.length = sizeof(*spa);
+		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
+		spa->range_index = 12+1;
+		spa->address = t->dimm_dma[4];
+		spa->length = DIMM_SIZE;
+
+		offset = offset + sizeof(*spa) * 3;
+		/* mem-region14 (spa/dcr4, dimm4) */
+		memdev = nfit_buf + offset;
+		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
+		memdev->header.length = sizeof(*memdev);
+		memdev->device_handle = handle[4];
+		memdev->physical_id = 4;
+		memdev->region_id = 0;
+		memdev->range_index = 10+1;
+		memdev->region_index = 4+1;
+		memdev->region_size = 0;
+		memdev->region_offset = 0;
+		memdev->address = 0;
+		memdev->interleave_index = 0;
+		memdev->interleave_ways = 1;
+
+		/* mem-region15 (spa0, dimm4) */
+		memdev = nfit_buf + offset +
+				sizeof(struct acpi_nfit_memory_map);
+		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
+		memdev->header.length = sizeof(*memdev);
+		memdev->device_handle = handle[4];
+		memdev->physical_id = 4;
+		memdev->region_id = 0;
+		memdev->range_index = 11+1;
+		memdev->region_index = 4+1;
+		memdev->region_size = SPA0_SIZE;
+		memdev->region_offset = t->spa_set_dma[2];
+		memdev->address = 0;
+		memdev->interleave_index = 0;
+		memdev->interleave_ways = 1;
+
+		/* mem-region16 (spa/dcr4, dimm4) */
+		memdev = nfit_buf + offset +
+				sizeof(struct acpi_nfit_memory_map) * 2;
+		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
+		memdev->header.length = sizeof(*memdev);
+		memdev->device_handle = handle[4];
+		memdev->physical_id = 4;
+		memdev->region_id = 0;
+		memdev->range_index = 12+1;
+		memdev->region_index = 4+1;
+		memdev->region_size = 0;
+		memdev->region_offset = 0;
+		memdev->address = 0;
+		memdev->interleave_index = 0;
+		memdev->interleave_ways = 1;
+
+		offset = offset + sizeof(struct acpi_nfit_memory_map) * 3;
+		/* flush3 (dimm4) */
+		flush = nfit_buf + offset;
+		flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
+		flush->header.length = sizeof(struct acpi_nfit_flush_address);
+		flush->device_handle = handle[4];
+		flush->hint_count = 1;
+		flush->hint_address[0] = t->flush_dma[4];
+	}
+
 	acpi_desc = &t->acpi_desc;
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &acpi_desc->dimm_dsm_force_en);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &acpi_desc->dimm_dsm_force_en);
@@ -1108,6 +1245,29 @@ static int nfit_test_probe(struct platform_device *pdev)
 	if (!acpi_desc->nvdimm_bus)
 		return -ENXIO;
 
+	INIT_LIST_HEAD(&acpi_desc->spa_maps);
+	INIT_LIST_HEAD(&acpi_desc->spas);
+	INIT_LIST_HEAD(&acpi_desc->dcrs);
+	INIT_LIST_HEAD(&acpi_desc->bdws);
+	INIT_LIST_HEAD(&acpi_desc->idts);
+	INIT_LIST_HEAD(&acpi_desc->flushes);
+	INIT_LIST_HEAD(&acpi_desc->memdevs);
+	INIT_LIST_HEAD(&acpi_desc->dimms);
+	mutex_init(&acpi_desc->spa_map_mutex);
+	mutex_init(&acpi_desc->init_mutex);
+
+	rc = acpi_nfit_init(acpi_desc, nfit_test->nfit_size);
+	if (rc) {
+		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+		return rc;
+	}
+
+	if (nfit_test->setup != nfit_test0_setup)
+		return 0;
+
+	nfit_test->setup_hotplug = 1;
+	nfit_test->setup(nfit_test);
+
 	rc = acpi_nfit_init(acpi_desc, nfit_test->nfit_size);
 	if (rc) {
 		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
-- 
2.4.3

