From: "Georg C. F. Greve" <greve-BSDwwRMYa8dh2yIolo3vgti2O/JbrIOy@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 27 Jul 2004 13:14:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oem1u2gg.fsf@reason.gnu-hamburg>
References: <m3d62rzi9a.fsf@brain.gnuhh.org>
	<1090350197.4828.5.camel@tyrosine> <m3acxthizw.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3acxthizw.fsf-eMhNhoSsuh6q92djB/mqZw@public.gmane.org> (Georg C. F. Greve's message of
	"Wed, 21 Jul 2004 10:17:23 +0200")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

Hi all,

okay, I did some more checks on the problems I experienced with
acpi-20040715 on Intel Centrino 855GM notebook ASUS M2N.

Background: As of kernel 2.6.7 suspend to RAM (s3_bios) actually
worked and even with DRI/DRM and AGP compiled in and the X server
running, things are working nicely. 

When restarting from suspend to RAM, I briefly see a yellow "inu" in
the uppermost row for a second, then the screen flickers once and X11
is back.

Only disadvantage: network cards (both wired & ipw2100 wireless) are
dead after suspend to ram, I need a suspend to disk (swsusp2 version
2.0.0.100) to bring them back to life. (referred to as "fine" below)

When upgrading to acpi-20040715 I discovered that resume from suspend
to RAM was broken. Contrary to what I wrote in my previous mail, it
seems that there is the yellow "inu" in the uppermost row and then the
machine is dead. (referred to as "dead" below)

I need a forced poweroff plus "needle-pushed reset button" to bring it
back to life.


Having had some time to let the machine compile in the background, I
narrowed down the code that broke the resume from suspend to RAM on my
machine. Apparently it was the patch that is supposed to fix the
network card problems.

When starting from a patched 2.6.7 with suspend to ram and resume
working fine as described above (=base), I have applied two patches

 (a) acpi-20040715

 (b) Fix ACPI after S3 patch of David Shaohua:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix-acpi-after-s3.patch
Content-Description: http://bugme.osdl.org/attachment.cgi?id=3292&action=view

===== arch/i386/kernel/i8259.c 1.30 vs edited =====
--- 1.30/arch/i386/kernel/i8259.c	Thu Apr 22 19:15:40 2004
+++ edited/arch/i386/kernel/i8259.c	Tue Jun 29 15:35:28 2004
@@ -238,14 +238,39 @@
 	}
 }
 
+static char irq_trigger[2];
+/**
+ * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
+ */
+static void restore_ELCR(char *trigger)
+{
+	outb(trigger[0], 0x4d0);
+	outb(trigger[1], 0x4d1);
+}
+
+static void save_ELCR(char *trigger)
+{
+	/* IRQ 0,1,2,8,13 are marked as reserved */
+	trigger[0] = inb(0x4d0) & 0xF8;
+	trigger[1] = inb(0x4d1) & 0xDE;
+}
+
 static int i8259A_resume(struct sys_device *dev)
 {
 	init_8259A(0);
+	restore_ELCR(irq_trigger);
+	return 0;
+}
+
+static int i8259A_suspend(struct sys_device *dev, u32 state)
+{
+	save_ELCR(irq_trigger);
 	return 0;
 }
 
 static struct sysdev_class i8259_sysdev_class = {
 	set_kset_name("i8259"),
+	.suspend = i8259A_suspend,
 	.resume = i8259A_resume,
 };
 
===== arch/x86_64/kernel/i8259.c 1.12 vs edited =====
--- 1.12/arch/x86_64/kernel/i8259.c	Wed Apr 21 08:55:12 2004
+++ edited/arch/x86_64/kernel/i8259.c	Tue Jun 29 15:36:08 2004
@@ -318,7 +318,7 @@
 	}
 }
 
-void __init init_8259A(int auto_eoi)
+void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
@@ -360,6 +360,57 @@
 
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
+
+static char irq_trigger[2];
+/**
+ * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
+ */
+static void restore_ELCR(char *trigger)
+{
+	outb(trigger[0], 0x4d0);
+	outb(trigger[1], 0x4d1);
+}
+
+static void save_ELCR(char *trigger)
+{
+	/* IRQ 0,1,2,8,13 are marked as reserved */
+	trigger[0] = inb(0x4d0) & 0xF8;
+	trigger[1] = inb(0x4d1) & 0xDE;
+}
+
+static int i8259A_resume(struct sys_device *dev)
+{
+	init_8259A(0);
+	restore_ELCR(irq_trigger);
+	return 0;
+}
+
+static int i8259A_suspend(struct sys_device *dev, u32 state)
+{
+	save_ELCR(irq_trigger);
+	return 0;
+}
+
+static struct sysdev_class i8259_sysdev_class = {
+	set_kset_name("i8259"),
+	.suspend = i8259A_suspend,
+	.resume = i8259A_resume,
+};
+
+static struct sys_device device_i8259A = {
+	.id	= 0,
+	.cls	= &i8259_sysdev_class,
+};
+
+static int __init i8259A_init_sysfs(void)
+{
+	int error = sysdev_class_register(&i8259_sysdev_class);
+	if (!error)
+		error = sysdev_register(&device_i8259A);
+	return error;
+}
+
+device_initcall(i8259A_init_sysfs);
 
 /*
  * IRQ2 is cascade interrupt to second interrupt controller

--=-=-=

     (from http://bugme.osdl.org/show_bug.cgi?id=2643 )

in the following combinations with the following results:

 base + (a) = dead

 base + (b) = dead

 base + (a) - (b) = fine


So applying the ACPI patch and reverse-applying the (b) patch to it
actually fixes the problem, although the network cards still remain
dead.

Which narrows the problem down to patch (b) as the one breaking
suspend to ram on ASUS M2N. Hope this helps tracking things down.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBjkPbvivwoZXSsoRAmUrAJ90NNuQZoKPrX7faoiJVE/50bt4pwCeKHoo
QUPIkAuUQ1/IfdBxf+skl5Q=
=LKSk
-----END PGP SIGNATURE-----
--==-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
