From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/8] thinkpad-acpi: firmware version checks
Date: Sat, 12 Sep 2009 15:22:12 -0300
Message-ID: <1252779738-7459-3-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32899 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754561AbZILSWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:22 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use the quirk infrastructure to warn of outdated firmware and also of
firmware versions that are known to cause problems.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |  182 ++++++++++++++++++++++++++++++++++
 1 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d287283..cc4155c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1601,6 +1601,187 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 #endif
 }
 
+/*************************************************************************
+ * Firmware Data
+ */
+
+/*
+ * Table of recommended minimum BIOS versions
+ *
+ * Reasons for listing:
+ *    1. Stable BIOS, listed because the unknown ammount of
+ *       bugs and bad ACPI behaviour on older versions
+ *
+ *    2. BIOS or EC fw with known bugs that trigger on Linux
+ *
+ *    3. BIOS with known reduced functionality in older versions
+ *
+ *  We recommend the latest BIOS and EC version.
+ *  We only support the latest BIOS and EC fw version as a rule.
+ *
+ *  Sources: IBM ThinkPad Public Web Documents (update changelogs),
+ *  Information from users in ThinkWiki
+ */
+
+#define TPV_Q(__v, __id1, __id2, __bv1, __bv2)		\
+	{ .vendor	= (__v),			\
+	  .bios		= TPID(__id1, __id2),		\
+	  .ec		= TPACPI_MATCH_ANY,		\
+	  .quirks	= TPACPI_MATCH_ANY << 16	\
+			  | (__bv1) << 8 | (__bv2) }
+
+#define TPV_Q_X(__v, __bid1, __bid2, __bv1, __bv2,	\
+		__eid1, __eid2, __ev1, __ev2)		\
+	{ .vendor	= (__v),			\
+	  .bios		= TPID(__bid1, __bid2),		\
+	  .ec		= TPID(__eid1, __eid2),		\
+	  .quirks	= (__ev1) << 24 | (__ev2) << 16 \
+			  | (__bv1) << 8 | (__bv2) }
+
+#define TPV_QI0(__id1, __id2, __bv1, __bv2) \
+	TPV_Q(PCI_VENDOR_ID_IBM, __id1, __id2, __bv1, __bv2)
+
+#define TPV_QI1(__id1, __id2, __bv1, __bv2, __ev1, __ev2) \
+	TPV_Q_X(PCI_VENDOR_ID_IBM, __id1, __id2, 	\
+		__bv1, __bv2, __id1, __id2, __ev1, __ev2)
+
+#define TPV_QI2(__bid1, __bid2, __bv1, __bv2,		\
+		__eid1, __eid2, __ev1, __ev2) 		\
+	TPV_Q_X(PCI_VENDOR_ID_IBM, __bid1, __bid2, 	\
+		__bv1, __bv2, __eid1, __eid2, __ev1, __ev2)
+
+#define TPV_QL0(__id1, __id2, __bv1, __bv2) \
+	TPV_Q(PCI_VENDOR_ID_LENOVO, __id1, __id2, __bv1, __bv2)
+
+#define TPV_QL1(__id1, __id2, __bv1, __bv2, __ev1, __ev2) \
+	TPV_Q_X(PCI_VENDOR_ID_LENOVO, __id1, __id2, 	\
+		__bv1, __bv2, __id1, __id2, __ev1, __ev2)
+
+#define TPV_QL2(__bid1, __bid2, __bv1, __bv2,		\
+		__eid1, __eid2, __ev1, __ev2) 		\
+	TPV_Q_X(PCI_VENDOR_ID_LENOVO, __bid1, __bid2, 	\
+		__bv1, __bv2, __eid1, __eid2, __ev1, __ev2)
+
+static const struct tpacpi_quirk tpacpi_bios_version_qtable[] __initconst = {
+	/*  Numeric models ------------------ */
+	/*      FW MODEL   BIOS VERS	      */
+	TPV_QI0('I', 'M',  '6', '5'),		 /* 570 */
+	TPV_QI0('I', 'U',  '2', '6'),		 /* 570E */
+	TPV_QI0('I', 'B',  '5', '4'),		 /* 600 */
+	TPV_QI0('I', 'H',  '4', '7'),		 /* 600E */
+	TPV_QI0('I', 'N',  '3', '6'),		 /* 600E */
+	TPV_QI0('I', 'T',  '5', '5'),		 /* 600X */
+	TPV_QI0('I', 'D',  '4', '8'),		 /* 770, 770E, 770ED */
+	TPV_QI0('I', 'I',  '4', '2'),		 /* 770X */
+	TPV_QI0('I', 'O',  '2', '3'),		 /* 770Z */
+
+	/* A-series ------------------------- */
+	/*      FW MODEL   BIOS VERS  EC VERS */
+	TPV_QI0('I', 'W',  '5', '9'),		 /* A20m */
+	TPV_QI0('I', 'V',  '6', '9'),		 /* A20p */
+	TPV_QI0('1', '0',  '2', '6'),		 /* A21e, A22e */
+	TPV_QI0('K', 'U',  '3', '6'),		 /* A21e */
+	TPV_QI0('K', 'X',  '3', '6'),		 /* A21m, A22m */
+	TPV_QI0('K', 'Y',  '3', '8'),		 /* A21p, A22p */
+	TPV_QI0('1', 'B',  '1', '7'),		 /* A22e */
+	TPV_QI0('1', '3',  '2', '0'),		 /* A22m */
+	TPV_QI0('1', 'E',  '7', '3'),		 /* A30/p (0) */
+	TPV_QI1('1', 'G',  '4', '1',  '1', '7'), /* A31/p (0) */
+	TPV_QI1('1', 'N',  '1', '6',  '0', '7'), /* A31/p (0) */
+
+	/* G-series ------------------------- */
+	/*      FW MODEL   BIOS VERS	      */
+	TPV_QI0('1', 'T',  'A', '6'),		 /* G40 */
+	TPV_QI0('1', 'X',  '5', '7'),		 /* G41 */
+
+	/* R-series, T-series --------------- */
+	/*      FW MODEL   BIOS VERS  EC VERS */
+	TPV_QI0('1', 'C',  'F', '0'),		 /* R30 */
+	TPV_QI0('1', 'F',  'F', '1'),		 /* R31 */
+	TPV_QI0('1', 'M',  '9', '7'),		 /* R32 */
+	TPV_QI0('1', 'O',  '6', '1'),		 /* R40 */
+	TPV_QI0('1', 'P',  '6', '5'),		 /* R40 */
+	TPV_QI0('1', 'S',  '7', '0'),		 /* R40e */
+	TPV_QI1('1', 'R',  'D', 'R',  '7', '1'), /* R50/p, R51,
+						    T40/p, T41/p, T42/p (1) */
+	TPV_QI1('1', 'V',  '7', '1',  '2', '8'), /* R50e, R51 (1) */
+	TPV_QI1('7', '8',  '7', '1',  '0', '6'), /* R51e (1) */
+	TPV_QI1('7', '6',  '6', '9',  '1', '6'), /* R52 (1) */
+	TPV_QI1('7', '0',  '6', '9',  '2', '8'), /* R52, T43 (1) */
+
+	TPV_QI0('I', 'Y',  '6', '1'),		 /* T20 */
+	TPV_QI0('K', 'Z',  '3', '4'),		 /* T21 */
+	TPV_QI0('1', '6',  '3', '2'),		 /* T22 */
+	TPV_QI1('1', 'A',  '6', '4',  '2', '3'), /* T23 (0) */
+	TPV_QI1('1', 'I',  '7', '1',  '2', '0'), /* T30 (0) */
+	TPV_QI1('1', 'Y',  '6', '5',  '2', '9'), /* T43/p (1) */
+
+	TPV_QL1('7', '9',  'E', '3',  '5', '0'), /* T60/p */
+	TPV_QL1('7', 'C',  'D', '2',  '2', '2'), /* R60, R60i */
+	TPV_QL0('7', 'E',  'D', '0'),		 /* R60e, R60i */
+
+	/*      BIOS FW    BIOS VERS  EC FW     EC VERS */
+	TPV_QI2('1', 'W',  '9', '0',  '1', 'V', '2', '8'), /* R50e (1) */
+	TPV_QL2('7', 'I',  '3', '4',  '7', '9', '5', '0'), /* T60/p wide */
+
+	/* X-series ------------------------- */
+	/*      FW MODEL   BIOS VERS  EC VERS */
+	TPV_QI0('I', 'Z',  '9', 'D'),		 /* X20, X21 */
+	TPV_QI0('1', 'D',  '7', '0'),		 /* X22, X23, X24 */
+	TPV_QI1('1', 'K',  '4', '8',  '1', '8'), /* X30 (0) */
+	TPV_QI1('1', 'Q',  '9', '7',  '2', '3'), /* X31, X32 (0) */
+	TPV_QI1('1', 'U',  'D', '3',  'B', '2'), /* X40 (0) */
+	TPV_QI1('7', '4',  '6', '4',  '2', '7'), /* X41 (0) */
+	TPV_QI1('7', '5',  '6', '0',  '2', '0'), /* X41t (0) */
+
+	TPV_QL0('7', 'B',  'D', '7'),		 /* X60/s */
+	TPV_QL0('7', 'J',  '3', '0'),		 /* X60t */
+
+	/* (0) - older versions lack DMI EC fw string and functionality */
+	/* (1) - older versions known to lack functionality */
+};
+
+#undef TPV_QL1
+#undef TPV_QL0
+#undef TPV_QI2
+#undef TPV_QI1
+#undef TPV_QI0
+#undef TPV_Q_X
+#undef TPV_Q
+
+static void __init tpacpi_check_outdated_fw(void)
+{
+	unsigned long fwvers;
+	u16 ec_version, bios_version;
+
+	fwvers = tpacpi_check_quirks(tpacpi_bios_version_qtable,
+				ARRAY_SIZE(tpacpi_bios_version_qtable));
+
+	if (!fwvers)
+		return;
+
+	bios_version = fwvers & 0xffffU;
+	ec_version = (fwvers >> 16) & 0xffffU;
+
+	/* note that unknown versions are set to 0x0000 and we use that */
+	if ((bios_version > thinkpad_id.bios_release) ||
+	    (ec_version > thinkpad_id.ec_release &&
+				ec_version != TPACPI_MATCH_ANY)) {
+		/*
+		 * The changelogs would let us track down the exact
+		 * reason, but it is just too much of a pain to track
+		 * it.  We only list BIOSes that are either really
+		 * broken, or really stable to begin with, so it is
+		 * best if the user upgrades the firmware anyway.
+		 */
+		printk(TPACPI_WARN
+			"WARNING: Outdated ThinkPad BIOS/EC firmware\n");
+		printk(TPACPI_WARN
+			"WARNING: This firmware may be missing critical bug "
+			"fixes and/or important features\n");
+	}
+}
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -1634,6 +1815,7 @@ static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
 			(thinkpad_id.nummodel_str) ?
 				thinkpad_id.nummodel_str : "unknown");
 
+	tpacpi_check_outdated_fw();
 	return 0;
 }
 
-- 
1.6.3.3

