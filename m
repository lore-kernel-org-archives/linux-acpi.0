From: Len Brown <len.brown@intel.com>
Subject: [PATCH 064/105] ACPI: thinkpad-acpi: cleanup thermal subdriver for sysfs conversion
Date: Sun, 29 Apr 2007 00:51:04 -0400
Message-ID: <1177822364262-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbXD2Ewr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:47 -0400
In-Reply-To: <11778223633408-git-send-email-len.brown@intel.com>
Message-Id: <04cc862c1893a055ab1117fa6f3aa0886c0ba032.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Clean-up the thermal subdriver for sysfs conversion.  Make thermal_get_*
reentrancy-safe while at it, and add the missing thermal_read_mode variable
to the header file.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
