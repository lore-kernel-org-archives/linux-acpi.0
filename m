From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: trackpoint dead after S3 suspend
Date: Sun, 16 Nov 2003 23:53:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031116225331.GA206@elf.ucw.cz>
References: <3FB3B9D0.5020408@netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FB3B9D0.5020408-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Suspend is becoming downright usable on my Thinkpad R32 under 
> 2.6.0-test9, but I still have a showstopper:
> 
> http://bugme.osdl.org/show_bug.cgi?id=1279
> 
> describes the mouse being dead after resume.  Reloading the psmouse 
> modules doesn't work for me either, but I don't get the same error 
> message for some reason.
> 
> Looks to me that this bug was improperly filed under "other" instead of 
> ACPI.

Its actually input problem. This might help, (untested!).
								Pavel

--- clean/drivers/input/serio/i8042.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2003-11-16 23:39:32.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
 
 #include <asm/io.h>
 
@@ -398,18 +399,15 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
 
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
@@ -783,6 +781,38 @@
 	values->mux = index;
 }
 
+static int i8042_resume_port(struct serio *port)
+{
+	struct serio_dev *dev = port->dev;
+	if (dev) {
+#if 0
+		dev->disconnect(port);
+		dev->connect(port, dev);
+#endif
+		serio_close(port);
+		serio_open(port, dev);
+	}	
+}
+
+static int i8042_resume(struct sys_device *dev)
+{
+	if (i8042_controller_init())
+		printk(KERN_ERR "i8042: resume failed\n");
+	i8042_resume_port(&i8042_aux_port);
+	i8042_resume_port(&i8042_kbd_port);
+	return 0;
+}
+
+static struct sysdev_class kbc_sysclass = {
+	set_kset_name("i8042"),
+	.resume = i8042_resume,
+};
+
+static struct sys_device device_i8042 = {
+	.id	= 0,
+	.cls	= &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -819,6 +849,14 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	{
+		int error = sysdev_class_register(&kbc_sysclass);
+		if (!error)
+			error = sys_device_register(&device_i8042);
+		if (error)
+			printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+	}
+
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
