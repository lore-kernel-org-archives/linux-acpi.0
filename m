From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 4/6] ideapad: add markups, unify comments and return result when init
Date: Mon, 13 Dec 2010 18:00:48 +0800
Message-ID: <1292234448-2715-1-git-send-email-ike.pan@canonical.com>
References: <1292234384-2599-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292234384-2599-1-git-send-email-ike.pan@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-acpi@vger.kernel.org

1. Add markups on init and exit functions
2. Unify the comments in the same style
3. Return result when module initial

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/ideapad-laptop.c |   31 +++++++++++++++++--------=
------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x=
86/ideapad-laptop.c
index 04b4f5b..3c6c5b5 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1,5 +1,5 @@
 /*
- *  ideapad_acpi.c - Lenovo IdeaPad ACPI Extras
+ *  ideapad-laptop.c - Lenovo IdeaPad ACPI Extras
  *
  *  Copyright =C2=A9 2010 Intel Corporation
  *  Copyright =C2=A9 2010 David Woodhouse <dwmw2@infradead.org>
@@ -168,8 +168,10 @@ static int write_ec_cmd(acpi_handle handle, int cm=
d, unsigned long data)
 	pr_err("timeout in write_ec_cmd\n");
 	return -1;
 }
-/* the above is ACPI helpers */
=20
+/*
+ * camera power
+ */
 static ssize_t show_ideapad_cam(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -203,6 +205,9 @@ static ssize_t store_ideapad_cam(struct device *dev=
,
=20
 static DEVICE_ATTR(camera_power, 0644, show_ideapad_cam, store_ideapad=
_cam);
=20
+/*
+ * Rfkill
+ */
 static int ideapad_rfk_set(void *data, bool blocked)
 {
 	int device =3D (unsigned long)data;
@@ -235,7 +240,8 @@ static void ideapad_sync_rfk_state(struct acpi_devi=
ce *adevice)
 			rfkill_set_hw_state(priv->rfk[i], hw_blocked);
 }
=20
-static int ideapad_register_rfkill(struct acpi_device *adevice, int de=
v)
+static int __devinit ideapad_register_rfkill(struct acpi_device *adevi=
ce,
+					     int dev)
 {
 	struct ideapad_private *priv =3D dev_get_drvdata(&adevice->dev);
 	int ret;
@@ -271,7 +277,8 @@ static int ideapad_register_rfkill(struct acpi_devi=
ce *adevice, int dev)
 	return 0;
 }
=20
-static void ideapad_unregister_rfkill(struct acpi_device *adevice, int=
 dev)
+static void __devexit ideapad_unregister_rfkill(struct acpi_device *ad=
evice,
+						int dev)
 {
 	struct ideapad_private *priv =3D dev_get_drvdata(&adevice->dev);
=20
@@ -326,7 +333,6 @@ static void ideapad_platform_exit(void)
 			   &ideapad_attribute_group);
 	platform_device_unregister(ideapad_priv->platform_device);
 }
-/* the above is platform device */
=20
 /*
  * input device
@@ -386,15 +392,17 @@ static void ideapad_input_report(unsigned long sc=
ancode)
 {
 	sparse_keymap_report_event(ideapad_priv->inputdev, scancode, 1, true)=
;
 }
-/* the above is input device */
=20
+/*
+ * module init/exit
+ */
 static const struct acpi_device_id ideapad_device_ids[] =3D {
 	{ "VPC2004", 0},
 	{ "", 0},
 };
 MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
=20
-static int ideapad_acpi_add(struct acpi_device *adevice)
+static int __devinit ideapad_acpi_add(struct acpi_device *adevice)
 {
 	int ret, i, cfg;
 	struct ideapad_private *priv;
@@ -432,7 +440,7 @@ platform_failed:
 	return ret;
 }
=20
-static int ideapad_acpi_remove(struct acpi_device *adevice, int type)
+static int __devexit ideapad_acpi_remove(struct acpi_device *adevice, =
int type)
 {
 	struct ideapad_private *priv =3D dev_get_drvdata(&adevice->dev);
 	int i;
@@ -478,19 +486,14 @@ static struct acpi_driver ideapad_acpi_driver =3D=
 {
 	.owner =3D THIS_MODULE,
 };
=20
-
 static int __init ideapad_acpi_module_init(void)
 {
-	acpi_bus_register_driver(&ideapad_acpi_driver);
-
-	return 0;
+	return acpi_bus_register_driver(&ideapad_acpi_driver);
 }
=20
-
 static void __exit ideapad_acpi_module_exit(void)
 {
 	acpi_bus_unregister_driver(&ideapad_acpi_driver);
-
 }
=20
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
--=20
1.7.1
