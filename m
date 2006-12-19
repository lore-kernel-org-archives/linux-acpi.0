From: akpm@osdl.org
Subject: [patch 17/19] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Tue, 19 Dec 2006 12:56:23 -0800
Message-ID: <200612192056.kBJKuOb7010062@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34520 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932961AbWLSU5T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:57:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, mingo@elte.hu, ak@suse.de

From: Ingo Molnar <mingo@elte.hu>

During kernel bootup, a new T60 laptop (CoreDuo, 32-bit) hangs about
10%-20% of the time in acpi_init():

 Calling initcall 0xc055ce1a: topology_init+0x0/0x2f()
 Calling initcall 0xc055d75e: mtrr_init_finialize+0x0/0x2c()
 Calling initcall 0xc05664f3: param_sysfs_init+0x0/0x175()
 Calling initcall 0xc014cb65: pm_sysrq_init+0x0/0x17()
 Calling initcall 0xc0569f99: init_bio+0x0/0xf4()
 Calling initcall 0xc056b865: genhd_device_init+0x0/0x50()
 Calling initcall 0xc056c4bd: fbmem_init+0x0/0x87()
 Calling initcall 0xc056dd74: acpi_init+0x0/0x1ee()

It's a hard hang that not even an NMI could punch through!  Frustratingly,
adding printks or function tracing to the ACPI code made the hangs go away
...

After some time an additional detail emerged: disabling the NMI watchdog
made these occasional hangs go away.

So i spent the better part of today trying to debug this and trying out
various theories when i finally found the likely reason for the hang: if
acpi_ns_initialize_devices() executes an _INI AML method and an NMI
happens to hit that AML execution in the wrong moment, the machine would
hang.  (my theory is that this must be some sort of chipset setup method
doing stores to chipset mmio registers?)

Unfortunately given the characteristics of the hang it was sheer
impossible to figure out which of the numerous AML methods is impacted
by this problem.

As a workaround i wrote an interface to disable chipset-based NMIs while
executing _INI sections - and indeed this fixed the hang.  I did a
boot-loop of 100 separate reboots and none hung - while without the patch
it would hang every 5-10 attempts.  Out of caution i did not touch the
nmi_watchdog=2 case (it's not related to the chipset anyway and didnt
hang).

I implemented this for both x86_64 and i686, tested the i686 laptop both
with nmi_watchdog=1 [which triggered the hangs] and nmi_watchdog=2, and
tested an Athlon64 box with the 64-bit kernel as well. Everything builds
and works with the patch applied.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/nmi.c          |   28 ++++++++++++++++++++++++++++
 arch/x86_64/kernel/nmi.c        |   27 +++++++++++++++++++++++++++
 drivers/acpi/namespace/nsinit.c |    9 +++++++++
 include/linux/nmi.h             |    9 ++++++++-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
+++ a/arch/i386/kernel/nmi.c
@@ -375,6 +375,34 @@ void enable_timer_nmi_watchdog(void)
 	}
 }
 
+static void __acpi_nmi_disable(void *__unused)
+{
+	apic_write_around(APIC_LVT0, APIC_DM_NMI | APIC_LVT_MASKED);
+}
+
+/*
+ * Disable timer based NMIs on all CPUs:
+ */
+void acpi_nmi_disable(void)
+{
+	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
+		on_each_cpu(__acpi_nmi_disable, NULL, 0, 1);
+}
+
+static void __acpi_nmi_enable(void *__unused)
+{
+	apic_write_around(APIC_LVT0, APIC_DM_NMI);
+}
+
+/*
+ * Enable timer based NMIs on all CPUs:
+ */
+void acpi_nmi_enable(void)
+{
+	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
+		on_each_cpu(__acpi_nmi_enable, NULL, 0, 1);
+}
+
 #ifdef CONFIG_PM
 
 static int nmi_pm_active; /* nmi_active before suspend */
diff -puN arch/x86_64/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi arch/x86_64/kernel/nmi.c
--- a/arch/x86_64/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
+++ a/arch/x86_64/kernel/nmi.c
@@ -362,6 +362,33 @@ void enable_timer_nmi_watchdog(void)
 	}
 }
 
+static void __acpi_nmi_disable(void *__unused)
+{
+	apic_write(APIC_LVT0, APIC_DM_NMI | APIC_LVT_MASKED);
+}
+
+/*
+ * Disable timer based NMIs on all CPUs:
+ */
+void acpi_nmi_disable(void)
+{
+	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
+		on_each_cpu(__acpi_nmi_disable, NULL, 0, 1);
+}
+
+static void __acpi_nmi_enable(void *__unused)
+{
+	apic_write(APIC_LVT0, APIC_DM_NMI);
+}
+
+/*
+ * Enable timer based NMIs on all CPUs:
+ */
+void acpi_nmi_enable(void)
+{
+	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
+		on_each_cpu(__acpi_nmi_enable, NULL, 0, 1);
+}
 #ifdef CONFIG_PM
 
 static int nmi_pm_active; /* nmi_active before suspend */
diff -puN drivers/acpi/namespace/nsinit.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi drivers/acpi/namespace/nsinit.c
--- a/drivers/acpi/namespace/nsinit.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
+++ a/drivers/acpi/namespace/nsinit.c
@@ -45,6 +45,7 @@
 #include <acpi/acnamesp.h>
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
+#include <linux/nmi.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsinit")
@@ -537,7 +538,15 @@ acpi_ns_init_one_device(acpi_handle obj_
 	info->parameter_type = ACPI_PARAM_ARGS;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
+	/*
+	 * Some hardware relies on this being executed as atomically
+	 * as possible (without an NMI being received in the middle of
+	 * this) - so disable NMIs and initialize the device:
+	 */
+	acpi_nmi_disable();
 	status = acpi_ns_evaluate(info);
+	acpi_nmi_enable();
+
 	if (ACPI_SUCCESS(status)) {
 		walk_info->num_INI++;
 
diff -puN include/linux/nmi.h~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi include/linux/nmi.h
--- a/include/linux/nmi.h~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
+++ a/include/linux/nmi.h
@@ -17,8 +17,15 @@
 #ifdef ARCH_HAS_NMI_WATCHDOG
 #include <asm/nmi.h>
 extern void touch_nmi_watchdog(void);
+extern void acpi_nmi_disable(void);
+extern void acpi_nmi_enable(void);
 #else
-# define touch_nmi_watchdog() touch_softlockup_watchdog()
+static inline void touch_nmi_watchdog(void)
+{
+	touch_softlockup_watchdog();
+}
+static inline void acpi_nmi_disable(void) { }
+static inline void acpi_nmi_enable(void) { }
 #endif
 
 #ifndef trigger_all_cpu_backtrace
_
