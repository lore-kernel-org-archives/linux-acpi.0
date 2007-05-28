From: Richard Hughes <hughsient@gmail.com>
Subject: Switching toshiba_acpi to use INPUT
Date: Mon, 28 May 2007 17:11:46 +0100
Message-ID: <1180368706.2590.28.camel@localhost.localdomain>
References: <1179389557.2604.12.camel@localhost.localdomain>
	 <464C2D7C.30607@neggie.net>
	 <1179398361.16432.58.camel@localhost.localdomain>
	 <464CF77F.5050706@neggie.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5QqfE9GLGPWzy12mA6k1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:59416 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762994AbXE1QL4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2007 12:11:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1656841ugf
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 09:11:53 -0700 (PDT)
In-Reply-To: <464CF77F.5050706@neggie.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Belmonte <john@neggie.net>
Cc: Daniel Silverstone <dsilvers@digital-scurf.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bastien Nocera <hadess@hadess.net>, linux-acpi <linux-acpi@vger.kernel.org>


--=-5QqfE9GLGPWzy12mA6k1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-05-17 at 20:46 -0400, John Belmonte wrote:
> As for the acpi events I guess there is
> not much motivation, but as the Ubuntu patch already has the polling
> code it may still be a useful place to start.

Attached patch adds a kernel thread to do polling on Toshiba hardware. 

Toshiba hardware is a little oddball, and does not provide ACPI events
on some key presses, typically Fn hotkey buttons. The key interface is
now polled, and events now matched to a list of toshiba specific
scancodes, and are squirted to userspace using the INPUT subsystem.

This means that toshiba laptops buttons "just work" without any
userspace daemon (using uinput) such as fnfx or bodges such as using a
userspace hal addon. Doing the polling in kernel is more efficient, and
makes stuff just work out of the box. You can assign the keys using
standard X keymaps, or using tools such as gnome-keybinding-properties.

This is similar to other patches sent for the thinkpad_acpi driver, and
is part of the "Unf*ck my keyboard" initiative to make multimedia keys
just work.

This has been extensively tested on a Toshiba Satellite Pro A10.

Please review. Patch is supplied inline and attached.

Signed-off-by: Richard Hughes <richard@hughsie.com>

 toshiba_acpi.c |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 220 insertions(+), 22 deletions(-)

--- origin/toshiba_acpi.c	2007-05-18 09:56:03.000000000 +0100
+++ toshiba_acpi.c	2007-05-28 16:53:39.000000000 +0100
@@ -27,13 +27,13 @@
  *		engineering the Windows drivers
  *	Yasushi Nagato - changes for linux kernel 2.4 -> 2.5
  *	Rob Miller - TV out and hotkeys help
- *
+ *	Richard Hughes - emit INPUT events, based on a patch from Daniel Silverstone
  *
  *  TODO
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.18"
+#define TOSHIBA_ACPI_VERSION	"0.19"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -42,6 +42,9 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/freezer.h>
+#include <linux/input.h>
 
 #include <asm/uaccess.h>
 
@@ -213,9 +216,15 @@ static acpi_status hci_read1(u32 reg, u3
 
 static struct proc_dir_entry *toshiba_proc_dir /*= 0*/ ;
 static struct backlight_device *toshiba_backlight_device;
+static struct input_dev *toshiba_input;
 static int force_fan;
 static int last_key_event;
 static int key_event_valid;
+static int hotkeys_over_input = 1;
+static int hotkeys_check_per_sec = 2;
+
+module_param(hotkeys_over_input, uint, 0400);
+module_param(hotkeys_check_per_sec, uint, 0400);
 
 typedef struct _ProcItem {
 	const char *name;
@@ -443,27 +452,33 @@ static char *read_keys(char *p)
 	u32 hci_result;
 	u32 value;
 
-	if (!key_event_valid) {
-		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
-		if (hci_result == HCI_SUCCESS) {
-			key_event_valid = 1;
-			last_key_event = value;
-		} else if (hci_result == HCI_EMPTY) {
-			/* better luck next time */
-		} else if (hci_result == HCI_NOT_SUPPORTED) {
-			/* This is a workaround for an unresolved issue on
-			 * some machines where system events sporadically
-			 * become disabled. */
-			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
-			printk(MY_NOTICE "Re-enabled hotkeys\n");
-		} else {
-			printk(MY_ERR "Error reading hotkey status\n");
-			goto end;
+	if (!hotkeys_over_input) {
+		if (!key_event_valid) {
+			hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+			if (hci_result == HCI_SUCCESS) {
+				key_event_valid = 1;
+				last_key_event = value;
+			} else if (hci_result == HCI_EMPTY) {
+				/* better luck next time */
+			} else if (hci_result == HCI_NOT_SUPPORTED) {
+				/* This is a workaround for an unresolved issue on
+				 * some machines where system events sporadically
+				 * become disabled. */
+				hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+				printk(MY_NOTICE "Re-enabled hotkeys\n");
+			} else {
+				printk(MY_ERR "Error reading hotkey status\n");
+				goto end;
+			}
 		}
+	} else {
+		key_event_valid = 0;
+		last_key_event = 0;
 	}
 
 	p += sprintf(p, "hotkey_ready:            %d\n", key_event_valid);
 	p += sprintf(p, "hotkey:                  0x%04x\n", last_key_event);
+	p += sprintf(p, "hotkeys via INPUT:       %d\n", hotkeys_over_input);
 
       end:
 	return p;
@@ -534,15 +549,138 @@ static acpi_status __exit remove_device(
 }
 
 static struct backlight_ops toshiba_backlight_data = {
-        .get_brightness = get_lcd,
-        .update_status  = set_lcd_status,
+	.get_brightness = get_lcd,
+	.update_status  = set_lcd_status,
 };
 
+static struct semaphore thread_sem;
+static int thread_should_die;
+
+static void thread_deliver_button_event(u32 value)
+{
+	int keycode = KEY_UNKNOWN;
+	int key_down = 1;
+
+	if (!toshiba_input)
+		return;
+
+	/* ignore FN on its own */
+	if (value == 0x0100)
+		return;
+
+	/* translate MSB to key up */
+	if (value & 0x80) {
+		value &= ~0x80;
+		key_down = 0;
+	}
+
+	/* translate keys to keycodes */
+	if (value == 0x101)
+		keycode = KEY_MUTE;
+	else if (value == 0x13b)
+		keycode = KEY_BREAK;
+	else if (value == 0x13c)
+		keycode = KEY_SEARCH;
+	else if (value == 0x13d)
+		keycode = KEY_SLEEP;
+	else if (value == 0x13e)
+		keycode = KEY_SUSPEND;
+	else if (value == 0x140)
+		keycode = KEY_BRIGHTNESSDOWN;
+	else if (value == 0x141)
+		keycode = KEY_BRIGHTNESSUP;
+	else if (value == 0x142)
+		keycode = KEY_WLAN;
+
+	if (keycode != KEY_UNKNOWN) {
+		printk(MY_INFO "mapped hkey %i to keycode %i [%i]\n", value, keycode, key_down);
+		input_report_key(toshiba_input, keycode, key_down);
+		input_sync(toshiba_input);
+	}
+}
+
+static int toshiba_acpi_thread(void *data)
+{
+	int dropped = 0;
+	int clear_queue = 0;
+	u32 hci_result, value;
+
+	daemonize("ktoshkeyd");
+	set_user_nice(current, 4);
+	thread_should_die = 0;
+
+	up(&thread_sem);
+
+	do {
+		/* In case we get stuck; we can rmmod the module here */
+		if (thread_should_die)
+			break;
+
+		/* We don't want to get stuck here with no scheduled timeout -
+		 * older toshibas such as the A60 may load and then return junk
+		 * during the hci_read */
+		if (clear_queue++ > 16)
+			break;
+
+		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+		if (hci_result == HCI_SUCCESS) {
+			dropped++;
+		} else if (hci_result == HCI_EMPTY) {
+			/* better luck next time */
+		} else if (hci_result == HCI_NOT_SUPPORTED) {
+			/* This is a workaround for an unresolved issue on
+			 * some machines where system events sporadically
+			 * become disabled. */
+			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+			printk(MY_NOTICE "Re-enabled hotkeys\n");
+		}
+	} while (hci_result != HCI_EMPTY);
+
+	printk(MY_INFO "Dropped %d keys from the queue on startup\n", dropped);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / hotkeys_check_per_sec);
+
+		if (thread_should_die)
+			break;
+
+		if (try_to_freeze())
+			continue;
+
+		do {
+			hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+			if (hci_result == HCI_SUCCESS) {
+				/* we got a button event */
+				thread_deliver_button_event(value);
+			} else if (hci_result == HCI_EMPTY) {
+				/* better luck next time */
+			} else if (hci_result == HCI_NOT_SUPPORTED) {
+				/* This is a workaround for an
+				 * unresolved issue on some machines
+				 * where system events sporadically
+				 * become disabled. */
+				hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+				printk(MY_NOTICE "Re-enabled hotkeys\n");
+			}
+		} while (hci_result == HCI_SUCCESS);
+	}
+	set_user_nice(current, -20);	/* Become nasty so we are cleaned up
+					 * before the module exits making us oops */
+	up(&thread_sem);
+	return 0;
+}
+
 static void __exit toshiba_acpi_exit(void)
 {
 	if (toshiba_backlight_device)
 		backlight_device_unregister(toshiba_backlight_device);
 
+	if (hotkeys_over_input) {
+		thread_should_die = 1;
+		down(&thread_sem);
+	}
+
 	remove_device();
 
 	if (toshiba_proc_dir)
@@ -551,6 +689,43 @@ static void __exit toshiba_acpi_exit(voi
 	return;
 }
 
+static int __init toshiba_input_init(void)
+{
+	int error;
+
+	/* use INPUT for key events */
+	toshiba_input = input_allocate_device();
+	if (!toshiba_input) {
+		error = -ENOMEM;
+		goto err_no_mem;
+	}
+
+	/* create one 'keyboard' virtual input device for all the acpi events */
+	toshiba_input->name = "Toshiba Extra Buttons";
+	toshiba_input->phys = "toshiba/input0";
+	toshiba_input->id.bustype = BUS_HOST;
+	toshiba_input->id.product = 0x0001;
+	toshiba_input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_MUTE, toshiba_input->keybit);
+	set_bit(KEY_BREAK, toshiba_input->keybit); /* probably should be KEY_LOCK */
+	set_bit(KEY_SEARCH, toshiba_input->keybit);
+	set_bit(KEY_SUSPEND, toshiba_input->keybit);
+	set_bit(KEY_SLEEP, toshiba_input->keybit);
+	set_bit(KEY_BRIGHTNESSDOWN, toshiba_input->keybit);
+	set_bit(KEY_BRIGHTNESSUP, toshiba_input->keybit);
+	set_bit(KEY_WLAN, toshiba_input->keybit);
+
+	error = input_register_device(toshiba_input);
+	if (error)
+		goto err_free_input;
+	return 0;
+
+err_free_input:
+	input_free_device(toshiba_input);
+err_no_mem:
+	return error;
+}
+
 static int __init toshiba_acpi_init(void)
 {
 	acpi_status status = AE_OK;
@@ -590,12 +765,35 @@ static int __init toshiba_acpi_init(void
 	toshiba_backlight_device = backlight_device_register("toshiba",NULL,
 						NULL,
 						&toshiba_backlight_data);
-        if (IS_ERR(toshiba_backlight_device)) {
+	if (IS_ERR(toshiba_backlight_device)) {
 		printk(KERN_ERR "Could not register toshiba backlight device\n");
 		toshiba_backlight_device = NULL;
 		toshiba_acpi_exit();
 	}
-        toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
+	toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
+
+	/* we have to poll the device as we do not get events */
+	if (hotkeys_over_input && ACPI_SUCCESS(status)) {
+		toshiba_input_init ();
+
+		/* just abort */
+		if (!toshiba_input) {
+			printk(KERN_ERR "could not allocate input device\n");
+			toshiba_acpi_exit();
+		}
+
+		/* sanitise */
+		if (hotkeys_check_per_sec < 1)
+			hotkeys_check_per_sec = 1;
+		if (hotkeys_check_per_sec > 10)
+			hotkeys_check_per_sec = 10;
+		printk(MY_INFO "ktoshkeyd checks per second : %d\n", hotkeys_check_per_sec);
+
+		/* create the thread */
+		init_MUTEX_LOCKED(&thread_sem);
+		kernel_thread(toshiba_acpi_thread, NULL, CLONE_KERNEL);
+		down(&thread_sem);
+	}
 
 	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }


--=-5QqfE9GLGPWzy12mA6k1
Content-Disposition: attachment; filename=toshiba_acpi_input_01.patch
Content-Type: text/x-patch; name=toshiba_acpi_input_01.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- origin/toshiba_acpi.c	2007-05-18 09:56:03.000000000 +0100
+++ toshiba_acpi.c	2007-05-28 16:53:39.000000000 +0100
@@ -27,13 +27,13 @@
  *		engineering the Windows drivers
  *	Yasushi Nagato - changes for linux kernel 2.4 -> 2.5
  *	Rob Miller - TV out and hotkeys help
- *
+ *	Richard Hughes - emit INPUT events, based on a patch from Daniel Silverstone
  *
  *  TODO
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.18"
+#define TOSHIBA_ACPI_VERSION	"0.19"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -42,6 +42,9 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/freezer.h>
+#include <linux/input.h>
 
 #include <asm/uaccess.h>
 
@@ -213,9 +216,15 @@ static acpi_status hci_read1(u32 reg, u3
 
 static struct proc_dir_entry *toshiba_proc_dir /*= 0*/ ;
 static struct backlight_device *toshiba_backlight_device;
+static struct input_dev *toshiba_input;
 static int force_fan;
 static int last_key_event;
 static int key_event_valid;
+static int hotkeys_over_input = 1;
+static int hotkeys_check_per_sec = 2;
+
+module_param(hotkeys_over_input, uint, 0400);
+module_param(hotkeys_check_per_sec, uint, 0400);
 
 typedef struct _ProcItem {
 	const char *name;
@@ -443,27 +452,33 @@ static char *read_keys(char *p)
 	u32 hci_result;
 	u32 value;
 
-	if (!key_event_valid) {
-		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
-		if (hci_result == HCI_SUCCESS) {
-			key_event_valid = 1;
-			last_key_event = value;
-		} else if (hci_result == HCI_EMPTY) {
-			/* better luck next time */
-		} else if (hci_result == HCI_NOT_SUPPORTED) {
-			/* This is a workaround for an unresolved issue on
-			 * some machines where system events sporadically
-			 * become disabled. */
-			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
-			printk(MY_NOTICE "Re-enabled hotkeys\n");
-		} else {
-			printk(MY_ERR "Error reading hotkey status\n");
-			goto end;
+	if (!hotkeys_over_input) {
+		if (!key_event_valid) {
+			hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+			if (hci_result == HCI_SUCCESS) {
+				key_event_valid = 1;
+				last_key_event = value;
+			} else if (hci_result == HCI_EMPTY) {
+				/* better luck next time */
+			} else if (hci_result == HCI_NOT_SUPPORTED) {
+				/* This is a workaround for an unresolved issue on
+				 * some machines where system events sporadically
+				 * become disabled. */
+				hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+				printk(MY_NOTICE "Re-enabled hotkeys\n");
+			} else {
+				printk(MY_ERR "Error reading hotkey status\n");
+				goto end;
+			}
 		}
+	} else {
+		key_event_valid = 0;
+		last_key_event = 0;
 	}
 
 	p += sprintf(p, "hotkey_ready:            %d\n", key_event_valid);
 	p += sprintf(p, "hotkey:                  0x%04x\n", last_key_event);
+	p += sprintf(p, "hotkeys via INPUT:       %d\n", hotkeys_over_input);
 
       end:
 	return p;
@@ -534,15 +549,138 @@ static acpi_status __exit remove_device(
 }
 
 static struct backlight_ops toshiba_backlight_data = {
-        .get_brightness = get_lcd,
-        .update_status  = set_lcd_status,
+	.get_brightness = get_lcd,
+	.update_status  = set_lcd_status,
 };
 
+static struct semaphore thread_sem;
+static int thread_should_die;
+
+static void thread_deliver_button_event(u32 value)
+{
+	int keycode = KEY_UNKNOWN;
+	int key_down = 1;
+
+	if (!toshiba_input)
+		return;
+
+	/* ignore FN on its own */
+	if (value == 0x0100)
+		return;
+
+	/* translate MSB to key up */
+	if (value & 0x80) {
+		value &= ~0x80;
+		key_down = 0;
+	}
+
+	/* translate keys to keycodes */
+	if (value == 0x101)
+		keycode = KEY_MUTE;
+	else if (value == 0x13b)
+		keycode = KEY_BREAK;
+	else if (value == 0x13c)
+		keycode = KEY_SEARCH;
+	else if (value == 0x13d)
+		keycode = KEY_SLEEP;
+	else if (value == 0x13e)
+		keycode = KEY_SUSPEND;
+	else if (value == 0x140)
+		keycode = KEY_BRIGHTNESSDOWN;
+	else if (value == 0x141)
+		keycode = KEY_BRIGHTNESSUP;
+	else if (value == 0x142)
+		keycode = KEY_WLAN;
+
+	if (keycode != KEY_UNKNOWN) {
+		printk(MY_INFO "mapped hkey %i to keycode %i [%i]\n", value, keycode, key_down);
+		input_report_key(toshiba_input, keycode, key_down);
+		input_sync(toshiba_input);
+	}
+}
+
+static int toshiba_acpi_thread(void *data)
+{
+	int dropped = 0;
+	int clear_queue = 0;
+	u32 hci_result, value;
+
+	daemonize("ktoshkeyd");
+	set_user_nice(current, 4);
+	thread_should_die = 0;
+
+	up(&thread_sem);
+
+	do {
+		/* In case we get stuck; we can rmmod the module here */
+		if (thread_should_die)
+			break;
+
+		/* We don't want to get stuck here with no scheduled timeout -
+		 * older toshibas such as the A60 may load and then return junk
+		 * during the hci_read */
+		if (clear_queue++ > 16)
+			break;
+
+		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+		if (hci_result == HCI_SUCCESS) {
+			dropped++;
+		} else if (hci_result == HCI_EMPTY) {
+			/* better luck next time */
+		} else if (hci_result == HCI_NOT_SUPPORTED) {
+			/* This is a workaround for an unresolved issue on
+			 * some machines where system events sporadically
+			 * become disabled. */
+			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+			printk(MY_NOTICE "Re-enabled hotkeys\n");
+		}
+	} while (hci_result != HCI_EMPTY);
+
+	printk(MY_INFO "Dropped %d keys from the queue on startup\n", dropped);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / hotkeys_check_per_sec);
+
+		if (thread_should_die)
+			break;
+
+		if (try_to_freeze())
+			continue;
+
+		do {
+			hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+			if (hci_result == HCI_SUCCESS) {
+				/* we got a button event */
+				thread_deliver_button_event(value);
+			} else if (hci_result == HCI_EMPTY) {
+				/* better luck next time */
+			} else if (hci_result == HCI_NOT_SUPPORTED) {
+				/* This is a workaround for an
+				 * unresolved issue on some machines
+				 * where system events sporadically
+				 * become disabled. */
+				hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+				printk(MY_NOTICE "Re-enabled hotkeys\n");
+			}
+		} while (hci_result == HCI_SUCCESS);
+	}
+	set_user_nice(current, -20);	/* Become nasty so we are cleaned up
+					 * before the module exits making us oops */
+	up(&thread_sem);
+	return 0;
+}
+
 static void __exit toshiba_acpi_exit(void)
 {
 	if (toshiba_backlight_device)
 		backlight_device_unregister(toshiba_backlight_device);
 
+	if (hotkeys_over_input) {
+		thread_should_die = 1;
+		down(&thread_sem);
+	}
+
 	remove_device();
 
 	if (toshiba_proc_dir)
@@ -551,6 +689,43 @@ static void __exit toshiba_acpi_exit(voi
 	return;
 }
 
+static int __init toshiba_input_init(void)
+{
+	int error;
+
+	/* use INPUT for key events */
+	toshiba_input = input_allocate_device();
+	if (!toshiba_input) {
+		error = -ENOMEM;
+		goto err_no_mem;
+	}
+
+	/* create one 'keyboard' virtual input device for all the acpi events */
+	toshiba_input->name = "Toshiba Extra Buttons";
+	toshiba_input->phys = "toshiba/input0";
+	toshiba_input->id.bustype = BUS_HOST;
+	toshiba_input->id.product = 0x0001;
+	toshiba_input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_MUTE, toshiba_input->keybit);
+	set_bit(KEY_BREAK, toshiba_input->keybit); /* probably should be KEY_LOCK */
+	set_bit(KEY_SEARCH, toshiba_input->keybit);
+	set_bit(KEY_SUSPEND, toshiba_input->keybit);
+	set_bit(KEY_SLEEP, toshiba_input->keybit);
+	set_bit(KEY_BRIGHTNESSDOWN, toshiba_input->keybit);
+	set_bit(KEY_BRIGHTNESSUP, toshiba_input->keybit);
+	set_bit(KEY_WLAN, toshiba_input->keybit);
+
+	error = input_register_device(toshiba_input);
+	if (error)
+		goto err_free_input;
+	return 0;
+
+err_free_input:
+	input_free_device(toshiba_input);
+err_no_mem:
+	return error;
+}
+
 static int __init toshiba_acpi_init(void)
 {
 	acpi_status status = AE_OK;
@@ -590,12 +765,35 @@ static int __init toshiba_acpi_init(void
 	toshiba_backlight_device = backlight_device_register("toshiba",NULL,
 						NULL,
 						&toshiba_backlight_data);
-        if (IS_ERR(toshiba_backlight_device)) {
+	if (IS_ERR(toshiba_backlight_device)) {
 		printk(KERN_ERR "Could not register toshiba backlight device\n");
 		toshiba_backlight_device = NULL;
 		toshiba_acpi_exit();
 	}
-        toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
+	toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
+
+	/* we have to poll the device as we do not get events */
+	if (hotkeys_over_input && ACPI_SUCCESS(status)) {
+		toshiba_input_init ();
+
+		/* just abort */
+		if (!toshiba_input) {
+			printk(KERN_ERR "could not allocate input device\n");
+			toshiba_acpi_exit();
+		}
+
+		/* sanitise */
+		if (hotkeys_check_per_sec < 1)
+			hotkeys_check_per_sec = 1;
+		if (hotkeys_check_per_sec > 10)
+			hotkeys_check_per_sec = 10;
+		printk(MY_INFO "ktoshkeyd checks per second : %d\n", hotkeys_check_per_sec);
+
+		/* create the thread */
+		init_MUTEX_LOCKED(&thread_sem);
+		kernel_thread(toshiba_acpi_thread, NULL, CLONE_KERNEL);
+		down(&thread_sem);
+	}
 
 	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }

--=-5QqfE9GLGPWzy12mA6k1--

