From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Wed, 04 Aug 2004 02:23:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3smb3wy2k.fsf@reason.gnu-hamburg>
References: <410E6F9C.2040904@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <410E6F9C.2040904-p32f3XyCuykqcZcGjlUOXw@public.gmane.org> (Nathan Bryant's message of
	"Mon, 02 Aug 2004 12:45:16 -0400")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Mon, 02 Aug 2004 12:45:16 -0400
 || Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org> wrote: 

 >> I added your suggested patch to arch/i386/kernel/i8259.c and
 >> recompiled. Problem persists, no difference I could tell.

 nb> I don't know why the patch masks out the reserved
 nb> interrupts. None of the other code that sets ELCR is masking out
 nb> those bits, and it all works fine. Possibly some chipsets use
 nb> different edge/level behavior for these, and the save code is
 nb> forcing them back to edge.  Does the problem persist if you go
 nb> into arch/i386/kernel/i8259.c and change: [...]

Yup. Problem persists.

Just took a working, patched 2.6.7 and applied


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=fix-acpi-after-s3.patch

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


which is causing the problem and also


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=S3-fix.patch

--- arch/i386/kernel/i8259.c.orig	2004-08-04 01:44:05.000000000 +0200
+++ arch/i386/kernel/i8259.c	2004-08-04 01:45:43.000000000 +0200
@@ -251,14 +251,18 @@ static void restore_ELCR(char *trigger)
 static void save_ELCR(char *trigger)
 {
 	/* IRQ 0,1,2,8,13 are marked as reserved */
-	trigger[0] = inb(0x4d0) & 0xF8;
-	trigger[1] = inb(0x4d1) & 0xDE;
+	trigger[0] = inb(0x4d0);
+	trigger[1] = inb(0x4d1);
 }
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(0);
+	unsigned long flags;
+ 	init_8259A(0);
+ 
+	spin_lock_irqsave(&i8259A_lock, flags);
 	restore_ELCR(irq_trigger);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return 0;
 }
 

--=-=-=


which we hoped to be fixing the problem.

The machine goes into S3 and upon wake up shows same behaviour as
without "hopefully fixing patch": Crashes with "inu" in yellow on the
left in upper row visible. After poweroff, only "needle-pushed reset"
will bring it back to life.

So current ACPI is still showing functional regression on ASUS M2N.

Anyone other ideas? Anyone ready to solve the puzzle?

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

iD8DBQBBECyHbvivwoZXSsoRAu/dAJ9B7SFUjhV0gUm2dhEwZVg8B9rc5ACgoRcU
VH4Nu5uA7aUa30O1I6qP8as=
=dBhI
-----END PGP SIGNATURE-----
--==-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
