From: Danny Kukawka <dkukawka@suse.de>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 20:18:30 +0200
Message-ID: <200704112018.31026.dkukawka@suse.de>
References: <22473653910004885@karneval.cz> <200704111505.03625.corentincj@iksaif.net> <461CE6AA.6050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38581 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbXDKST7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2007 14:19:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, corentincj@iksaif.net, sziwan@users.sourceforge.net

Jiri Slaby wrote:
> Corentin CHARY napsal(a):
>> Le Wednesday 11 April 2007 11:33:48 Jiri Slaby, vous avez =C3=A9crit=
 :
>>> asus_acpi, support F2JE model
>> Just use the new asus-laptop driver =3D)
>> (see acpi4asus-0.40)
>=20
> code seems good, but this is not so good:
> #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,20)
> #warning "This module does not support 2.6.20 yet, wait for a new rel=
ease
> #=3D)" endif
>
> When do you plan to support latest kernels and merge it to mainline?

This patch fixes acpi4asus-0.40 for me at least with 2.6.20 on a ASUS R=
1F.

Danny

Signed-off-by: Danny Kukawka <dkukawka@suse.de>
---
 asus-laptop.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- acpi4asus-0.40/driver/asus-laptop.c	2007-02-13 17:42:51.000000000 +=
0100
+++ acpi4asus-0.40/driver/asus-laptop.c	2007-04-11 20:12:49.000000000 +=
0200
@@ -41,8 +41,8 @@
 # include <linux/autoconf.h>
 #endif
=20
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,20)
-#warning "This module does not support 2.6.20 yet, wait for a new rele=
ase =3D)"
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,21)
+#warning "This module does not support 2.6.21 yet, wait for a new rele=
ase =3D)"
 #endif
=20
 #include <linux/kernel.h>
@@ -226,8 +226,8 @@
 	static void object##_led_set(struct led_classdev *led_cdev,	\
 				     enum led_brightness value);	\
 	static int object##_led_wk;					\
-	static void object##_led_update(void *data);			\
-        DECLARE_WORK(object##_led_work, object##_led_update, NULL);	\
+	static void object##_led_update(struct work_struct *dummy);	\
+        DECLARE_WORK(object##_led_work, object##_led_update);		\
 	static struct led_classdev object##_led =3D {			\
 		.name           =3D "asus:" ledname,			\
 		.brightness_set =3D object##_led_set,			\
@@ -329,7 +329,7 @@
 		object##_led_wk =3D value;				\
 		queue_work(led_workqueue, &object##_led_work);		\
 	}								\
-	static void object##_led_update(void * data)			\
+	static void object##_led_update(struct work_struct *dummy)	\
 	{								\
 		int value =3D object##_led_wk;				\
 		write_status(object##_set_handle, value, (mask));	\
@@ -1053,8 +1053,7 @@
 	struct backlight_device *bd;
=20
 	if(brightness_set_handle && lcd_switch_handle) {
-		bd =3D backlight_device_register (ASUS_HOTK_FILE, NULL,
-						&asusbl_data);
+		bd =3D backlight_device_register (ASUS_HOTK_FILE, NULL, NULL, &asusb=
l_data);
=20
 		if (IS_ERR (bd)) {
 			printk(ASUS_ERR
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
