From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/6] ACPI: set waking vector in inactive facs table
Date: Mon, 13 Oct 2008 16:10:34 +0800
Message-ID: <1223885434.2735.188.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61818 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbYJMIMa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:12:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>


RSDT and XSDT may export different FACS tables.
Some of the BIOSes only checks one of them when resuming.
And Linux reboots instead of resuming because BIOS can't find
the waking vector.
=46or example,
=EF=BB=BFI have a platform which suspends well, but always reboots inst=
ead of
resuming when pressing the power button.
I found that there are two FACS tables on this platform,
XSDT-->FADT1-->Xfacs-->FACS1
	|----->facs-|
		    |->FACS2
RSDT-->FADT2-->facs-|
Linux uses XSDT on this platform and sets the waking vector in FACS1
when suspending.
But it seems that the BIOS only cares for the waking vector in FACS2,
thus it reboots when resuming because the waking vector is not set at a=
ll.

Set the waking vector in inactive FACS table in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   20 ++++++++++++++++++++
 drivers/acpi/tables/tbfadt.c    |    6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
@@ -65,6 +65,7 @@ acpi_set_firmware_waking_vector(acpi_phy
 {
 	struct acpi_table_facs *facs;
 	acpi_status status;
+	u32 table_index;
=20
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
=20
@@ -92,6 +93,25 @@ acpi_set_firmware_waking_vector(acpi_phy
 		facs->xfirmware_waking_vector =3D physical_address;
 	}
=20
+	/* set the firmware vector in the inactive facs table */
+	for (table_index =3D 0, facs =3D NULL; ; table_index++) {
+		status =3D acpi_get_inactive_table_by_index(table_index,
+				ACPI_CAST_INDIRECT_PTR(struct acpi_table_header,
+							&facs));
+		if (status =3D=3D AE_TABLE_NOT_SUPPORTED)
+			continue;
+		if (ACPI_FAILURE(status))
+			break;
+
+		if (!ACPI_COMPARE_NAME(&facs->signature, ACPI_SIG_FACS))
+			continue;
+
+		if (facs->version >=3D 1)
+			facs->xfirmware_waking_vector =3D 0;
+		facs->firmware_waking_vector =3D (u32)physical_address;
+		break;
+	}
+
 	return_ACPI_STATUS(AE_OK);
 }
=20
Index: linux-2.6/drivers/acpi/tables/tbfadt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
+++ linux-2.6/drivers/acpi/tables/tbfadt.c
@@ -290,11 +290,13 @@ static void acpi_tb_convert_fadt(void)
=20
 	if (!acpi_gbl_FADT.Xfacs) {
 		acpi_gbl_FADT.Xfacs =3D (u64) acpi_gbl_FADT.facs;
-	}
+	} else if (acpi_gbl_FADT.Xfacs !=3D acpi_gbl_FADT.facs)
+		ACPI_WARNING((AE_INFO, "32 bit FACS and 64 bit FACS not match\n"));
=20
 	if (!acpi_gbl_FADT.Xdsdt) {
 		acpi_gbl_FADT.Xdsdt =3D (u64) acpi_gbl_FADT.dsdt;
-	}
+	} else if (acpi_gbl_FADT.Xdsdt !=3D acpi_gbl_FADT.dsdt)
+		ACPI_WARNING((AE_INFO, "32 bit DSDT and 64 bit DSDT not match\n"));
=20
 	/*
 	 * For ACPI 1.0 FADTs (revision 1 or 2), ensure that reserved fields =
which


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
