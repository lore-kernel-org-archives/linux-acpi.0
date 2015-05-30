From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / init: Switch over platform to the ACPI mode later
Date: Sat, 30 May 2015 14:21:28 +0200
Message-ID: <12578608.kKCTgirQ6f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63493 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757563AbbE3Lzy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 May 2015 07:55:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Marius Tolzmann <tolzmann@molgen.mpg.de>, Matt Fleming <matt@codeblueprint.co.uk>, Toshi Kani <toshi.kani@hp.com>, Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before
timekeeping_init()" moved the ACPI subsystem initialization,
including the ACPI mode enabling, to an earlier point in the
initialization sequence, to allow the timekeeping subsystem
use ACPI early.  Unfortunately, that resulted in boot regressions
on some systems and the early ACPI initialization was moved toward
its original position in the kernel initialization code by commit
c4e1acbb35e4 "ACPI / init: Invoke early ACPI initialization later".

However, that turns out to be insufficient, as boot is still broken
on the Tyan S8812 mainboard.

To fix that issue, split the ACPI early initialization code into
two pieces so the majority of it still located in acpi_early_init()
and the part switching over the platform into the ACPI mode goes into
a new function, acpi_subsystem_init(), executed at the original early
ACPI initialization spot.

That fixes the Tyan S8812 boot problem, but still allows ACPI
tables to be loaded earlier which is useful to the EFI code in
efi_enter_virtual_mode().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=97141
Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c   |   36 +++++++++++++++++++++---------------
 include/linux/acpi.h |    2 ++
 init/main.c          |    1 +
 3 files changed, 24 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -533,26 +533,32 @@ void __init acpi_early_init(void)
 		acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
 	}
 #endif
+	return;
+
+ error0:
+	disable_acpi();
+}
+
+void __init acpi_subsystem_init(void)
+{
+	acpi_status status;
+
+	if (acpi_disabled)
+		return;
 
 	status = acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to enable ACPI\n");
-		goto error0;
+		disable_acpi();
+	} else {
+		/*
+		 * If the system is using ACPI then we can be reasonably
+		 * confident that any regulators are managed by the firmware
+		 * so tell the regulator core it has everything it needs to
+		 * know.
+		 */
+		regulator_has_full_constraints();
 	}
-
-	/*
-	 * If the system is using ACPI then we can be reasonably
-	 * confident that any regulators are managed by the firmware
-	 * so tell the regulator core it has everything it needs to
-	 * know.
-	 */
-	regulator_has_full_constraints();
-
-	return;
-
-      error0:
-	disable_acpi();
-	return;
 }
 
 static int __init acpi_bus_init(void)
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -440,6 +440,7 @@ extern acpi_status acpi_pci_osc_control_
 #define ACPI_OST_SC_INSERT_NOT_SUPPORTED	0x82
 
 extern void acpi_early_init(void);
+extern void acpi_subsystem_init(void);
 
 extern int acpi_nvs_register(__u64 start, __u64 size);
 
@@ -494,6 +495,7 @@ static inline const char *acpi_dev_name(
 }
 
 static inline void acpi_early_init(void) { }
+static inline void acpi_subsystem_init(void) { }
 
 static inline int early_acpi_boot_init(void)
 {
Index: linux-pm/init/main.c
===================================================================
--- linux-pm.orig/init/main.c
+++ linux-pm/init/main.c
@@ -664,6 +664,7 @@ asmlinkage __visible void __init start_k
 
 	check_bugs();
 
+	acpi_subsystem_init();
 	sfi_init_late();
 
 	if (efi_enabled(EFI_RUNTIME_SERVICES)) {

