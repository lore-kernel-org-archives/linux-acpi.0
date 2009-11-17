From: akpm@linux-foundation.org
Subject: [patch for 2.6.32? 2/2] thinkpad-acpi: fix detection of old ThinkPads
Date: Tue, 17 Nov 2009 14:07:22 -0800
Message-ID: <200911172207.nAHM7Np5007567@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49868 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852AbZKQWII (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:08:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, hmh@hmh.eng.br, bjorn.helgaas@hp.com, kimoto@lightlink.com, rjw@sisk.pl

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

There is a problem in the quirk tables used by tpacpi_is_fw_known() and
tpacpi_check_outdated_fw(), which causes outdated BIOSes that are lacking
the EC firmware ID DMI field to never match.

This breaks module loading on, e.g.  a T23 with outdated BIOS, and the
module will refuse to load unless the "force_load=1" parameter is given.

Fix the quirk tables so that they can also match the outdated BIOSes,
which in turn will both fix the module loading, and also warn the user
that he is using outdated firmware and should upgrade.

This fixes a serious regression, introduced by commit
e675abafcc0df38125e6e94a9ba91c92fe774f52, "thinkpad-acpi: be more strict
when detecting a ThinkPad".

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=14597

Reported-by: Paul Kimoto <kimoto@lightlink.com>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Tested-by: Paul Kimoto <kimoto@lightlink.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/thinkpad_acpi.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff -puN drivers/platform/x86/thinkpad_acpi.c~thinkpad-acpi-fix-detection-of-old-thinkpads drivers/platform/x86/thinkpad_acpi.c
--- a/drivers/platform/x86/thinkpad_acpi.c~thinkpad-acpi-fix-detection-of-old-thinkpads
+++ a/drivers/platform/x86/thinkpad_acpi.c
@@ -1680,36 +1680,48 @@ static void tpacpi_remove_driver_attribu
 			  | (__bv1) << 8 | (__bv2) }
 
 #define TPV_Q_X(__v, __bid1, __bid2, __bv1, __bv2,	\
-		__eid1, __eid2, __ev1, __ev2)		\
+		__eid, __ev1, __ev2)			\
 	{ .vendor	= (__v),			\
 	  .bios		= TPID(__bid1, __bid2),		\
-	  .ec		= TPID(__eid1, __eid2),		\
+	  .ec		= __eid,			\
 	  .quirks	= (__ev1) << 24 | (__ev2) << 16 \
 			  | (__bv1) << 8 | (__bv2) }
 
 #define TPV_QI0(__id1, __id2, __bv1, __bv2) \
 	TPV_Q(PCI_VENDOR_ID_IBM, __id1, __id2, __bv1, __bv2)
 
+/* Outdated IBM BIOSes often lack the EC id string */
 #define TPV_QI1(__id1, __id2, __bv1, __bv2, __ev1, __ev2) \
 	TPV_Q_X(PCI_VENDOR_ID_IBM, __id1, __id2, 	\
-		__bv1, __bv2, __id1, __id2, __ev1, __ev2)
+		__bv1, __bv2, TPID(__id1, __id2),	\
+		__ev1, __ev2),				\
+	TPV_Q_X(PCI_VENDOR_ID_IBM, __id1, __id2, 	\
+		__bv1, __bv2, TPACPI_MATCH_UNKNOWN,	\
+		__ev1, __ev2)
 
+/* Outdated IBM BIOSes often lack the EC id string */
 #define TPV_QI2(__bid1, __bid2, __bv1, __bv2,		\
 		__eid1, __eid2, __ev1, __ev2) 		\
 	TPV_Q_X(PCI_VENDOR_ID_IBM, __bid1, __bid2, 	\
-		__bv1, __bv2, __eid1, __eid2, __ev1, __ev2)
+		__bv1, __bv2, TPID(__eid1, __eid2),	\
+		__ev1, __ev2),				\
+	TPV_Q_X(PCI_VENDOR_ID_IBM, __bid1, __bid2, 	\
+		__bv1, __bv2, TPACPI_MATCH_UNKNOWN,	\
+		__ev1, __ev2)
 
 #define TPV_QL0(__id1, __id2, __bv1, __bv2) \
 	TPV_Q(PCI_VENDOR_ID_LENOVO, __id1, __id2, __bv1, __bv2)
 
 #define TPV_QL1(__id1, __id2, __bv1, __bv2, __ev1, __ev2) \
 	TPV_Q_X(PCI_VENDOR_ID_LENOVO, __id1, __id2, 	\
-		__bv1, __bv2, __id1, __id2, __ev1, __ev2)
+		__bv1, __bv2, TPID(__id1, __id2),	\
+		__ev1, __ev2)
 
 #define TPV_QL2(__bid1, __bid2, __bv1, __bv2,		\
 		__eid1, __eid2, __ev1, __ev2) 		\
 	TPV_Q_X(PCI_VENDOR_ID_LENOVO, __bid1, __bid2, 	\
-		__bv1, __bv2, __eid1, __eid2, __ev1, __ev2)
+		__bv1, __bv2, TPID(__eid1, __eid2),	\
+		__ev1, __ev2)
 
 static const struct tpacpi_quirk tpacpi_bios_version_qtable[] __initconst = {
 	/*  Numeric models ------------------ */
_
