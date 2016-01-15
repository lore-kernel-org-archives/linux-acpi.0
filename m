From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/3] libnvdimm, nfit: move nvdimm poison search to core
Date: Thu, 14 Jan 2016 18:31:55 -0700
Message-ID: <1452821516-26788-3-git-send-email-vishal.l.verma@intel.com>
References: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31358 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbcAOBcI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 20:32:08 -0500
In-Reply-To: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linda Knippers <linda.knippers@hpe.com>

Sending ARS DSMs to get a poison list is dissociated from the nfit
driver, so move all the related code into libnvdimm core.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit.c       | 198 +--------------------------------------------
 drivers/nvdimm/core.c     | 200 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libnvdimm.h |   3 +-
 3 files changed, 201 insertions(+), 200 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index e1dbc8d..168e076 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ndctl.h>
-#include <linux/delay.h>
 #include <linux/list.h>
 #include <linux/acpi.h>
 #include <linux/sort.h>
@@ -1474,201 +1473,6 @@ static void acpi_nfit_blk_region_disable(struct nvdimm_bus *nvdimm_bus,
 	/* devm will free nfit_blk */
 }
 
-static int ars_get_cap(struct nvdimm_bus_descriptor *nd_desc,
-		struct nd_cmd_ars_cap *cmd, u64 addr, u64 length)
-{
-	cmd->address = addr;
-	cmd->length = length;
-
-	return nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_CAP, cmd,
-			sizeof(*cmd));
-}
-
-static int ars_do_start(struct nvdimm_bus_descriptor *nd_desc,
-		struct nd_cmd_ars_start *cmd, u64 addr, u64 length)
-{
-	int rc;
-
-	cmd->address = addr;
-	cmd->length = length;
-	cmd->type = ND_ARS_PERSISTENT;
-
-	while (1) {
-		rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_START, cmd,
-				sizeof(*cmd));
-		if (rc)
-			return rc;
-		switch (cmd->status) {
-		case 0:
-			return 0;
-		case 1:
-			/* ARS unsupported, but we should never get here */
-			return 0;
-		case 2:
-			return -EINVAL;
-		case 3:
-			/* ARS is in progress */
-			msleep(1000);
-			break;
-		default:
-			return -ENXIO;
-		}
-	}
-}
-
-static int ars_get_status(struct nvdimm_bus_descriptor *nd_desc,
-		struct nd_cmd_ars_status *cmd)
-{
-	int rc;
-
-	while (1) {
-		rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_STATUS, cmd,
-			sizeof(*cmd));
-		if (rc || cmd->status & 0xffff)
-			return -ENXIO;
-
-		/* Check extended status (Upper two bytes) */
-		switch (cmd->status >> 16) {
-		case 0:
-			return 0;
-		case 1:
-			/* ARS is in progress */
-			msleep(1000);
-			break;
-		case 2:
-			/* No ARS performed for the current boot */
-			return 0;
-		default:
-			return -ENXIO;
-		}
-	}
-}
-
-static int ars_status_process_records(struct nvdimm_bus *nvdimm_bus,
-		struct nd_cmd_ars_status *ars_status, u64 start)
-{
-	int rc;
-	u32 i;
-
-	/*
-	 * The address field returned by ars_status should be either
-	 * less than or equal to the address we last started ARS for.
-	 * The (start, length) returned by ars_status should also have
-	 * non-zero overlap with the range we started ARS for.
-	 * If this is not the case, bail.
-	 */
-	if (ars_status->address > start ||
-			(ars_status->address + ars_status->length < start))
-		return -ENXIO;
-
-	for (i = 0; i < ars_status->num_records; i++) {
-		rc = nvdimm_bus_add_poison(nvdimm_bus,
-				ars_status->records[i].err_address,
-				ars_status->records[i].length);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
-}
-
-static int acpi_nfit_find_poison(struct acpi_nfit_desc *acpi_desc,
-		struct nd_region_desc *ndr_desc)
-{
-	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
-	struct nvdimm_bus *nvdimm_bus = acpi_desc->nvdimm_bus;
-	struct nd_cmd_ars_status *ars_status = NULL;
-	struct nd_cmd_ars_start *ars_start = NULL;
-	struct nd_cmd_ars_cap *ars_cap = NULL;
-	u64 start, len, cur, remaining;
-	int rc;
-
-	ars_cap = kzalloc(sizeof(*ars_cap), GFP_KERNEL);
-	if (!ars_cap)
-		return -ENOMEM;
-
-	start = ndr_desc->res->start;
-	len = ndr_desc->res->end - ndr_desc->res->start + 1;
-
-	rc = ars_get_cap(nd_desc, ars_cap, start, len);
-	if (rc)
-		goto out;
-
-	/*
-	 * If ARS is unsupported, or if the 'Persistent Memory Scrub' flag in
-	 * extended status is not set, skip this but continue initialization
-	 */
-	if ((ars_cap->status & 0xffff) ||
-		!(ars_cap->status >> 16 & ND_ARS_PERSISTENT)) {
-		dev_warn(acpi_desc->dev,
-			"ARS unsupported (status: 0x%x), won't create an error list\n",
-			ars_cap->status);
-		goto out;
-	}
-
-	/*
-	 * Check if a full-range ARS has been run. If so, use those results
-	 * without having to start a new ARS.
-	 */
-	ars_status = kzalloc(ars_cap->max_ars_out + sizeof(*ars_status),
-			GFP_KERNEL);
-	if (!ars_status) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	rc = ars_get_status(nd_desc, ars_status);
-	if (rc)
-		goto out;
-
-	if (ars_status->address <= start &&
-		(ars_status->address + ars_status->length >= start + len)) {
-		rc = ars_status_process_records(nvdimm_bus, ars_status, start);
-		goto out;
-	}
-
-	/*
-	 * ARS_STATUS can overflow if the number of poison entries found is
-	 * greater than the maximum buffer size (ars_cap->max_ars_out)
-	 * To detect overflow, check if the length field of ars_status
-	 * is less than the length we supplied. If so, process the
-	 * error entries we got, adjust the start point, and start again
-	 */
-	ars_start = kzalloc(sizeof(*ars_start), GFP_KERNEL);
-	if (!ars_start)
-		return -ENOMEM;
-
-	cur = start;
-	remaining = len;
-	do {
-		u64 done, end;
-
-		rc = ars_do_start(nd_desc, ars_start, cur, remaining);
-		if (rc)
-			goto out;
-
-		rc = ars_get_status(nd_desc, ars_status);
-		if (rc)
-			goto out;
-
-		rc = ars_status_process_records(nvdimm_bus, ars_status, cur);
-		if (rc)
-			goto out;
-
-		end = min(cur + remaining,
-			ars_status->address + ars_status->length);
-		done = end - cur;
-		cur += done;
-		remaining -= done;
-	} while (remaining);
-
- out:
-	kfree(ars_cap);
-	kfree(ars_start);
-	kfree(ars_status);
-	return rc;
-}
-
 static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
 		struct nd_mapping *nd_mapping, struct nd_region_desc *ndr_desc,
 		struct acpi_nfit_memory_map *memdev,
@@ -1781,7 +1585,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 
 	nvdimm_bus = acpi_desc->nvdimm_bus;
 	if (nfit_spa_type(spa) == NFIT_SPA_PM) {
-		rc = acpi_nfit_find_poison(acpi_desc, ndr_desc);
+		rc = nvdimm_bus_find_poison(nvdimm_bus, ndr_desc);
 		if (rc) {
 			dev_err(acpi_desc->dev,
 				"error while performing ARS to find poison: %d\n",
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 2e2832b..69994036 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/ctype.h>
 #include <linux/ndctl.h>
 #include <linux/mutex.h>
@@ -487,7 +488,8 @@ static int __add_poison(struct nvdimm_bus *nvdimm_bus, u64 addr, u64 length)
 	return 0;
 }
 
-int nvdimm_bus_add_poison(struct nvdimm_bus *nvdimm_bus, u64 addr, u64 length)
+static int nvdimm_bus_add_poison(struct nvdimm_bus *nvdimm_bus, u64 addr,
+		u64 length)
 {
 	struct nd_poison *pl;
 
@@ -514,7 +516,201 @@ int nvdimm_bus_add_poison(struct nvdimm_bus *nvdimm_bus, u64 addr, u64 length)
 	 */
 	return __add_poison(nvdimm_bus, addr, length);
 }
-EXPORT_SYMBOL_GPL(nvdimm_bus_add_poison);
+
+static int ars_get_cap(struct nvdimm_bus_descriptor *nd_desc,
+		struct nd_cmd_ars_cap *cmd, u64 addr, u64 length)
+{
+	cmd->address = addr;
+	cmd->length = length;
+
+	return nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_CAP, cmd,
+			sizeof(*cmd));
+}
+
+static int ars_do_start(struct nvdimm_bus_descriptor *nd_desc,
+		struct nd_cmd_ars_start *cmd, u64 addr, u64 length)
+{
+	int rc;
+
+	cmd->address = addr;
+	cmd->length = length;
+	cmd->type = ND_ARS_PERSISTENT;
+
+	while (1) {
+		rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_START, cmd,
+				sizeof(*cmd));
+		if (rc)
+			return rc;
+		switch (cmd->status) {
+		case 0:
+			return 0;
+		case 1:
+			/* ARS unsupported, but we should never get here */
+			return 0;
+		case 2:
+			return -EINVAL;
+		case 3:
+			/* ARS is in progress */
+			msleep(1000);
+			break;
+		default:
+			return -ENXIO;
+		}
+	}
+}
+
+static int ars_get_status(struct nvdimm_bus_descriptor *nd_desc,
+		struct nd_cmd_ars_status *cmd)
+{
+	int rc;
+
+	while (1) {
+		rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_STATUS, cmd,
+			sizeof(*cmd));
+		if (rc || cmd->status & 0xffff)
+			return -ENXIO;
+
+		/* Check extended status (Upper two bytes) */
+		switch (cmd->status >> 16) {
+		case 0:
+			return 0;
+		case 1:
+			/* ARS is in progress */
+			msleep(1000);
+			break;
+		case 2:
+			/* No ARS performed for the current boot */
+			return 0;
+		default:
+			return -ENXIO;
+		}
+	}
+}
+
+static int ars_status_process_records(struct nvdimm_bus *nvdimm_bus,
+		struct nd_cmd_ars_status *ars_status, u64 start)
+{
+	int rc;
+	u32 i;
+
+	/*
+	 * The address field returned by ars_status should be either
+	 * less than or equal to the address we last started ARS for.
+	 * The (start, length) returned by ars_status should also have
+	 * non-zero overlap with the range we started ARS for.
+	 * If this is not the case, bail.
+	 */
+	if (ars_status->address > start ||
+			(ars_status->address + ars_status->length < start))
+		return -ENXIO;
+
+	for (i = 0; i < ars_status->num_records; i++) {
+		rc = nvdimm_bus_add_poison(nvdimm_bus,
+				ars_status->records[i].err_address,
+				ars_status->records[i].length);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+int nvdimm_bus_find_poison(struct nvdimm_bus *nvdimm_bus,
+		struct nd_region_desc *ndr_desc)
+{
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	struct nd_cmd_ars_status *ars_status = NULL;
+	struct nd_cmd_ars_start *ars_start = NULL;
+	struct nd_cmd_ars_cap *ars_cap = NULL;
+	u64 start, len, cur, remaining;
+	int rc;
+
+	ars_cap = kzalloc(sizeof(*ars_cap), GFP_KERNEL);
+	if (!ars_cap)
+		return -ENOMEM;
+
+	start = ndr_desc->res->start;
+	len = ndr_desc->res->end - ndr_desc->res->start + 1;
+
+	rc = ars_get_cap(nd_desc, ars_cap, start, len);
+	if (rc)
+		goto out;
+
+	/*
+	 * If ARS is unsupported, or if the 'Persistent Memory Scrub' flag in
+	 * extended status is not set, skip this but continue initialization
+	 */
+	if ((ars_cap->status & 0xffff) ||
+		!(ars_cap->status >> 16 & ND_ARS_PERSISTENT)) {
+		dev_warn(&nvdimm_bus->dev,
+			"ARS unsupported (status: 0x%x), won't create an error list\n",
+			ars_cap->status);
+		goto out;
+	}
+
+	/*
+	 * Check if a full-range ARS has been run. If so, use those results
+	 * without having to start a new ARS.
+	 */
+	ars_status = kzalloc(ars_cap->max_ars_out + sizeof(*ars_status),
+			GFP_KERNEL);
+	if (!ars_status) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = ars_get_status(nd_desc, ars_status);
+	if (rc)
+		goto out;
+
+	if (ars_status->address <= start &&
+		(ars_status->address + ars_status->length >= start + len)) {
+		rc = ars_status_process_records(nvdimm_bus, ars_status, start);
+		goto out;
+	}
+
+	/*
+	 * ARS_STATUS can overflow if the number of poison entries found is
+	 * greater than the maximum buffer size (ars_cap->max_ars_out)
+	 * To detect overflow, check if the length field of ars_status
+	 * is less than the length we supplied. If so, process the
+	 * error entries we got, adjust the start point, and start again
+	 */
+	ars_start = kzalloc(sizeof(*ars_start), GFP_KERNEL);
+	if (!ars_start)
+		return -ENOMEM;
+
+	cur = start;
+	remaining = len;
+	do {
+		u64 done, end;
+
+		rc = ars_do_start(nd_desc, ars_start, cur, remaining);
+		if (rc)
+			goto out;
+
+		rc = ars_get_status(nd_desc, ars_status);
+		if (rc)
+			goto out;
+
+		rc = ars_status_process_records(nvdimm_bus, ars_status, cur);
+		if (rc)
+			goto out;
+
+		end = min(cur + remaining,
+			ars_status->address + ars_status->length);
+		done = end - cur;
+		cur += done;
+		remaining -= done;
+	} while (remaining);
+
+ out:
+	kfree(ars_cap);
+	kfree(ars_start);
+	kfree(ars_status);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(nvdimm_bus_find_poison);
 
 static void free_poison_list(struct list_head *poison_list)
 {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index bed40df..aedf4fc 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -116,7 +116,8 @@ static inline struct nd_blk_region_desc *to_blk_region_desc(
 
 }
 
-int nvdimm_bus_add_poison(struct nvdimm_bus *nvdimm_bus, u64 addr, u64 length);
+int nvdimm_bus_find_poison(struct nvdimm_bus *nvdimm_bus,
+		struct nd_region_desc *ndr_desc);
 struct nvdimm_bus *__nvdimm_bus_register(struct device *parent,
 		struct nvdimm_bus_descriptor *nfit_desc, struct module *module);
 #define nvdimm_bus_register(parent, desc) \
-- 
2.5.0

