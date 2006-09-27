From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [patch 1/3] ibm-acpi: Use a enum to select the thermal sensor reading strategy
Date: Wed, 27 Sep 2006 20:53:36 -0300
Message-ID: <20060928001131.938563576@khazad-dum.debian.net>
References: <20060927235335.483578718@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:685 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1031294AbWI1Aiq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 20:38:46 -0400
Content-Disposition: inline; filename=ibm-acpi_thermal_access_mode.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, stefan@datenfreihafen.org

This patch consolidades all decisions regarding the strategy to be used to
read thinkpad thermal sensors into a single enum, and refactors the
thermal sensor reading code to use a much more readable (and easier to
extend) switch() construct.

Signed-off-By: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: borislav@users.sourceforge.net
---
 drivers/acpi/ibm_acpi.c |   71 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 25 deletions(-)

Index: 2.6.18/drivers/acpi/ibm_acpi.c
===================================================================
--- 2.6.18.orig/drivers/acpi/ibm_acpi.c
+++ 2.6.18/drivers/acpi/ibm_acpi.c
@@ -216,6 +216,12 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 #define IBM_HKEY_HID	"IBM0068"
 #define IBM_PCI_HID	"PNP0A03"
 
+enum thermal_access_mode {
+	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
+	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
+	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+};
+
 struct ibm_struct {
 	char *name;
 	char param[32];
@@ -1272,16 +1278,22 @@ static int acpi_ec_write(int i, u8 v)
 	return 1;
 }
 
-static int thermal_tmp_supported;
-static int thermal_updt_supported;
+static enum thermal_access_mode thermal_read_mode;
 
 static int thermal_init(void)
 {
-	/* temperatures not supported on 570, G4x, R30, R31, R32 */
-	thermal_tmp_supported = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
-
-	/* 600e/x, 770e, 770x */
-	thermal_updt_supported = acpi_evalf(ec_handle, NULL, "UPDT", "qv");
+	if (acpi_evalf(ec_handle, NULL, "TMP7", "qv")) {
+		if (acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
+			/* 600e/x, 770e, 770x */
+			thermal_read_mode = IBMACPI_THERMAL_ACPI_UPDT;
+		} else {
+			/* Standard ACPI TMPx access, max 8 sensors */
+			thermal_read_mode = IBMACPI_THERMAL_ACPI_TMP07;
+		}
+	} else {
+		/* temperatures not supported on 570, G4x, R30, R31, R32 */
+		thermal_read_mode = IBMACPI_THERMAL_NONE;
+	}
 
 	return 0;
 }
@@ -1289,34 +1301,43 @@ static int thermal_init(void)
 static int thermal_read(char *p)
 {
 	int len = 0;
-
-	if (!thermal_tmp_supported)
-		len += sprintf(p + len, "temperatures:\tnot supported\n");
-	else {
-		int i, t;
-		char tmpi[] = "TMPi";
-		s8 tmp[8];
-
-		if (thermal_updt_supported)
-			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+	int i, t;
+	s8 tmp[8];
+	char tmpi[] = "TMPi";
+
+	len += sprintf(p + len,	"temperatures:\t");
+
+	switch(thermal_read_mode) {
+	case IBMACPI_THERMAL_ACPI_UPDT:
+		if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+			return -EIO;
+		for (i = 0; i < 8; i++) {
+			tmpi[3] = '0' + i;
+			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
+			tmp[i] = (t - 2732 + 5) / 10;
+		}
+		break;
 
+	case IBMACPI_THERMAL_ACPI_TMP07:
 		for (i = 0; i < 8; i++) {
 			tmpi[3] = '0' + i;
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
-			if (thermal_updt_supported)
-				tmp[i] = (t - 2732 + 5) / 10;
-			else
-				tmp[i] = t;
+			tmp[i] = t;
 		}
+		break;
 
-		len += sprintf(p + len,
-			       "temperatures:\t%d %d %d %d %d %d %d %d\n",
-			       tmp[0], tmp[1], tmp[2], tmp[3],
-			       tmp[4], tmp[5], tmp[6], tmp[7]);
+	case IBMACPI_THERMAL_NONE:
+	default:
+		len += sprintf(p + len, "not supported\n");
+		return len;
 	}
 
+	for (i = 0; i < 7; i++)
+		len += sprintf(p + len, "%d ", tmp[i]);
+	len += sprintf(p + len, "%d\n", tmp[i]);
+
 	return len;
 }
 

--
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
