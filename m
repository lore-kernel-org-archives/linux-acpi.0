From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/34] ACPI: disable _OSI(Windows 2009) on Asus K50IJ
Date: Thu, 24 Dec 2009 01:23:36 -0500
Message-ID: <81074e90f5c150ca70ab8dfcc77860cbe76f364d.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63913 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZLXGYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:15 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV5002IX8GBQL71@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:12 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 23e5a05..2815df6 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -185,6 +185,12 @@ static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
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
@@ -211,6 +217,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
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
-- 
1.6.0.6

