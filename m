From: akpm@linux-foundation.org
Subject: [patch for 2.6.27? 2/2] acpi: cope with PNPACPI tables missing an RTC entry
Date: Mon, 22 Sep 2008 14:05:10 -0700
Message-ID: <200809222105.m8ML5BMA029612@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55799 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350AbYIVVGj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 17:06:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, dbrownell@users.sourceforge.net, a.zummo@towertech.it, abelay@novell.com, bjorn.helgaas@hp.com, cebbert@redhat.com, mingo@elte.hu, rik.theys@esat.kuleuven.be, stable@kernel.org, tglx@linutronix.de

From: David Brownell <dbrownell@users.sourceforge.net>

A bugzilla entry (http://bugzilla.kernel.org/show_bug.cgi?id=11580)
reports that some PNPACPI tables don't list RTC devices; they are
instead glommed into a generic "system resources" entry.

Address that on x86 (while ignoring ia64, the other user of ACPI) by
having ACPI glue check for that case, and if necessary then setting
up a platform device and having rtc_cmos use it.

Seems like a candidate for 2.6.27-final and for backporting.  There's a
Fedora kernel report for this too.  Workaround is simple (see the bug
report) but less functional.

[akpm@linux-foundation.org: forward-declare struct device]
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Reported-by: Rik Theys <rik.theys@esat.kuleuven.be>
Cc: Adam Belay <abelay@novell.com>
Cc: Chuck Ebbert <cebbert@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/rtc.c         |   13 ++++++++++++-
 drivers/acpi/glue.c           |   16 +++++++++++++++-
 drivers/pnp/core.c            |    8 ++++++++
 drivers/rtc/rtc-cmos.c        |    4 ++--
 include/asm-x86/mc146818rtc.h |    7 +++++++
 include/linux/pnp.h           |    1 +
 6 files changed, 45 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/rtc.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry arch/x86/kernel/rtc.c
--- a/arch/x86/kernel/rtc.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/arch/x86/kernel/rtc.c
@@ -220,11 +220,22 @@ static struct platform_device rtc_device
 	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
+#ifdef CONFIG_PNP
+/* PNPACPI tables sometimes omit the RTC, or are ignored */
+struct device *__init add_nonpnp_rtc_cmos(void)
+{
+	if (!rtc_device.dev.bus)
+		platform_device_register(&rtc_device);
+	return &rtc_device.dev;
+}
+#endif
+
 static __init int add_rtc_cmos(void)
 {
 #ifdef CONFIG_PNP
+	/* in case of pnpacpi=off */
 	if (!pnp_platform_devices)
-		platform_device_register(&rtc_device);
+		add_nonpnp_rtc_cmos();
 #else
 	platform_device_register(&rtc_device);
 #endif /* CONFIG_PNP */
diff -puN drivers/acpi/glue.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry drivers/acpi/glue.c
--- a/drivers/acpi/glue.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/drivers/acpi/glue.c
@@ -366,7 +366,21 @@ static int __init pnp_match(struct devic
 
 static struct device *__init get_rtc_dev(void)
 {
-	return bus_find_device(&pnp_bus_type, NULL, NULL, pnp_match);
+	struct device *rtc;
+
+	/* return RTC from PNPACPI tables */
+	rtc = bus_find_device(&pnp_bus_type, NULL, NULL, pnp_match);
+
+#ifdef ARCH_PNP_RTC_WORKAROUND
+	/* cope with buggy PNPACPI tables (like the HP DL3x0 servers
+	 * which have no RTC device listed), and with pnpacpi=off
+	 */
+	if (!rtc) {
+		pnp_rtc_missing = true;
+		rtc = add_nonpnp_rtc_cmos();
+	}
+#endif
+	return rtc;
 }
 
 static int __init acpi_rtc_init(void)
diff -puN drivers/pnp/core.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry drivers/pnp/core.c
--- a/drivers/pnp/core.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/drivers/pnp/core.c
@@ -25,10 +25,18 @@ DEFINE_SPINLOCK(pnp_lock);
  * ACPI or PNPBIOS should tell us about all platform devices, so we can
  * skip some blind probes.  ISAPNP typically enumerates only plug-in ISA
  * devices, not built-in things like COM ports.
+ *
+ * Sometimes ACPI tables omit devices like RTCs, which can be critical.
+ * To avoid legacy poke-the-hardware-and-guess drivers (unfriendly to
+ * the driver model), something else creates a (platform) device node;
+ * and drivers must know to kick-in their non-PNP (non-PC) bus glue.
  */
 int pnp_platform_devices;
 EXPORT_SYMBOL(pnp_platform_devices);
 
+bool pnp_rtc_missing;
+EXPORT_SYMBOL(pnp_rtc_missing);
+
 void *pnp_alloc(long size)
 {
 	void *result;
diff -puN drivers/rtc/rtc-cmos.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry drivers/rtc/rtc-cmos.c
--- a/drivers/rtc/rtc-cmos.c~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/drivers/rtc/rtc-cmos.c
@@ -1032,7 +1032,7 @@ static struct platform_driver cmos_platf
 static int __init cmos_init(void)
 {
 #ifdef	CONFIG_PNP
-	if (pnp_platform_devices)
+	if (pnp_platform_devices && !pnp_rtc_missing)
 		return pnp_register_driver(&cmos_pnp_driver);
 	else
 		return platform_driver_probe(&cmos_platform_driver,
@@ -1047,7 +1047,7 @@ module_init(cmos_init);
 static void __exit cmos_exit(void)
 {
 #ifdef	CONFIG_PNP
-	if (pnp_platform_devices)
+	if (pnp_platform_devices && !pnp_rtc_missing)
 		pnp_unregister_driver(&cmos_pnp_driver);
 	else
 		platform_driver_unregister(&cmos_platform_driver);
diff -puN include/asm-x86/mc146818rtc.h~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry include/asm-x86/mc146818rtc.h
--- a/include/asm-x86/mc146818rtc.h~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/include/asm-x86/mc146818rtc.h
@@ -9,6 +9,8 @@
 #include <asm/processor.h>
 #include <linux/mc146818rtc.h>
 
+struct device;
+
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
 #define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
@@ -87,6 +89,11 @@ static inline unsigned char current_lock
 #define current_lock_cmos_reg() 0
 #endif
 
+#ifdef CONFIG_PNP
+#define ARCH_PNP_RTC_WORKAROUND
+extern struct device *add_nonpnp_rtc_cmos(void);
+#endif
+
 /*
  * The yet supported machines all access the RTC index register via
  * an ISA port access but the way to access the date register differs ...
diff -puN include/linux/pnp.h~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry include/linux/pnp.h
--- a/include/linux/pnp.h~acpi-cope-with-pnpacpi-tables-missing-an-rtc-entry
+++ a/include/linux/pnp.h
@@ -427,6 +427,7 @@ int pnp_device_attach(struct pnp_dev *pn
 void pnp_device_detach(struct pnp_dev *pnp_dev);
 extern struct list_head pnp_global;
 extern int pnp_platform_devices;
+extern bool pnp_rtc_missing;
 
 /* multidevice card support */
 struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
_
