From: Andy Lutomirski <luto@MIT.EDU>
Subject: [PATCH v4 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't already
Date: Wed, 17 Aug 2011 10:03:19 -0400
Message-ID: <ad2ca4c41de2e9031f337959667145d7908bf06e.1313586473.git.luto@mit.edu>
References: <cover.1313586473.git.luto@mit.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1313586473.git.luto@mit.edu>
In-Reply-To: <cover.1313586473.git.luto@mit.edu>
References: <cover.1313586473.git.luto@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@mit.edu>
List-Id: linux-acpi@vger.kernel.org

My Intel DQ67SW (latest BIOS) disables monitor/mwait on the boot CPU
if TXT is enabled.  We're lucky that the system works at all, since
the feature is still enabled on other CPUs.

The obvious fix is to just re-enable it ourselves.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 arch/x86/kernel/cpu/intel.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1f7367d..c79e7b7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -492,6 +492,29 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
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
+			printk(KERN_WARNING FW_WARN "IA32_MISC_ENABLE.ENABLE_MONITOR_FSM was not set\n");
+		}
+	}
 }
 
 #ifdef CONFIG_X86_32
-- 
1.7.6
