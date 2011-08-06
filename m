From: Andy Lutomirski <luto@MIT.EDU>
Subject: [PATCH v2 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't already
Date: Sat,  6 Aug 2011 07:42:36 -0400
Message-ID: <67feadbc353e826cf5d715d06f8ff1f92277a97d.1312630712.git.luto@mit.edu>
References: <cover.1312630712.git.luto@mit.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:45900 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753930Ab1HFLnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Aug 2011 07:43:03 -0400
In-Reply-To: <cover.1312630712.git.luto@mit.edu>
In-Reply-To: <cover.1312630712.git.luto@mit.edu>
References: <cover.1312630712.git.luto@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@mit.edu>

My Intel DQ67SW (latest BIOS) disables monitor/mwait on the boot CPU
if TXT is enabled.  We're lucky that the system works at all, since
the feature is still enabled on other CPUs.

The obvious fix is to just re-enable it ourselves.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 arch/x86/kernel/cpu/intel.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c80ab41..5a0150c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -493,6 +493,31 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 			wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
 		}
 	}
+
+	/* Enable monitor/mwait if BIOS didn't do it for us. */
+	if (!cpu_has(c, X86_FEATURE_MWAIT) && cpu_has(c, X86_FEATURE_XMM3)
+	    && c->x86 >= 6 && !(c->x86 == 6 && c->x86_model < 0x1c)
+	    && !(c->x86 == 0xf && c->x86_model < 3)) {
+		u64 misc_enable;
+		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+		misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
+
+		/*
+		 * Some non-SSE3 cpus will #GP.  We check for that,
+		 * but it can't hurt to be safe.
+		 */
+		wrmsr_safe(MSR_IA32_MISC_ENABLE, (u32)misc_enable,
+			   (u32)(misc_enable >> 32));
+
+		/* Re-read monitor capability. */
+		if (cpuid_ecx(1) & 0x8) {
+			set_cpu_cap(c, X86_FEATURE_MWAIT);
+
+			printk(KERN_WARNING FW_WARN "CPU #%d: "
+			       "IA32_MISC_ENABLE.ENABLE_MONITOR_FSM "
+			       "was not set\n", c->cpu_index);
+		}
+	}
 }
 
 #ifdef CONFIG_X86_32
-- 
1.7.6

