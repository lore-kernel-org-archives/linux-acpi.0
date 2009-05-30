From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 2/5] thinkpad-acpi: add quirklist engine
Date: Sat, 30 May 2009 13:25:06 -0300
Message-ID: <1243700709-25977-3-git-send-email-hmh@hmh.eng.br>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1243700709-25977-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a quirklist engine suitable for matching ThinkPad firmware,
and change the code to use it.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/platform/x86/thinkpad_acpi.c |  119 ++++++++++++++++++++++++++++------
 1 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d2a0ef8..3981b06 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -364,6 +364,73 @@ static void tpacpi_log_usertask(const char * const what)
 		} \
 	} while (0)
 
+/*
+ * Quirk handling helpers
+ *
+ * ThinkPad IDs and versions seen in the field so far
+ * are two-characters from the set [0-9A-Z], i.e. base 36.
+ *
+ * We use values well outside that range as specials.
+ */
+
+#define TPACPI_MATCH_ANY		0xffffU
+#define TPACPI_MATCH_UNKNOWN		0U
+
+/* TPID('1', 'Y') == 0x5931 */
+#define TPID(__c1, __c2) (((__c2) << 8) | (__c1))
+
+#define TPACPI_Q_IBM(__id1, __id2, __quirk)	\
+	{ .vendor = PCI_VENDOR_ID_IBM,		\
+	  .bios = TPID(__id1, __id2),		\
+	  .ec = TPACPI_MATCH_ANY,		\
+	  .quirks = (__quirk) }
+
+#define TPACPI_Q_LNV(__id1, __id2, __quirk)	\
+	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
+	  .bios = TPID(__id1, __id2),		\
+	  .ec = TPACPI_MATCH_ANY,		\
+	  .quirks = (__quirk) }
+
+struct tpacpi_quirk {
+	unsigned int vendor;
+	u16 bios;
+	u16 ec;
+	unsigned long quirks;
+};
+
+/**
+ * tpacpi_check_quirks() - search BIOS/EC version on a list
+ * @qlist:		array of &struct tpacpi_quirk
+ * @qlist_size:		number of elements in @qlist
+ *
+ * Iterates over a quirks list until one is found that matches the
+ * ThinkPad's vendor, BIOS and EC model.
+ *
+ * Returns 0 if nothing matches, otherwise returns the quirks field of
+ * the matching &struct tpacpi_quirk entry.
+ *
+ * The match criteria is: vendor, ec and bios much match.
+ */
+static unsigned long __init tpacpi_check_quirks(
+			const struct tpacpi_quirk *qlist,
+			unsigned int qlist_size)
+{
+	while (qlist_size) {
+		if ((qlist->vendor == thinkpad_id.vendor ||
+				qlist->vendor == TPACPI_MATCH_ANY) &&
+		    (qlist->bios == thinkpad_id.bios_model ||
+				qlist->bios == TPACPI_MATCH_ANY) &&
+		    (qlist->ec == thinkpad_id.ec_model ||
+				qlist->ec == TPACPI_MATCH_ANY))
+			return qlist->quirks;
+
+		qlist_size--;
+		qlist++;
+	}
+	return 0;
+}
+
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -6223,30 +6290,18 @@ TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
  * We assume 0x07 really means auto mode while this quirk is active,
  * as this is far more likely than the ThinkPad being in level 7,
  * which is only used by the firmware during thermal emergencies.
+ *
+ * Enable for TP-1Y (T43), TP-78 (R51e), TP-76 (R52),
+ * TP-70 (T43, R52), which are known to be buggy.
  */
 
-static void fan_quirk1_detect(void)
+static void fan_quirk1_setup(void)
 {
-	/* In some ThinkPads, neither the EC nor the ACPI
-	 * DSDT initialize the HFSP register, and it ends up
-	 * being initially set to 0x07 when it *could* be
-	 * either 0x07 or 0x80.
-	 *
-	 * Enable for TP-1Y (T43), TP-78 (R51e),
-	 * TP-76 (R52), TP-70 (T43, R52), which are known
-	 * to be buggy. */
 	if (fan_control_initial_status == 0x07) {
-		switch (thinkpad_id.ec_model) {
-		case 0x5931: /* TP-1Y */
-		case 0x3837: /* TP-78 */
-		case 0x3637: /* TP-76 */
-		case 0x3037: /* TP-70 */
-			printk(TPACPI_NOTICE
-			       "fan_init: initial fan status is unknown, "
-			       "assuming it is in auto mode\n");
-			tp_features.fan_ctrl_status_undef = 1;
-			;;
-		}
+		printk(TPACPI_NOTICE
+		       "fan_init: initial fan status is unknown, "
+		       "assuming it is in auto mode\n");
+		tp_features.fan_ctrl_status_undef = 1;
 	}
 }
 
@@ -6804,9 +6859,27 @@ static const struct attribute_group fan_attr_group = {
 	.attrs = fan_attributes,
 };
 
+#define	TPACPI_FAN_Q1	0x0001
+
+#define TPACPI_FAN_QI(__id1, __id2, __quirks)	\
+	{ .vendor = PCI_VENDOR_ID_IBM,		\
+	  .bios = TPACPI_MATCH_ANY,		\
+	  .ec = TPID(__id1, __id2),		\
+	  .quirks = __quirks }
+
+static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
+	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
+	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
+	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
+	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
+};
+
+#undef TPACPI_FAN_QI
+
 static int __init fan_init(struct ibm_init_struct *iibm)
 {
 	int rc;
+	unsigned long quirks;
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
 			"initializing fan subdriver\n");
@@ -6823,6 +6896,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	TPACPI_ACPIHANDLE_INIT(gfan);
 	TPACPI_ACPIHANDLE_INIT(sfan);
 
+	quirks = tpacpi_check_quirks(fan_quirk_table,
+				     ARRAY_SIZE(fan_quirk_table));
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
@@ -6832,7 +6908,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		if (likely(acpi_ec_read(fan_status_offset,
 					&fan_control_initial_status))) {
 			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
-			fan_quirk1_detect();
+			if (quirks & TPACPI_FAN_Q1)
+				fan_quirk1_setup();
 		} else {
 			printk(TPACPI_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
-- 
1.6.2.4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
