From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/7] ACPI: ibm-acpi: rename some identifiers
Date: Fri, 23 Mar 2007 17:33:55 -0300
Message-ID: <1174682041499-git-send-email-hmh@hmh.eng.br>
References: <11746820402862-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49768 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425AbXCWUeH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Mar 2007 16:34:07 -0400
In-Reply-To: <11746820402862-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rename some identifiers so that they are more in tune with the rest of the
driver code, or less generic.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/ibm_acpi.c |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 60aaed9..41c46b0 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -506,7 +506,7 @@ static int ibm_acpi_driver_init(void)
 	return 0;
 }
 
-static int driver_read(char *p)
+static int ibm_acpi_driver_read(char *p)
 {
 	int len = 0;
 
@@ -1310,9 +1310,9 @@ static const int led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
 static const int led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
 static const int led_led_arg1[] = { 0, 0x80, 0xc0 };
 
-#define EC_HLCL 0x0c
-#define EC_HLBL 0x0d
-#define EC_HLMS 0x0e
+#define IBMACPI_LED_EC_HLCL 0x0c
+#define IBMACPI_LED_EC_HLBL 0x0d
+#define IBMACPI_LED_EC_HLMS 0x0e
 
 static int led_write(char *buf)
 {
@@ -1344,13 +1344,15 @@ static int led_write(char *buf)
 		} else if (led_supported == IBMACPI_LED_OLD) {
 			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
 			led = 1 << led;
-			ret = ec_write(EC_HLMS, led);
+			ret = ec_write(IBMACPI_LED_EC_HLMS, led);
 			if (ret >= 0)
 				ret =
-				    ec_write(EC_HLBL, led * led_exp_hlbl[ind]);
+				    ec_write(IBMACPI_LED_EC_HLBL,
+				    	     led * led_exp_hlbl[ind]);
 			if (ret >= 0)
 				ret =
-				    ec_write(EC_HLCL, led * led_exp_hlcl[ind]);
+				    ec_write(IBMACPI_LED_EC_HLCL,
+				    	     led * led_exp_hlcl[ind]);
 			if (ret < 0)
 				return ret;
 		} else {
@@ -1657,8 +1659,8 @@ static int brightness_read(char *p)
 	return len;
 }
 
-#define BRIGHTNESS_UP	4
-#define BRIGHTNESS_DOWN	5
+#define TP_CMOS_BRIGHTNESS_UP	4
+#define TP_CMOS_BRIGHTNESS_DOWN	5
 
 static int brightness_set(int value)
 {
@@ -1667,7 +1669,8 @@ static int brightness_set(int value)
 
 	value &= 7;
 
-	cmos_cmd = value > current_value ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
+	cmos_cmd = value > current_value ?
+		   TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 	for (i = current_value; i != value; i += inc) {
 		if (!cmos_eval(cmos_cmd))
@@ -1769,9 +1772,9 @@ static int volume_read(char *p)
 	return len;
 }
 
-#define VOLUME_DOWN	0
-#define VOLUME_UP	1
-#define VOLUME_MUTE	2
+#define TP_CMOS_VOLUME_DOWN	0
+#define TP_CMOS_VOLUME_UP	1
+#define TP_CMOS_VOLUME_MUTE	2
 
 static int volume_write(char *buf)
 {
@@ -1805,7 +1808,8 @@ static int volume_write(char *buf)
 			return -EINVAL;
 
 		if (new_level != level) {	/* mute doesn't change */
-			cmos_cmd = new_level > level ? VOLUME_UP : VOLUME_DOWN;
+			cmos_cmd = new_level > level ?
+					TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
 			if (mute && (!cmos_eval(cmos_cmd) ||
@@ -1817,14 +1821,15 @@ static int volume_write(char *buf)
 				    !acpi_ec_write(volume_offset, i + inc))
 					return -EIO;
 
-			if (mute && (!cmos_eval(VOLUME_MUTE) ||
+			if (mute && (!cmos_eval(TP_CMOS_VOLUME_MUTE) ||
 				     !acpi_ec_write(volume_offset,
 						    new_level + mute)))
 				return -EIO;
 		}
 
 		if (new_mute != mute) {	/* level doesn't change */
-			cmos_cmd = new_mute ? VOLUME_MUTE : VOLUME_UP;
+			cmos_cmd = new_mute ?
+				   TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
 			if (!cmos_eval(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
@@ -2315,7 +2320,7 @@ static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
 	 .init = ibm_acpi_driver_init,
-	 .read = driver_read,
+	 .read = ibm_acpi_driver_read,
 	 },
 	{
 	 .name = "hotkey",
@@ -2534,7 +2539,7 @@ static int __init ibm_device_add(struct acpi_device *device)
 	return 0;
 }
 
-static int __init register_driver(struct ibm_struct *ibm)
+static int __init register_ibmacpi_subdriver(struct ibm_struct *ibm)
 {
 	int ret;
 
@@ -2569,7 +2574,7 @@ static int __init ibm_init(struct ibm_struct *ibm)
 		return 0;
 
 	if (ibm->hid) {
-		ret = register_driver(ibm);
+		ret = register_ibmacpi_subdriver(ibm);
 		if (ret < 0)
 			return ret;
 		ibm->driver_registered = 1;
-- 
1.5.0.3

