Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFD2F8E98;
	Thu, 13 Aug 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637057; cv=none; b=lUdMBE4maKekRL482NmlrFgDsfMh7k8ro2hS/OfSl3XqJ4f0dzxXMXWmxpQpuWrqp4fAMOphox+3BMc9r+1r2zzUR8ky5TybkWR9fJu8DLwLv/hlMWZKkCrVh7MKnUx2HINU22wH/fDVbnfAAdyXkdvEnWggv5CKSsku6ubaGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637057; c=relaxed/simple;
	bh=2LtZ3cYUMI0i+nvTYSbTqG4og8sUeAQPXZ2li1ybIxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIyfY13UYij/BPOWWE+0KTbL3dlBVhGj1mmRBblCO5VRj5nCvlw8KuYCoNgRCaQrx226gBnNFx5K4Eq0l2BJjPLUyHKCBCn4Oe11vOgJm4yp4jg5onq0P3hzyC/pyBARUDS3bE60xHIANYCGwM3T/hIg7TCPN4+H6z8urnrFXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowABnPfH26n1qtTJ7BQ--.24293S2;
	Fri, 14 Aug 2026 00:04:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2 1/2] ACPI: IORT: validate table and node extents before traversal
Date: Fri, 14 Aug 2026 00:04:06 +0800
Message-ID: <20260813160406.71911-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
References: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnPfH26n1qtTJ7BQ--.24293S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrW8Gw13Kry8Wr13CFy5CFg_yoW7Xw13pr
	4DGFWYqrZ3JFsrW3yxtrZ5Cw45Aw4Ikr4UJr4rGayakwn5C345CFW2kr9I9F1rGF4kWw48
	ZF1Y9FyjkFWDAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoq2MUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

IORT walkers construct the first node from firmware node_offset and then
read node fields after checking only whether the current pointer reached
the table end.  A bad root offset, truncated node header, or zero or
oversized node length can therefore escape the table or prevent progress.

Validate the root table and minimum node area before constructing the first
pointer.  Reuse a remaining-length check in each generic IORT node walk so
every advertised node is contained before its fields are consumed.

Fixes: 88ef16d888a0 ("ACPI: I/O Remapping Table (IORT) initial support")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/arm64/iort.c | 64 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index af7a9b2fd5bc..101d54eec544 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -148,6 +148,48 @@ typedef acpi_status (*iort_find_node_callback)
 /* Root pointer to the mapped IORT table */
 static struct acpi_table_header *iort_table;
 
+static bool iort_table_valid(struct acpi_table_iort *iort)
+{
+	size_t node_bytes;
+
+	if (!iort || iort->header.length < sizeof(*iort))
+		return false;
+
+	if (!iort->node_count)
+		return true;
+
+	if (iort->node_offset < sizeof(*iort) ||
+	    iort->node_offset > iort->header.length -
+				      sizeof(struct acpi_iort_node))
+		return false;
+
+	node_bytes = iort->header.length - iort->node_offset;
+	return iort->node_count <=
+		node_bytes / sizeof(struct acpi_iort_node);
+}
+
+static bool iort_node_valid(struct acpi_iort_node *node,
+			    struct acpi_iort_node *end)
+{
+	size_t remaining;
+
+	if (WARN_TAINT(node >= end, TAINT_FIRMWARE_WORKAROUND,
+		       "IORT node pointer overflows, bad table!\n"))
+		return false;
+
+	remaining = (u8 *)end - (u8 *)node;
+	if (WARN_TAINT(remaining < sizeof(*node), TAINT_FIRMWARE_WORKAROUND,
+		       "IORT node header is truncated, bad table!\n"))
+		return false;
+
+	if (WARN_TAINT(node->length < sizeof(*node) ||
+		       node->length > remaining, TAINT_FIRMWARE_WORKAROUND,
+		       "IORT node length overflows, bad table!\n"))
+		return false;
+
+	return true;
+}
+
 static LIST_HEAD(iort_msi_chip_list);
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
 
@@ -237,14 +279,16 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 
 	/* Get the first IORT node */
 	iort = (struct acpi_table_iort *)iort_table;
+	if (!iort_table_valid(iort) || !iort->node_count)
+		return NULL;
+
 	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
 				 iort->node_offset);
 	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 				iort_table->length);
 
 	for (i = 0; i < iort->node_count; i++) {
-		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
-			       "IORT node pointer overflows, bad table!\n"))
+		if (!iort_node_valid(iort_node, iort_end))
 			return NULL;
 
 		if (iort_node->type == type &&
@@ -1168,6 +1212,8 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
 		return;
 
 	iort = (struct acpi_table_iort *)iort_table;
+	if (!iort_table_valid(iort) || !iort->node_count)
+		return;
 
 	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
 				 iort->node_offset);
@@ -1175,8 +1221,7 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
 				iort_table->length);
 
 	for (i = 0; i < iort->node_count; i++) {
-		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
-			       "IORT node pointer overflows, bad table!\n"))
+		if (!iort_node_valid(iort_node, iort_end))
 			return;
 
 		if (iort_node->type == ACPI_IORT_NODE_RMR)
@@ -2054,6 +2099,8 @@ static void __init iort_init_platform_devices(void)
 	 * have different struct types
 	 */
 	iort = (struct acpi_table_iort *)iort_table;
+	if (!iort_table_valid(iort) || !iort->node_count)
+		return;
 
 	/* Get the first IORT node */
 	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
@@ -2062,10 +2109,8 @@ static void __init iort_init_platform_devices(void)
 				iort_table->length);
 
 	for (i = 0; i < iort->node_count; i++) {
-		if (iort_node >= iort_end) {
-			pr_err("iort node pointer overflows, bad table\n");
+		if (!iort_node_valid(iort_node, iort_end))
 			return;
-		}
 
 		iort_enable_acs(iort_node);
 
@@ -2132,12 +2177,14 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 				(struct acpi_table_header **)&iort);
 	if (ACPI_FAILURE(status))
 		return limit;
+	if (!iort_table_valid(iort) || !iort->node_count)
+		goto out;
 
 	node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
 	end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
 
 	for (i = 0; i < iort->node_count; i++) {
-		if (node >= end)
+		if (!iort_node_valid(node, end))
 			break;
 
 		switch (node->type) {
@@ -2162,6 +2209,7 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 		}
 		node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
 	}
+out:
 	acpi_put_table(&iort->header);
 	return limit;
 }
-- 
2.50.1 (Apple Git-155)

