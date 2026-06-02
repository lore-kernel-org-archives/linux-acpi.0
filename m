Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF83783C4;
	Tue,  2 Jun 2026 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384597; cv=none; b=u1hoc7tNQ6HQ6P6RNGS9R9sCq1pGkpO4UMHpcwzmJUrZYysCLAykF9qqYbVF6R8IfZ1YrrYoCuGBP6P1B5e+jKB1IFk0/h0dF3YEp4OhIIktJdvWhTVh7U0XIOjEXX2f6L7FsiTAbYR+QBPp38h9FJx76AKGrSX3G6IZcjVT9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384597; c=relaxed/simple;
	bh=j3LWQZxs0djlPAZCD7aX7+D4Rxouki06AXik8Oox2E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VunMCrWynSeurM5pAXBPTefZYvSeK39t7Nv1KqBwqToeaTts7fTo/YIYlBIiADxb1peNxfnW1YcjsRyxD89oSznxWqlxrAiIkv0XjO62xSP0Oer57mrcaMOHwEVDlelqA6KhgwEwOwvA1IZRW4UL04Qv8v9yYd5HsUAxmWwGc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gY3Wt7fe; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gY3Wt7fe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384576; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=h2pWtpjptei4P784Opv68R55ZKackwdCfjKjGSRIiNQ=;
	b=gY3Wt7feqo9rBB3iP1KHoFap53MUK1R34atzpnNtr3BOoHZAD7VEOowR453a2wITI3Pc73uBXoq0GDjox+4YNd6fpgmOAX9TdLAmescDlhjRWbeBjTGBfnGnyr2lI1wbVUMxpDnQw6qGY5ubNIdVYZKrBQDDOn/e/L0LpcfCvPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2gc_1780384574;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2gc_1780384574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:15 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 14/16] arm64: ras: support vendor node CMN700
Date: Tue,  2 Jun 2026 15:15:37 +0800
Message-ID: <20260602071540.3711528-15-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CMN (Coherent Mesh Network) architecture incorporates five distinct
device types. Each device type is associated with an error group register
set.

CMN's error records utilize a memory-mapped single error record view [1].
Critically, one error record corresponds to one AEST node, implying that
a single CMN instance can generate hundreds of AEST nodes. To manage this
scale, this driver introduces a virtual ras node, which represents an
entire CMN device, such as an HNI or HNF. This allows an HNF ras node,
for instance, to leverage its errgsr register to pinpoint which specific
error record has reported an error.

[1]: https://developer.arm.com/documentation/102308/latest/

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/arm64/aest.c    | 111 ++++++++-
 drivers/ras/arm64/Makefile   |   1 +
 drivers/ras/arm64/ras-cmn.c  | 469 +++++++++++++++++++++++++++++++++++
 drivers/ras/arm64/ras-core.c |  48 +++-
 drivers/ras/arm64/ras.h      |  29 +++
 5 files changed, 650 insertions(+), 8 deletions(-)
 create mode 100644 drivers/ras/arm64/ras-cmn.c

diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index 1b020ab7eccd..1c68c83ccf4a 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/xarray.h>
 #include <linux/cleanup.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -173,6 +174,10 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 	return 0;
 }
 
+/*
+ * Non-vendor path: attach all per-entry properties as the platform device's
+ * primary fwnode (single-layer structure).
+ */
 static int __init
 aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
 {
@@ -187,6 +192,51 @@ aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
 	return device_create_managed_software_node(&pdev->dev, props, NULL);
 }
 
+/*
+ * CMN700 path (double-layer structure):
+ *   - first_time: create the parent fwnode on @pdev carrying the vendor
+ *     identification (HID/UID);
+ *   - always:     hang a child swnode under @pdev's primary fwnode for the
+ *     current AEST entry, so that multiple AEST entries sharing the same
+ *     HID/UID accumulate as siblings under one platform device.
+ */
+static int __init
+aest_create_cmn700_fwnode(struct acpi_aest_hdr *hdr,
+			  struct platform_device *pdev, bool first_time)
+{
+	struct acpi_aest_node_interface_header *interface;
+	struct property_entry child_props[17] = { };
+	struct fwnode_handle *child;
+	int p = 0;
+	int ret;
+
+	ret = aest_init_node_props(hdr, child_props, &p, pdev);
+	if (ret)
+		return ret;
+
+	if (first_time) {
+		ret = device_create_managed_software_node(&pdev->dev, child_props, NULL);
+		if (ret)
+			return ret;
+	}
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header,
+				 hdr, hdr->node_interface_offset);
+
+	child_props[p++] = PROPERTY_ENTRY_U64("arm,record-base", interface->address);
+	/*
+	 * Hang the per-entry properties as a child swnode under the platform
+	 * device's primary fwnode. AEST platform devices live for the whole
+	 * system lifetime, so we intentionally do not track child fwnodes for
+	 * removal here.
+	 */
+	child = fwnode_create_software_node(child_props, dev_fwnode(&pdev->dev));
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+
+	return 0;
+}
+
 static int aest_node_mem_size(u8 group_format)
 {
 	switch (group_format) {
@@ -264,9 +314,60 @@ static int __init acpi_aest_init_node(struct acpi_aest_hdr *aest_hdr)
 	return 0;
 }
 
+static DEFINE_XARRAY(aest_cmn700_groups);
+static int __init acpi_aest_init_cmn700_node(struct acpi_aest_hdr *aest_hdr)
+{
+	struct acpi_aest_vendor_v2 *vendor;
+	struct platform_device *existing;
+	int ret;
+
+	vendor = ACPI_ADD_PTR(struct acpi_aest_vendor_v2, aest_hdr,
+			      aest_hdr->node_specific_offset);
+
+	/*
+	 * If a previous AEST entry already produced a platform device for
+	 * the same vendor HID/UID, just append a child swnode for the
+	 * current entry under that pdev's primary fwnode and return.
+	 */
+	existing = xa_load(&aest_cmn700_groups, vendor->acpi_uid);
+	if (existing)
+		return aest_create_cmn700_fwnode(aest_hdr, existing, false);
+
+	struct platform_device *pdev __free(platform_device_put) =
+		acpi_aest_alloc_pdev(aest_hdr);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	ret = aest_create_cmn700_fwnode(aest_hdr, pdev, true);
+	if (ret)
+		return ret;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ret;
+
+	/* pdev is now owned by the driver core; release the cleanup-managed put. */
+	struct platform_device *added = no_free_ptr(pdev);
+
+	ret = xa_err(xa_store(&aest_cmn700_groups, vendor->acpi_uid, added, GFP_KERNEL));
+	if (ret)
+		return ret;
+
+	pr_debug("Platform device added for AEST vendor node: %s.%d\n",
+		 added->name, added->id);
+
+	return 0;
+}
+
+static int __init is_acpi_aest_cmn_node(struct acpi_aest_vendor_v2 *vendor)
+{
+	return strncmp(vendor->acpi_hid, "ARMHC701", 8) == 0;
+}
+
 static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
 {
 	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_aest_vendor_v2 *vendor;
 	struct acpi_table_aest *aest;
 	int rc;
 
@@ -281,8 +382,14 @@ static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
 				"AEST node pointer overflow, bad table.\n");
 			return -EINVAL;
 		}
-
-		rc = acpi_aest_init_node(aest_node);
+		vendor = ACPI_ADD_PTR(struct acpi_aest_vendor_v2, aest_node,
+				      aest_node->node_specific_offset);
+
+		if (aest_node->type == ACPI_AEST_VENDOR_ERROR_NODE &&
+		    is_acpi_aest_cmn_node(vendor))
+			rc = acpi_aest_init_cmn700_node(aest_node);
+		else
+			rc = acpi_aest_init_node(aest_node);
 		if (rc)
 			return rc;
 
diff --git a/drivers/ras/arm64/Makefile b/drivers/ras/arm64/Makefile
index 2f3119ac3ec5..0e4c7421c131 100644
--- a/drivers/ras/arm64/Makefile
+++ b/drivers/ras/arm64/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ARM64_RAS_DRIVER) 	+= arm64_ras.o
 arm64_ras-y		:= ras-core.o
 arm64_ras-y		+= ras-sysfs.o
 arm64_ras-y		+= ras-inject.o
+arm64_ras-y		+= ras-cmn.o
diff --git a/drivers/ras/arm64/ras-cmn.c b/drivers/ras/arm64/ras-cmn.c
new file mode 100644
index 000000000000..109cdc46a717
--- /dev/null
+++ b/drivers/ras/arm64/ras-cmn.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table CMN-700 Support
+ *
+ * Copyright (c) 2025, Alibaba Inc
+ *
+ * CMN-700 exposes 6 RAS-relevant device types (HN-I, HN-F, XP, SBSX,
+ * RN-D/CXRA, MTSX). Each device type owns an error group register set
+ * holding a set of error records.
+ *
+ * CMN uses the memory-mapped single-record view, so every AEST node
+ * corresponds to exactly one CMN error record - a single mesh can
+ * yield hundreds of AEST entries. Per Arm ACPI Spec[1] §2.6.3.4 the
+ * device type is recovered from the AEST vendor-specific data. This
+ * driver enumerates every CMN AEST entry, reads the CMN node-info
+ * register and stitches all entries of the same type into one
+ * aggregate ras_node carrying many ras_records (one per logic_id).
+ *
+ * Each CMN instance owns its own error interrupt. The shared FHI/ERI
+ * lines are registered per ras_node with IRQF_SHARED, so every
+ * per-type handler runs and locates the offending record by walking
+ * the error group registers - mirroring CMN Spec[2] §3.8.
+ *
+ * The CMN RAS topology is:
+ *
+ *                     +----+
+ *                  -->|XP  |     ......
+ *                  |  +----+
+ *                  |
+ *                  |  +----+     ......
+ *                  |  |HNI |     +----------------+
+ *                  |  +----+   ->|record/AEST node|
+ *                  |           | +----------------+
+ *  +------------+  |  +----+   |    .
+ *  |CMN Instance|--|  |HNF |---|    .
+ *  +------------+  |  +----+   |    .
+ *                  |           | +----------------+
+ *                  |  +----+   ->|record/AEST node|
+ *                  |  |SBSX|     +----------------+
+ *                  |  +----+     ......
+ *                  |
+ *                  |  +----+
+ *                  -->|RND |     ......   (also MTSX)
+ *                     +----+
+ *
+ * All addressing needed to reach the CMN RAS register block, the CMN
+ * node-info register and the CMN ERRGSR is taken from AEST.
+ *
+ *   PERIPHBASE = ERRFR_addr - ERRFR_offset_in_register_block
+ *                           - register_block_offset_within_CMN
+ *              = record_base - 0x3100 - cmn_node_offset
+ *
+ * where the CMN-700 record register block places ERRFR at offset 0x3100
+ * (CMN-700 TRM[2]). The AEST "arm,node-specific-data" payload carries
+ * two u64s used by this driver: [0..7] = hnd_offset (locates the
+ * per-type ERRGSR via cmn_config->errgsr_offset()), [8..15] =
+ * cmn_node_offset (offset of this node's register block within CMN).
+ *
+ * Per CMN-700 erratum #2732981, ERRGSR for HN-I / HN-S / SBSX is
+ * broken; for those types the per-record status_reporting bit is left
+ * set so the core polls the records instead of reading ERRGSR.
+ *
+ * AEST topology consumed by this driver (see drivers/acpi/arm64/aest.c):
+ *
+ *   pdev (arm64_ras, dev_name = "cmn700")
+ *   ├── primary fwnode  :
+ *   └── child swnode x N: per-AEST-entry properties:
+ *                            arm,interface-type
+ *                            arm,record-base
+ *                            arm,node-specific-data[]  (vendor data)
+ *
+ * Each child swnode corresponds to one AEST node, i.e. one CMN error
+ * record identified by (node_type, logic_id).
+ *
+ * [1] Arm ACPI for Armv8/Armv9: https://developer.arm.com/documentation/den0093/latest
+ * [2] CMN-700 TRM (Arm 102308): https://developer.arm.com/documentation/102308/latest
+ */
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/unaligned.h>
+
+#include "ras.h"
+
+
+#define CMN_NODE_INFO			0x0000
+#define CMN_NI_NODE_TYPE		GENMASK_ULL(15, 0)
+#define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
+#define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
+
+/* Subset of CMN node types relevant to RAS */
+enum cmn_ras_node_type {
+	CMN_TYPE_HNI	= 0x4,
+	CMN_TYPE_HNF	= 0x5,
+	CMN_TYPE_XP	= 0x6,
+	CMN_TYPE_SBSX	= 0x7,
+	CMN_TYPE_MTSX	= 0x10,
+	CMN_TYPE_CXRA	= 0x100,
+	CMN_TYPE_CXHA	= 0x101,
+	CMN_TYPE_CCHA	= 0x104,
+	CMN_TYPE_HNS	= 0x200,
+};
+
+/*
+ * Offset of ERRFR within the CMN-700 RAS register block.
+ * AEST's interface->address points at ERRFR; subtracting this plus the
+ * cmn_node_offset (vendor-specific-data[8..15]) yields PERIPHBASE.
+ */
+#define CMN_ERRFR_OFFSET_IN_REGBLK	0x3100
+
+#define CMN_RAS_DEV_NUM			6
+#define CMN700_ERRGSR_NUM		8
+#define CMN_ERRGSR_OFFSET		0x3000
+
+struct cmn_vendor_data {
+	struct acpi_aest_vendor_v2 vendor;
+	int node_type;
+	int node_id;
+	int logic_id;
+};
+
+struct cmn_config {
+	int errgsr_num;
+	int dev_num;
+	const int *node_id_map;
+	const char *const *node_name;
+	int (*errgsr_mapping)(int errgsr_bit);
+	u64 (*errgsr_offset)(u64 hnd_offset, int node_idx);
+};
+
+static const char *const cmn700_node_name[] = {
+	[CMN_TYPE_HNI]	= "HNI",
+	[CMN_TYPE_HNF]	= "HNF",
+	[CMN_TYPE_XP]	= "XP",
+	[CMN_TYPE_SBSX]	= "SBSX",
+	[CMN_TYPE_CXRA]	= "RND",
+	[CMN_TYPE_MTSX]	= "MTSX",
+};
+
+static const int cmn700_node_id_map[] = {
+	[CMN_TYPE_HNI]	= 1,
+	[CMN_TYPE_HNF]	= 2,
+	[CMN_TYPE_XP]	= 0,
+	[CMN_TYPE_SBSX]	= 3,
+	[CMN_TYPE_CXRA]	= 4,
+	[CMN_TYPE_MTSX]	= 5,
+};
+
+static u64 cmn700_errgsr_offset(u64 hnd_offset, int node_idx)
+{
+	return hnd_offset + CMN_ERRGSR_OFFSET +
+	       (node_idx * 2) * CMN700_ERRGSR_NUM * 8;
+}
+
+static int cmn700_errgsr_mapping(int errgsr_bit)
+{
+	return errgsr_bit / 2;
+}
+
+static struct cmn_config cmn700_config = {
+	.errgsr_num	= CMN700_ERRGSR_NUM,
+	.dev_num	= CMN_RAS_DEV_NUM,
+	.node_name	= cmn700_node_name,
+	.node_id_map	= cmn700_node_id_map,
+	.errgsr_mapping	= cmn700_errgsr_mapping,
+	.errgsr_offset	= cmn700_errgsr_offset,
+};
+
+static struct cmn_config *cmn_config;
+
+
+static int cmn_init_vendor_data(struct device *dev, struct cmn_vendor_data *vendor_data,
+				u64 *errgsr_addr, u64 record_base)
+{
+	struct acpi_aest_vendor_v2 vendor;
+	u64 cmn_node_offset, reg, logic_id, type, node_id;
+	u64 hnd_offset, periphbase;
+	void __iomem *cmn_node_base;
+	struct fwnode_handle *child = dev_fwnode(dev);
+
+	fwnode_property_read_u8_array(child, "arm,node-specific-data",
+				       (u8 *)&vendor, sizeof(vendor));
+
+	hnd_offset = get_unaligned_le64(&vendor.vendor_specific_data[0]);
+	cmn_node_offset = get_unaligned_le64(&vendor.vendor_specific_data[8]);
+
+	periphbase = record_base - CMN_ERRFR_OFFSET_IN_REGBLK - cmn_node_offset;
+
+	cmn_node_base = devm_ioremap(dev, periphbase + cmn_node_offset +
+			    CMN_NODE_INFO, SZ_4K);
+	if (!cmn_node_base)
+		return -ENOMEM;
+
+	reg = readq_relaxed(cmn_node_base);
+	logic_id = FIELD_GET(CMN_NI_LOGICAL_ID, reg);
+	type = FIELD_GET(CMN_NI_NODE_TYPE, reg);
+	node_id = FIELD_GET(CMN_NI_NODE_ID, reg);
+
+	if (type >= ARRAY_SIZE(cmn700_node_id_map) ||
+	    !cmn_config->node_name[type]) {
+		dev_dbg(dev, "Skipping unsupported CMN node type %llx\n", type);
+		return -ENODEV;
+	}
+
+	*errgsr_addr = periphbase + cmn_config->errgsr_offset(hnd_offset,
+							      cmn_config->node_id_map[type]);
+
+	vendor_data->vendor = vendor;
+	vendor_data->node_type = type;
+	vendor_data->node_id = node_id;
+	vendor_data->logic_id = logic_id;
+
+	devm_iounmap(dev, cmn_node_base);
+
+	dev_dbg(dev, "periphbase %llx, node_offset %llx, logic_id %llx, type %llx, node_id %llx\n",
+		periphbase, cmn_node_offset, logic_id, type, node_id);
+
+	return 0;
+}
+
+/*
+ * Initialise one ras_node (representing one CMN node *type*, e.g. HN-F).
+ * Per CMN-700 erratum #2732981, ERRGSR for HN-I / HN-S / SBSX is broken;
+ * AEST conveys this via the per-record "Error group-based status reporting
+ * supported" flag (bit0 of arm,status-reporting). When that bit is 0 we
+ * leave node->errgsr NULL so the core polls instead of reading ERRGSR.
+ */
+static int cmn_init_node(struct platform_device *pdev,
+			 struct ras_node *cmn_node, u64 type, u64 errgsr_addr)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	cmn_node->dev = dev;
+	cmn_node->type = ACPI_AEST_VENDOR_ERROR_NODE;
+	cmn_node->name = devm_kasprintf(dev, GFP_KERNEL, "%s.%llx",
+					cmn_config->node_name[type], errgsr_addr);
+	if (!cmn_node->name)
+		return -ENOMEM;
+
+	/* CMN700 just support version 1 */
+	cmn_node->version = 1;
+	cmn_node->errgsr = devm_ioremap(dev, errgsr_addr, cmn_config->errgsr_num * 8);
+	if (!cmn_node->errgsr)
+		return -ENOMEM;
+
+	cmn_node->errgsr_num = cmn_config->errgsr_num;
+	cmn_node->errgsr_mapping = cmn_config->errgsr_mapping;
+	cmn_node->record_count = cmn_config->errgsr_num * BITS_PER_LONG / 2;
+	cmn_node->record_implemented = devm_bitmap_zalloc(
+		dev, cmn_node->record_count, GFP_KERNEL);
+	if (!cmn_node->record_implemented)
+		return -ENOMEM;
+	bitmap_set(cmn_node->record_implemented, 0, cmn_node->record_count);
+
+	cmn_node->status_reporting = devm_bitmap_zalloc(
+		dev, cmn_node->record_count, GFP_KERNEL);
+	if (!cmn_node->status_reporting)
+		return -ENOMEM;
+	bitmap_set(cmn_node->status_reporting, 0, cmn_node->record_count);
+	/* If !errgsr_supported leave bitmap zero so all records are polled. */
+
+	cmn_node->records = devm_kcalloc(dev, cmn_node->record_count,
+					 sizeof(struct ras_record), GFP_KERNEL);
+	if (!cmn_node->records)
+		return -ENOMEM;
+
+	cmn_node->specific_data_size = device_property_count_u8(dev,
+								"arm,node-specific-data");
+	if (cmn_node->specific_data_size > 0) {
+		cmn_node->specific_data = devm_kzalloc(dev, cmn_node->specific_data_size,
+						       GFP_KERNEL);
+		if (!cmn_node->specific_data)
+			return -ENOMEM;
+		ret = device_property_read_u8_array(dev, "arm,node-specific-data",
+						    cmn_node->specific_data,
+						    cmn_node->specific_data_size);
+		if (ret)
+			return ret;
+	}
+
+	ras_node_dbg(cmn_node, "Init with errgsr %llx\n", errgsr_addr);
+	return 0;
+}
+
+/*
+ * Process one AEST record (one child fwnode) and stitch it into the
+ * appropriate per-type ras_node. The ras_node is initialised lazily on the
+ * first record observed for that type.
+ */
+static int cmn_init_record(struct platform_device *pdev, struct ras_node *nodes,
+			   struct fwnode_handle *child)
+{
+	struct device *dev = &pdev->dev;
+	u64 errgsr_addr, record_base;
+	struct cmn_vendor_data *vendor_data;
+	struct ras_node *cmn_node;
+	struct ras_record *record;
+	int ret, node_index;
+	u8 interface_type;
+
+
+	ret = fwnode_property_read_u8(child, "arm,interface-type",
+				      &interface_type);
+	if (ret)
+		return ret;
+	if (interface_type != ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED) {
+		dev_err(dev, "CMN only supports single-record memory mapped\n");
+		return -ENODEV;
+	}
+
+	ret = fwnode_property_read_u64(child, "arm,record-base",
+				       &record_base);
+	if (ret)
+		return ret;
+
+	vendor_data = devm_kzalloc(dev, sizeof(*vendor_data), GFP_KERNEL);
+	if (!vendor_data)
+		return -ENOMEM;
+
+	ret = cmn_init_vendor_data(dev, vendor_data, &errgsr_addr, record_base);
+	if (ret)
+		return ret;
+
+	node_index = cmn_config->node_id_map[vendor_data->node_type];
+
+	cmn_node = &nodes[node_index];
+	if (!cmn_node->name) {
+		ret = cmn_init_node(pdev, cmn_node, vendor_data->node_type, errgsr_addr);
+		if (ret)
+			return ret;
+	}
+
+	if (vendor_data->logic_id >= cmn_node->record_count) {
+		dev_warn(dev, "logic_id %u exceeds record_count %u\n",
+			 vendor_data->logic_id, cmn_node->record_count);
+		return 0;
+	}
+
+	/*
+	 * CMN-700 stitches several single-mapping AEST nodes into one
+	 * aggregate ras_node, so the record_implemented / status_reporting
+	 * bitmaps that ACPI normally provides per group are absent here
+	 * and must be populated by the driver: clear the bit at this
+	 * record's logic_id slot to mark it implemented (and reporting).
+	 */
+	clear_bit(vendor_data->logic_id, cmn_node->record_implemented);
+	/* CMN-700 erratum #2732981, ERRGSR for HN-I / HN-S / SBSX is broken */
+	if (vendor_data->node_type != CMN_TYPE_HNI &&
+	    vendor_data->node_type != CMN_TYPE_HNS &&
+	    vendor_data->node_type != CMN_TYPE_SBSX)
+		clear_bit(vendor_data->logic_id, cmn_node->status_reporting);
+
+	record = &cmn_node->records[vendor_data->logic_id];
+	record->name = devm_kasprintf(dev, GFP_KERNEL, "record%d", vendor_data->logic_id);
+	if (!record->name)
+		return -ENOMEM;
+	record->regs_base = devm_ioremap(dev,
+					 (resource_size_t)record_base,
+					 sizeof(struct ras_ext_regs));
+	if (!record->regs_base)
+		return -ENOMEM;
+	record->node = cmn_node;
+	record->index = vendor_data->logic_id;
+	record->access = &ras_access[interface_type];
+
+	record->vendor_data = vendor_data;
+	record->vendor_data_size = sizeof(*vendor_data);
+
+	ras_record_dbg(record, "base %llx\n", record_base);
+	return 0;
+}
+
+/*
+ * Vendor pdev (CMN) carries one shared fhi/eri pair. Register it on each
+ * populated ras_node with IRQF_SHARED so all per-type handlers run, and
+ * enable per-record FI/CFI/UI in ERXCTLR via the shared ras_enable_irq.
+ */
+static int cmn_register_record_irq(struct platform_device *pdev,
+				   struct ras_node *nodes)
+{
+	struct device *dev = &pdev->dev;
+	int fhi_irq, eri_irq, i, ret;
+
+	fhi_irq = platform_get_irq_byname_optional(pdev, AEST_FHI_NAME);
+	eri_irq = platform_get_irq_byname_optional(pdev, AEST_ERI_NAME);
+	if (fhi_irq <= 0 && eri_irq <= 0)
+		return 0;
+
+	for (i = 0; i < cmn_config->dev_num; i++) {
+		struct ras_node *n = &nodes[i];
+		char *desc;
+
+		if (!n->name)		/* slot not used by this CMN */
+			continue;
+
+		desc = devm_kasprintf(dev, GFP_KERNEL, "arm64_ras.%s.%s",
+				      dev_name(dev), n->name);
+		if (!desc)
+			return -ENOMEM;
+
+		if (fhi_irq > 0) {
+			ret = devm_request_irq(dev, fhi_irq, ras_irq_func,
+					       IRQF_SHARED, desc, n);
+			if (ret)
+				return ret;
+			n->irq[0] = fhi_irq;
+		}
+		if (eri_irq > 0) {
+			ret = devm_request_irq(dev, eri_irq, ras_irq_func,
+					       IRQF_SHARED, desc, n);
+			if (ret)
+				return ret;
+			n->irq[1] = eri_irq;
+		}
+	}
+	return 0;
+}
+
+/* Common entry point: walk every child swnode under @pdev. */
+static int cmn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child;
+	struct ras_node *nodes;
+	int ret;
+
+	nodes = devm_kcalloc(dev, cmn_config->dev_num, sizeof(*nodes),
+				GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
+	/*
+	 * In CMN-700, each AEST node is a single mapping record, so
+	 * treat every child fwnode as one record rather than a node
+	 * with multiple records underneath.
+	 */
+	device_for_each_child_node(dev, child) {
+		ret = cmn_init_record(pdev, nodes, child);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	ret = cmn_register_record_irq(pdev, nodes);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, nodes);
+
+	for (int i = 0; i < cmn_config->dev_num; i++) {
+		ras_online_node(&nodes[i]);
+		ras_node_init_debugfs(&nodes[i]);
+	}
+
+	return 0;
+}
+
+int ras_cmn700_probe(struct platform_device *pdev)
+{
+	cmn_config = &cmn700_config;
+
+	dev_set_name(&pdev->dev, "cmn700");
+
+	return cmn_probe(pdev);
+}
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 8cde26ab95de..2fb645659694 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -284,6 +284,7 @@ static void ras_node_foreach_poll_record(void (*func)(struct ras_record *, void
 					 struct ras_node *node, void *data)
 {
 	int i;
+
 	/*
 	 * Per AEST spec:
 	 *  - record_implemented: bitmap of records that are actually
@@ -310,7 +311,7 @@ static void ras_node_foreach_poll_record(void (*func)(struct ras_record *, void
 
 static int ras_proc(struct ras_node *node)
 {
-	int count = 0, i, j, size = node->record_count;
+	int count = 0, i, j, size = node->record_count, record_idx;
 	u64 err_group = 0;
 
 	ras_node_foreach_poll_record(ras_proc_record, node, &count);
@@ -321,24 +322,27 @@ static int ras_proc(struct ras_node *node)
 	ras_node_dbg(node, "Report bitmap %*pb\n", size, node->status_reporting);
 	for (i = 0; i < BITS_TO_U64(size); i++) {
 		err_group = readq_relaxed((void *)node->errgsr + i * 8);
-		ras_node_dbg(node, "errgsr[%d]: 0x%llx\n", i, err_group);
 
 		for_each_set_bit(j, (unsigned long *)&err_group, BITS_PER_LONG) {
+			record_idx = node->errgsr_mapping(i * BITS_PER_LONG + j);
+			ras_node_dbg(node, "errgsr[%d]: bit %d occur error\n",
+				      i, record_idx);
 			/*
 			 * Error group base is only valid in Memory Map node,
 			 * so driver do not need to write select register and
 			 * sync.
 			 */
-			if (test_bit(i * BITS_PER_LONG + j, node->status_reporting))
+			if (test_bit(record_idx, node->status_reporting))
 				continue;
-			ras_proc_record(&node->records[j], &count, false);
+			ras_proc_record(&node->records[record_idx],
+					&count, false);
 		}
 	}
 
 	return count;
 }
 
-static irqreturn_t ras_irq_func(int irq, void *input)
+irqreturn_t ras_irq_func(int irq, void *input)
 {
 	struct ras_node *node = input;
 
@@ -529,7 +533,7 @@ static void ras_online_record(struct ras_record *record, void *data, bool __unus
 	ras_enable_irq(record);
 }
 
-static void ras_online_node(struct ras_node *node)
+void ras_online_node(struct ras_node *node)
 {
 	int count = 0;
 
@@ -808,6 +812,7 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 		return ERR_PTR(-EINVAL);
 	}
 
+	node->errgsr_mapping = default_errgsr_mapping;
 	node->name = alloc_ras_node_name(node);
 	if (!node->name)
 		return ERR_PTR(-ENOMEM);
@@ -877,10 +882,41 @@ static int ras_setup_irq(struct platform_device *pdev, struct ras_node *node)
 	return 0;
 }
 
+static struct ras_vendor_match vendor_match[] = {
+	{ "ARMHC701", &ras_cmn700_probe },
+	{  },
+};
+
+static int
+ras_vendor_probe(struct platform_device *pdev)
+{
+	int i;
+	struct acpi_aest_vendor_v2 vendor;
+
+	device_property_read_u8_array(&pdev->dev, "arm,node-specific-data",
+				      (u8 *)&vendor, sizeof(vendor));
+
+	dev_dbg(&pdev->dev, "Try to probe vendor node %s\n", vendor.acpi_hid);
+	for (i = 0; i < ARRAY_SIZE(vendor_match); i++) {
+		if (!strncmp(vendor_match[i].hid, vendor.acpi_hid, 8))
+			return vendor_match[i].probe(pdev);
+	}
+
+	return -ENODEV;
+}
+
 static int arm64_ras_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct ras_node *node;
+	u8 type;
+
+	ret = device_property_read_u8(&pdev->dev, "arm,node-type", &type);
+	if (ret)
+		return ret;
+
+	if (type == ACPI_AEST_VENDOR_ERROR_NODE)
+		return ras_vendor_probe(pdev);
 
 	node = ras_init_node(pdev);
 	if (IS_ERR(node))
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index 8a0d2909fe4b..75aa4ac83a41 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -9,6 +9,7 @@
 #define _DRIVERS_RAS_ARM64_RAS_H_
 
 #include <linux/acpi_aest.h>
+#include <linux/interrupt.h>
 #include <asm/ras.h>
 #include <linux/debugfs.h>
 
@@ -98,6 +99,8 @@ struct ras_record {
 	struct ras_node *node;
 	const struct ras_access *access;
 	struct dentry *debugfs;
+	void *vendor_data;
+	size_t vendor_data_size;
 
 	struct ce_threshold ce;
 	enum ras_ce_threshold threshold_type;
@@ -177,6 +180,18 @@ struct ras_node {
 	 * into SPA
 	 */
 	unsigned long *addressing_mode;
+	/*
+	 * Usually bit[n] in errgsr indicates [n]th error record within this
+	 * error node report error. But some compoent may have different rules.
+	 * For example, CMN700 TRM 4.3.5.12 say:
+	 *	``` Error occurs when the index is even and Fault
+	 *	    occurs when the index is odd. ```
+	 *	Bit[n]: record[n] report ERROR.
+	 *	Bit[n + 1]: record[n] report FAULT.
+	 * errgsr_mapping function is used to map errgsr bit to record index
+	 * for various components.
+	 */
+	int (*errgsr_mapping)(int errgsr_bit);
 	struct ras_record *records;
 
 	u32 specific_data_size;
@@ -184,6 +199,7 @@ struct ras_node {
 	u32 record_index;
 	u32 flags;
 	int version;
+	int errgsr_num;
 
 	u8 type;
 	u8 access_type;
@@ -301,8 +317,21 @@ static inline void ras_sync(struct ras_node *node)
 		isb();
 }
 
+static inline int default_errgsr_mapping(int errgsr_bit)
+{
+	return errgsr_bit;
+}
+
+struct ras_vendor_match {
+	char hid[ACPI_ID_LEN];
+	int (*probe)(struct platform_device *pdev);
+};
+
 void ras_node_init_debugfs(struct ras_node *node);
 void ras_inject_init_debugfs(struct ras_record *record);
 void ras_proc_record(struct ras_record *record, void *data, bool fake);
+irqreturn_t ras_irq_func(int irq, void *input);
+void ras_online_node(struct ras_node *node);
+int ras_cmn700_probe(struct platform_device *pdev);
 
 #endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
-- 
2.51.2.612.gdc70283dfc

