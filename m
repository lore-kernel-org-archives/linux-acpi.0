From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 19/20] ACPI: thinkpad-acpi: cleanup thermal
	subdriver for sysfs conversion
Date: Sat, 21 Apr 2007 11:08:43 -0300
Message-ID: <11771645291715-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Clean-up the thermal subdriver for sysfs conversion.  Make thermal_get_*
reentrancy-safe while at it, and add the missing thermal_read_mode variable
to the header file.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   79 ++++++++++++++++++++++++++++--------------
 drivers/misc/thinkpad_acpi.h |    8 ++++
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 8829d3c..e9aec87 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1818,13 +1818,13 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 		ta1 = ta2 = 0;
 		for (i = 0; i < 8; i++) {
-			if (likely(acpi_ec_read(0x78 + i, &t))) {
+			if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
 				ta1 |= t;
 			} else {
 				ta1 = 0;
 				break;
 			}
-			if (likely(acpi_ec_read(0xC0 + i, &t))) {
+			if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
 				ta2 |= t;
 			} else {
 				ta1 = 0;
@@ -1869,57 +1869,84 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 	return (thermal_read_mode != TPACPI_THERMAL_NONE)? 0 : 1;
 }
 
-static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
+/* idx is zero-based */
+static int thermal_get_sensor(int idx, s32 *value)
 {
-	int i, t;
+	int t;
 	s8 tmp;
-	char tmpi[] = "TMPi";
+	char tmpi[5];
 
-	if (!s)
-		return -EINVAL;
+	t = TP_EC_THERMAL_TMP0;
 
 	switch (thermal_read_mode) {
 #if TPACPI_MAX_THERMAL_SENSORS >= 16
 	case TPACPI_THERMAL_TPEC_16:
-		for (i = 0; i < 8; i++) {
-			if (!acpi_ec_read(0xC0 + i, &tmp))
-				return -EIO;
-			s->temp[i + 8] = tmp * 1000;
+		if (idx >= 8 && idx <= 15) {
+			t = TP_EC_THERMAL_TMP8;
+			idx -= 8;
 		}
 		/* fallthrough */
 #endif
 	case TPACPI_THERMAL_TPEC_8:
-		for (i = 0; i < 8; i++) {
-			if (!acpi_ec_read(0x78 + i, &tmp))
+		if (idx <= 7) {
+			if (!acpi_ec_read(t + idx, &tmp))
 				return -EIO;
-			s->temp[i] = tmp * 1000;
+			*value = tmp * 1000;
+			return 0;
 		}
-		return (thermal_read_mode == TPACPI_THERMAL_TPEC_16) ? 16 : 8;
+		break;
 
 	case TPACPI_THERMAL_ACPI_UPDT:
-		if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
-			return -EIO;
-		for (i = 0; i < 8; i++) {
-			tmpi[3] = '0' + i;
+		if (idx <= 7) {
+			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
+			if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
+				return -EIO;
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
-			s->temp[i] = (t - 2732) * 100;
+			*value = (t - 2732) * 100;
+			return 0;
 		}
-		return 8;
+		break;
 
 	case TPACPI_THERMAL_ACPI_TMP07:
-		for (i = 0; i < 8; i++) {
-			tmpi[3] = '0' + i;
+		if (idx <= 7) {
+			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
-			s->temp[i] = t * 1000;
+			*value = t * 1000;
+			return 0;
 		}
-		return 8;
+		break;
 
 	case TPACPI_THERMAL_NONE:
 	default:
-		return 0;
+		return -ENOSYS;
 	}
+
+	return -EINVAL;
+}
+
+static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
+{
+	int res, i;
+	int n;
+
+	n = 8;
+	i = 0;
+
+	if (!s)
+		return -EINVAL;
+
+	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
+		n = 16;
+
+	for(i = 0 ; i < n; i++) {
+		res = thermal_get_sensor(i, &s->temp[i]);
+		if (res)
+			return res;
+	}
+
+	return n;
 }
 
 static int thermal_read(char *p)
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index fb0abb0..6432b28 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -427,12 +427,20 @@ enum thermal_access_mode {
 	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
 };
 
+enum { /* TPACPI_THERMAL_TPEC_* */
+	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
+	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
+};
+
 #define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
 struct ibm_thermal_sensors_struct {
 	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
 };
 
+static enum thermal_access_mode thermal_read_mode;
+
 static int thermal_init(struct ibm_init_struct *iibm);
+static int thermal_get_sensor(int idx, s32 *value);
 static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
 static int thermal_read(char *p);
 
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
