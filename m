From: Pavel Machek <pavel@ucw.cz>
Subject: FYI: My current suspend bigdiff
Date: Mon, 24 Nov 2003 12:07:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031124110718.GB9843@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

This is how my current "bigdiff" looks... [This is not for
application, but if you want to make S3 working, it might help you].


						Pavel

%patch
Index: linux/drivers/input/serio/i8042.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/serio/i8042.c	2003-11-24 11:30:30.00000000=
0 +0100
+++ linux/drivers/input/serio/i8042.c	2003-11-22 16:56:05.000000000 +01=
00
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
=20
 #include <asm/io.h>
=20
@@ -398,18 +399,15 @@
  * desired.
  */
 =09
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
=20
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
=20
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
@@ -783,6 +781,32 @@
 	values->mux =3D index;
 }
=20
+static int i8042_resume_port(struct serio *port)
+{
+	struct serio_dev *dev =3D port->dev;
+	if (dev && dev->resume)
+		dev->resume(port);
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
+static struct sysdev_class kbc_sysclass =3D {
+	set_kset_name("i8042"),
+	.resume =3D i8042_resume,
+};
+
+static struct sys_device device_i8042 =3D {
+	.id	=3D 0,
+	.cls	=3D &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -819,6 +843,14 @@
=20
 	register_reboot_notifier(&i8042_notifier);
=20
+	{
+		int error =3D sysdev_class_register(&kbc_sysclass);
+		if (!error)
+			error =3D sys_device_register(&device_i8042);
+		if (error)
+			printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+	}
+
 	return 0;
 }
=20
Index: linux/drivers/input/keyboard/atkbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/keyboard/atkbd.c	2003-11-24 11:30:30.00000=
0000 +0100
+++ linux/drivers/input/keyboard/atkbd.c	2003-11-24 10:31:28.000000000 =
+0100
@@ -145,7 +145,7 @@
 	unsigned char set;
 	unsigned char release;
 	int lastkey;
-	volatile signed char ack;
+	atomic_t ack;
 	unsigned char emul;
 	unsigned short id;
 	unsigned char write;
@@ -214,10 +214,10 @@
=20
 	switch (code) {
 		case ATKBD_RET_ACK:
-			atkbd->ack =3D 1;
+			atomic_set(&atkbd->ack, 1);
 			goto out;
 		case ATKBD_RET_NAK:
-			atkbd->ack =3D -1;
+			atomic_set(&atkbd->ack, 2);
 			goto out;
 	}
=20
@@ -294,7 +294,7 @@
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
 	int timeout =3D 20000; /* 200 msec */
-	atkbd->ack =3D 0;
+	atomic_set(&atkbd->ack, 0);
=20
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
@@ -302,9 +302,9 @@
 	if (serio_write(atkbd->serio, byte))
 		return -1;
=20
-	while (!atkbd->ack && timeout--) udelay(10);
+	while (!atomic_read(&atkbd->ack) && timeout--) udelay(10);
=20
-	return -(atkbd->ack <=3D 0);
+	return -(atomic_read(&atkbd->ack) !=3D 1);
 }
=20
 /*
@@ -582,6 +582,37 @@
 	kfree(atkbd);
 }
=20
+int atkbd_hwinit(struct atkbd *atkbd)
+{
+	if (atkbd->write) {
+		if (atkbd_probe(atkbd)) {
+			return -EIO;
+		}
+	=09
+		atkbd->set =3D atkbd_set_3(atkbd);
+		atkbd_enable(atkbd);
+
+	} else {
+		atkbd->set =3D 2;
+		atkbd->id =3D 0xab00;
+	}
+
+	if (atkbd->set =3D=3D 4) {
+		atkbd->dev.ledbit[0] |=3D BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(=
LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
+		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
+	} else
+		sprintf(atkbd->name, "AT %s Set %d keyboard",
+			atkbd->translated ? "Translated" : "Raw", atkbd->set);
+	return 0;
+}
+
+static void atkbd_resume(struct serio *serio)
+{
+	struct atkbd *atkbd =3D serio->private;
+	if (atkbd_hwinit(atkbd))
+		printk(KERN_ERR "Ouch, keyboard no longer there after resume?\n");
+}
+
 /*
  * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
@@ -641,29 +672,11 @@
 		return;
 	}
=20
-	if (atkbd->write) {
-
-		if (atkbd_probe(atkbd)) {
-			serio_close(serio);
-			kfree(atkbd);
-			return;
-		}
-	=09
-		atkbd->set =3D atkbd_set_3(atkbd);
-		atkbd_enable(atkbd);
-
-	} else {
-		atkbd->set =3D 2;
-		atkbd->id =3D 0xab00;
+	if (atkbd_hwinit(atkbd)) {
+		serio_close(serio);
+		kfree(atkbd);
+		return;
 	}
-
-	if (atkbd->set =3D=3D 4) {
-		atkbd->dev.ledbit[0] |=3D BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(=
LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
-		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
-	} else
-		sprintf(atkbd->name, "AT %s Set %d keyboard",
-			atkbd->translated ? "Translated" : "Raw", atkbd->set);
-
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
=20
 	if (atkbd->set =3D=3D 3)
@@ -688,10 +701,11 @@
 }
=20
=20
-static struct serio_dev atkbd_dev =3D {
+struct serio_dev atkbd_dev =3D {
 	.interrupt =3D	atkbd_interrupt,
 	.connect =3D	atkbd_connect,
 	.disconnect =3D	atkbd_disconnect,
+	.resume =3D	atkbd_resume,
 	.cleanup =3D	atkbd_cleanup,
 };
=20
Index: linux/include/linux/serio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/linux/serio.h	2003-11-24 11:30:30.000000000 +010=
0
+++ linux/include/linux/serio.h	2003-11-22 16:54:24.000000000 +0100
@@ -50,6 +50,7 @@
 			unsigned int, struct pt_regs *);
 	void (*connect)(struct serio *, struct serio_dev *dev);
 	void (*disconnect)(struct serio *);
+	void (*resume)(struct serio *);
 	void (*cleanup)(struct serio *);
=20
 	struct list_head node;
Index: linux/drivers/input/power.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/power.c	2003-11-24 11:30:30.000000000 +010=
0
+++ linux/drivers/input/power.c	2003-07-23 00:18:13.000000000 +0200
@@ -72,6 +72,18 @@
 				break;
 			case KEY_POWER:
 				/* Hum power down the machine. */
+				{
+					char *argv[2] =3D {NULL, NULL};
+					char *envp[3] =3D {NULL, NULL, NULL};
+
+					argv[0] =3D "/sbin/poweroff";
+
+					/* minimal command environment */
+					envp[0] =3D "HOME=3D/";
+					envp[1] =3D "PATH=3D/sbin:/bin:/usr/sbin:/usr/bin";
+=09
+					call_usermodehelper(argv[0], argv, envp, 0);
+				}
 				break;
 			default:=09
 				return;
Index: linux/drivers/acpi/thermal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/thermal.c	2003-11-24 11:30:30.000000000 +01=
00
+++ linux/drivers/acpi/thermal.c	2003-11-24 10:45:49.000000000 +0100
@@ -467,6 +467,7 @@
 	if (result)
 		return_VALUE(result);
=20
+	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down=
=2E\n", tz->temperature);
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->tri=
ps.critical.flags.enabled);
=20
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
Index: linux/arch/i386/kernel/cpu/mtrr/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/i386/kernel/cpu/mtrr/main.c	2003-11-24 11:30:30.000=
000000 +0100
+++ linux/arch/i386/kernel/cpu/mtrr/main.c	2003-10-23 00:42:26.00000000=
0 +0200
@@ -588,6 +588,7 @@
 {
 	int i;
=20
+#if 0
 	for (i =3D 0; i < num_var_ranges; i++) {
 		if (mtrr_state[i].lsize)=20
 			set_mtrr(i,
@@ -596,6 +597,8 @@
 				 mtrr_state[i].ltype);
 	}
 	kfree(mtrr_state);
+#endif
+
 	return 0;
 }
=20
Index: linux/arch/x86_64/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/x86_64/kernel/time.c	2003-11-24 11:30:30.000000000 =
+0100
+++ linux/arch/x86_64/kernel/time.c	2003-10-09 00:19:18.000000000 +0200
@@ -22,7 +22,7 @@
 #include <linux/time.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
@@ -75,7 +75,7 @@
  * timer interrupt has happened already, but vxtime.trigger wasn't upd=
ated yet.
  * This is not a problem, because jiffies hasn't updated either. They =
are bound
  * together by xtime_lock.
-         */
+ */
=20
 static inline unsigned int do_gettimeoffset_tsc(void)
 {
@@ -626,7 +626,17 @@
 	return 0;
 }
=20
-void __init pit_init(void)
+static struct sysdev_class rtc_sysclass =3D {
+	set_kset_name("rtc"),
+};
+
+/* XXX this driverfs stuff should probably go elsewhere later -john */
+static struct sys_device device_i8253 =3D {
+	.id		=3D 0,
+	.cls	=3D &rtc_sysclass,
+};
+
+int __init pit_init(void)
 {
 	unsigned long flags;
=20
@@ -635,6 +645,11 @@
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
+
+	int error =3D sysdev_class_register(&rtc_sysclass);
+	if (!error)
+		error =3D sys_device_register(&device_i8253);
+	return error;
 }
=20
 int __init time_setup(char *str)
@@ -678,8 +693,8 @@
 		cpu_khz =3D hpet_calibrate_tsc();
 		timename =3D "HPET";
 	} else {
-	pit_init();
-	cpu_khz =3D pit_calibrate_tsc();
+		pit_init();
+		cpu_khz =3D pit_calibrate_tsc();
 		timename =3D "PIT";
 	}
=20
Index: linux/include/linux/suspend.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/linux/suspend.h	2003-11-24 11:30:30.000000000 +0=
100
+++ linux/include/linux/suspend.h	2003-10-18 23:06:22.000000000 +0200
@@ -45,31 +45,43 @@
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
=20
+/* kernel/power/swsusp.c */
+extern int software_suspend(void);
+
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
-#endif /* CONFIG_PM */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-extern unsigned char software_suspend_enabled;
=20
-extern void software_suspend(void);
 #else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline void software_suspend(void)
+static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
+	return -EPERM;
 }
+#define software_resume()		do { } while(0)
 #endif	/* CONFIG_SOFTWARE_SUSPEND */
=20
=20
 #ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
=20
 #else
 static inline void refrigerator(unsigned long flag)
 {
=20
 }
+static inline int freeze_processes(void)
+{
+	return 0;
+}
+static inline void thaw_processes(void)
+{
+
+}
 #endif	/* CONFIG_PM */
=20
 #endif /* _LINUX_SWSUSP_H */
Index: linux/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/power/swsusp.c	2003-11-24 11:30:30.000000000 +010=
0
+++ linux/kernel/power/swsusp.c	2003-10-23 00:59:17.000000000 +0200
@@ -73,9 +73,8 @@
=20
 extern void do_magic(int resume);
=20
-#define NORESUME		1
-#define RESUME_SPECIFIED	2
-
+#define NORESUME               1
+#define RESUME_SPECIFIED       2
=20
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
@@ -227,6 +226,7 @@
 static void read_swapfiles(void) /* This is called before saving image=
 */
 {
 	int i, len;
+	char buff[sizeof(resume_file)], *sname;
 =09
 	len=3Dstrlen(resume_file);
 	root_swap =3D 0xFFFF;
@@ -245,8 +245,11 @@
 					swapfile_used[i] =3D SWAPFILE_IGNORED;				 =20
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device =3D=3D swap_info[i].swap_device) {
+				sname =3D d_path(swap_info[i].swap_file->f_dentry,
+					       swap_info[i].swap_file->f_vfsmnt,
+					       buff,
+					       sizeof(buff));
+				if (!strcmp(sname, resume_file)) {
 					swapfile_used[i] =3D SWAPFILE_SUSPEND;
 					root_swap =3D i;
 				} else {
@@ -283,8 +286,8 @@
  *    would happen on next reboot -- corrupting data.
  *
  *    Note: The buffer we allocate to use to write the suspend header =
is
- *    not freed; its not needed since system is going down anyway
- *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
+ *    not freed; its not needed since the system is going down anyway
+ *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
  */
 static int write_suspend_image(void)
 {
@@ -488,33 +491,6 @@
 	printk("|\n");
 }
=20
-/* Make disk drivers accept operations, again */
-static void drivers_unsuspend(void)
-{
-	device_resume();
-}
-
-/* Called from process context */
-static int drivers_suspend(void)
-{
-	return device_suspend(4);
-}
-
-#define RESUME_PHASE1 1 /* Called from interrupts disabled */
-#define RESUME_PHASE2 2 /* Called with interrupts enabled */
-#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
-static void drivers_resume(int flags)
-{
-	if (flags & RESUME_PHASE1) {
-		device_resume();
-	}
-  	if (flags & RESUME_PHASE2) {
-#ifdef SUSPEND_CONSOLE
-		update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
-	}
-}
-
 static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
@@ -569,7 +545,7 @@
=20
 static void suspend_save_image(void)
 {
-	drivers_unsuspend();
+	device_resume();
=20
 	lock_swapdevices();
 	write_suspend_image();
@@ -615,6 +591,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts *=
/=20
=20
+	device_power_down(4);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt ou=
r memory, right?
 			   Do it with disabled interrupts for best effect. That way, if som=
e
@@ -630,8 +607,10 @@
=20
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	drivers_resume(RESUME_ALL_PHASES);
+	device_resume();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
=20
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -672,7 +651,9 @@
 {
 	int is_problem;
 	read_swapfiles();
+	device_power_down(4);
 	is_problem =3D suspend_prepare_image();
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	if (!is_problem) {
 		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, a=
nd we need to revert it in order to pass in_atomic() checks */
@@ -694,11 +675,22 @@
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 }
=20
-static void do_software_suspend(void)
+/*
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
+ */
+int software_suspend(void)
 {
+	int res;
+	if (!software_suspend_enabled)
+		return -EAGAIN;
+
+	software_suspend_enabled =3D 0;
+	might_sleep();
+
 	if (arch_prepare_suspend()) {
 		printk("%sArchitecture failed to prepare\n", name_suspend);
-		return;
+		return -EPERM;
 	}	=09
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
@@ -716,7 +708,7 @@
 		blk_run_queues();
=20
 		/* Save state of all device drivers, and stop them. */		  =20
-		if(drivers_suspend()=3D=3D0)
+		if ((res =3D device_suspend(4))=3D=3D0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -728,24 +720,12 @@
 			 */
 			do_magic(0);
 		thaw_processes();
-	}
+	} else
+		res =3D -EBUSY;
 	software_suspend_enabled =3D 1;
 	MDELAY(1000);
 	pm_restore_console();
-}
-
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-void software_suspend(void)
-{
-	if(!software_suspend_enabled)
-		return;
-
-	software_suspend_enabled =3D 0;
-	might_sleep();
-	do_software_suspend();
+	return res;
 }
=20
 /* More restore stuff */
@@ -915,7 +895,7 @@
=20
 extern dev_t __init name_to_dev_t(const char *line);
=20
-static int __read_suspend_image(struct block_device *bdev, union diskp=
age *cur, int noresume)
+static int __init __read_suspend_image(struct block_device *bdev, unio=
n diskpage *cur, int noresume)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
@@ -1091,6 +1071,7 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
=20
Index: linux/kernel/sys.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/sys.c	2003-11-24 11:30:30.000000000 +0100
+++ linux/kernel/sys.c	2003-10-26 13:09:00.000000000 +0100
@@ -472,13 +472,11 @@
=20
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		if (!software_suspend_enabled) {
+		{
+			int ret =3D software_suspend();
 			unlock_kernel();
-			return -EAGAIN;
+			return ret;
 		}
-		software_suspend();
-		do_exit(0);
-		break;
 #endif
=20
 	default:
Index: linux/Documentation/power/swsusp.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/Documentation/power/swsusp.txt	2003-11-24 11:30:30.00000=
0000 +0100
+++ linux/Documentation/power/swsusp.txt	2003-10-26 12:49:22.000000000 =
+0100
@@ -17,13 +17,30 @@
 You need to append resume=3D/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
=20
-[Notice. Rest docs is pretty outdated (see date!) It should be safe to
-use swsusp on ext3/reiserfs these days.]
+Pavel's unreliable guide to swsusp mess
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=20
+
+There are currently two versions of swap suspend in the kernel, the ol=
d
+"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
+version in kernel/power/pmdisk.c. They provide the same functionality;
+the old version looks ugly but was tested, while the new version looks
+nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
+calls the old version, echo disk > /sys/power/state calls the new one.
+
+[In the future, when the new version is stable enough, two things can
+happen:
+
+* the new version is moved into swsusp.c, and swsusp is renamed to swa=
p
+  suspend (Pavel prefers this)
+
+* pmdisk is kept as is and swsusp.c is removed from the kernel]
+
=20
=20
 Article about goals and implementation of Software Suspend for Linux
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Author: G=82=E1bor Kuti
-Last revised: 2002-04-08
+Last revised: 2003-10-20 by Pavel Machek
=20
 Idea and goals to achieve
=20
@@ -36,84 +53,23 @@
 interrupt our programs so processes that are calculating something for=
 a long
 time shouldn't need to be written interruptible.
=20
-On desk machines the power saving function isn't as important as it is=
 in
-laptops but we really may benefit from the second one. Nowadays the nu=
mber of
-desk machines supporting suspend function in their APM is going up but=
 there
-are (and there will still be for a long time) machines that don't even=
 support
-APM of any kind. On the other hand it is reported that using APM's sus=
pend
-some irqs (e.g. ATA disk irq) is lost and it is annoying for the user =
until
-the Linux kernel resets the device.
-
-So I started thinking about implementing Software Suspend which doesn'=
t need
-any APM support and - since it uses pretty near only high-level routin=
es - is
-supposed to be architecture independent code.
-
 Using the code
=20
-The code is experimental right now - testers, extra eyes are welcome. =
To
-compile this support into the kernel, you need CONFIG_EXPERIMENTAL,=20
-and then CONFIG_SOFTWARE_SUSPEND in menu General Setup to be  enabled.=
 It
-cannot be used as a module and I don't think it will ever be needed.
-
-You have two ways to use this code. The first one is if you've compile=
d in
-sysrq support then you may press Sysrq-D to request suspend. The other=
 way
-is with a patched SysVinit (my patch is against 2.76 and available at =
my
-home page). You might call 'swsusp' or 'shutdown -z <time>'. Next way =
is to
-echo 4 > /proc/acpi/sleep.
+You have two ways to use this code. The first one is is with a patched
+SysVinit (my patch is against 2.76 and available at my home page). You
+might call 'swsusp' or 'shutdown -z <time>'. Next way is to echo 4 >
+/proc/acpi/sleep.
=20
 Either way it saves the state of the machine into active swaps and the=
n
 reboots.  You must explicitly specify the swap partition to resume fro=
m with
 ``resume=3D'' kernel option. If signature is found it loads and restor=
es saved
 state. If the option ``noresume'' is specified as a boot parameter, it=
 skips
-the resuming.  Warning! Look at section ``Things to implement'' to see=
 what
-isn't yet implemented.  Also I strongly suggest you to list all active=
 swaps
-in /etc/fstab. Firstly because you don't have to specify anything to r=
esume
-and secondly if you have more than one swap area you can't decide whic=
h one
-has the 'root' signature.=20
+the resuming.
=20
 In the meantime while the system is suspended you should not touch any=
 of the
 hardware!
=20
 About the code
-Goals reached
-
-The code can be downloaded from
-http://falcon.sch.bme.hu/~seasons/linux/. It mainly works but there ar=
e still
-some of XXXs, TODOs, FIXMEs in the code which seem not to be too impor=
tant. It
-should work all right except for the problems listed in ``Things to
-implement''. Notes about the code are really welcome.
-
-How the code works
-
-When suspending is triggered it immediately wakes up process bdflush. =
Bdflush
-checks whether we have anything in our run queue tq_bdflush. Since we =
queued up
-function do_software_suspend, it is called. Here we shrink everything =
including
-dcache, inodes, buffers and memory (here mainly processes are swapped =
out). We
-count how many pages we need to duplicate (we have to be atomical!) th=
en we
-create an appropriate sized page directory. It will point to the origi=
nal and
-the new (copied) address of the page. We get the free pages by
-__get_free_pages() but since it changes state we have to be able to tr=
ack it
-later so it also flips in a bit in page's flags (a new Nosave flag). W=
e
-duplicate pages and then mark them as used (so atomicity is ensured). =
After
-this we write out the image to swaps, do another sync and the machine =
may
-reboot. We also save registers to stack.
-
-By resuming an ``inverse'' method is executed. The image if exists is =
loaded,
-loadling is either triggered by ``resume=3D'' kernel option.  We
-change our task to bdflush (it is needed because if we don't do this i=
nit does
-an oops when it is waken up later) and then pages are copied back to t=
heir
-original location. We restore registers, free previously allocated mem=
ory,
-activate memory context and task information. Here we should restore h=
ardware
-state but even without this the machine is restored and processes are =
continued
-to work. I think hardware state should be restored by some list (using
-notify_chain) and probably by some userland program (run-parts?) for u=
sers'
-pleasure. Check out my patch at the same location for the sysvinit pat=
ch.
-
-WARNINGS!
-- It does not like pcmcia cards. And this is logical: pcmcia cards nee=
d
-  cardmgr to be initialized. they are not initialized during singleuse=
r boot,
-  but "resumed" kernel does expect them to be initialized. That leads =
to
-  armagedon. You should eject any pcmcia cards before suspending.
=20
 Things to implement
 - SMP support. I've done an SMP support but since I don't have access =
to a kind
@@ -122,34 +78,14 @@
   interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since =
any
   process data won't be changed.
-- Hardware state restoring.  Now there's support for notifying via the=
 notify
-  chain, event handlers are welcome. Some devices may have microcodes =
loaded
-  into them. We should have event handlers for them as well.
-- We should support other architectures (There are really only some ar=
ch
-  related functions..)
-- We should also restore original state of swaps if the ``noresume'' k=
ernel
-  option is specified.. Or do we need such a feature to save state for=
 some
-  other time? Do we need some kind of ``several saved states''?  (Linu=
x-HA
-  people?). There's been some discussion about checkpointing on linux-=
future.
 - Should make more sanity checks. Or are these enough?
=20
 Not so important ideas for implementing
=20
 - If a real time process is running then don't suspend the machine.
-- Support for power.conf file as in Solaris, autoshutdown, special
-  devicetypes support, maybe in sysctl.
-- Introduce timeout for SMP locking. But first locking ought to work :=
O
-- Pre-detect if we don't have enough swap space or free it instead of
-  calling panic.
 - Support for adding/removing hardware while suspended?
 - We should not free pages at the beginning so aggressively, most of t=
hem
   go there anyway..
-- If X is active while suspending then by resuming calling svgatextmod=
e
-  corrupts the virtual console of X.. (Maybe this has been fixed AFAIK=
).
-
-Drivers we support
-- IDE disks are okay
-- vesafb
=20
 Drivers that need support
 - pc_keyb -- perhaps we can wait for vojtech's input patches
Index: linux/Documentation/power/video.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/Documentation/power/video.txt	2003-11-24 11:30:30.000000=
000 +0100
+++ linux/Documentation/power/video.txt	2003-10-26 12:49:28.000000000 +=
0100
@@ -0,0 +1,36 @@
+
+		Video issues with S3 resume
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		     2003, Pavel Machek
+
+During S3 resume, hardware needs to be reinitialized. For most
+devices, this is easy, and kernel driver knows how to do
+it. Unfortunately there's one exception: video card. Those are usually
+initialized by BIOS, and kernel does not have enough information to
+boot video card. (Kernel usually does not even contain video card
+driver -- vesafb and vgacon are widely used).
+
+This is not problem for swsusp, because during swsusp resume, BIOS is
+run normally so video card is normally initialized.
+
+There are three types of systems where video works after S3 resume:
+
+* systems where video state is preserved over S3. (HP Omnibook xe3)
+
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=3Ds3_mode on these. (Toshiba 4030cdt)
+
+* systems where it is possible to call video bios during S3
+  resume. Unfortunately, it is not correct to call video BIOS at that
+  point, but it happens to work on some machines. Use
+  acpi_sleep=3Ds3_bios (Athlon64 desktop system)
+
+Now, if you pass acpi_sleep=3Dsomething, and it does not work with you=
r
+bios, you'll get hard crash during resume. Be carefull.
+
+You may have system where none of above works. At that point you
+either invent another ugly hack that works, or write proper driver for
+your video card (good luck getting docs :-(). Maybe suspending from X
+(proper X, knowing your hardware, not XF68_FBcon) might have better
+chance of working.
Index: linux/arch/i386/kernel/acpi/wakeup.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/i386/kernel/acpi/wakeup.S	2003-11-24 11:30:30.00000=
0000 +0100
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-10-26 12:49:44.000000000 =
+0100
@@ -193,11 +193,6 @@
 	# and restore the stack ... but you need gdt for this to work
 	movl	saved_context_esp, %esp
=20
-	movw	$0x0e00 + 'W', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + 'O', 0xb8018
-
 	movl	%cs:saved_magic, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_magic
@@ -205,9 +200,6 @@
 	# jump to place where we left off
 	movl	saved_eip,%eax
 	movw	$0x0e00 + 'x', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + '!', 0xb801a
 	jmp	*%eax
=20
 bogus_magic:
Index: linux/arch/i386/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/i386/kernel/time.c	2003-11-24 11:30:30.000000000 +0=
100
+++ linux/arch/i386/kernel/time.c	2003-10-26 13:08:50.000000000 +0100
@@ -280,16 +280,37 @@
 	unsigned long retval;
=20
 	spin_lock(&rtc_lock);
-
 	retval =3D mach_get_cmos_time();
-
 	spin_unlock(&rtc_lock);
=20
 	return retval;
 }
=20
+static long clock_cmos_diff;
+
+static int pit_suspend(struct sys_device *dev, u32 state)
+{
+	/*
+	 * Estimate time zone so that set_time can update the clock
+	 */
+	clock_cmos_diff =3D -get_cmos_time();
+	clock_cmos_diff +=3D get_seconds();
+	return 0;
+}
+
+static int pit_resume(struct sys_device *dev)
+{
+	write_seqlock_irq(&xtime_lock);
+	xtime.tv_sec =3D get_cmos_time() + clock_cmos_diff;
+	xtime.tv_nsec =3D 0;=20
+	write_sequnlock_irq(&xtime_lock);
+	return 0;
+}
+
 static struct sysdev_class pit_sysclass =3D {
 	set_kset_name("pit"),
+	.resume =3D pit_resume,
+	.suspend =3D pit_suspend,
 };
=20
 /* XXX this driverfs stuff should probably go elsewhere later -john */
Index: linux/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/power/process.c	2003-11-24 11:30:30.000000000 +01=
00
+++ linux/kernel/power/process.c	2003-10-26 12:50:56.000000000 +0100
@@ -49,10 +49,11 @@
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=3D");
 	current->flags &=3D ~PF_FREEZE;
-	if (flag)
-		flush_signals(current); /* We have signaled a kernel thread, which i=
sn't normal behaviour
-					   and that may lead to 100%CPU sucking because those threads
-					   just don't manage signals. */
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
 	current->flags |=3D PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();
Index: linux/drivers/input/keyboard/98kbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/keyboard/98kbd.c	2003-11-24 11:30:30.00000=
0000 +0100
+++ linux/drivers/input/keyboard/98kbd.c	2003-11-24 11:29:07.000000000 =
+0100
@@ -100,7 +100,7 @@
 	char phys[32];
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
-	signed char ack;
+	atomic_t ack;
 	unsigned char shift;
 	struct {
 		unsigned char scancode;
@@ -118,10 +118,10 @@
=20
 	switch (data) {
 		case KBD98_RET_ACK:
-			kbd98->ack =3D 1;
+			atomic_set(&kbd98->ack, 1);
 			return;
 		case KBD98_RET_NAK:
-			kbd98->ack =3D -1;
+			atomic_set(&kbd98->ack, 2);
 			return;
 	}
=20
@@ -220,14 +220,14 @@
 static int kbd98_sendbyte(struct kbd98 *kbd98, unsigned char byte)
 {
 	int timeout =3D 10000; /* 100 msec */
-	kbd98->ack =3D 0;
+	atomic_set(&kbd98->ack, 0);
=20
 	if (serio_write(kbd98->serio, byte))
 		return -1;
=20
-	while (!kbd98->ack && timeout--) udelay(10);
+	while (!atomic_read(&kbd98->ack) && timeout--) udelay(10);
=20
-	return -(kbd98->ack <=3D 0);
+	return -(atomic_read(&kbd98->ack) !=3D 1);
 }
=20
 /*
Index: linux/drivers/input/mouse/psmouse-base.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/mouse/psmouse-base.c	2003-11-24 11:30:30.0=
00000000 +0100
+++ linux/drivers/input/mouse/psmouse-base.c	2003-11-24 11:29:30.000000=
000 +0100
@@ -39,8 +39,8 @@
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
=20
 static int psmouse_noext;
-int psmouse_resolution;
-unsigned int psmouse_rate =3D 60;
+static int psmouse_resolution;
+static unsigned int psmouse_rate =3D 60;
 int psmouse_smartscroll =3D PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
=20
@@ -121,13 +121,14 @@
 	if (psmouse->acking) {
 		switch (data) {
 			case PSMOUSE_RET_ACK:
-				psmouse->ack =3D 1;
+				atomic_set(&psmouse->ack, 1);
 				break;
 			case PSMOUSE_RET_NAK:
-				psmouse->ack =3D -1;
+				atomic_set(&psmouse->ack, 2);
 				break;
 			default:
-				psmouse->ack =3D 1;	/* Workaround for mice which don't ACK the Get=
 ID command */
+				/* Workaround for mice which don't ACK the Get ID command */
+				atomic_set(&psmouse->ack, 1);
 				if (psmouse->cmdcnt)
 					psmouse->cmdbuf[--psmouse->cmdcnt] =3D data;
 				break;
@@ -197,7 +198,7 @@
 static int psmouse_sendbyte(struct psmouse *psmouse, unsigned char byt=
e)
 {
 	int timeout =3D 10000; /* 100 msec */
-	psmouse->ack =3D 0;
+	atomic_set(&psmouse->ack, 0);
 	psmouse->acking =3D 1;
=20
 	if (serio_write(psmouse->serio, byte)) {
@@ -205,9 +206,9 @@
 		return -1;
 	}
=20
-	while (!psmouse->ack && timeout--) udelay(10);
+	while (!atomic_read(&psmouse->ack) && timeout--) udelay(10);
=20
-	return -(psmouse->ack <=3D 0);
+	return -(atomic_read(&psmouse->ack) !=3D 1);
 }
=20
 /*
@@ -439,8 +440,7 @@
 		param[0] =3D 2;
 	else if (psmouse_resolution >=3D 50)
 		param[0] =3D 1;
-	else if (psmouse_resolution)
-		param[0] =3D 0;
+	else	param[0] =3D 0;
=20
         psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
 }
@@ -532,20 +532,11 @@
 static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t reques=
t, void *data)
 {
 	struct psmouse *psmouse =3D dev->data;
-	struct serio_dev *ser_dev =3D psmouse->serio->dev;
-
-	synaptics_disconnect(psmouse);
-
-	/* We need to reopen the serio port to reinitialize the i8042 control=
ler */
-	serio_close(psmouse->serio);
-	serio_open(psmouse->serio, ser_dev);
-
-	/* Probe and re-initialize the mouse */
-	psmouse_probe(psmouse);
-	psmouse_initialize(psmouse);
-	synaptics_pt_init(psmouse);
-	psmouse_activate(psmouse);
=20
+	if (request =3D=3D PM_RESUME) {
+		psmouse->state =3D PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->serio);
+	}
 	return 0;
 }
=20
Index: linux/drivers/input/mouse/psmouse.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/mouse/psmouse.h	2003-11-24 11:30:30.000000=
000 +0100
+++ linux/drivers/input/mouse/psmouse.h	2003-11-24 11:29:43.000000000 +=
0100
@@ -37,7 +37,7 @@
 	unsigned long last;
 	unsigned char state;
 	char acking;
-	volatile char ack;
+	atomic_t ack;	/* This is being accessed without locking, at least mak=
e sure we do not run into alignment problems */
 	char error;
 	char devname[64];
 	char phys[32];
Index: linux/drivers/input/serio/serio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/input/serio/serio.c	2003-11-24 11:30:30.00000000=
0 +0100
+++ linux/drivers/input/serio/serio.c	2003-11-24 11:30:06.000000000 +01=
00
@@ -83,6 +83,7 @@
 }
=20
 #define SERIO_RESCAN	1
+#define SERIO_RECONNECT	2
=20
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -111,6 +112,38 @@
 	}
 }
=20
+static void serio_invalidate_pending_events(struct serio *serio)
+{
+	struct serio_event *event;
+
+	list_for_each_entry(event, &serio_event_list, node)
+		if (event->serio =3D=3D serio)
+			event->serio =3D NULL;
+}
+
+static void serio_queue_event(struct serio *serio, int event_type)
+{
+	struct serio_event *event;
+
+	if ((event =3D kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		event->type =3D event_type;
+		event->serio =3D serio;
+
+		list_add_tail(&event->node, &serio_event_list);
+		wake_up(&serio_wait);
+	}
+}
+
+void serio_rescan(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RESCAN);
+}
+
+void serio_reconnect(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RECONNECT);
+}
+
 static int serio_thread(void *nothing)
 {
 	lock_kernel();
@@ -130,20 +163,6 @@
 	complete_and_exit(&serio_exited, 0);
 }
=20
-void serio_rescan(struct serio *serio)
-{
-	struct serio_event *event;
-
-	if (!(event =3D kmalloc(sizeof(struct serio_event), GFP_ATOMIC)))
-		return;
-
-	event->type =3D SERIO_RESCAN;
-	event->serio =3D serio;
-
-	list_add_tail(&event->node, &serio_event_list);
-	wake_up(&serio_wait);
-}
-
 irqreturn_t serio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {

%diffstat
 Documentation/power/swsusp.txt     |  104 ++++++---------------------
 Documentation/power/video.txt      |   36 +++++++++
 arch/i386/kernel/acpi/wakeup.S     |    8 --
 arch/i386/kernel/cpu/mtrr/main.c   |    3=20
 arch/i386/kernel/suspend_asm.S     |   94 ------------------------
 arch/i386/kernel/time.c            |   25 ++++++
 arch/x86_64/kernel/time.c          |   25 +++++-
 drivers/acpi/thermal.c             |    1=20
 drivers/base/power.c               |  140 ----------------------------=
---------
 drivers/input/keyboard/98kbd.c     |   12 +--
 drivers/input/keyboard/atkbd.c     |   72 +++++++++++--------
 drivers/input/mouse/psmouse-base.c |   37 +++------
 drivers/input/mouse/psmouse.h      |    2=20
 drivers/input/power.c              |   12 +++
 drivers/input/serio/i8042.c        |   40 +++++++++-
 drivers/input/serio/serio.c        |   47 ++++++++----
 include/linux/serio.h              |    1=20
 include/linux/suspend.h            |   26 +++++-
 kernel/power/process.c             |    9 +-
 kernel/power/swsusp.c              |   91 +++++++++---------------
 kernel/sys.c                       |    8 --
 21 files changed, 317 insertions(+), 476 deletions(-)


--=20
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
