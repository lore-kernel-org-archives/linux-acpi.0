From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] ACPI: ibm-acpi: add Ultrabay support for the T60p ThinkPad
Date: Tue,  6 Feb 2007 19:13:43 -0200
Message-ID: <11707964243869-git-send-email-hmh@hmh.eng.br>
References: <11707964241851-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56081 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965474AbXBFVNz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 16:13:55 -0500
In-Reply-To: <11707964241851-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

From: Theodore Ts'o <tytso@mit.edu>

The following patch adds support for obtaining the status and ejecting
Ultrabay devices for the T60p Thinkpad; my guess is that it probably
works on T60 Thinkpads and probably more recent Lenovo latops as well.

With the 2.03 BIOS I have been able to eject a SATA drive in an Ultrabay
carrier by using the command:

  "echo 1 > /sys/class/scsi_device/1:0:0:0/device/delete"

and upon re-inserting the it back into the device and issuing the
command:

 "echo 0 0 0 > /sys/class/scsi_host/host1/scan"

have the device appear again.  (With the 1.02 BIOS the device does not
function when re-inserted, even after a warm boot; a cold reboot is
required to store the Ultrabay device's functionality.)

More complicated Ultrabay eject and insert scripts can be found on the
ThinkWiki, although it's important to comment out the "hdparm -Y" as it
apparently doesn't work or do anything, and causes the eject process to
hang for about a minute.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Whoopie <whoopie79@gmx.net>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/ibm_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index c6144ca..5c0f1b8 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -159,7 +159,8 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 #endif
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
-	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
+	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60, SATA mode? */
+	   "\\_SB.PCI0.IDE0.PRIM.MSTR", /* T60p, IDE mode? */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
     );				/* A21e, R30, R31 */
 
-- 
1.4.4.4

