From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 2/22] Remove trailing whitespace
Date: Wed, 20 Dec 2006 09:40:10 +0100
Message-ID: <200612200940.10880.corentincj@iksaif.net>
References: <200612192218.49326.corentincj@iksaif.net> <200612200235.30393.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:43740 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964931AbWLTIkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 03:40:14 -0500
In-Reply-To: <200612200235.30393.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Yep, I use kmail ... Here is the patch without corruptions.
Also available here :=20
http://xf.iksaif.net/acpi4asus/2.6.19/0001-asus_acpi-remove-trailing-wh=
itespace.patch .

--- a/drivers/acpi/asus_acpi.c	2006-12-15 10:35:29.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-12-15 10:30:52.000000000 +0100
@@ -83,7 +83,7 @@
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
=20
-/* For each model, all features implemented,=20
+/* For each model, all features implemented,
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
 	char *name;		//name of the laptop________________A
@@ -128,7 +128,7 @@
 		L3D,		//L3400D
 		L3H,		//L3H, L2000E, L5D
 		L4R,		//L4500R
-		L5x,		//L5800C=20
+		L5x,		//L5800C
 		L8L,		//L8400L
 		M1A,		//M1300A
 		M2E,		//M2400E, L4400L
@@ -428,12 +428,12 @@
 		},
 };
=20
-/*=20
+/*
  * This function evaluates an ACPI method, given an int as parameter, =
the
  * method is searched within the scope of the handle, can be NULL. The=
 output
  * of the method is written is output, which can also be NULL
  *
- * returns 1 if write is successful, 0 else.=20
+ * returns 1 if write is successful, 0 else.
  */
 static int write_acpi_int(acpi_handle handle, const char *method, int =
val,
 			  struct acpi_buffer *output)
@@ -485,9 +485,9 @@
 	len +=3D sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
 	len +=3D sprintf(page + len, "Model reference    : %s\n",
 		       hotk->methods->name);
-	/*=20
-	 * The SFUN method probably allows the original driver to get the lis=
t=20
-	 * of features supported by a given model. For now, 0x0100 or 0x0800=20
+	/*
+	 * The SFUN method probably allows the original driver to get the lis=
t
+	 * of features supported by a given model. For now, 0x0100 or 0x0800
 	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI car=
d.
 	 * The significance of others is yet to be found.
 	 */
@@ -497,7 +497,7 @@
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
 	 * battery low and 0x04 for battery critical, its readings tend to be
-	 * more accurate than those provided by _BST.=20
+	 * more accurate than those provided by _BST.
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
 	 */
@@ -666,7 +666,7 @@
 proc_write_bluetooth(struct file *file, const char __user * buffer,
 		     unsigned long count, void *data)
 {
-	/* Note: mt_bt_switch controls both internal Bluetooth adapter's=20
+	/* Note: mt_bt_switch controls both internal Bluetooth adapter's
 	   presence and its LED */
 	return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 0=
);
 }
@@ -710,7 +710,7 @@
=20
 		input.count =3D 2;
 		input.pointer =3D mt_params;
-		/* Note: the following values are partly guessed up, but=20
+		/* Note: the following values are partly guessed up, but
 		   otherwise they seem to work */
 		mt_params[0].type =3D ACPI_TYPE_INTEGER;
 		mt_params[0].integer.value =3D 0x02;
@@ -751,7 +751,7 @@
 			    (hotk->handle, hotk->methods->mt_lcd_switch, 0x07,
 			     NULL))
 				status =3D AE_ERROR;
-			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,=20
+			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,
 			   the exact behaviour is simulated here */
 		}
 		if (ACPI_FAILURE(status))
@@ -862,7 +862,7 @@
 }
=20
 /*
- * Now, *this* one could be more user-friendly, but so far, no-one has=
=20
+ * Now, *this* one could be more user-friendly, but so far, no-one has
  * complained. The significance of bits is the same as in proc_write_d=
isp()
  */
 static int
@@ -879,9 +879,9 @@
 }
=20
 /*
- * Experimental support for display switching. As of now: 1 should act=
ivate=20
- * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combinat=
ion=20
- * (bitwise) of these will suffice. I never actually tested 3 displays=
 hooked up=20
+ * Experimental support for display switching. As of now: 1 should act=
ivate
+ * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combinat=
ion
+ * (bitwise) of these will suffice. I never actually tested 3 displays=
 hooked up
  * simultaneously, so be warned. See the acpi4asus README for more inf=
o.
  */
 static int
@@ -981,9 +981,9 @@
 			      &proc_read_bluetooth, mode, device);
 	}
=20
-	/*=20
-	 * We need both read node and write method as LCD switch is also acce=
ssible
-	 * from keyboard=20
+	/*
+	 * We need both read node and write method as LCD switch is also
+	 * accessible from keyboard
 	 */
 	if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
 		asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode,
@@ -1124,8 +1124,8 @@
 	acpi_status status;
=20
 	/*
-	 * Get DSDT headers early enough to allow for differentiating between=
=20
-	 * models, but late enough to allow acpi_bus_register_driver() to fai=
l=20
+	 * Get DSDT headers early enough to allow for differentiating between
+	 * models, but late enough to allow acpi_bus_register_driver() to fai=
l
 	 * before doing anything ACPI-specific. Should we encounter a machine=
,
 	 * which needs special handling (i.e. its hotkey device has a differe=
nt
 	 * HID), this bit will be moved. A global variable asus_info contains
@@ -1152,8 +1152,8 @@
=20
 	/*
 	 * Try to match the object returned by INIT to the specific model.
-	 * Handle every possible object (or the lack of thereof) the DSDT=20
-	 * writers might throw at us. When in trouble, we pass NULL to=20
+	 * Handle every possible object (or the lack of thereof) the DSDT
+	 * writers might throw at us. When in trouble, we pass NULL to
 	 * asus_model_match() and try something completely different.
 	 */
 	if (buffer.pointer) {
@@ -1193,7 +1193,7 @@
 	/* Sort of per-model blacklist */
 	if (strncmp(string, "L2B", 3) =3D=3D 0)
 		hotk->methods->lcd_status =3D NULL;
-	/* L2B is similar enough to L3C to use its settings, with this only=20
+	/* L2B is similar enough to L3C to use its settings, with this only
 	   exception */
 	else if (strncmp(string, "A3G", 3) =3D=3D 0)
 		hotk->methods->lcd_status =3D "\\BLFG";


Le mercredi 20 d=E9cembre 2006 08:35, Len Brown a =E9crit=A0:
> On Tuesday 19 December 2006 16:18, Corentin CHARY wrote:
> > @@ -485,9 +485,9 @@
> >         len +=3D sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION=
 "\n");
> >         len +=3D sprintf(page + len, "Model reference    : %s\n",
> >                        hotk->methods->name);
> > -       /*
> > -        * The SFUN method probably allows the original driver to g=
et the
> > list -        * of features supported by a given model. For now, 0x=
0100
> > or 0x0800 +       /*
> > +        * The SFUN method probably allows the original driver to g=
et the
> > list +        * of features supported by a given model. For now, 0x=
0100
> > or 0x0800 * bit signifies that the laptop is equipped with a Wi-Fi
> > MiniPCI card.
>
> This patch is corrupt because "card." starts a new line.
> If you are using kmail, perhaps you could check
> settings/configure kmail/composer/
> and uncheck "word wrap at column [n]"
>
> thanks,
> -Len
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
