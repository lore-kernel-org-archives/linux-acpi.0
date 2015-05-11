From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 1/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Mon, 11 May 2015 12:17:13 +0800
Message-ID: <1431317839-4584-2-git-send-email-hanjun.guo@linaro.org>
References: <1431317839-4584-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431317839-4584-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

In ACPI processor drivers, we use direct comparisons of cpu logical
id with -1 which are error prone in case logical cpuid is accidentally
assinged an error code and prevents us from returning an error-encoding
cpuid directly in some cases.

So introduce invalid_logical_cpuid() to identify cpu with invalid
logical cpu num, then it will be used to replace the direct comparisons
with -1.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c | 5 +++--
 drivers/acpi/processor_pdc.c  | 5 +----
 include/linux/acpi.h          | 5 +++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 58f335c..ac6bda0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -275,7 +275,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		 * Handle UP system running SMP kernel, with no CPU
 		 * entry in MADT
 		 */
-		if ((cpu_index == -1) && (num_online_cpus() == 1))
+		if (invalid_logical_cpuid(cpu_index)
+		    && (num_online_cpus() == 1))
 			cpu_index = 0;
 	}
 	pr->id = cpu_index;
@@ -285,7 +286,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (pr->id == -1) {
+	if (invalid_logical_cpuid(pr->id)) {
 		int ret = acpi_processor_hotadd_init(pr);
 		if (ret)
 			return ret;
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index e5dd808..7cfbda4 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -52,10 +52,7 @@ static bool __init processor_physically_present(acpi_handle handle)
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-	if (cpuid == -1)
-		return false;
-
-	return true;
+	return !invalid_logical_cpuid(cpuid);
 }
 
 static void acpi_set_pdc_bits(u32 *buf)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e4da5e3..913b49f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -158,6 +158,11 @@ typedef u32 phys_cpuid_t;
 #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
 #endif
 
+static inline bool invalid_logical_cpuid(u32 cpuid)
+{
+	return (int)cpuid < 0;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
-- 
1.9.1
