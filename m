From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/4] ACPI 2.0 / ECDT: Remove early namespace reference from EC
Date: Thu, 24 Mar 2016 10:42:53 +0800
Message-ID: <498ee79265016e4ec3e2d65b94954d21e5438e20.1458786874.git.lv.zheng@intel.com>
References: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed> <cover.1458786874.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458786874.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

All operation region accesses are allowed by AML interpreter when AML is
executed, so actually BIOSen are responsible to avoid the operation region
accesses in AML before OSPM has prepared an operation region driver. This
is done via _REG control method. So AML code normally sets a global named
object REGC to 1 when _REG(3, 1) is evaluated.

Then what is ECDT? Quoting from ACPI spec 6.0, 5.2.15 Embedded Controller
Boot Resources Table (ECDT):
 "The presence of this table allows OSPM to provide Embedded Controller
  operation region space access before the namespace has been evaluated."
Spec also suggests a compatible mean to indicate the early EC access
availability:
 Device (EC)
 {
     Name (REGC, Ones)
     Method (_REG, 2)
     {
         If (LEqual (Arg0, 3))
         {
             Store (Arg1, REGC)
         }
     }
     Method (ECAV)
     {
         If (LEqual (REGC, Ones))
         {
             If (LGreaterEqual (_REV, 2))
             {
                 Return (One)
             }
             Else
             {
                 Return (Zero)
             }
         }
         Else
         {
             Return (REGC)
         }
     }
 }
In this way, it allows EC accesses to happen before EC._REG(3, 1) is
invoked.

But ECAV is not the only way practical BIOSen using to indicate the early
EC access availibility, the known variations include:
1. Setting REGC to One in \_SB._INI when _REV >= 2. Since \_SB._INI is the
   first control method evaluated by OSPM during the enumeration, this
   allows EC accesses to happen for the entire enumeration process before
   the namespace EC is enumerated.
2. Initialize REGC to One by default, this even allows EC accesses to
   happen during the table loading.

Linux is now broken around ECDT support during the long term bug fixing
work because it has merged many wrong ECDT bug fixes (see details below).
Linux currently uses namespace EC's settings instead of ECDT settings when
ECDT is detected. This apparently will result in namespace walk and
_CRS/_GPE/_REG evaluations. Such stuffs could only happen after namespace
is ready, while ECDT is purposely to be used before namespace is ready.

The wrong bug fixing story is:
1. Link 1:
   At Linux ACPI early stages, "no _Lxx/_Exx/_Qxx evaluation can happen
   before the namespace is ready" are not ensured by ACPICA core and Linux.
   This is currently ensured by deferred enabling of GPE and defered
   registering of EC query methods (acpi_ec_register_query_methods).
2. Link 2:
   Reporters reported buggy ECDTs, expecting quirks for the platform.
   Originally, the quirk is simple, only doing things with ECDT.
   Bug 9399 and 12461 are platforms (Asus L4R, Asus M6R, MSI MS-171F)
   reported to have wrong ECDT IO port addresses, the port addresses are
   reversed.
   Bug 11880 is a platform (Asus X50GL) reported to have 0 valued port
   addresses, we can see that all EC accesses are protected by ECAV on
   this platform, so actually no early EC accesses is required by this
   platform.
3. Link 3:
   But when the bug fixing developer was requested to provide a handy and
   non-quirk bug fix, he tried to use correct EC settings from namespace
   and broke the spec purpose. We can even see that the developer was
   suffered from many regrssions. One interesting one is 14086, where the
   actual root cause obviously should be: _REG is evaluated too early. But
   unfortunately, the bug is fixed in a totally wrong way.

So everything goes wrong from these commits:
   Commit: c6cb0e878446c79f42e7833d7bb69ed6bfbb381f
   Subject: ACPI: EC: Don't trust ECDT tables from ASUS
   Commit: a5032bfdd9c80e0231a6324661e123818eb46ecd
   Subject: ACPI: EC: Always parse EC device

This patch reverts Linux behavior to simple ECDT quirk support in order to
stop early _CRS/_GPE/_REG evaluations.
For Bug 9399, 12461, since it is reported that the platforms require early
EC accesses, this patch restores the simple ECDT quirks for them.
For Bug 11880, since it is not reported that the platform requires early EC
accesses and its ACPI tables contain correct ECAV, we choose an ECDT
enumeration failure for this platform.

Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=9916
        http://bugzilla.kernel.org/show_bug.cgi?id=10100
        https://lkml.org/lkml/2008/2/25/282
Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=9399
        https://bugzilla.kernel.org/show_bug.cgi?id=12461
        https://bugzilla.kernel.org/show_bug.cgi?id=11880
Link 3: https://bugzilla.kernel.org/show_bug.cgi?id=11884
        https://bugzilla.kernel.org/show_bug.cgi?id=14081
        https://bugzilla.kernel.org/show_bug.cgi?id=14086
        https://bugzilla.kernel.org/show_bug.cgi?id=14446
Link 4: https://bugzilla.kernel.org/show_bug.cgi?id=112911
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/ec.c |  145 ++++++++++++++++++++---------------------------------
 1 file changed, 54 insertions(+), 91 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b8f474b..0e70181 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -175,10 +175,9 @@ static void acpi_ec_event_processor(struct work_struct *work);
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
 
-static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
-static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
+static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
 
 /* --------------------------------------------------------------------------
  *                           Logging/Debugging
@@ -1358,11 +1357,12 @@ static int acpi_ec_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	/* Check for boot EC */
-	if (boot_ec &&
-	    (boot_ec->handle == device->handle ||
-	     boot_ec->handle == ACPI_ROOT_OBJECT)) {
+	if (boot_ec) {
 		ec = boot_ec;
 		boot_ec = NULL;
+		ec_remove_handlers(ec);
+		if (first_ec == ec)
+			first_ec = NULL;
 	} else {
 		ec = make_acpi_ec();
 		if (!ec)
@@ -1462,20 +1462,6 @@ static const struct acpi_device_id ec_device_ids[] = {
 	{"", 0},
 };
 
-/* Some BIOS do not survive early DSDT scan, skip it */
-static int ec_skip_dsdt_scan(const struct dmi_system_id *id)
-{
-	EC_FLAGS_SKIP_DSDT_SCAN = 1;
-	return 0;
-}
-
-/* ASUStek often supplies us with broken ECDT, validate it */
-static int ec_validate_ecdt(const struct dmi_system_id *id)
-{
-	EC_FLAGS_VALIDATE_ECDT = 1;
-	return 0;
-}
-
 #if 0
 /*
  * Some EC firmware variations refuses to respond QR_EC when SCI_EVT is not
@@ -1517,30 +1503,29 @@ static int ec_clear_on_resume(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int ec_correct_ecdt(const struct dmi_system_id *id)
+{
+	pr_debug("Detected system needing ECDT address correction.\n");
+	EC_FLAGS_CORRECT_ECDT = 1;
+	return 0;
+}
+
 static struct dmi_system_id ec_dmi_table[] __initdata = {
 	{
-	ec_skip_dsdt_scan, "Compal JFL92", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
-	DMI_MATCH(DMI_BOARD_NAME, "JFL92") }, NULL},
+	ec_correct_ecdt, "Asus L4R", {
+	DMI_MATCH(DMI_BIOS_VERSION, "1008.006"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),
+	DMI_MATCH(DMI_BOARD_NAME, "L4R") }, NULL},
+	{
+	ec_correct_ecdt, "Asus M6R", {
+	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "M6R"),
+	DMI_MATCH(DMI_BOARD_NAME, "M6R") }, NULL},
 	{
-	ec_validate_ecdt, "MSI MS-171F", {
+	ec_correct_ecdt, "MSI MS-171F", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
 	{
-	ec_validate_ecdt, "ASUS hardware", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
-	{
-	ec_validate_ecdt, "ASUS hardware", {
-	DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc.") }, NULL},
-	{
-	ec_skip_dsdt_scan, "HP Folio 13", {
-	DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13"),}, NULL},
-	{
-	ec_validate_ecdt, "ASUS hardware", {
-	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek Computer Inc."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),}, NULL},
-	{
 	ec_clear_on_resume, "Samsung hardware", {
 	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
 	{},
@@ -1548,8 +1533,8 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 
 int __init acpi_ec_ecdt_probe(void)
 {
+	int ret = 0;
 	acpi_status status;
-	struct acpi_ec *saved_ec = NULL;
 	struct acpi_table_ecdt *ecdt_ptr;
 
 	boot_ec = make_acpi_ec();
@@ -1561,67 +1546,45 @@ int __init acpi_ec_ecdt_probe(void)
 	dmi_check_system(ec_dmi_table);
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
-	if (ACPI_SUCCESS(status)) {
-		pr_info("EC description table is found, configuring boot EC\n");
-		boot_ec->command_addr = ecdt_ptr->control.address;
-		boot_ec->data_addr = ecdt_ptr->data.address;
-		boot_ec->gpe = ecdt_ptr->gpe;
-		boot_ec->handle = ACPI_ROOT_OBJECT;
-		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id,
-				&boot_ec->handle);
-		/* Don't trust ECDT, which comes from ASUSTek */
-		if (!EC_FLAGS_VALIDATE_ECDT)
-			goto install;
-		saved_ec = kmemdup(boot_ec, sizeof(struct acpi_ec), GFP_KERNEL);
-		if (!saved_ec)
-			return -ENOMEM;
-	/* fall through */
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto error;
 	}
 
-	if (EC_FLAGS_SKIP_DSDT_SCAN) {
-		kfree(saved_ec);
-		return -ENODEV;
+	if (!ecdt_ptr->control.address || !ecdt_ptr->data.address) {
+		/*
+		 * Asus X50GL:
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=11880
+		 */
+		ret = -ENODEV;
+		goto error;
 	}
 
-	/* This workaround is needed only on some broken machines,
-	 * which require early EC, but fail to provide ECDT */
-	pr_debug("Look up EC in DSDT\n");
-	status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
-					boot_ec, NULL);
-	/* Check that acpi_get_devices actually find something */
-	if (ACPI_FAILURE(status) || !boot_ec->handle)
-		goto error;
-	if (saved_ec) {
-		/* try to find good ECDT from ASUSTek */
-		if (saved_ec->command_addr != boot_ec->command_addr ||
-		    saved_ec->data_addr != boot_ec->data_addr ||
-		    saved_ec->gpe != boot_ec->gpe ||
-		    saved_ec->handle != boot_ec->handle)
-			pr_info("ASUSTek keeps feeding us with broken "
-			"ECDT tables, which are very hard to workaround. "
-			"Trying to use DSDT EC info instead. Please send "
-			"output of acpidump to linux-acpi@vger.kernel.org\n");
-		kfree(saved_ec);
-		saved_ec = NULL;
+	pr_info("EC description table is found, configuring boot EC\n");
+	if (EC_FLAGS_CORRECT_ECDT) {
+		/*
+		 * Asus L4R, Asus M6R
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=9399
+		 * MSI MS-171F
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=12461
+		 */
+		boot_ec->command_addr = ecdt_ptr->data.address;
+		boot_ec->data_addr = ecdt_ptr->control.address;
 	} else {
-		/* We really need to limit this workaround, the only ASUS,
-		* which needs it, has fake EC._INI method, so use it as flag.
-		* Keep boot_ec struct as it will be needed soon.
-		*/
-		if (!dmi_name_in_vendors("ASUS") ||
-		    !acpi_has_method(boot_ec->handle, "_INI"))
-			return -ENODEV;
+		boot_ec->command_addr = ecdt_ptr->control.address;
+		boot_ec->data_addr = ecdt_ptr->data.address;
 	}
-install:
-	if (!ec_install_handlers(boot_ec)) {
+	boot_ec->gpe = ecdt_ptr->gpe;
+	boot_ec->handle = ACPI_ROOT_OBJECT;
+	ret = ec_install_handlers(boot_ec);
+	if (!ret)
 		first_ec = boot_ec;
-		return 0;
-	}
 error:
-	kfree(boot_ec);
-	kfree(saved_ec);
-	boot_ec = NULL;
-	return -ENODEV;
+	if (ret) {
+		kfree(boot_ec);
+		boot_ec = NULL;
+	}
+	return ret;
 }
 
 static int param_set_event_clearing(const char *val, struct kernel_param *kp)
-- 
1.7.10
