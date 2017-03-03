From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 3/5] x86/acpi: Restore the order of CPU IDs
Date: Fri, 3 Mar 2017 16:02:25 +0800
Message-ID: <1488528147-2279-4-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:22579 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751611AbdCCIMN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2017 03:12:13 -0500
In-Reply-To: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, lenb@kernel.org, xiaolong.ye@intel.com, guzheng1@huawei.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

The following commits:

  f7c28833c2 ("x86/acpi: Enable acpi to register all possible cpus at
boot time") and 8f54969dc8 ("x86/acpi: Introduce persistent storage
for cpuid <-> apicid mapping")

... registered all the possible CPUs at boot time via ACPI tables to
make the mapping of cpuid <-> apicid fixed. Both enabled and disabled
CPUs could have a logical CPU ID after boot time.

But, ACPI tables are unreliable. the number amd order of Local APIC
entries which depends on the firmware is often inconsistent with the
physical devices. Even if they are consistent, The disabled CPUs which
take up some logical CPU IDs will also make the order discontinuous.

Revert the part of disabled CPUs registration, keep the allocation
logic of logical CPU IDs and also keep some code location changes.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 arch/x86/kernel/acpi/boot.c |  7 ++++++-
 arch/x86/kernel/apic/apic.c | 26 +++++++-------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index f6b0e87..b2879cc23 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -179,10 +179,15 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 		return -EINVAL;
 	}
 
+	if (!enabled) {
+		++disabled_cpus;
+		return -EINVAL;
+	}
+
 	if (boot_cpu_physical_apicid != -1U)
 		ver = boot_cpu_apic_version;
 
-	cpu = __generic_processor_info(id, ver, enabled);
+	cpu = generic_processor_info(id, ver);
 	if (cpu >= 0)
 		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4261b32..26a2ff0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2072,7 +2072,7 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
 
-int __generic_processor_info(int apicid, int version, bool enabled)
+int generic_processor_info(int apicid, int version)
 {
 	int cpu, max = nr_cpu_ids;
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
@@ -2130,11 +2130,9 @@ int __generic_processor_info(int apicid, int version, bool enabled)
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;
 
-		if (enabled) {
-			pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
-				   "reached. Processor %d/0x%x ignored.\n",
-				   max, thiscpu, apicid);
-		}
+		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
+			   "reached. Processor %d/0x%x ignored.\n",
+			   max, thiscpu, apicid);
 
 		disabled_cpus++;
 		return -EINVAL;
@@ -2186,23 +2184,13 @@ int __generic_processor_info(int apicid, int version, bool enabled)
 		apic->x86_32_early_logical_apicid(cpu);
 #endif
 	set_cpu_possible(cpu, true);
-
-	if (enabled) {
-		num_processors++;
-		physid_set(apicid, phys_cpu_present_map);
-		set_cpu_present(cpu, true);
-	} else {
-		disabled_cpus++;
-	}
+	physid_set(apicid, phys_cpu_present_map);
+	set_cpu_present(cpu, true);
+	num_processors++;
 
 	return cpu;
 }
 
-int generic_processor_info(int apicid, int version)
-{
-	return __generic_processor_info(apicid, version, true);
-}
-
 int hard_smp_processor_id(void)
 {
 	return read_apic_id();
-- 
2.5.5



