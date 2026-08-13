Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21553361973;
	Thu, 13 Aug 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636156; cv=none; b=SnJrxALBkr/DAQU/LIXTrxVXZYnr1ZNHSgsSM32pshMXkZnO5+w0dnWK0PzUQQ0c3Bt1ZyLNSqFpc7IghYrZB/n7wIip2TmkRBcXBx0lFi+RfNJUE7ajQ4gqcifCQ86snP3VCPEn4AKmIsDAuLEMTBaGvyRmOI65ntVJXAA4a6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636156; c=relaxed/simple;
	bh=s177SFau+FQjuR8xwYnc0mzzaLrEN/47vTR/BVWCy5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTytY3pPNyGqHXq6FODRVt0J+BTyLkut7fcUk2u0fcyXvKbxoOZ/pHSxPybcSfa7qiaZvjrzcyN3sxu8B2xauo/dsKpwRCf5tzXCycyy1Emxtvi/BlPMOjTCMUwNt6bWpEpLd6T3BdDvJYoCOvX8e09y2bzrqNSAwiCSTPHJnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAA3DPBp531qP5Z6BQ--.54209S2;
	Thu, 13 Aug 2026 23:48:57 +0800 (CST)
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
Subject: [PATCH v2 1/3] ACPI: RHCT: validate table and node extents before traversal
Date: Thu, 13 Aug 2026 23:48:57 +0800
Message-ID: <20260813154857.62247-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813154600.58861-1-pengpeng@iscas.ac.cn>
References: <20260813154600.58861-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3DPBp531qP5Z6BQ--.54209S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4DZw13AFyUtr4fAr4DXFb_yoW7CF15pa
	1IgFy5JrWrJw13Wr4xtw4ruwsIq3y0vF4UXrWrGa45tw1kKr18KFWjkrya9F1rKF1vgw47
	Zan8tF98CF48AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

RHCT consumers construct the first node from firmware node_offset and
advance using each node length.  A bad offset, truncated header, or zero or
oversized length can make traversal leave the table or fail to progress.

Validate the root node area before constructing a pointer.  Iterate at most
node_count entries and require every complete node to remain within the
table.

Fixes: e6b9d8eddb17 ("drivers/acpi: RISC-V: Add RHCT related code")
Fixes: 9ca87564190c ("RISC-V: ACPI: RHCT: Add function to get CBO block sizes")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rhct.c | 100 ++++++++++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index 8f3f38c64a88..01d6e39c0c5a 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -10,6 +10,44 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 
+static bool rhct_table_valid(struct acpi_table_rhct *rhct)
+{
+	size_t node_bytes;
+
+	if (!rhct || rhct->header.length < sizeof(*rhct))
+		return false;
+
+	if (!rhct->node_count)
+		return true;
+
+	if (rhct->node_offset < sizeof(*rhct) ||
+	    rhct->node_offset > rhct->header.length -
+				 sizeof(struct acpi_rhct_node_header))
+		return false;
+
+	node_bytes = rhct->header.length - rhct->node_offset;
+	return rhct->node_count <=
+		node_bytes / sizeof(struct acpi_rhct_node_header);
+}
+
+static bool rhct_node_valid(struct acpi_rhct_node_header *node,
+			    struct acpi_rhct_node_header *end)
+{
+	size_t remaining;
+
+	if ((u8 *)node >= (u8 *)end)
+		return false;
+
+	remaining = (u8 *)end - (u8 *)node;
+	if (remaining < sizeof(*node) || node->length < sizeof(*node) ||
+	    node->length > remaining) {
+		pr_err(FW_BUG "Invalid RHCT node length\n");
+		return false;
+	}
+
+	return true;
+}
+
 static struct acpi_table_rhct *acpi_get_rhct(void)
 {
 	static struct acpi_table_header *rhct;
@@ -45,6 +83,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	struct acpi_table_rhct *rhct;
 	u32 *hart_info_node_offset;
 	u32 acpi_cpu_id;
+	unsigned int i;
 	int ret;
 
 	BUG_ON(acpi_disabled);
@@ -61,28 +100,39 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 		rhct = (struct acpi_table_rhct *)table;
 	}
 
-	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+	if (!rhct_table_valid(rhct))
+		return -EINVAL;
+	if (!rhct->node_count)
+		return -ENOENT;
+
+	node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct,
+			    rhct->node_offset);
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct,
+			   rhct->header.length);
+
+	for (i = 0; i < rhct->node_count; i++) {
+		if (!rhct_node_valid(node, end))
+			return -EINVAL;
 
-	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
-	     node < end;
-	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
 		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
 			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
 			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
-			if (acpi_cpu_id != hart_info->uid)
-				continue;
-
-			for (int i = 0; i < hart_info->num_offsets; i++) {
-				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
-							rhct, hart_info_node_offset[i]);
-				if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
-					isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
-								ref_node, size_hdr);
-					*isa = isa_node->isa;
-					return 0;
+			if (acpi_cpu_id == hart_info->uid) {
+				for (int j = 0; j < hart_info->num_offsets; j++) {
+					ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+								rhct, hart_info_node_offset[j]);
+					if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+						isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
+									ref_node, size_hdr);
+						*isa = isa_node->isa;
+						return 0;
+					}
 				}
 			}
 		}
+
+		node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node,
+				    node->length);
 	}
 
 	return -1;
@@ -141,6 +191,7 @@ void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 	struct acpi_rhct_node_header *node, *end;
 	struct acpi_rhct_hart_info *hart_info;
 	struct acpi_table_rhct *rhct;
+	unsigned int i;
 
 	if (acpi_disabled)
 		return;
@@ -162,14 +213,25 @@ void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 	if (cbop_size)
 		*cbop_size = 0;
 
-	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
-	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
-	     node < end;
-	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+	if (!rhct_table_valid(rhct) || !rhct->node_count)
+		return;
+
+	node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct,
+			    rhct->node_offset);
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct,
+			   rhct->header.length);
+
+	for (i = 0; i < rhct->node_count; i++) {
+		if (!rhct_node_valid(node, end))
+			return;
+
 		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
 			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
 			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
 						      cboz_size, cbop_size);
 		}
+
+		node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node,
+				    node->length);
 	}
 }
-- 
2.50.1 (Apple Git-155)

