From: Andy Lutomirski <luto@MIT.EDU>
Subject: [PATCH v3 1/2] x86: Enable fast strings on Intel if BIOS hasn't already
Date: Tue,  9 Aug 2011 08:41:05 -0400
Message-ID: <d9f3056c77b6cd44a2f4c90278ce483a011dda12.1312893572.git.luto@mit.edu>
References: <cover.1312893572.git.luto@mit.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:61714 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180Ab1HIMlS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2011 08:41:18 -0400
In-Reply-To: <cover.1312893572.git.luto@mit.edu>
In-Reply-To: <cover.1312893572.git.luto@mit.edu>
References: <cover.1312893572.git.luto@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@mit.edu>

Intel SDM volume 3A, 8.4.2 says:

  Software can disable fast-string operation by clearing the
  fast-string-enable bit (bit 0) of IA32_MISC_ENABLE MSR.
  However, Intel recomments that system software always enable
  fast-string operation.

The Intel DQ67SW board (with latest BIOS) disables fast string
operations if TXT is enabled.  A Lenovo X220 disables it regardless
of TXT setting.  I doubt I'm the only person with a dumb BIOS like
this.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 arch/x86/kernel/cpu/intel.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ed6086e..7d02873 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -30,6 +30,7 @@
 static void __cpuinit early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
+	bool allow_fast_string = true;
 
 	/* Unmask CPUID levels if masked: */
 	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
@@ -118,10 +119,11 @@ static void __cpuinit early_init_intel(struct cpuinfo_x86 *c)
 	 * (model 2) with the same problem.
 	 */
 	if (c->x86 == 15) {
-		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+		allow_fast_string = false;
 
+		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
 		if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
-			printk(KERN_INFO "kmemcheck: Disabling fast string operations\n");
+			printk_once(KERN_INFO "kmemcheck: Disabling fast string operations\n");
 
 			misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
 			wrmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
@@ -130,13 +132,29 @@ static void __cpuinit early_init_intel(struct cpuinfo_x86 *c)
 #endif
 
 	/*
-	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
-	 * clear the fast string and enhanced fast string CPU capabilities.
+	 * If BIOS didn't enable fast string operation, try to enable
+	 * it ourselves.  If that fails, then clear the fast string
+	 * and enhanced fast string CPU capabilities.
 	 */
 	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+
+		if (allow_fast_string &&
+		    !(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
+			misc_enable |= MSR_IA32_MISC_ENABLE_FAST_STRING;
+			wrmsr_safe(MSR_IA32_MISC_ENABLE, (u32)misc_enable,
+				   (u32)(misc_enable >> 32));
+
+			/* Re-read to make sure it stuck. */
+			rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+
+			if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)
+				printk_once(KERN_INFO FW_WARN "CPU #%d: IA32_MISC_ENABLE.FAST_STRING_ENABLE was not set",
+				       c->cpu_index);
+		}
+
 		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
-			printk(KERN_INFO "Disabled fast string operations\n");
+			printk_once(KERN_INFO "Failed to enable fast string operations\n");
 			setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
 			setup_clear_cpu_cap(X86_FEATURE_ERMS);
 		}
-- 
1.7.6

