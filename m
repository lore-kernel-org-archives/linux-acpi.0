From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 03/21] ACPI: ibm-acpi: Use a enum to select the thermal sensor reading strategy
Date: Sat, 25 Nov 2006 18:42:56 -0200
Message-ID: <20061125204256.6604.85736.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45763 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967174AbWKYUmy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:42:54 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch consolidades all decisions regarding the strategy to be used to
read thinkpad thermal sensors into a single enum, and refactors the
thermal sensor reading code to use a much more readable (and easier to
extend) switch() construct, in a separate function.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |   90 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 622626b..3a8f223 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -217,6 +217,17 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 #define IBM_HKEY_HID	"IBM0068"
 #define IBM_PCI_HID	"PNP0A03"
 
+enum thermal_access_mode {
+	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
+	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
+	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+};
+
+#define IBMACPI_MAX_THERMAL_SENSORS 8	/* Max thermal sensors supported */
+struct ibm_thermal_sensors_struct {
+	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
+};
+
 struct ibm_struct {
 	char *name;
 	char param[32];
@@ -1275,50 +1286,79 @@ static int acpi_ec_write(int i, u8 v)
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
 
-static int thermal_read(char *p)
+static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 {
-	int len = 0;
+	int i, t;
+	char tmpi[] = "TMPi";
 
-	if (!thermal_tmp_supported)
-		len += sprintf(p + len, "temperatures:\tnot supported\n");
-	else {
-		int i, t;
-		char tmpi[] = "TMPi";
-		s8 tmp[8];
+	if (!s)
+		return -EINVAL;
 
-		if (thermal_updt_supported)
-			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+	switch (thermal_read_mode) {
+	case IBMACPI_THERMAL_ACPI_UPDT:
+		if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+			return -EIO;
+		for (i = 0; i < 8; i++) {
+			tmpi[3] = '0' + i;
+			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
+			s->temp[i] = (t - 2732) * 100;
+		}
+		return 8;
 
+	case IBMACPI_THERMAL_ACPI_TMP07:
 		for (i = 0; i < 8; i++) {
 			tmpi[3] = '0' + i;
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
-			if (thermal_updt_supported)
-				tmp[i] = (t - 2732 + 5) / 10;
-			else
-				tmp[i] = t;
+			s->temp[i] = t * 1000;
 		}
+		return 8;
 
-		len += sprintf(p + len,
-			       "temperatures:\t%d %d %d %d %d %d %d %d\n",
-			       tmp[0], tmp[1], tmp[2], tmp[3],
-			       tmp[4], tmp[5], tmp[6], tmp[7]);
+	case IBMACPI_THERMAL_NONE:
+	default:
+		return 0;
 	}
+}
+
+static int thermal_read(char *p)
+{
+	int len = 0;
+	int n, i;
+	struct ibm_thermal_sensors_struct t;
+
+	n = thermal_get_sensors(&t);
+	if (unlikely(n < 0))
+		return n;
+
+	len += sprintf(p + len, "temperatures:\t");
+
+	if (n > 0) {
+		for (i = 0; i < (n - 1); i++)
+			len += sprintf(p + len, "%d ", t.temp[i] / 1000);
+		len += sprintf(p + len, "%d\n", t.temp[i] / 1000);
+	} else
+		len += sprintf(p + len, "not supported\n");
 
 	return len;
 }
