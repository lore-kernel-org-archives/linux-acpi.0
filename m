Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8F48382C;
	Thu, 13 Aug 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635796; cv=none; b=eHaB3toO5QrOnWAtFiXBkAxm7LPzIFfvTtXOKL5TE2q0oaK5j3EMbLGrLbbXu9CzcpGDr4xck+oO5+jIzJoalo3YXmnHnswm4w9J7Q2GeJP+z3JA3nkjIpH3OvzBQ+ERkaH5D1Nqx3wGT5e5ZrYVnK9340CFbXP6i/3iRLoxIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635796; c=relaxed/simple;
	bh=D9YFqKC11MYf6iP5zGNxUZ9oWrssrAXEZercgJW9Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjjFmUhJBsjmk5r/pfAZHjy6DxexgrGSnV0E4kicaPseqzntiVOC+TVvFXWBfYQfREqWjtH82rgbWkHoAKgukn+AjM2OaIO+MvirgPS32GecwWVdU8MjyP+2OSEKwecym6IUyVlxCx/d6Kaj71WFw2r3XmFQhtVcZCdExJqZjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAX7O8I5n1qKVx6BQ--.56368S2;
	Thu, 13 Aug 2026 23:43:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2 2/3] ACPI: RIMT: validate node payload and array extents
Date: Thu, 13 Aug 2026 23:43:03 +0800
Message-ID: <20260813154303.53923-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813153851.47947-1-pengpeng@iscas.ac.cn>
References: <20260813153851.47947-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAX7O8I5n1qKVx6BQ--.56368S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15GryfGw45ur4fJryxXwb_yoW7WFykpa
	y2gay5ArZrJr1xW3WIvF4rAayYqw10qrW7ta909a1qvr1kKrWxGF4jkry3uw15JFZ7Ww47
	JFs8tFs8ur4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

RIMT node lengths bound type-specific payloads, but the parser casts
node_data and follows interrupt-wire and ID-mapping offsets without proving
their extents.  Platform-device matching also treats the firmware name as
an unbounded C string.

Require each supported fixed payload and non-empty array to fit in its
node, and require a platform device name to terminate before the mapping
array or node end.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rimt.c | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 533e9aba6e97..e8075f79b552 100644
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
@@ -70,6 +72,99 @@ static bool rimt_node_valid(struct acpi_rimt_node *node,
 	return true;
 }
 
+static bool rimt_node_has_data(struct acpi_rimt_node *node, size_t data_size)
+{
+	if (node->length < sizeof(*node) ||
+	    data_size > node->length - sizeof(*node)) {
+		pr_err(FW_BUG "Truncated RIMT node type %u\n", node->type);
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
+	if (offset < min_offset || offset > node->length ||
+	    check_mul_overflow(count, elem_size, &bytes) ||
+	    bytes > node->length - offset) {
+		pr_err(FW_BUG "Invalid %s in RIMT node type %u\n", name,
+		       node->type);
+		return false;
+	}
+
+	return true;
+}
+
+static bool rimt_node_data_valid(struct acpi_rimt_node *node)
+{
+	size_t data_offset = sizeof(*node);
+
+	switch (node->type) {
+	case ACPI_RIMT_NODE_TYPE_IOMMU: {
+		struct acpi_rimt_iommu *iommu;
+
+		if (!rimt_node_has_data(node, sizeof(*iommu)))
+			return false;
+
+		iommu = (struct acpi_rimt_iommu *)node->node_data;
+		return rimt_node_array_valid(node, iommu->interrupt_wire_offset,
+					     iommu->num_interrupt_wires,
+					     sizeof(struct acpi_rimt_iommu_wire_gsi),
+					     data_offset + sizeof(*iommu),
+					     "interrupt wire array");
+	}
+	case ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX: {
+		struct acpi_rimt_pcie_rc *pci_rc;
+
+		if (!rimt_node_has_data(node, sizeof(*pci_rc)))
+			return false;
+
+		pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
+		return rimt_node_array_valid(node, pci_rc->id_mapping_offset,
+					     pci_rc->num_id_mappings,
+					     sizeof(struct acpi_rimt_id_mapping),
+					     data_offset + sizeof(*pci_rc),
+					     "ID mapping array");
+	}
+	case ACPI_RIMT_NODE_TYPE_PLAT_DEVICE: {
+		struct acpi_rimt_platform_device *plat;
+		size_t name_end;
+
+		if (!rimt_node_has_data(node, sizeof(*plat)))
+			return false;
+
+		plat = (struct acpi_rimt_platform_device *)node->node_data;
+		if (!rimt_node_array_valid(node, plat->id_mapping_offset,
+					   plat->num_id_mappings,
+					   sizeof(struct acpi_rimt_id_mapping),
+					   data_offset + sizeof(*plat),
+					   "ID mapping array"))
+			return false;
+
+		name_end = plat->num_id_mappings ? plat->id_mapping_offset :
+						     node->length;
+		if (name_end <= data_offset + sizeof(*plat) ||
+		    !memchr(plat->device_name, '\0',
+			    name_end - data_offset - sizeof(*plat))) {
+			pr_err(FW_BUG "Invalid device name in RIMT node\n");
+			return false;
+		}
+
+		return true;
+	}
+	default:
+		return false;
+	}
+}
+
 /**
  * rimt_set_fwnode() - Create rimt_fwnode and use it to register
  *		       iommu data in the rimt_fwnode_list
@@ -107,6 +202,9 @@ static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 	acpi_status status = AE_NOT_FOUND;
 	struct device *dev = context;
 
+	if (!rimt_node_data_valid(node))
+		return status;
+
 	if (node->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
 		struct acpi_rimt_iommu *iommu_node = (struct acpi_rimt_iommu *)&node->node_data;
 
@@ -285,6 +383,9 @@ static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
 {
 	struct acpi_rimt_pcie_rc *pci_rc;
 
+	if (!rimt_node_data_valid(node))
+		return false;
+
 	pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
 	return pci_rc->flags & ACPI_RIMT_PCIE_ATS_SUPPORTED;
 }
@@ -340,6 +441,9 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 	struct acpi_rimt_id_mapping *map;
 	struct acpi_rimt_node *parent;
 
+	if (index < 0 || !rimt_node_data_valid(node))
+		return NULL;
+
 	if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
 		pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
 		id_mapping_offset = pci_node->id_mapping_offset;
@@ -391,6 +495,9 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		int i, rc = 0;
 		u32 map_id = id;
 
+		if (!rimt_node_data_valid(node))
+			goto fail_map;
+
 		if (RIMT_TYPE_MASK(node->type) & type_mask) {
 			if (id_out)
 				*id_out = id;
-- 
2.50.1 (Apple Git-155)

