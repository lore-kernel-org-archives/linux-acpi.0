From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] X86: Introduce mperf_aperf X86_FEATURE
Date: Thu, 23 Apr 2009 15:03:03 +0200
Message-ID: <1240491784-29933-3-git-send-email-trenn@suse.de>
References: <1240491784-29933-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbZDWNDH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 09:03:07 -0400
In-Reply-To: <1240491784-29933-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Users of the newly introduced:
EXPORT_SYMBOL_GPL(get_average_perf);
function must check for this feature to make sure it can be used.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 arch/x86/include/asm/cpufeature.h          |    1 +
 arch/x86/kernel/cpu/addon_cpuid_features.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/x86/kernel/cpu/mkcapflags.pl

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index bb83b1c..b1c4bd8 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -155,6 +155,7 @@
  */
 #define X86_FEATURE_IDA		(7*32+ 0) /* Intel Dynamic Acceleration */
 #define X86_FEATURE_ARAT	(7*32+ 1) /* Always Running APIC Timer */
+#define X86_FEATURE_APERF_MPERF	(7*32+ 3) /* APERF/MPERF average freq MSRs */
 
 /* Virtualization flags: Linux defined */
 #define X86_FEATURE_TPR_SHADOW  (8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/addon_cpuid_features.c b/arch/x86/kernel/cpu/addon_cpuid_features.c
index c965e52..e91c357 100644
--- a/arch/x86/kernel/cpu/addon_cpuid_features.c
+++ b/arch/x86/kernel/cpu/addon_cpuid_features.c
@@ -32,6 +32,7 @@ void __cpuinit init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 	static const struct cpuid_bit __cpuinitconst cpuid_bits[] = {
 		{ X86_FEATURE_IDA, CR_EAX, 1, 0x00000006 },
 		{ X86_FEATURE_ARAT, CR_EAX, 2, 0x00000006 },
+		{ X86_FEATURE_APERF_MPERF, CR_ECX, 0, 0x00000006 },
 		{ 0, 0, 0, 0 }
 	};
 
diff --git a/arch/x86/kernel/cpu/mkcapflags.pl b/arch/x86/kernel/cpu/mkcapflags.pl
old mode 100644
new mode 100755
-- 
1.6.0.2

