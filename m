Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049F3BD22B;
	Thu, 13 Aug 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635885; cv=none; b=bxzSPLe2gq8uJeUoCZLiQgfdvY4JIATPcIGU990f9F+/GuktILJjGupJm+lTWuxc3A4c//ZITqQdbqWfL4XHKUYH3CLfypJItMn7R+Pjs7UnJd1XxZx4+oMTdbif4Qt2MTnBVi7XaNstipY3dzpkphG1LTTP6YSBhJ2mw/5+sXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635885; c=relaxed/simple;
	bh=Zyht0mWHDZHcAP5IyAVj91TVthN80ulNOWbpbeVSRis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsEGf2C8N7CvpF1MhrZ8WEneS/J7ymJNuk/V6UQKQR2obskFXcP3CYudi0HSQw9FfadCA9uPRou6RCF3qEtWQyX2bJCkx0BhTYxJBQENQKZDC0MNjLR1ZnBfnc3SEZ9apMQscTxg32WYb4ZLM7fsY7bUKWV3EIBxNEwg10D0wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAX6+5h5n1qOm16BQ--.64263S2;
	Thu, 13 Aug 2026 23:44:33 +0800 (CST)
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
Subject: [PATCH v2 3/3] ACPI: RIMT: validate mapping references and ID arithmetic
Date: Thu, 13 Aug 2026 23:44:32 +0800
Message-ID: <20260813154432.57786-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAAX6+5h5n1qOm16BQ--.64263S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4DKFW5ZF1kWFyUtw1UZFb_yoW7Zrykp3
	y2grWYqrZ7XF4xWa1Iya1rZa4aq3W0qrW2kF40k3WDKw1q9ryxKF48ZFy3WF15JFWfGw42
	qrs8tas5ur4jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

RIMT ID mappings contain a destination node offset, a source-ID count and
a translated destination range.  The parser accepts offsets into the
middle of nodes, can follow cyclic mappings forever, and uses unchecked
u32 range arithmetic.

Resolve references only at validated node boundaries and limit a walk to
the table's node count.  Treat num_ids as the number of IDs, use
subtraction for source-range membership, and reject destination-ID
addition overflow.  Preserve the existing fallback of returning the input
ID unchanged.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rimt.c | 81 ++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index e8075f79b552..6e4b02e8ddd7 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -27,7 +27,6 @@ struct rimt_fwnode {
 static LIST_HEAD(rimt_fwnode_list);
 static DEFINE_SPINLOCK(rimt_fwnode_lock);
 
-#define RIMT_TYPE_MASK(type)	(1 << (type))
 #define RIMT_IOMMU_TYPE		BIT(0)
 
 /* Root pointer to the mapped RIMT table */
@@ -165,6 +164,39 @@ static bool rimt_node_data_valid(struct acpi_rimt_node *node)
 	}
 }
 
+static struct acpi_rimt_node *rimt_node_from_offset(u32 offset)
+{
+	struct acpi_rimt_node *node, *end;
+	struct acpi_table_rimt *rimt;
+	unsigned int i;
+
+	if (!rimt_table_valid())
+		return NULL;
+
+	rimt = (struct acpi_table_rimt *)rimt_table;
+	if (offset < rimt->node_offset || offset >= rimt->header.length)
+		return NULL;
+
+	node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt, rimt->node_offset);
+	end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt, rimt->header.length);
+
+	for (i = 0; i < rimt->num_nodes; i++) {
+		if (!rimt_node_valid(node, end))
+			return NULL;
+		if ((u8 *)node - (u8 *)rimt == offset)
+			return node;
+
+		node = ACPI_ADD_PTR(struct acpi_rimt_node, node, node->length);
+	}
+
+	return NULL;
+}
+
+static bool rimt_type_in_mask(u8 type, u8 type_mask)
+{
+	return type < 8 && BIT(type) & type_mask;
+}
+
 /**
  * rimt_set_fwnode() - Create rimt_fwnode and use it to register
  *		       iommu data in the rimt_fwnode_list
@@ -422,13 +454,19 @@ struct rimt_pci_alias_info {
 	const struct iommu_ops *ops;
 };
 
-static int rimt_id_map(struct acpi_rimt_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
+static int rimt_id_map(struct acpi_rimt_id_mapping *map, u32 rid_in,
+		       u32 *rid_out)
 {
+	u32 id_offset;
+
 	if (rid_in < map->source_id_base ||
-	    (rid_in > map->source_id_base + map->num_ids))
+	    rid_in - map->source_id_base >= map->num_ids)
 		return -ENXIO;
 
-	*rid_out = map->dest_id_base + (rid_in - map->source_id_base);
+	id_offset = rid_in - map->source_id_base;
+	if (check_add_overflow(map->dest_id_base, id_offset, rid_out))
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -469,7 +507,9 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 		return NULL;
 	}
 
-	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
+	parent = rimt_node_from_offset(map->dest_offset);
+	if (!parent || !rimt_node_data_valid(parent))
+		return NULL;
 
 	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
 	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
@@ -488,6 +528,13 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 	u32 id_mapping_offset, num_id_mapping;
 	struct acpi_rimt_pcie_rc *pci_node;
 	u32 id = id_in;
+	unsigned int depth = 0;
+	u32 num_nodes;
+
+	if (!rimt_table_valid())
+		goto fail_map;
+
+	num_nodes = ((struct acpi_table_rimt *)rimt_table)->num_nodes;
 
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
@@ -495,10 +542,10 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		int i, rc = 0;
 		u32 map_id = id;
 
-		if (!rimt_node_data_valid(node))
+		if (depth++ >= num_nodes || !rimt_node_data_valid(node))
 			goto fail_map;
 
-		if (RIMT_TYPE_MASK(node->type) & type_mask) {
+		if (rimt_type_in_mask(node->type, type_mask)) {
 			if (id_out)
 				*id_out = id;
 			return node;
@@ -522,16 +569,9 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
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
-			rc = rimt_id_map(map, node->type, map_id, &id);
+			rc = rimt_id_map(map, map_id, &id);
 			if (!rc)
 				break;
 		}
@@ -539,8 +579,13 @@ static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 		if (i == num_id_mapping)
 			goto fail_map;
 
-		node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
-				    rc ? 0 : map->dest_offset);
+		if (!map->dest_offset) {
+			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+			       node, node->type);
+			goto fail_map;
+		}
+
+		node = rimt_node_from_offset(map->dest_offset);
 	}
 
 fail_map:
@@ -561,7 +606,7 @@ static struct acpi_rimt_node *rimt_node_map_platform_id(struct acpi_rimt_node *n
 	if (!parent)
 		return NULL;
 
-	if (!(RIMT_TYPE_MASK(parent->type) & type_mask))
+	if (!rimt_type_in_mask(parent->type, type_mask))
 		parent = rimt_node_map_id(parent, id, id_out, type_mask);
 	else
 		if (id_out)
-- 
2.50.1 (Apple Git-155)

