From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] thinkpad-acpi: support the second fan on the X61
Date: Thu, 18 Jun 2009 00:40:17 -0300
Message-ID: <1245296417-3734-3-git-send-email-hmh@hmh.eng.br>
References: <1245296417-3734-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32811 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754130AbZFRDka (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 23:40:30 -0400
In-Reply-To: <1245296417-3734-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Support reading the tachometer of the auxiliary fan of a X60/X61.

It was found out by sheer luck, that bit 0 of EC register 0x31
(formely HBRV) selects which fan is active for tachometer readings
through EC 0x84/0x085: 0 for fan1, 1 for fan2.

Many thanks to Christoph Kl=C3=BCnter, to Whoopie, and to weasel, who
helped confirm that behaviour.

=46an control through EC HFSP applies to both fans equally, regardless
of the state of bit 0 of EC 0x31.  That matches the way the DSDT uses
HFSP.

In order to better support the secondary fan, export a second
tachometer over hwmon, and add defensive measures to make sure we are
reading the correct tachometer.

Support for the second fan is whitelist-based, as I have not found
anything obvious to look for in the DSDT to detect the presence of
the second fan.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   10 ++-
 drivers/platform/x86/thinkpad_acpi.c    |  122 +++++++++++++++++++++++=
+++++++-
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/la=
ptops/thinkpad-acpi.txt
index f2ff638..0d5e913 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1269,7 +1269,7 @@ Fan control and monitoring: fan speed, fan enable=
/disable
=20
 procfs: /proc/acpi/ibm/fan
 sysfs device attributes: (hwmon "thinkpad") fan1_input, pwm1,
-			  pwm1_enable
+			  pwm1_enable, fan2_input
 sysfs hwmon driver attributes: fan_watchdog
=20
 NOTE NOTE NOTE: fan control operations are disabled by default for
@@ -1282,6 +1282,9 @@ from the hardware registers of the embedded contr=
oller.  This is known
 to work on later R, T, X and Z series ThinkPads but may show a bogus
 value on other models.
=20
+Some Lenovo ThinkPads support a secondary fan.  This fan cannot be
+controlled separately, it shares the main fan control.
+
 Fan levels:
=20
 Most ThinkPad fans work in "levels" at the firmware interface.  Level =
0
@@ -1412,6 +1415,11 @@ hwmon device attribute fan1_input:
 	which can take up to two minutes.  May return rubbish on older
 	ThinkPads.
=20
+hwmon device attribute fan2_input:
+	Fan tachometer reading, in RPM, for the secondary fan.
+	Available only on some ThinkPads.  If the secondary fan is
+	not installed, will always read 0.
+
 hwmon driver attribute fan_watchdog:
 	Fan safety watchdog timer interval, in seconds.  Minimum is
 	1 second, maximum is 120 seconds.  0 disables the watchdog.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
index c8d74db..27ca676 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -264,6 +264,7 @@ static struct {
 	u32 wan:1;
 	u32 uwb:1;
 	u32 fan_ctrl_status_undef:1;
+	u32 second_fan:1;
 	u32 beep_needs_two_args:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
@@ -6298,6 +6299,21 @@ static struct ibm_struct volume_driver_data =3D =
{
  *	For firmware bugs, refer to:
  *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Iss=
ues
  *
+ *	----
+ *
+ *	ThinkPad EC register 0x31 bit 0 (only on select models)
+ *
+ *	When bit 0 of EC register 0x31 is zero, the tachometer registers
+ *	show the speed of the main fan.  When bit 0 of EC register 0x31
+ *	is one, the tachometer registers show the speed of the auxiliary
+ *	fan.
+ *
+ *	Fan control seems to affect both fans, regardless of the state
+ *	of this bit.
+ *
+ *	So far, only the firmware for the X60/X61 non-tablet versions
+ *	seem to support this (firmware TP-7M).
+ *
  * TPACPI_FAN_WR_ACPI_FANS:
  *	ThinkPad X31, X40, X41.  Not available in the X60.
  *
@@ -6324,6 +6340,8 @@ enum {					/* Fan control constants */
 	fan_status_offset =3D 0x2f,	/* EC register 0x2f */
 	fan_rpm_offset =3D 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
 					 * 0x84 must be read before 0x85 */
+	fan_select_offset =3D 0x31,	/* EC register 0x31 (Firmware 7M)
+					   bit 0 selects which fan is active */
=20
 	TP_EC_FAN_FULLSPEED =3D 0x40,	/* EC fan mode: full speed */
 	TP_EC_FAN_AUTO	    =3D 0x80,	/* EC fan mode: auto fan control */
@@ -6417,6 +6435,38 @@ static void fan_quirk1_handle(u8 *fan_status)
 	}
 }
=20
+/* Select main fan on X60/X61, NOOP on others */
+static bool fan_select_fan1(void)
+{
+	if (tp_features.second_fan) {
+		u8 val;
+
+		if (ec_read(fan_select_offset, &val) < 0)
+			return false;
+		val &=3D 0xFEU;
+		if (ec_write(fan_select_offset, val) < 0)
+			return false;
+	}
+	return true;
+}
+
+/* Select secondary fan on X60/X61 */
+static bool fan_select_fan2(void)
+{
+	u8 val;
+
+	if (!tp_features.second_fan)
+		return false;
+
+	if (ec_read(fan_select_offset, &val) < 0)
+		return false;
+	val |=3D 0x01U;
+	if (ec_write(fan_select_offset, val) < 0)
+		return false;
+
+	return true;
+}
+
 /*
  * Call with fan_mutex held
  */
@@ -6494,6 +6544,8 @@ static int fan_get_speed(unsigned int *speed)
 	switch (fan_status_access_mode) {
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
+		if (unlikely(!fan_select_fan1()))
+			return -EIO;
 		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
 			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
 			return -EIO;
@@ -6510,6 +6562,34 @@ static int fan_get_speed(unsigned int *speed)
 	return 0;
 }
=20
+static int fan2_get_speed(unsigned int *speed)
+{
+	u8 hi, lo;
+	bool rc;
+
+	switch (fan_status_access_mode) {
+	case TPACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
+		if (unlikely(!fan_select_fan2()))
+			return -EIO;
+		rc =3D !acpi_ec_read(fan_rpm_offset, &lo) ||
+			     !acpi_ec_read(fan_rpm_offset + 1, &hi);
+		fan_select_fan1(); /* play it safe */
+		if (rc)
+			return -EIO;
+
+		if (likely(speed))
+			*speed =3D (hi << 8) | lo;
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int fan_set_level(int level)
 {
 	if (!fan_control_allowed)
@@ -6915,6 +6995,25 @@ static struct device_attribute dev_attr_fan_fan1=
_input =3D
 	__ATTR(fan1_input, S_IRUGO,
 		fan_fan1_input_show, NULL);
=20
+/* sysfs fan fan2_input ----------------------------------------------=
-- */
+static ssize_t fan_fan2_input_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res;
+	unsigned int speed;
+
+	res =3D fan2_get_speed(&speed);
+	if (res < 0)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+}
+
+static struct device_attribute dev_attr_fan_fan2_input =3D
+	__ATTR(fan2_input, S_IRUGO,
+		fan_fan2_input_show, NULL);
+
 /* sysfs fan fan_watchdog (hwmon driver) -----------------------------=
-- */
 static ssize_t fan_fan_watchdog_show(struct device_driver *drv,
 				     char *buf)
@@ -6948,6 +7047,7 @@ static DRIVER_ATTR(fan_watchdog, S_IWUSR | S_IRUG=
O,
 static struct attribute *fan_attributes[] =3D {
 	&dev_attr_fan_pwm1_enable.attr, &dev_attr_fan_pwm1.attr,
 	&dev_attr_fan_fan1_input.attr,
+	NULL, /* for fan2_input */
 	NULL
 };
=20
@@ -6955,7 +7055,8 @@ static const struct attribute_group fan_attr_grou=
p =3D {
 	.attrs =3D fan_attributes,
 };
=20
-#define	TPACPI_FAN_Q1	0x0001
+#define	TPACPI_FAN_Q1	0x0001		/* Unitialized HFSP */
+#define TPACPI_FAN_2FAN	0x0002		/* EC 0x31 bit 0 selects fan2 */
=20
 #define TPACPI_FAN_QI(__id1, __id2, __quirks)	\
 	{ .vendor =3D PCI_VENDOR_ID_IBM,		\
@@ -6963,13 +7064,21 @@ static const struct attribute_group fan_attr_gr=
oup =3D {
 	  .ec =3D TPID(__id1, __id2),		\
 	  .quirks =3D __quirks }
=20
+#define TPACPI_FAN_QL(__id1, __id2, __quirks)	\
+	{ .vendor =3D PCI_VENDOR_ID_LENOVO,	\
+	  .bios =3D TPACPI_MATCH_ANY,		\
+	  .ec =3D TPID(__id1, __id2),		\
+	  .quirks =3D __quirks }
+
 static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
 	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
+	TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
 };
=20
+#undef TPACPI_FAN_QL
 #undef TPACPI_FAN_QI
=20
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -6986,6 +7095,7 @@ static int __init fan_init(struct ibm_init_struct=
 *iibm)
 	fan_control_commands =3D 0;
 	fan_watchdog_maxinterval =3D 0;
 	tp_features.fan_ctrl_status_undef =3D 0;
+	tp_features.second_fan =3D 0;
 	fan_control_desired_level =3D 7;
=20
 	TPACPI_ACPIHANDLE_INIT(fans);
@@ -7006,6 +7116,11 @@ static int __init fan_init(struct ibm_init_struc=
t *iibm)
 			fan_status_access_mode =3D TPACPI_FAN_RD_TPEC;
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
+			if (quirks & TPACPI_FAN_2FAN) {
+				tp_features.second_fan =3D 1;
+				dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
+					"secondary fan support enabled\n");
+			}
 		} else {
 			printk(TPACPI_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
@@ -7061,6 +7176,11 @@ static int __init fan_init(struct ibm_init_struc=
t *iibm)
=20
 	if (fan_status_access_mode !=3D TPACPI_FAN_NONE ||
 	    fan_control_access_mode !=3D TPACPI_FAN_WR_NONE) {
+		if (tp_features.second_fan) {
+			/* attach second fan tachometer */
+			fan_attributes[ARRAY_SIZE(fan_attributes)-2] =3D
+					&dev_attr_fan_fan2_input.attr;
+		}
 		rc =3D sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
 					 &fan_attr_group);
 		if (rc < 0)
--=20
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
