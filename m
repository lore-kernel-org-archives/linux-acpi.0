From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/5] x86, acpi, cpu-hotplug: Introduce apicid_to_cpuid[] array to store persistent cpuid <-> apicid mapping.
Date: Wed, 1 Jul 2015 12:45:57 +0800
Message-ID: <1435725959-18689-4-git-send-email-tangchen@cn.fujitsu.com>
References: <1435725959-18689-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:59871 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949AbbGAEqD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 00:46:03 -0400
In-Reply-To: <1435725959-18689-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tj@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com
Cc: tangchen@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, Gu Zheng <guz.fnst@cn.fujitsu.com>

From: Gu Zheng <guz.fnst@cn.fujitsu.com>

In this patch, we introduce a new static array named apicid_to_cpuid[],
which is large enough to store info for all possible cpus.

And then, we modify the cpuid calculation. In generic_processor_info(),
it simply finds the next unused cpuid. And it is also why the cpuid <-> nodeid
mapping changes with node hotplug.

After this patch, we find the next unused cpuid, map it to an apicid,
and store the mapping in apicid_to_cpuid[], so that cpuid <-> apicid
mapping will be persistent.

And finally we will use this array to make cpuid <-> nodeid persistent.

cpuid <-> apicid mapping is established at local apic registeration time.
But non-present or disabled cpus are ignored.

In this patch, we establish all possible cpuid <-> apicid mapping when
registering local apic.


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/include/asm/mpspec.h |  1 +
 arch/x86/kernel/acpi/boot.c   |  6 ++----
 arch/x86/kernel/apic/apic.c   | 47 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index b07233b..db902d8 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -86,6 +86,7 @@ static inline void early_reserve_e820_mpc_new(void) { }
 #endif
 
 int generic_processor_info(int apicid, int version);
+int __generic_processor_info(int apicid, int version, bool enabled);
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24..bcc85b2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -174,15 +174,13 @@ static int acpi_register_lapic(int id, u8 enabled)
 		return -EINVAL;
 	}
 
-	if (!enabled) {
+	if (!enabled)
 		++disabled_cpus;
-		return -EINVAL;
-	}
 
 	if (boot_cpu_physical_apicid != -1U)
 		ver = apic_version[boot_cpu_physical_apicid];
 
-	return generic_processor_info(id, ver);
+	return __generic_processor_info(id, ver, enabled);
 }
 
 static int __init
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a9c9830..c744ffb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1977,7 +1977,38 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 	apic_write(APIC_LVT1, value);
 }
 
-static int __generic_processor_info(int apicid, int version, bool enabled)
+/*
+ * Logic cpu number(cpuid) to local APIC id persistent mappings.
+ * Do not clear the mapping even if cpu is hot-removed.
+ */
+static int apicid_to_cpuid[] = {
+	[0 ... NR_CPUS - 1] = -1,
+};
+
+/*
+ * Internal cpu id bits, set the bit once cpu present, and never clear it.
+ */
+static cpumask_t cpuid_mask = CPU_MASK_NONE;
+
+static int get_cpuid(int apicid)
+{
+	int free_id, i;
+
+	free_id = cpumask_next_zero(-1, &cpuid_mask);
+	if (free_id >= nr_cpu_ids)
+		return -1;
+
+	for (i = 0; i < free_id; i++)
+		if (apicid_to_cpuid[i] == apicid)
+			return i;
+
+	apicid_to_cpuid[free_id] = apicid;
+	cpumask_set_cpu(free_id, &cpuid_mask);
+
+	return free_id;
+}
+
+int __generic_processor_info(int apicid, int version, bool enabled)
 {
 	int cpu, max = nr_cpu_ids;
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
@@ -2058,8 +2089,18 @@ static int __generic_processor_info(int apicid, int version, bool enabled)
 		 * for BSP.
 		 */
 		cpu = 0;
-	} else
-		cpu = cpumask_next_zero(-1, cpu_present_mask);
+	} else {
+		cpu = get_cpuid(apicid);
+		if (cpu < 0) {
+			int thiscpu = max + disabled_cpus;
+
+			pr_warning("  Processor %d/0x%x ignored.\n",
+				   thiscpu, apicid);
+			if (enabled)
+				disabled_cpus++;
+			return -EINVAL;
+		}
+	}
 
 	/*
 	 * Validate version
-- 
1.9.3

