From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Subject: [PATCH v2 4/4] acpi, numa: Enable ACPI based NUMA on ARM64
Date: Tue, 17 Nov 2015 23:55:33 +0530
Message-ID: <1447784733-10419-5-git-send-email-gkulkarni@caviumnetworks.com>
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

Add function needed for cpu to node mapping, and enable
ACPI based NUMA for ARM64 in Kconfig

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |  4 ++--
 drivers/acpi/numa.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h | 15 +++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 25dbb76..06ea7dc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -280,8 +280,8 @@ config ACPI_THERMAL
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (X86 || IA64)
-	default y if IA64_GENERIC || IA64_SGI_SN2
+	depends on (X86 || IA64 || ARM64)
+	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
 
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 36683d0..807083a 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -175,6 +175,18 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_SRAT_TYPE_GICC_AFFINITY:
+		{
+			struct acpi_srat_gicc_affinity *p =
+			    (struct acpi_srat_gicc_affinity *)header;
+			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
+				 p->acpi_processor_uid,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_GICC_ENABLED) ?
+				 "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -260,6 +272,24 @@ acpi_parse_processor_affinity(struct acpi_subtable_header *header,
 	return 0;
 }
 
+static int __init
+acpi_parse_gicc_affinity(struct acpi_subtable_header *header,
+			      const unsigned long end)
+{
+	struct acpi_srat_gicc_affinity *processor_affinity;
+
+	processor_affinity = (struct acpi_srat_gicc_affinity *)header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_gicc_affinity_init(processor_affinity);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -304,6 +334,9 @@ int __init acpi_numa_init(void)
 {
 	int cnt = 0;
 
+	if (acpi_disabled)
+		return -EINVAL;
+
 	/*
 	 * Should not limit number with cpu num that is from NR_CPUS or nr_cpus=
 	 * SRAT cpu entries could have different order with that in MADT.
@@ -316,6 +349,8 @@ int __init acpi_numa_init(void)
 				     acpi_parse_x2apic_affinity, 0);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				     acpi_parse_processor_affinity, 0);
+		acpi_table_parse_srat(ACPI_SRAT_TYPE_GICC_AFFINITY,
+				     acpi_parse_gicc_affinity, 0);
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0548339..ff56702 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -170,8 +170,23 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
 /* the following four functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
+
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+#else
+static inline void
+acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa) { }
+#endif
+
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
+
+#ifdef CONFIG_ARM64
+void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
+#else
+static inline void
+acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
+#endif
+
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 void acpi_numa_arch_fixup(void);
 
-- 
1.8.1.4
