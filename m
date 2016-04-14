From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 14/16] x86/paravirt: remove paravirt_enabled()
Date: Wed, 13 Apr 2016 17:04:44 -0700
Message-ID: <1460592286-300-15-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36838 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932384AbcDNAFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 20:05:21 -0400
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

That that paravirt_enabled() is replaced with proper
x86 semantics we can remove it.

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/include/asm/paravirt.h       | 5 -----
 arch/x86/include/asm/paravirt_types.h | 1 -
 arch/x86/include/asm/processor.h      | 1 -
 arch/x86/kernel/kvm.c                 | 8 --------
 arch/x86/kernel/paravirt.c            | 1 -
 arch/x86/lguest/boot.c                | 2 --
 arch/x86/xen/enlighten.c              | 1 -
 7 files changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6c7a4a192032..dff26bc91b17 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -15,11 +15,6 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-static inline int paravirt_enabled(void)
-{
-	return pv_info.paravirt_enabled;
-}
-
 static inline void load_sp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 6acc1b26cf40..7fedf24bd811 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -69,7 +69,6 @@ struct pv_info {
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
 #endif
 
-	int paravirt_enabled;
 	const char *name;
 };
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0c70c7daa6b8..8d326e822cb8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -473,7 +473,6 @@ static inline unsigned long current_top_of_stack(void)
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
-#define paravirt_enabled()	0
 
 static inline void load_sp0(struct tss_struct *tss,
 			    struct thread_struct *thread)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dc1207e2f193..eea2a6f72b31 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -285,14 +285,6 @@ static void __init paravirt_ops_setup(void)
 {
 	pv_info.name = "KVM";
 
-	/*
-	 * KVM isn't paravirt in the sense of paravirt_enabled.  A KVM
-	 * guest kernel works like a bare metal kernel with additional
-	 * features, and paravirt_enabled is about features that are
-	 * missing.
-	 */
-	pv_info.paravirt_enabled = 0;
-
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
 		pv_cpu_ops.io_delay = kvm_io_delay;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index f08ac28b8136..71a2d8a05a66 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -294,7 +294,6 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
-	.paravirt_enabled = 0,
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index f5497ee5fd2f..3847e736702e 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1408,8 +1408,6 @@ __init void lguest_init(void)
 {
 	/* We're under lguest. */
 	pv_info.name = "lguest";
-	/* Paravirt is enabled. */
-	pv_info.paravirt_enabled = 1;
 	/* We're running at privilege level 1, not 0 as normal. */
 	pv_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b08489ba5051..f9fb90978867 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1186,7 +1186,6 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
 }
 
 static const struct pv_info xen_info __initconst = {
-	.paravirt_enabled = 1,
 	.shared_kernel_pmd = 0,
 
 #ifdef CONFIG_X86_64
-- 
2.7.2

