From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: Add "acpi_no_initrd_override" kernel parameter
Date: Wed,  6 Feb 2008 20:12:51 -0500
Message-ID: <1202346773-1893-4-git-send-email-lenb@kernel.org>
References: <47AA4F9D.7010601@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:1827 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758696AbYBGBXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:23:09 -0500
In-Reply-To: <47AA4F9D.7010601@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>, Eric Piel <eric.piel@tremplin-utc.net>, Len Brown <len.brown@intel.com>

=46rom: =C3=89ric Piel <Eric.Piel@tremplin-utc.net>

The acpi_no_initrd_override parameter permits to disable the load of an=
 ACPI
table from the initramfs.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 drivers/acpi/osl.c                  |   14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel=
-parameters.txt
index 8fd5aa4..ef2316a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -175,6 +175,9 @@ and is between 256 and 4096 characters. It is defin=
ed in the file
=20
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
=20
+	acpi_no_initrd_override	[KNL,ACPI]
+			Disable loading custom ACPI tables from the initramfs
+
 	acpi_os_name=3D	[HW,ACPI] Tell ACPI BIOS the name of the OS
 			Format: To spoof as Windows 98: =3D"Microsoft Windows"
=20
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index bbd8360..40adf0d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,6 +77,10 @@ static struct workqueue_struct *kacpi_notify_wq;
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
=20
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+static int acpi_no_initrd_override;
+#endif
+
 /*
  * "Ode to _OSI(Linux)"
  *
@@ -386,7 +390,8 @@ acpi_os_table_override(struct acpi_table_header * e=
xisting_table,
 		*new_table =3D (struct acpi_table_header *)AmlCode;
 #endif
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0) {
+	if ((strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0) &&
+	    !acpi_no_initrd_override) {
 		struct acpi_table_header *initrd_table =3D acpi_find_dsdt_initrd();
 		if (initrd_table)
 			*new_table =3D initrd_table;
@@ -402,6 +407,13 @@ acpi_os_table_override(struct acpi_table_header * =
existing_table,
 	return AE_OK;
 }
=20
+int __init acpi_no_initrd_override_setup(char *s)
+{
+	acpi_no_initrd_override =3D 1;
+	return 1;
+}
+__setup("acpi_no_initrd_override", acpi_no_initrd_override_setup);
+
 static irqreturn_t acpi_irq(int irq, void *dev_id)
 {
 	return (*acpi_irq_handler) (acpi_irq_context) ? IRQ_HANDLED : IRQ_NON=
E;
--=20
1.5.4.23.gef5b9

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
