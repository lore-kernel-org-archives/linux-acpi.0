From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 1/2] acpi choose sleep state help
Date: Tue, 19 Jun 2007 10:33:14 +0800
Message-ID: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48886 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760484AbXFSChs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2007 22:37:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, dbrownell@users.sourceforge.net

Based on David's patch
http://marc.info/?l=linux-acpi&m=117873972806360&w=2
I slightly changed it.

Add a helper routine, which gets the sleep state of a ACPI device.

Index: 2.6.22-rc2/drivers/acpi/sleep/main.c
===================================================================
--- 2.6.22-rc2.orig/drivers/acpi/sleep/main.c	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/drivers/acpi/sleep/main.c	2007-06-19 09:19:09.000000000 +0800
@@ -34,6 +34,8 @@ static u32 acpi_suspend_states[] = {
 
 static int init_8259A_after_S1;
 
+static int acpi_target_sleep_state = ACPI_STATE_S0;
+
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
  *	@pm_state:		suspend state we're entering.
@@ -54,6 +56,7 @@ static int acpi_pm_prepare(suspend_state
 		printk("acpi_pm_prepare does not support %d \n", pm_state);
 		return -EPERM;
 	}
+	acpi_target_sleep_state = acpi_state;
 	return acpi_sleep_prepare(acpi_state);
 }
 
@@ -140,6 +143,7 @@ static int acpi_pm_finish(suspend_state_
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
+	acpi_target_sleep_state = ACPI_STATE_S0;
 	return 0;
 }
 
@@ -184,6 +188,7 @@ static struct pm_ops acpi_pm_ops = {
 #ifdef CONFIG_SOFTWARE_SUSPEND
 static int acpi_hibernation_prepare(void)
 {
+	acpi_target_sleep_state = ACPI_STATE_S4;
 	return acpi_sleep_prepare(ACPI_STATE_S4);
 }
 
@@ -215,6 +220,7 @@ static void acpi_hibernation_finish(void
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
+	acpi_target_sleep_state = ACPI_STATE_S0;
 }
 
 static struct hibernation_ops acpi_hibernation_ops = {
@@ -224,6 +230,49 @@ static struct hibernation_ops acpi_hiber
 };
 #endif				/* CONFIG_SOFTWARE_SUSPEND */
 
+int acpi_pm_choose_sleep_state(acpi_handle handle, pm_message_t state)
+{
+	char sxd[] = "_SxD";
+	unsigned long d_min, d_max;
+	struct acpi_device *dev;
+
+	/*
+	 * If the sleep state is S0, we will return D3, but if the device has
+	 * _S0W, we will use the value from _S0W
+	 */
+	d_min = ACPI_STATE_D3;
+	d_max = ACPI_STATE_D3;
+
+	/* If present, _SxD methods give the minimum D-state we may use
+	 * for each S-state ... with lowest latency state switching.
+	 *
+	 * We rely on acpi_evaluate_integer() not clobbering the integer
+	 * provided -- that's our fault recovery, we ignore retval.
+	 */
+	sxd[2] = '0' + acpi_target_sleep_state;
+	if (acpi_target_sleep_state > ACPI_STATE_S0)
+		acpi_evaluate_integer(handle, sxd, NULL, &d_min);
+
+	/*
+	 * If _PRW says we can wake from the upcoming system state, the _SxD
+	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
+	 * methods exist (ACPI 3.x), they give the lowest power D-state that
+	 * can also wake the system.  _S0W can be valid.
+	 */
+	if (acpi_bus_get_device(handle, &dev)) {
+		printk(KERN_ERR"ACPI handle hasn't context\n");
+		return d_max;
+	}
+	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
+	    (dev->wakeup.state.enabled &&
+	     dev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+		sxd[3] = 'W';
+		acpi_evaluate_integer(handle, sxd, NULL, &d_max);
+	}
+	/* choose a state within d_min to d_max, we just choose the max */
+	return d_max;
+}
+
 /*
  * Toshiba fails to preserve interrupts over S1, reinitialization
  * of 8259 is needed after S1 resume.
Index: 2.6.22-rc2/include/acpi/acpi_bus.h
===================================================================
--- 2.6.22-rc2.orig/include/acpi/acpi_bus.h	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/include/acpi/acpi_bus.h	2007-06-19 09:23:54.000000000 +0800
@@ -364,6 +364,8 @@ acpi_handle acpi_get_child(acpi_handle, 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
+int acpi_pm_choose_sleep_state(acpi_handle handle, pm_message_t state);
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
