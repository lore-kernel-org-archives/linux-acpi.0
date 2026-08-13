Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9B4908AF;
	Thu, 13 Aug 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635701; cv=none; b=MQXiT4VDiqzabbqMls/IRCtZ4tKT2kzzp6bR2UJr5RwnTnAT9jQnK+OBngUrcnfApHjRu+HMkbJp7uyeQ59FitQiEc1ZsMf0hQUPH2vgOZposBx7EesAzFzw41iHx7OZhUg7C0Cxida7nG7zbAuIuzYfkK1scaVqRq6RyhZ+++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635701; c=relaxed/simple;
	bh=UYq2WyBYyJjk4r1C36k3TtSENCaoMvnK4YbfniU67/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mro+o3u1M6zXE8rnz21IY/AR6pbzgsoZxIR8CG0esCKrVIZ7yblekltCVUxJBe0YQ02VB9aGgsM/D5Pp67ZfqkObMTcIZcCUzK86UiMaTEsTtYhJMNcWwthba83gykkDmCoSAIa3zwiSvm1bDtdU/XNq+KI+Wn9zrTAIjx92SKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowABXK++j5X1q6EV6BQ--.55604S2;
	Thu, 13 Aug 2026 23:41:23 +0800 (CST)
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
Subject: [PATCH v2 1/3] ACPI: RIMT: validate table and node extents before traversal
Date: Thu, 13 Aug 2026 23:41:23 +0800
Message-ID: <20260813154123.51566-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABXK++j5X1q6EV6BQ--.55604S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18tF1xGF4UAF48tF1UJrb_yoW5CF45pa
	13K3s0vrn5JrnrWa1xtF1rAFy3AF4xtrW7JryYka1Ygws8K3y8KF42yryavFn8GF93Ww42
	yrs8tFn8CF4qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

RIMT walkers construct the first node from a firmware-provided offset and
advance by each node length.  Checking only whether the current pointer
reached the table end still permits a bad root offset, a truncated node
header, or a zero or oversized node length to be read.

Validate the root node area before constructing the first pointer.  Bound
traversal by num_nodes and require every complete node to fit in the table.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/riscv/rimt.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index e4538fa6c2c8..533e9aba6e97 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -31,6 +31,45 @@ static DEFINE_SPINLOCK(rimt_fwnode_lock);
 /* Root pointer to the mapped RIMT table */
 static struct acpi_table_header *rimt_table;
 
+static bool rimt_table_valid(void)
+{
+	struct acpi_table_rimt *rimt = (struct acpi_table_rimt *)rimt_table;
+	size_t node_bytes;
+
+	if (!rimt || rimt->header.length < sizeof(*rimt))
+		return false;
+
+	if (!rimt->num_nodes)
+		return true;
+
+	if (rimt->node_offset < sizeof(*rimt) ||
+	    rimt->node_offset > rimt->header.length -
+				 sizeof(struct acpi_rimt_node))
+		return false;
+
+	node_bytes = rimt->header.length - rimt->node_offset;
+	return rimt->num_nodes <=
+		node_bytes / sizeof(struct acpi_rimt_node);
+}
+
+static bool rimt_node_valid(struct acpi_rimt_node *node,
+			    struct acpi_rimt_node *end)
+{
+	size_t remaining;
+
+	if ((u8 *)node >= (u8 *)end)
+		return false;
+
+	remaining = (u8 *)end - (u8 *)node;
+	if (remaining < sizeof(*node) || node->length < sizeof(*node) ||
+	    node->length > remaining) {
+		pr_err(FW_BUG "Invalid RIMT node length\n");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * rimt_set_fwnode() - Create rimt_fwnode and use it to register
  *		       iommu data in the rimt_fwnode_list
@@ -153,19 +192,21 @@ static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
 	struct acpi_table_rimt *rimt;
 	int i;
 
-	if (!rimt_table)
+	if (!rimt_table_valid())
 		return NULL;
 
 	/* Get the first RIMT node */
 	rimt = (struct acpi_table_rimt *)rimt_table;
+	if (!rimt->num_nodes)
+		return NULL;
+
 	rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
 				 rimt->node_offset);
 	rimt_end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
 				rimt_table->length);
 
 	for (i = 0; i < rimt->num_nodes; i++) {
-		if (WARN_TAINT(rimt_node >= rimt_end, TAINT_FIRMWARE_WORKAROUND,
-			       "RIMT node pointer overflows, bad table!\n"))
+		if (!rimt_node_valid(rimt_node, rimt_end))
 			return NULL;
 
 		if (rimt_node->type == type &&
@@ -525,4 +566,10 @@ void __init riscv_acpi_rimt_init(void)
 
 		return;
 	}
+
+	if (!rimt_table_valid()) {
+		pr_err(FW_BUG "Invalid RIMT table layout\n");
+		acpi_put_table(rimt_table);
+		rimt_table = NULL;
+	}
 }
-- 
2.50.1 (Apple Git-155)

