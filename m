From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: EC: Rewrite DMI checks
Date: Fri, 02 Oct 2009 20:21:33 +0400
Message-ID: <20091002162133.14126.81642.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47063 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754542AbZJBQVb (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 2 Oct 2009 12:21:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Use dmi_check_system() for DMI matching.
Don't use string "Notebook" for matching MSI hardware.
Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14081
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f707960..3fcb913 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -119,6 +119,7 @@ static struct acpi_ec {
 } *boot_ec, *first_ec;
 
 static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
+static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -899,6 +900,33 @@ static const struct acpi_device_id ec_device_ids[] = {
 	{"", 0},
 };
 
+/* ASUStek often supplies us with broken ECDT, validate it */
+static int ec_validate_ecdt(const struct dmi_system_id *id)
+{
+	EC_FLAGS_VALIDATE_ECDT = 1;
+	return 0;
+}
+
+/* MSI EC needs special treatment, enable it */
+static int ec_flag_msi(const struct dmi_system_id *id)
+{
+	EC_FLAGS_MSI = 1;
+	EC_FLAGS_VALIDATE_ECDT = 1;
+	return 0;
+}
+
+static struct dmi_system_id __initdata ec_dmi_table[] = {
+	{
+	ec_flag_msi, "MSI hardware", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Micro-Star"),
+	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star") }, NULL},
+	{
+	ec_validate_ecdt, "ASUS hardware", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
+	{},
+};
+
+
 int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
@@ -911,11 +939,7 @@ int __init acpi_ec_ecdt_probe(void)
 	/*
 	 * Generate a boot ec context
 	 */
-	if (dmi_name_in_vendors("Micro-Star") ||
-	    dmi_name_in_vendors("Notebook")) {
-		pr_info(PREFIX "Enabling special treatment for EC from MSI.\n");
-		EC_FLAGS_MSI = 1;
-	}
+	dmi_check_system(ec_dmi_table);
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_SUCCESS(status)) {
@@ -926,7 +950,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
 		/* Don't trust ECDT, which comes from ASUSTek */
-		if (!dmi_name_in_vendors("ASUS") && EC_FLAGS_MSI == 0)
+		if (!EC_FLAGS_VALIDATE_ECDT)
 			goto install;
 		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 		if (!saved_ec)
@@ -934,6 +958,7 @@ int __init acpi_ec_ecdt_probe(void)
 		memcpy(saved_ec, boot_ec, sizeof(struct acpi_ec));
 	/* fall through */
 	}
+
 	/* This workaround is needed only on some broken machines,
 	 * which require early EC, but fail to provide ECDT */
 	printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");

