From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / init: Switch over platform to the ACPI mode later
Date: Wed, 10 Jun 2015 01:48:29 +0200
Message-ID: <13170654.9h99FfQLut@vostro.rjw.lan>
References: <12578608.kKCTgirQ6f@vostro.rjw.lan> <1433351637.23540.170.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58101 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751158AbbFIXWl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2015 19:22:41 -0400
In-Reply-To: <1433351637.23540.170.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Marius Tolzmann <tolzmann@molgen.mpg.de>, Matt Fleming <matt@codeblueprint.co.uk>, Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Wednesday, June 03, 2015 11:13:57 AM Toshi Kani wrote:
> On Sat, 2015-05-30 at 14:21 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before
> > timekeeping_init()" moved the ACPI subsystem initialization,
> > including the ACPI mode enabling, to an earlier point in the
> > initialization sequence, to allow the timekeeping subsystem
> > use ACPI early.  Unfortunately, that resulted in boot regressions
> > on some systems and the early ACPI initialization was moved toward
> > its original position in the kernel initialization code by commit
> > c4e1acbb35e4 "ACPI / init: Invoke early ACPI initialization later".
> > 
> > However, that turns out to be insufficient, as boot is still broken
> > on the Tyan S8812 mainboard.
> > 
> > To fix that issue, split the ACPI early initialization code into
> > two pieces so the majority of it still located in acpi_early_init()
> > and the part switching over the platform into the ACPI mode goes into
> > a new function, acpi_subsystem_init(), executed at the original early
> > ACPI initialization spot.
> > 
> > That fixes the Tyan S8812 boot problem, but still allows ACPI
> > tables to be loaded earlier which is useful to the EFI code in
> > efi_enter_virtual_mode().
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=97141
> > Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Can you add comments to acpi_early_init() and acpi_subsystem_init() to
> clarify what ACPI features are enabled at each phase, and what
> dependency they have in the boot sequence?  (The same goes to
> early_acpi_boot_init() and acpi_boot_init().)

OK, update follows.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / init: Switch over platform to the ACPI mode later

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
Fixes: 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before timekeeping_init()"
Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/bus.c   |   56 +++++++++++++++++++++++++++++++++++++--------------
 include/linux/acpi.h |    2 +
 init/main.c          |    1 
 3 files changed, 44 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -470,6 +470,16 @@ static int __init acpi_bus_init_irq(void
 	return 0;
 }
 
+/**
+ * acpi_early_init - Initialize ACPICA and populate the ACPI namespace.
+ *
+ * The ACPI tables are accessible after this, but the handling of events has not
+ * been initialized and the global lock is not available yet, so AML should not
+ * be executed at this point.
+ *
+ * Doing this before switching the EFI runtime services to virtual mode allows
+ * the EfiBootServices memory to be freed slightly earlier on boot.
+ */
 void __init acpi_early_init(void)
 {
 	acpi_status status;
@@ -533,26 +543,42 @@ void __init acpi_early_init(void)
 		acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
 	}
 #endif
+	return;
+
+ error0:
+	disable_acpi();
+}
+
+/**
+ * acpi_subsystem_init - Finalize the early initialization of ACPI.
+ *
+ * Switch over the platform to the ACPI mode (if possible), initialize the
+ * handling of ACPI events, install the interrupt and global lock handlers.
+ *
+ * Doing this too early is generally unsafe, but at the same time it needs to be
+ * done before all things that really depend on ACPI.  The right spot appears to
+ * be before finalizing the EFI initialization.
+ */
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
@@ -450,6 +450,7 @@ extern acpi_status acpi_pci_osc_control_
 #define ACPI_OST_SC_INSERT_NOT_SUPPORTED	0x82
 
 extern void acpi_early_init(void);
+extern void acpi_subsystem_init(void);
 
 extern int acpi_nvs_register(__u64 start, __u64 size);
 
@@ -504,6 +505,7 @@ static inline const char *acpi_dev_name(
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

