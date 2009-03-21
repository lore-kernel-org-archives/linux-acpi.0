From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 12:22:35 +0100
Message-ID: <200903211222.36642.matze@welwarsky.de>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320004043.GF19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_83MxJePfsNpssvL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:26600
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZCULWo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 07:22:44 -0400
In-Reply-To: <20090320011837.GA23183@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, sony-vaio-z-series@lists.launchpad.net, malattia@linux.it, linux-acpi@vger.kernel.org

--Boundary-00=_83MxJePfsNpssvL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 20 March 2009 02:18:37 Norbert Preining wrote:
> Ok, here is the code.
>
> For those interested I Cc the  sony-vaio-z-series@lists.launchpad.net
> group where I first found that modules.
>
> You need:
> 	kernel 2.6.29-rc8	(maybe it works with all from .28 on)
> 	the patch Matthew sent
> 	the attached patch
>
> Together you get full rfkill support for bluetooth/wwan/wifi, plus afais
> stamina-speed mode setting.
>
> Maybe Matthias the creator of the sony-laptop for vaio-zseries modules
> can take a look at the patch and see if I missed something.

I checked the code and I think you didn't miss anything. Looks good.

> Matthias: sony_led_off and sony_dgpu_sta is never used, is that
> intentional? And also the #define SONY_WMMX_GUID I couldn't find being
> used anywhere.

You can safely get rid of this, its the GUID of the only valid (but broken)=
=20
WMMX function in the DSDT code. It was a dead end.

> Maybe Matthew can take a look and fix the compile warnings in function
> =E2=80=98sony_ovga_dsm=E2=80=99 (there are some!).

Check the attached patch, it does away with the compile warnings. I've remo=
ved=20
the warnings in functional code and put ifdefs (ugh!) around debug only cod=
e.=20
You can just remove it if you don't like it, I'm only keeping it around for=
=20
reference.

I've also backported Matthews patch to the standard Suse 11.1 kernel so tha=
t=20
we can test it more easily.


--Boundary-00=_83MxJePfsNpssvL
Content-Type: text/x-patch;
  charset="UTF-8";
  name="sony-laptop-zseries-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sony-laptop-zseries-cleanup.patch"

--- sony-laptop.c.orig	2009-03-21 12:11:31.000000000 +0100
+++ sony-laptop.c	2009-03-21 12:17:32.000000000 +0100
@@ -85,8 +85,6 @@
 #define SONY_PIC_HID		"SNY6001"
 #define SONY_PIC_DRIVER_NAME	"Sony Programmable IO Control Driver"
 
-#define SONY_WMMX_GUID "F6CB5C3C-9CAE-4EBD-B577-931EA32A2CC0"
-
 MODULE_AUTHOR("Stelian Pop, Mattia Dongili");
 MODULE_DESCRIPTION("Sony laptop extras driver (SPIC and SNC ACPI device)");
 MODULE_LICENSE("GPL");
@@ -485,8 +483,8 @@
 /*********** Platform Device ***********/
 static int sony_ovga_dsm(int func, int arg)
 {
-	static const char *path = "\\_SB.PCI0.OVGA._DSM";
-	static const char muid[] = {
+	static char *path = "\\_SB.PCI0.OVGA._DSM";
+	static char muid[] = {
 		/*00*/	0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,		/* MUID */
 		/*08*/	0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4,
 	};
@@ -494,7 +492,6 @@
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
 	union acpi_object params[4];
-	union acpi_object *obj;
 	int result;
 
 	input.count = 4;
@@ -515,25 +512,30 @@
 		return -1;
 	}
 
-	obj = (union acpi_object*)output.pointer;
-	printk("result type %d\n", obj->type);
-	if (obj->type == ACPI_TYPE_PACKAGE) {
-		int i;
-		printk("returned package sized %d\n", obj->package.count);
-		for (i = 0; i < obj->package.count; i++)
-			printk("%d %08x\n", i, obj->package.elements[i].integer.value);
-	} else
-	if (obj->type == ACPI_TYPE_INTEGER) {
-		printk("returned integer %08X\n", obj->integer.value);
-	} else
-	if (obj->type == ACPI_TYPE_BUFFER) {
-		int i;
-		printk("returned buffer sized %d\n", obj->buffer.length);
-		for (i = 0; i < obj->buffer.length; i++)
-			printk("%d %02x\n", i, obj->buffer.pointer[i]);
+#ifdef DEBUG
+	{
+		union acpi_object *obj;
+		obj = (union acpi_object*)output.pointer;
+		printk("result type %d\n", obj->type);
+		if (obj->type == ACPI_TYPE_PACKAGE) {
+			int i;
+			printk("returned package sized %d\n", obj->package.count);
+			for (i = 0; i < obj->package.count; i++)
+				printk("%d %08x\n", i, obj->package.elements[i].integer.value);
+		} else
+		if (obj->type == ACPI_TYPE_INTEGER) {
+			printk("returned integer %08X\n", obj->integer.value);
+		} else
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			int i;
+			printk("returned buffer sized %d\n", obj->buffer.length);
+			for (i = 0; i < obj->buffer.length; i++)
+				printk("%d %02x\n", i, obj->buffer.pointer[i]);
+		}
 	}
-	kfree(output.pointer);
+#endif
 
+	kfree(output.pointer);
 	return 0;
 }
 
@@ -547,6 +549,7 @@
 	return sony_ovga_dsm(2, 0x12);
 }
 
+#ifdef DEBUG
 static int sony_led_off(void)
 {
 	return sony_ovga_dsm(2, 0x13);
@@ -556,6 +559,7 @@
 {
 	return sony_ovga_dsm(3, 0x00);
 }
+#endif
 
 static int sony_dgpu_off(void)
 {

--Boundary-00=_83MxJePfsNpssvL--
