From: Baoquan He <bhe@redhat.com>
Subject: [Patch v4 1/2] x86/mm/numa: Open code function early_get_boot_cpu_id
Date: Fri, 12 Aug 2016 14:57:12 +0800
Message-ID: <1470985033-22493-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcHLG5T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Aug 2016 02:57:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Baoquan He <bhe@redhat.com>

Previously early_acpi_boot_init is called in early_get_boot_cpu_id()
to get value for boot_cpu_physical_apicid. Now early_acpi_boot_init()
has been taken out and moved to setup_arch(), the name of
early_get_boot_cpu_id doesn't match its implementation. And only the
getting boot-time SMP configuration code is left. So in this patch
open code it.

And move the smp_found_config check into default_get_smp_config to
simplify code. Because both early_get_smp_config and get_smp_config call
x86_init.mpparse.get_smp_config(). While x86_init.mpparse.get_smp_config
is set as default_get_smp_config when they really try to get boot-time
SMP config, otherwise it's set as x86_init_uint_noop to do nothing.

And there are different version of early_get_smp_config based on
CONFIG_X86_MPPARSE check, so remove the redundent CONFIG_X86_MPPARSE #ifdef
check when call early_get_smp_config.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v3:
  -No change.
v3->v4:
  1)Move smp_found_config check into default_get_smp_config.
  2)Remove the redundent #ifdef check of CONFIG_X86_MPPARSE when call  early_get_smp_config.
  -These are suggested by Ingo.
    
 arch/x86/kernel/mpparse.c |  3 +++
 arch/x86/kernel/setup.c   |  3 +--
 arch/x86/mm/amdtopology.c | 22 +++++-----------------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 068c4a9..0f8d204 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -499,6 +499,9 @@ void __init default_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf = mpf_found;
 
+	if (!smp_found_config)
+		return;
+
 	if (!mpf)
 		return;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 991b779..a0db003 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1214,8 +1214,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * get boot-time SMP configuration:
 	 */
-	if (smp_found_config)
-		get_smp_config();
+	get_smp_config();
 
 	prefill_possible_map();
 
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index ba47524..d1c7de0 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -52,21 +52,6 @@ static __init int find_northbridge(void)
 	return -ENOENT;
 }
 
-static __init void early_get_boot_cpu_id(void)
-{
-	/*
-	 * need to get the APIC ID of the BSP so can use that to
-	 * create apicid_to_node in amd_scan_nodes()
-	 */
-#ifdef CONFIG_X86_MPPARSE
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	if (smp_found_config)
-		early_get_smp_config();
-#endif
-}
-
 int __init amd_numa_init(void)
 {
 	u64 start = PFN_PHYS(0);
@@ -180,8 +165,11 @@ int __init amd_numa_init(void)
 	cores = 1 << bits;
 	apicid_base = 0;
 
-	/* get the APIC ID of the BSP early for systems with apicid lifting */
-	early_get_boot_cpu_id();
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	early_get_smp_config();
+
 	if (boot_cpu_physical_apicid > 0) {
 		pr_info("BSP APIC ID: %02x\n", boot_cpu_physical_apicid);
 		apicid_base = boot_cpu_physical_apicid;
-- 
2.5.5

