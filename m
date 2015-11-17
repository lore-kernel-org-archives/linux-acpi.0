From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Subject: [PATCH v2 2/4] acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
Date: Tue, 17 Nov 2015 23:55:31 +0530
Message-ID: <1447784733-10419-3-git-send-email-gkulkarni@caviumnetworks.com>
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

Replace ACPI_DEBUG_PRINT() with pr_debug() in this patch as
ACPI_DEBUG_OUTPUT is controlled by ACPICA.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/numa.c | 54 +++++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4e427fc..36683d0 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -129,64 +129,52 @@ EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
-
-	ACPI_FUNCTION_NAME("acpi_table_print_srat_entry");
-
 	if (!header)
 		return;
 
 	switch (header->type) {
 
 	case ACPI_SRAT_TYPE_CPU_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_cpu_affinity *p =
 			    (struct acpi_srat_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
-					  p->apic_id, p->local_sapic_eid,
-					  p->proximity_domain_lo,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
-					  "enabled" : "disabled"));
+			pr_debug("SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+				 p->apic_id, p->local_sapic_eid,
+				 p->proximity_domain_lo,
+				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+				 "enabled" : "disabled");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
 	case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
-					  (unsigned long)p->base_address,
-					  (unsigned long)p->length,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
-					  "enabled" : "disabled",
-					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
-					  " hot-pluggable" : "",
-					  (p->flags & ACPI_SRAT_MEM_NON_VOLATILE)?
-					  " non-volatile" : ""));
+			pr_debug("SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
+				 (unsigned long)p->base_address,
+				 (unsigned long)p->length,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
+				 "enabled" : "disabled",
+				 (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
+				 " hot-pluggable" : "",
+				 (p->flags & ACPI_SRAT_MEM_NON_VOLATILE) ?
+				 " non-volatile" : "");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
 	case ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_x2apic_cpu_affinity *p =
 			    (struct acpi_srat_x2apic_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (x2apicid[0x%08x]) in"
-					  " proximity domain %d %s\n",
-					  p->apic_id,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
-					  "enabled" : "disabled"));
+			pr_debug("SRAT Processor (x2apicid[0x%08x]) in proximity domain %d %s\n",
+				 p->apic_id,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+				 "enabled" : "disabled");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
-- 
1.8.1.4
