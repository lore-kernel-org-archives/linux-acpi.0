Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35F40910E;
	Mon,  6 Jul 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331197; cv=none; b=TtH7PvCkLcEbLgX7c/s/z0Y4xzdkjstVMtmUCCzfLf4B47661mQ/iHOCcIvooRHWV6QD8T1krR11Bnol/Gy8t1T0E9cOjY/zAZhBGMnm6QSfJGiTgikGhOY9oTvNAyaWkx2ocZa/ON8j0FnV1rnV75odyGbdUWAItY3J8Q69wJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331197; c=relaxed/simple;
	bh=ao0mAJF1fBeEXg2bTZVWP9KSAeybMX8ZEJsGrZRoTiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9O2gggfAR+AafSH1cfndclbTHlCEy1D4KEJKL+QrGLGSD8JBVT8xhVWHXveJjUWxxeuHrWNBh2uN62y5YAGhSKDkak2XRkyTmFI+cHTT0kSQZnoJnGX0CtYIg4zRhgKRHL6IttqQK2VbTY3qmBBj4XD4EU9Ne5pvt3k9435n2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABX9c1teUtqVN3xBA--.1422S2;
	Mon, 06 Jul 2026 17:46:21 +0800 (CST)
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
Subject: [PATCH] ACPI: RHCT: validate node reference bounds
Date: Mon,  6 Jul 2026 17:46:19 +0800
Message-ID: <20260706094619.83121-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABX9c1teUtqVN3xBA--.1422S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUGry7Jr1xJr1rWF1xKrg_yoW3Wr1DpF
	4S9345Aan8Jw1fWr1Iqa1ru3y3X340vF4UXFZ3Gayqyr1vk3WUKF4jk3429F15tF4vgw4x
	Zr4DtFyDGF48ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

RHCT hart-info nodes carry offset arrays that reference other
nodes in the same firmware table.  Validate the current node,
the hart-info offset array, and each referenced ISA or CMO node
before reading type-specific fields.

The ISA string path also checks that the advertised string range
is present before returning it to the RISC-V ISA parser.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rhct.c | 146 +++++++++++++++++++++++++++++++++-----
 1 file changed, 128 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index 8f3f38c64a88..bb8f8d4ab137 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -9,6 +9,94 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
+
+static bool rhct_node_valid(struct acpi_table_rhct *rhct,
+			    struct acpi_rhct_node_header *node)
+{
+	struct acpi_rhct_node_header *end;
+	size_t remaining;
+
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct,
+			   rhct->header.length);
+	if (node >= end)
+		return false;
+
+	remaining = (char *)end - (char *)node;
+	if (remaining < sizeof(*node) ||
+	    node->length < sizeof(*node) ||
+	    node->length > remaining) {
+		pr_err(FW_BUG "Invalid RHCT node length\n");
+		return false;
+	}
+
+	return true;
+}
+
+static struct acpi_rhct_node_header *rhct_node_from_offset(struct acpi_table_rhct *rhct,
+							   u32 offset)
+{
+	struct acpi_rhct_node_header *node;
+
+	if (offset > rhct->header.length)
+		return NULL;
+
+	node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, offset);
+	return rhct_node_valid(rhct, node) ? node : NULL;
+}
+
+static bool rhct_node_has_data(struct acpi_rhct_node_header *node,
+			       size_t data_size)
+{
+	if (node->length < sizeof(*node) + data_size) {
+		pr_err(FW_BUG "Truncated RHCT node type %u\n", node->type);
+		return false;
+	}
+
+	return true;
+}
+
+static bool rhct_hart_info_valid(struct acpi_rhct_node_header *node)
+{
+	struct acpi_rhct_hart_info *hart_info;
+	size_t offsets_size;
+
+	if (!rhct_node_has_data(node, sizeof(*hart_info)))
+		return false;
+
+	hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node,
+				 sizeof(*node));
+	if (check_mul_overflow(hart_info->num_offsets, sizeof(u32),
+			       &offsets_size) ||
+	    offsets_size > node->length - sizeof(*node) -
+			   sizeof(*hart_info)) {
+		pr_err(FW_BUG "Invalid RHCT hart-info offset array\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool rhct_isa_string_valid(struct acpi_rhct_node_header *node)
+{
+	struct acpi_rhct_isa_string *isa_node;
+	size_t remaining;
+
+	if (!rhct_node_has_data(node, sizeof(*isa_node)))
+		return false;
+
+	isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string, node,
+				sizeof(*node));
+	remaining = node->length - sizeof(*node) - sizeof(*isa_node);
+	if (isa_node->isa_length > remaining ||
+	    !memchr(isa_node->isa, '\0', isa_node->isa_length)) {
+		pr_err(FW_BUG "Invalid RHCT ISA string\n");
+		return false;
+	}
+
+	return true;
+}
 
 static struct acpi_table_rhct *acpi_get_rhct(void)
 {
@@ -38,8 +126,6 @@ static struct acpi_table_rhct *acpi_get_rhct(void)
 int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const char **isa)
 {
 	struct acpi_rhct_node_header *node, *ref_node, *end;
-	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
-	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
 	struct acpi_rhct_hart_info *hart_info;
 	struct acpi_rhct_isa_string *isa_node;
 	struct acpi_table_rhct *rhct;
@@ -66,18 +152,32 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
 	     node < end;
 	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (!rhct_node_valid(rhct, node))
+			return -EINVAL;
+
 		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
-			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
-			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (!rhct_hart_info_valid(node))
+				return -EINVAL;
+
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node,
+						 sizeof(*node));
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info,
+							     sizeof(*hart_info));
 			if (acpi_cpu_id != hart_info->uid)
 				continue;
 
 			for (int i = 0; i < hart_info->num_offsets; i++) {
-				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
-							rhct, hart_info_node_offset[i]);
+				ref_node = rhct_node_from_offset(rhct,
+								 hart_info_node_offset[i]);
+				if (!ref_node)
+					return -EINVAL;
+
 				if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+					if (!rhct_isa_string_valid(ref_node))
+						return -EINVAL;
+
 					isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
-								ref_node, size_hdr);
+								ref_node, sizeof(*ref_node));
 					*isa = isa_node->isa;
 					return 0;
 				}
@@ -89,22 +189,32 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 }
 
 static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
-					  struct acpi_rhct_hart_info *hart_info,
+					  struct acpi_rhct_node_header *node,
 					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
 {
-	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
-	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
 	struct acpi_rhct_node_header *ref_node;
+	struct acpi_rhct_hart_info *hart_info;
 	struct acpi_rhct_cmo_node *cmo_node;
 	u32 *hart_info_node_offset;
 
-	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+	if (!rhct_hart_info_valid(node))
+		return;
+
+	hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node,
+				 sizeof(*node));
+	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info,
+					     sizeof(*hart_info));
 	for (int i = 0; i < hart_info->num_offsets; i++) {
-		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
-					rhct, hart_info_node_offset[i]);
+		ref_node = rhct_node_from_offset(rhct, hart_info_node_offset[i]);
+		if (!ref_node)
+			return;
+
 		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+			if (!rhct_node_has_data(ref_node, sizeof(*cmo_node)))
+				return;
+
 			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
-						ref_node, size_hdr);
+						ref_node, sizeof(*ref_node));
 			if (cbom_size && cmo_node->cbom_size <= 30) {
 				if (!*cbom_size)
 					*cbom_size = BIT(cmo_node->cbom_size);
@@ -137,9 +247,7 @@ static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size)
 {
-	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
 	struct acpi_rhct_node_header *node, *end;
-	struct acpi_rhct_hart_info *hart_info;
 	struct acpi_table_rhct *rhct;
 
 	if (acpi_disabled)
@@ -166,9 +274,11 @@ void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
 	     node < end;
 	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (!rhct_node_valid(rhct, node))
+			return;
+
 		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
-			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
-			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
+			acpi_parse_hart_info_cmo_node(rhct, node, cbom_size,
 						      cboz_size, cbop_size);
 		}
 	}
-- 
2.43.0

