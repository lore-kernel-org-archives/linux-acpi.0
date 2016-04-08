From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 04/14] x86/rtc: replace paravirt rtc check with platform legacy quirk
Date: Fri,  8 Apr 2016 16:57:32 -0700
Message-ID: <1460159852-13254-1-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41505 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbcDHX5h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 19:57:37 -0400
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

We have 4 types of x86 platforms that disable RTC:

  * Intel MID
  * Lguest - uses paravirt
  * Xen dom-U - uses paravirt
  * x86 on legacy systems annotated with an ACPI legacy flag

We can consolidate all of these into a platform specific legacy
quirk set early in boot through i386_start_kernel() and through
x86_64_start_reservations(). This deals with the RTC quirks which
we can rely on through the hardware subarch, the ACPI check can
be dealt with separately.

For Xen things are bit more complex given that the @X86_SUBARCH_XEN
x86_hardware_subarch is shared on for Xen which uses the PV path for
both domU and dom0. Since the semantics for differentiating between
the two are Xen specific we provide a platform helper to help override
default legacy features -- x86_platform.set_legacy_features(). Use
of this helper is highly discouraged, its only purpose should be
to account for the lack of semantics available within your given
x86_hardware_subarch.

As per 0-day, this bumps the vmlinux size using i386-tinyconfig as
follows:

TOTAL   TEXT   init.text    x86_early_init_platform_quirks()
+70     +62    +62          +43

Only 8 bytes overhead total, as the main increase in size is
all removed via __init.

v2: split the subarch check from the ACPI check, clarify
    on the ACPI change commit log why ordering works
v3: add x86_platform.set_legacy_features() to account for dom0,
    add also size impact on vmlinux as per 0-day report

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/Makefile                     |  1 +
 arch/x86/include/asm/paravirt.h       |  6 ------
 arch/x86/include/asm/paravirt_types.h |  5 -----
 arch/x86/include/asm/processor.h      |  1 -
 arch/x86/include/asm/x86_init.h       | 21 +++++++++++++++++++++
 arch/x86/kernel/Makefile              |  6 +++++-
 arch/x86/kernel/head32.c              |  2 ++
 arch/x86/kernel/head64.c              |  1 +
 arch/x86/kernel/platform-quirks.c     | 21 +++++++++++++++++++++
 arch/x86/kernel/rtc.c                 |  7 ++-----
 arch/x86/lguest/boot.c                |  1 -
 arch/x86/xen/enlighten.c              | 10 +++++++---
 12 files changed, 60 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kernel/platform-quirks.c

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4086abca0b32..f9ed8a7ce2b6 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -209,6 +209,7 @@ endif
 head-y := arch/x86/kernel/head_$(BITS).o
 head-y += arch/x86/kernel/head$(BITS).o
 head-y += arch/x86/kernel/head.o
+head-y += arch/x86/kernel/platform-quirks.o
 
 libs-y  += arch/x86/lib/
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 601f1b8f9961..6c7a4a192032 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -20,12 +20,6 @@ static inline int paravirt_enabled(void)
 	return pv_info.paravirt_enabled;
 }
 
-static inline int paravirt_has_feature(unsigned int feature)
-{
-	WARN_ON_ONCE(!pv_info.paravirt_enabled);
-	return (pv_info.features & feature);
-}
-
 static inline void load_sp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e8c2326478c8..6acc1b26cf40 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -70,14 +70,9 @@ struct pv_info {
 #endif
 
 	int paravirt_enabled;
-	unsigned int features;	  /* valid only if paravirt_enabled is set */
 	const char *name;
 };
 
-#define paravirt_has(x) paravirt_has_feature(PV_SUPPORTED_##x)
-/* Supported features */
-#define PV_SUPPORTED_RTC        (1<<0)
-
 struct pv_init_ops {
 	/*
 	 * Patch may replace one of the defined code sequences with
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9264476f3d57..0c70c7daa6b8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -474,7 +474,6 @@ static inline unsigned long current_top_of_stack(void)
 #else
 #define __cpuid			native_cpuid
 #define paravirt_enabled()	0
-#define paravirt_has(x) 	0
 
 static inline void load_sp0(struct tss_struct *tss,
 			    struct thread_struct *thread)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 1ae89a2721d6..8bb8c1a4615a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -142,6 +142,15 @@ struct x86_cpuinit_ops {
 struct timespec;
 
 /**
+ * struct x86_legacy_features - legacy x86 features
+ *
+ * @rtc: this device has a CMOS real-time clock present
+ */
+struct x86_legacy_features {
+	int rtc;
+};
+
+/**
  * struct x86_platform_ops - platform specific runtime functions
  * @calibrate_tsc:		calibrate TSC
  * @get_wallclock:		get time from HW clock like RTC etc.
@@ -152,6 +161,14 @@ struct timespec;
  * @save_sched_clock_state:	save state for sched_clock() on suspend
  * @restore_sched_clock_state:	restore state for sched_clock() on resume
  * @apic_post_init:		adjust apic if neeeded
+ * @legacy:			legacy features
+ * @set_legacy_features:	override legacy features. Use of this callback
+ * 				is highly discouraged. You should only need
+ * 				this if your hardware platform requires further
+ * 				custom fine tuning far beyong what may be
+ * 				possible in x86_early_init_platform_quirks() by
+ * 				only using the current x86_hardware_subarch
+ * 				semantics.
  */
 struct x86_platform_ops {
 	unsigned long (*calibrate_tsc)(void);
@@ -165,6 +182,8 @@ struct x86_platform_ops {
 	void (*save_sched_clock_state)(void);
 	void (*restore_sched_clock_state)(void);
 	void (*apic_post_init)(void);
+	struct x86_legacy_features legacy;
+	void (*set_legacy_features)(void);
 };
 
 struct pci_dev;
@@ -186,6 +205,8 @@ extern struct x86_cpuinit_ops x86_cpuinit;
 extern struct x86_platform_ops x86_platform;
 extern struct x86_msi_ops x86_msi;
 extern struct x86_io_apic_ops x86_io_apic_ops;
+
+extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 89f8ade0bc7c..7a9e44d935de 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -2,7 +2,11 @@
 # Makefile for the linux kernel.
 #
 
-extra-y                := head_$(BITS).o head$(BITS).o head.o vmlinux.lds
+extra-y	:= head_$(BITS).o
+extra-y	+= head$(BITS).o
+extra-y	+= head.o
+extra-y	+= platform-quirks.o
+extra-y	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 2911ef3a9f1c..d784bb547a9d 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -34,6 +34,8 @@ asmlinkage __visible void __init i386_start_kernel(void)
 	cr4_init_shadow();
 	sanitize_boot_params(&boot_params);
 
+	x86_early_init_platform_quirks();
+
 	/* Call the subarch specific early setup function */
 	switch (boot_params.hdr.hardware_subarch) {
 	case X86_SUBARCH_INTEL_MID:
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1f4422d5c8d0..b72fb0b71dd1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -182,6 +182,7 @@ void __init x86_64_start_reservations(char *real_mode_data)
 	if (!boot_params.hdr.version)
 		copy_bootdata(__va(real_mode_data));
 
+	x86_early_init_platform_quirks();
 	reserve_ebda_region();
 
 	switch (boot_params.hdr.hardware_subarch) {
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
new file mode 100644
index 000000000000..021a5f973ce3
--- /dev/null
+++ b/arch/x86/kernel/platform-quirks.c
@@ -0,0 +1,21 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/bios_ebda.h>
+
+void __init x86_early_init_platform_quirks(void)
+{
+	x86_platform.legacy.rtc = 1;
+
+	switch (boot_params.hdr.hardware_subarch) {
+	case X86_SUBARCH_XEN:
+	case X86_SUBARCH_LGUEST:
+	case X86_SUBARCH_INTEL_MID:
+		x86_platform.legacy.rtc = 0;
+		break;
+	}
+
+	if (x86_platform.set_legacy_features)
+		x86_platform.set_legacy_features();
+}
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 4af8d063fb36..62c48da3889d 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -14,6 +14,7 @@
 #include <asm/time.h>
 #include <asm/intel-mid.h>
 #include <asm/rtc.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_X86_32
 /*
@@ -188,10 +189,6 @@ static __init int add_rtc_cmos(void)
 	if (of_have_populated_dt())
 		return 0;
 
-	/* Intel MID platforms don't have ioport rtc */
-	if (intel_mid_identify_cpu())
-		return -ENODEV;
-
 #ifdef CONFIG_ACPI
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_CMOS_RTC) {
 		/* This warning can likely go away again in a year or two. */
@@ -200,7 +197,7 @@ static __init int add_rtc_cmos(void)
 	}
 #endif
 
-	if (paravirt_enabled() && !paravirt_has(RTC))
+	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
 	platform_device_register(&rtc_device);
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index fd57d3ae7e16..f5497ee5fd2f 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1414,7 +1414,6 @@ __init void lguest_init(void)
 	pv_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
 	pv_info.shared_kernel_pmd = 1;
-	pv_info.features = 0;
 
 	/*
 	 * We set up all the lguest overrides for sensitive operations.  These
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 40487f1ecb4c..e066fcf87c3d 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1192,7 +1192,6 @@ static const struct pv_info xen_info __initconst = {
 #ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = FLAT_USER_CS64,
 #endif
-	.features = 0,
 	.name = "Xen",
 };
 
@@ -1505,6 +1504,11 @@ static void __init xen_pvh_early_guest_init(void)
 }
 #endif    /* CONFIG_XEN_PVH */
 
+static void xen_dom0_set_legacy_features(void)
+{
+	x86_platform.legacy.rtc = 1;
+}
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(void)
 {
@@ -1525,8 +1529,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	if (xen_initial_domain())
-		pv_info.features |= PV_SUPPORTED_RTC;
 	pv_init_ops = xen_init_ops;
 	if (!xen_pvh_domain()) {
 		pv_cpu_ops = xen_cpu_ops;
@@ -1679,6 +1681,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 			.u.firmware_info.type = XEN_FW_KBD_SHIFT_FLAGS,
 		};
 
+		x86_platform.set_legacy_features =
+				xen_dom0_set_legacy_features;
 		xen_init_vga(info, xen_start_info->console.dom0.info_size);
 		xen_start_info->console.domU.mfn = 0;
 		xen_start_info->console.domU.evtchn = 0;
-- 
2.7.2

