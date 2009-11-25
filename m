From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/6] thinkpad-acpi: fix detection of old ThinkPads
Date: Wed, 25 Nov 2009 01:11:59 -0500
Message-ID: <275014ae46871ce0ab08550fc4040f12b685813a.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:44672 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZKYGMU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:20 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN00EW5IK60NQW@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:07 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
In-reply-to: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

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

http://bugzilla.kernel.org/show_bug.cgi?id=14597

Reported-by: Paul Kimoto <kimoto@lightlink.com>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Tested-by: Paul Kimoto <kimoto@lightlink.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 03c0a56..a848c7e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1680,36 +1680,48 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
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
-- 
1.6.0.6

