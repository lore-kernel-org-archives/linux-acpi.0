From: Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Subject: Re: trackpoint dead after S3 suspend
Date: Sun, 23 Nov 2003 02:13:27 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FC05E17.1010208@netspace.org>
References: <3FB3B9D0.5020408@netspace.org> <20031116225331.GA206@elf.ucw.cz> <20031119145809.GA14399@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031119145809.GA14399-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor wrote:

>Thus wrote Pavel Machek:
>  
>
>>Its actually input problem. This might help, (untested!).
>>    
>>
>
>This actually makes my keyboard *not* work after any suspend, including the
>previously-OK S1. Your last patch was better for my system, it seems.
>Best regards,
>
>  
>
I tried a very naive hack, which gets a step closer to fixing things.
I essentially copied i8042_init to the resume function.  It's terribly 
ugly, and incorrect in a myriad of ways, but the mouse is responding.  
Unfortunately it appears that the mouse is still not generating 
interrupts, so the mouse response is slow and jerky.
I fooled around quite a bit, but wasn't able to do any better than this.

Probably not very helpful, but I thought I pass this on.


===== i8042.c 1.32 vs 1.34 =====
--- 1.32/drivers/input/serio/i8042.c    Fri Sep 26 02:56:26 2003
+++ 1.34/drivers/input/serio/i8042.c    Sun Nov 23 01:33:42 2003
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
@@ -683,7 +681,7 @@
 static int __init i8042_port_register(struct i8042_values *values, 
struct serio *port)
 {
     values->exists = 1;
-
+   
     i8042_ctr &= ~values->disable;
 
     if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
@@ -783,6 +781,83 @@
     values->mux = index;
 }
 
+static int i8042_resume_port(struct serio *port)
+{
+    struct serio_dev *dev = port->dev;
+    if (dev) {
+#if 1
+        dev->disconnect(port);
+        dev->connect(port, dev);
+#endif
+        serio_close(port);
+        serio_open(port, dev);
+        serio_rescan(port);  
+    }   
+}
+
+static int i8042_resume(struct sys_device *dev)
+{
+    if (i8042_controller_init())
+        printk(KERN_ERR "i8042: resume failed\n");
+    i8042_resume_port(&i8042_aux_port);
+    i8042_resume_port(&i8042_kbd_port);
+    return 0;
+}
+
+static int i8042_resume2(struct sys_device *dev)
+{
+
+  int i;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+
+    if (i8042_platform_init())
+        return -EBUSY;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+    i8042_aux_values.irq = I8042_AUX_IRQ;
+    i8042_kbd_values.irq = I8042_KBD_IRQ;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+    if (i8042_controller_init())
+        return -ENODEV;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+    if (i8042_dumbkbd)
+        i8042_kbd_port.write = NULL;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+
+    for (i = 0; i < 4; i++)
+        i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
+
+    if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
+        for (i = 0; i < 4; i++)
+            i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
+    else
+        if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values))
+            i8042_port_register(&i8042_aux_values, &i8042_aux_port);
+
+    i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
+    init_timer(&i8042_timer);
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+    i8042_timer.function = i8042_timer_func;
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+    mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+  printk(KERN_ERR "i8042_resume2 line:%d\n",__LINE__);
+
+    i8042_resume_port(&i8042_aux_port);
+    i8042_resume_port(&i8042_kbd_port);
+
+
+    return 0;
+}
+
+static struct sysdev_class kbc_sysclass = {
+    set_kset_name("i8042"),
+    .resume = i8042_resume2,
+};
+
+static struct sys_device device_i8042 = {
+    .id    = 0,
+    .cls    = &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
     int i;
@@ -818,6 +893,14 @@
     mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
     register_reboot_notifier(&i8042_notifier);
+
+    {
+        int error = sysdev_class_register(&kbc_sysclass);
+        if (!error)
+            error = sys_device_register(&device_i8042);
+        if (error)
+            printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+    }
 
     return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
