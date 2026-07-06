Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BF366806;
	Mon,  6 Jul 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331070; cv=none; b=FnYIwNCRXNszXMBq7QL1BGnBGL9DLokOFdo+z87T6JdH4BGOpGkcmMGaIJzin2KtBoF5u6oFZ4NZiAsxuUD0dXTfP3ekRa0dmzDrkEGqbCnXLp2+SJrm8qtfkwip7GlhQLXrmK8mnYWtfb81r5ge/vClaDw2ky3gbL2W7p+s8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331070; c=relaxed/simple;
	bh=JYEm4fiVERFoLgNYb226ahF99iTencGRQBMYWspRjSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJjGK0Jlg0jp9vrEIg4R6e3GB/dJgGMGvgWANH8rbL62eIU+qHwUpj7ebTjOdQ/N02MXl9LZm73cQNL3H5H+0gfHYpmOCAeiJ2GoWNnlle+rlHoaB0W1ZbEHZ5wkkUN37s3ayLPNFx7sY1dg36QPgEfDO5L1MxxyVhRWJK8KriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABnBc7veEtqps_xBA--.35117S2;
	Mon, 06 Jul 2026 17:44:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: RIMT: validate node and mapping bounds
Date: Mon,  6 Jul 2026 17:44:14 +0800
Message-ID: <20260706094414.82794-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnBc7veEtqps_xBA--.35117S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tw4rKryrWFyUJrWUCFWkXrb_yoWDWFWfp3
	y2gFy5JrZ7Jr17Wa1IqFs5AFWaqw18trW2kayYk3Wqyw1vgryxKFWI9Fy5W3W5JFWfGw47
	Jrs8tF98ur4qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

RIMT nodes and ID mappings are supplied by firmware. The parser
must prove that the current node body, any ID mapping array, and
any referenced destination node are inside the mapped RIMT table
before consumers read type-specific fields.

Add common node and array validators, use them before matching
IOMMU, PCI root complex, and platform-device nodes, and fetch
mapping destinations through the same validated offset path.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rimt.c | 152 ++++++++++++++++++++++++++++++++++----
 1 file changed, 138 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index e4538fa6c2c8..7c9c8406a222 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -12,8 +12,10 @@
 #include <linux/device/driver.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
 #include "init.h"
 
 struct rimt_fwnode {
@@ -31,6 +33,78 @@ static DEFINE_SPINLOCK(rimt_fwnode_lock);
 /* Root pointer to the mapped RIMT table */
 static struct acpi_table_header *rimt_table;
 
+static bool rimt_node_valid(struct acpi_rimt_node *node,
+			    struct acpi_rimt_node *end)
+{
+	size_t remaining;
+
+	if (WARN_TAINT(node >= end, TAINT_FIRMWARE_WORKAROUND,
+		       "RIMT node pointer overflows, bad table!\n"))
+		return false;
+
+	remaining = (char *)end - (char *)node;
+	if (WARN_TAINT(remaining < sizeof(*node), TAINT_FIRMWARE_WORKAROUND,
+		       "RIMT node header is truncated, bad table!\n"))
+		return false;
+
+	if (WARN_TAINT(node->length < sizeof(*node) || node->length > remaining,
+		       TAINT_FIRMWARE_WORKAROUND,
+		       "RIMT node length overflows, bad table!\n"))
+		return false;
+
+	return true;
+}
+
+static struct acpi_rimt_node *rimt_node_from_offset(u32 offset)
+{
+	struct acpi_rimt_node *node, *end;
+
+	if (!rimt_table || offset > rimt_table->length)
+		return NULL;
+
+	node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, offset);
+	end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+			   rimt_table->length);
+
+	return rimt_node_valid(node, end) ? node : NULL;
+}
+
+static bool rimt_node_has_data(struct acpi_rimt_node *node, size_t data_size)
+{
+	if (node->length < sizeof(*node) + data_size) {
+		pr_err(FW_BUG "Truncated RIMT node %p type %d\n", node,
+		       node->type);
+		return false;
+	}
+
+	return true;
+}
+
+static bool rimt_node_array_valid(struct acpi_rimt_node *node, u32 offset,
+				  u32 count, size_t elem_size,
+				  size_t min_offset, const char *name)
+{
+	size_t bytes;
+
+	if (!count)
+		return true;
+
+	if (!offset || offset < min_offset || offset > node->length) {
+		pr_err(FW_BUG "Invalid %s offset in RIMT node %p\n", name,
+		       node);
+		return false;
+	}
+
+	if (check_mul_overflow(count, elem_size, &bytes) ||
+	    bytes > node->length - offset) {
+		pr_err(FW_BUG "Invalid %s array in RIMT node %p\n", name,
+		       node);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * rimt_set_fwnode() - Create rimt_fwnode and use it to register
  *		       iommu data in the rimt_fwnode_list
@@ -69,7 +143,12 @@ static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 	struct device *dev = context;
 
 	if (node->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
-		struct acpi_rimt_iommu *iommu_node = (struct acpi_rimt_iommu *)&node->node_data;
+		struct acpi_rimt_iommu *iommu_node;
+
+		if (!rimt_node_has_data(node, sizeof(*iommu_node)))
+			return status;
+
+		iommu_node = (struct acpi_rimt_iommu *)&node->node_data;
 
 		if (dev_is_pci(dev)) {
 			struct pci_dev *pdev;
@@ -97,6 +176,9 @@ static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 		struct acpi_rimt_pcie_rc *pci_rc;
 		struct pci_bus *bus;
 
+		if (!rimt_node_has_data(node, sizeof(*pci_rc)))
+			return status;
+
 		bus = to_pci_bus(dev);
 		pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
 
@@ -112,6 +194,10 @@ static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 		struct acpi_rimt_platform_device *ncomp;
 		struct device *plat_dev = dev;
 		struct acpi_device *adev;
+		size_t name_len;
+
+		if (!rimt_node_has_data(node, sizeof(*ncomp)))
+			return status;
 
 		/*
 		 * Walk the device tree to find a device with an
@@ -138,6 +224,12 @@ static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 		}
 
 		ncomp = (struct acpi_rimt_platform_device *)node->node_data;
+		name_len = node->length - sizeof(*node) - sizeof(*ncomp);
+		if (!name_len || !memchr(ncomp->device_name, '\0', name_len)) {
+			acpi_os_free(buf.pointer);
+			return AE_NOT_FOUND;
+		}
+
 		status = !strcmp(ncomp->device_name, buf.pointer) ?
 							AE_OK : AE_NOT_FOUND;
 		acpi_os_free(buf.pointer);
@@ -164,8 +256,7 @@ static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
 				rimt_table->length);
 
 	for (i = 0; i < rimt->num_nodes; i++) {
-		if (WARN_TAINT(rimt_node >= rimt_end, TAINT_FIRMWARE_WORKAROUND,
-			       "RIMT node pointer overflows, bad table!\n"))
+		if (!rimt_node_valid(rimt_node, rimt_end))
 			return NULL;
 
 		if (rimt_node->type == type &&
@@ -244,6 +335,9 @@ static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
 {
 	struct acpi_rimt_pcie_rc *pci_rc;
 
+	if (!rimt_node_has_data(node, sizeof(*pci_rc)))
+		return false;
+
 	pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
 	return pci_rc->flags & ACPI_RIMT_PCIE_ATS_SUPPORTED;
 }
@@ -283,7 +377,7 @@ struct rimt_pci_alias_info {
 static int rimt_id_map(struct acpi_rimt_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
 {
 	if (rid_in < map->source_id_base ||
-	    (rid_in > map->source_id_base + map->num_ids))
+	    rid_in - map->source_id_base > map->num_ids)
 		return -ENXIO;
 
 	*rid_out = map->dest_id_base + (rid_in - map->source_id_base);
@@ -298,15 +392,24 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 	struct acpi_rimt_pcie_rc *pci_node;
 	struct acpi_rimt_id_mapping *map;
 	struct acpi_rimt_node *parent;
+	size_t min_offset;
 
 	if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		if (!rimt_node_has_data(node, sizeof(*pci_node)))
+			return NULL;
+
 		pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
 		id_mapping_offset = pci_node->id_mapping_offset;
 		num_id_mapping = pci_node->num_id_mappings;
+		min_offset = sizeof(*node) + sizeof(*pci_node);
 	} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+		if (!rimt_node_has_data(node, sizeof(*plat_node)))
+			return NULL;
+
 		plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
 		id_mapping_offset = plat_node->id_mapping_offset;
 		num_id_mapping = plat_node->num_id_mappings;
+		min_offset = sizeof(*node) + sizeof(*plat_node);
 	} else {
 		return NULL;
 	}
@@ -314,6 +417,10 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 	if (!id_mapping_offset || !num_id_mapping || index >= num_id_mapping)
 		return NULL;
 
+	if (!rimt_node_array_valid(node, id_mapping_offset, num_id_mapping,
+				   sizeof(*map), min_offset, "ID mapping"))
+		return NULL;
+
 	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
 			   id_mapping_offset + index * sizeof(*map));
 
@@ -324,7 +431,9 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 		return NULL;
 	}
 
-	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
+	parent = rimt_node_from_offset(map->dest_offset);
+	if (!parent)
+		return NULL;
 
 	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
 	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
@@ -343,6 +452,7 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 	u32 id_mapping_offset, num_id_mapping;
 	struct acpi_rimt_pcie_rc *pci_node;
 	u32 id = id_in;
+	size_t min_offset;
 
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
@@ -357,13 +467,21 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		}
 
 		if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+			if (!rimt_node_has_data(node, sizeof(*pci_node)))
+				goto fail_map;
+
 			pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
 			id_mapping_offset = pci_node->id_mapping_offset;
 			num_id_mapping = pci_node->num_id_mappings;
+			min_offset = sizeof(*node) + sizeof(*pci_node);
 		} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+			if (!rimt_node_has_data(node, sizeof(*plat_node)))
+				goto fail_map;
+
 			plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
 			id_mapping_offset = plat_node->id_mapping_offset;
 			num_id_mapping = plat_node->num_id_mappings;
+			min_offset = sizeof(*node) + sizeof(*plat_node);
 		} else {
 			goto fail_map;
 		}
@@ -371,16 +489,14 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		if (!id_mapping_offset || !num_id_mapping)
 			goto fail_map;
 
+		if (!rimt_node_array_valid(node, id_mapping_offset,
+					   num_id_mapping, sizeof(*map),
+					   min_offset, "ID mapping"))
+			goto fail_map;
+
 		map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
 				   id_mapping_offset);
 
-		/* Firmware bug! */
-		if (!map->dest_offset) {
-			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
-			       node, node->type);
-			goto fail_map;
-		}
-
 		/* Do the ID translation */
 		for (i = 0; i < num_id_mapping; i++, map++) {
 			rc = rimt_id_map(map, node->type, map_id, &id);
@@ -391,8 +507,16 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		if (i == num_id_mapping)
 			goto fail_map;
 
-		node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
-				    rc ? 0 : map->dest_offset);
+		/* Firmware bug! */
+		if (!map->dest_offset) {
+			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+			       node, node->type);
+			goto fail_map;
+		}
+
+		node = rimt_node_from_offset(map->dest_offset);
+		if (!node)
+			goto fail_map;
 	}
 
 fail_map:
-- 
2.43.0

