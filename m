From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 2/2] ARM64 / ACPI: make acpi_map_gic_cpu_interface() as void function
Date: Fri, 27 Mar 2015 21:55:08 +0800
Message-ID: <1427464513-14414-5-git-send-email-hanjun.guo@linaro.org>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Since the only caller of acpi_parse_gic_cpu_interface() doesn't
need the return value, make it have a void return type to avoid
introducing subtle bugs, and update the comments of the function
accordingly.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index c263cba..8b83955 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -98,12 +98,8 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 /**
  * acpi_map_gic_cpu_interface - generates a logical cpu number
  * and map to MPIDR represented by GICC structure
- * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
- * @enabled: this cpu is enabled or not
- *
- * Returns the logical cpu number which maps to MPIDR
  */
-static int __init
+static void __init
 acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	int i;
@@ -112,17 +108,17 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 
 	if (mpidr == INVALID_HWID) {
 		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
-		return -EINVAL;
+		return;
 	}
 
 	total_cpus++;
 	if (!enabled)
-		return -EINVAL;
+		return;
 
 	if (enabled_cpus >=  NR_CPUS) {
 		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
 			NR_CPUS, total_cpus, mpidr);
-		return -EINVAL;
+		return;
 	}
 
 	/* Check if GICC structure of boot CPU is available in the MADT */
@@ -130,7 +126,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 		if (bootcpu_valid) {
 			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
 			       mpidr);
-			return -EINVAL;
+			return;
 		}
 
 		bootcpu_valid = true;
@@ -145,28 +141,27 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 		if (cpu_logical_map(i) == mpidr) {
 			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
 			       mpidr);
-			return -EINVAL;
+			return;
 		}
 	}
 
 	if (!acpi_psci_present())
-		return -EOPNOTSUPP;
+		return;
 
 	cpu_ops[enabled_cpus] = cpu_get_ops("psci");
 	/* CPU 0 was already initialized */
 	if (enabled_cpus) {
 		if (!cpu_ops[enabled_cpus])
-			return -EINVAL;
+			return;
 
 		if (cpu_ops[enabled_cpus]->cpu_init(NULL, enabled_cpus))
-			return -EOPNOTSUPP;
+			return;
 
 		/* map the logical cpu id to cpu MPIDR */
 		cpu_logical_map(enabled_cpus) = mpidr;
 	}
 
 	enabled_cpus++;
-	return enabled_cpus;
 }
 
 static int __init
-- 
1.9.1
