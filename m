From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH - 2.6.19 -1/2] Let serio bus handle suspending/resuming of
	i8042 ports
Date: Wed, 21 Feb 2007 18:08:13 +0100
Message-ID: <1172077693.10619.103.camel@d36.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47665 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422703AbXBURIP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 12:08:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stable <Stable@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@mail.ru>, linux-acpi <linux-acpi@vger.kernel.org>

i8042 - let serio bus suspend ports

Let serio subsystem take care of suspending the ports; concentrate
on suspending/resuming the controller itself.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---

 drivers/input/serio/i8042.c |   56 +++++++++++++++++-----------------
 drivers/input/serio/serio.c |   72 ++++++++++++++++++++++++++++++++------------
 include/linux/serio.h       |    6 ---
 3 files changed, 82 insertions(+), 52 deletions(-)

Index: linux-2.6.19/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.19.orig/drivers/input/serio/i8042.c
+++ linux-2.6.19/drivers/input/serio/i8042.c
@@ -732,7 +732,7 @@ static int i8042_controller_init(void)
 	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
 		if (i8042_unlock)
 			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
-		 else
+		else
 			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
 	}
 	spin_unlock_irqrestore(&i8042_lock, flags);
@@ -799,27 +799,6 @@ static void i8042_controller_reset(void)
 
 
 /*
- * Here we try to reset everything back to a state in which the BIOS will be
- * able to talk to the hardware when rebooting.
- */
-
-static void i8042_controller_cleanup(void)
-{
-	int i;
-
-/*
- * Reset anything that is connected to the ports.
- */
-
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio)
-			serio_cleanup(i8042_ports[i].serio);
-
-	i8042_controller_reset();
-}
-
-
-/*
  * i8042_panic_blink() will flash the keyboard LEDs and is called when
  * kernel panics. Flashing LEDs is useful for users running X who may
  * not see the console and will help distingushing panics from "real"
@@ -864,13 +843,22 @@ static long i8042_panic_blink(long count
 
 #undef DELAY
 
+#ifdef CONFIG_PM
 /*
- * Here we try to restore the original BIOS settings
+ * Here we try to restore the original BIOS settings. We only want to
+ * do that once, when we really suspend, not when we taking memory
+ * snapshot for swsusp (in this case we'll perform required cleanup
+ * as part of shutdown process).
  */
 
 static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
-	i8042_controller_cleanup();
+	if (dev->dev.power.power_state.event != state.event) {
+		if (state.event == PM_EVENT_SUSPEND)
+			i8042_controller_reset();
+
+		dev->dev.power.power_state = state;
+	}
 
 	return 0;
 }
@@ -884,6 +872,12 @@ static int i8042_resume(struct platform_
 {
 	int error;
 
+/*
+ * Do not bother with restoring state if we haven't suspened yet
+ */
+	if (dev->dev.power.power_state.event == PM_EVENT_ON)
+		return 0;
+
 	error = i8042_controller_check();
 	if (error)
 		return error;
@@ -893,9 +887,12 @@ static int i8042_resume(struct platform_
 		return error;
 
 /*
- * Restore pre-resume CTR value and disable all ports
+ * Restore original CTR value and disable all ports
  */
 
+	i8042_ctr = i8042_initial_ctr;
+	if (i8042_direct)
+		i8042_ctr &= ~I8042_CTR_XLATE;
 	i8042_ctr |= I8042_CTR_AUXDIS | I8042_CTR_KBDDIS;
 	i8042_ctr &= ~(I8042_CTR_AUXINT | I8042_CTR_KBDINT);
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
@@ -916,8 +913,11 @@ static int i8042_resume(struct platform_
 
 	i8042_interrupt(0, NULL);
 
+	dev->dev.power.power_state = PMSG_ON;
+
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 /*
  * We need to reset the 8042 back to original mode on system shutdown,
@@ -926,7 +926,7 @@ static int i8042_resume(struct platform_
 
 static void i8042_shutdown(struct platform_device *dev)
 {
-	i8042_controller_cleanup();
+	i8042_controller_reset();
 }
 
 static int __devinit i8042_create_kbd_port(void)
@@ -1161,9 +1161,11 @@ static struct platform_driver i8042_driv
 	},
 	.probe		= i8042_probe,
 	.remove		= __devexit_p(i8042_remove),
+	.shutdown	= i8042_shutdown,
+#ifdef CONFIG_PM
 	.suspend	= i8042_suspend,
 	.resume		= i8042_resume,
-	.shutdown	= i8042_shutdown,
+#endif
 };
 
 static int __init i8042_init(void)
Index: linux-2.6.19/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.19.orig/drivers/input/serio/serio.c
+++ linux-2.6.19/drivers/input/serio/serio.c
@@ -784,10 +784,60 @@ static int serio_driver_remove(struct de
 	return 0;
 }
 
+static void serio_cleanup(struct serio *serio)
+{
+	if (serio->drv && serio->drv->cleanup)
+		serio->drv->cleanup(serio);
+}
+
+static void serio_shutdown(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	serio_cleanup(serio);
+}
+
+#ifdef CONFIG_PM
+static int serio_suspend(struct device *dev, pm_message_t state)
+{
+	if (dev->power.power_state.event != state.event) {
+		if (state.event == PM_EVENT_SUSPEND)
+			serio_cleanup(to_serio_port(dev));
+
+		dev->power.power_state = state;
+	}
+
+	return 0;
+}
+
+static int serio_resume(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	if (dev->power.power_state.event != PM_EVENT_ON &&
+	    serio_reconnect_driver(serio)) {
+		/*
+		 * Driver re-probing can take a while, so better let kseriod
+		 * deal with it.
+		 */
+		serio_rescan(serio);
+	}
+
+	dev->power.power_state = PMSG_ON;
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct bus_type serio_bus = {
-	.name =	"serio",
-	.probe = serio_driver_probe,
-	.remove = serio_driver_remove,
+	.name		=	"serio",
+	.probe		= serio_driver_probe,
+	.remove		= serio_driver_remove,
+	.shutdown	= serio_shutdown,
+#ifdef CONFIG_PM
+	.suspend	= serio_suspend,
+ 	.resume		= serio_resume,
+#endif
 };
 
 static void serio_add_driver(struct serio_driver *drv)
@@ -890,21 +940,6 @@ static int serio_uevent(struct device *d
 
 #endif /* CONFIG_HOTPLUG */
 
-static int serio_resume(struct device *dev)
-{
-	struct serio *serio = to_serio_port(dev);
-
-	if (serio_reconnect_driver(serio)) {
-		/*
-		 * Driver re-probing can take a while, so better let kseriod
-		 * deal with it.
-		 */
-		serio_rescan(serio);
-	}
-
-	return 0;
-}
-
 /* called from serio_driver->connect/disconnect methods under serio_mutex */
 int serio_open(struct serio *serio, struct serio_driver *drv)
 {
@@ -954,7 +989,6 @@ static int __init serio_init(void)
 	serio_bus.drv_attrs = serio_driver_attrs;
 	serio_bus.match = serio_bus_match;
 	serio_bus.uevent = serio_uevent;
-	serio_bus.resume = serio_resume;
 	error = bus_register(&serio_bus);
 	if (error) {
 		printk(KERN_ERR "serio: failed to register serio bus, error: %d\n", error);
Index: linux-2.6.19/include/linux/serio.h
===================================================================
--- linux-2.6.19.orig/include/linux/serio.h
+++ linux-2.6.19/include/linux/serio.h
@@ -113,12 +113,6 @@ static inline void serio_drv_write_wakeu
 		serio->drv->write_wakeup(serio);
 }
 
-static inline void serio_cleanup(struct serio *serio)
-{
-	if (serio->drv && serio->drv->cleanup)
-		serio->drv->cleanup(serio);
-}
-
 /*
  * Use the following functions to manipulate serio's per-port
  * driver-specific data.


