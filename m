From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 3/5] ACPI/PPTT: Modify node flag detection to find last
 IDENTICAL
Date: Fri,  3 May 2019 18:24:05 -0500
Message-ID: <20190503232407.37195-4-jeremy.linton@arm.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190503232407.37195-1-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net, linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, john.garry@huawei.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

The ACPI specification implies that the IDENTICAL flag should be
set on all non leaf nodes where the children are identical.
This means that we need to be searching for the last node with
the identical flag set rather than the first one.

Since this flag is also dependent on the table revision, we
need to add a bit of extra code to verify the table revision,
and the next node's state in the traversal. Since we want to
avoid function pointers here, lets just special case
the IDENTICAL flag.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 1865515297ca..456e1c0a35ae 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -432,17 +432,39 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+static bool flag_identical(struct acpi_table_header *table_hdr,
+			  struct acpi_pptt_processor *cpu)
+{
+	struct acpi_pptt_processor *next;
+
+	/* heterogeneous machines must use PPTT revision > 1 */
+	if (table_hdr->revision < 2)
+		return false;
+
+	/* Locate the last node in the tree with IDENTICAL set */
+	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
+		next = fetch_pptt_node(table_hdr, cpu->parent);
+		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
+			return true;
+	}
+
+	return false;
+}
+
 /* Passing level values greater than this will result in search termination */
 #define PPTT_ABORT_PACKAGE 0xFF
 
-static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
+static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
 								  struct acpi_pptt_processor *cpu,
 								  int level, int flag)
 {
 	struct acpi_pptt_processor *prev_node;
 
 	while (cpu && level) {
-		if (cpu->flags & flag)
+		if (flag == ACPI_PPTT_ACPI_IDENTICAL) {
+			if (flag_identical(table_hdr, cpu))
+				break;
+		} else if (cpu->flags & flag)
 			break;
 		pr_debug("level %d\n", level);
 		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
@@ -480,7 +502,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (cpu_node) {
-		cpu_node = acpi_find_processor_package_id(table, cpu_node,
+		cpu_node = acpi_find_processor_tag_id(table, cpu_node,
 							  level, flag);
 		/*
 		 * As per specification if the processor structure represents
-- 
2.21.0
