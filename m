From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] ACPI/PPTT: Simplify leaf node detection.
Date: Fri,  1 Mar 2019 12:52:21 -0600
Message-ID: <20190301185221.608501-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-acpi@vger.kernel.org

ACPI 6.3 bumps the PPTT table revision and adds a LEAF_NODE flag.
This allows us to avoid a second pass through the table to assure
that the node in question is a leaf.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index ad31c50de3be..065c4fc245d1 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -209,6 +209,9 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	struct acpi_pptt_processor *cpu_node;
 	u32 proc_sz;
 
+	if (table_hdr->revision > 1)
+		return (node->flags & ACPI_PPTT_ACPI_LEAF_NODE);
+
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
-- 
2.20.1
