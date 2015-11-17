From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Subject: [PATCH v2 1/4] acpi, numa: Use pr_fmt() instead of printk
Date: Tue, 17 Nov 2015 23:55:30 +0530
Message-ID: <1447784733-10419-2-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com
Cc: gpkulkarni@gmail.com
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Just do some cleanups to replace printk with pr_fmt().

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/numa.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 72b6e9e..4e427fc 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -18,6 +18,9 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
+
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -28,8 +31,6 @@
 #include <linux/nodemask.h>
 #include <linux/topology.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_NUMA	0x80000000
 #define _COMPONENT	ACPI_NUMA
 ACPI_MODULE_NAME("numa");
@@ -187,9 +188,8 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 #endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 	default:
-		printk(KERN_WARNING PREFIX
-		       "Found unsupported SRAT entry (type = 0x%x)\n",
-		       header->type);
+		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
+			header->type);
 		break;
 	}
 }
@@ -222,7 +222,7 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
 
 	if (!slit_valid(slit)) {
-		printk(KERN_INFO "ACPI: SLIT table looks invalid. Not used.\n");
+		pr_info("SLIT table looks invalid. Not used.\n");
 		return -EINVAL;
 	}
 	acpi_numa_slit_init(slit);
@@ -233,12 +233,9 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 void __init __weak
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 {
-	printk(KERN_WARNING PREFIX
-	       "Found unsupported x2apic [0x%08x] SRAT entry\n", pa->apic_id);
-	return;
+	pr_warn("Found unsupported x2apic [0x%08x] SRAT entry\n", pa->apic_id);
 }
 
-
 static int __init
 acpi_parse_x2apic_affinity(struct acpi_subtable_header *header,
 			   const unsigned long end)
-- 
1.8.1.4
