From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: disable _OSI(Windows 2009) on Asus K50IJ
Date: Mon, 21 Dec 2009 16:13:15 +0800
Message-ID: <1261383195.12263.16.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57686 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZLUIJp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 03:09:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Alex.Haeussler@googlemail.com


Fix a win7 compability issue on Asus K50IJ.

Here is the _BCM method of this laptop:
                    Method (_BCM, 1, NotSerialized)
                    {
                        If (LGreaterEqual (OSFG, OSVT))
                        {
                            If (LNotEqual (OSFG, OSW7))
                            {
                                Store (One, BCMD)
                                Store (GCBL (Arg0), Local0)
                                Subtract (0x0F, Local0, LBTN)
                                ^^^SBRG.EC0.STBR ()
                                ...
                            }
                            Else
                            {
                                DBGR (0x0B, Zero, Zero, Arg0)
                                Store (Arg0, LBTN)
                                ^^^SBRG.EC0.STBR ()
                                ...
                            }
                        }
                    }
LBTN is used to store the index of the brightness level in the _BCL.
GCBL is a method that convert the percentage value to the index value.
If _OSI(Windows 2009) is not disabled, LBTN is stored a percentage
value which is surely beyond the end of _BCL package.
http://bugzilla.kernel.org/show_bug.cgi?id=14753

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/blacklist.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6/drivers/acpi/blacklist.c
===================================================================
--- linux-2.6.orig/drivers/acpi/blacklist.c
+++ linux-2.6/drivers/acpi/blacklist.c
@@ -185,6 +185,12 @@ static int __init dmi_disable_osi_vista(
 	acpi_osi_setup("!Windows 2006");
 	return 0;
 }
+static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2009");
+	return 0;
+}
 
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	{
@@ -211,6 +217,14 @@ static struct dmi_system_id acpi_osi_dmi
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win7,
+	.ident = "ASUS K50IJ",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "K50IJ"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.


