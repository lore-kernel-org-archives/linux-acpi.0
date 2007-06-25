From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 3/8] ACPI: Add acpi_pm_device_sleep_state helper routine
Date: Tue, 26 Jun 2007 00:45:49 +0200
Message-ID: <200706260045.51039.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41923 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXFYWrl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2007 18:47:41 -0400
In-Reply-To: <200706260039.17530.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

From: Shaohua Li <shaohua.li@intel.com>, Rafael J. Wysocki <rjw@sisk.pl>

Based on the David Brownell's patch at
http://marc.info/?l=linux-acpi&m=117873972806360&w=2

Add a helper routine returning the lowest power (highest number) ACPI device
power state that given device can be in while the system is in the sleep state
indicated by acpi_target_sleep_state .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h   |    2 +
 2 files changed, 57 insertions(+)

Index: linux-2.6.22-rc6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/main.c	2007-06-25 21:34:46.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/main.c	2007-06-25 21:58:30.000000000 +0200
@@ -262,6 +262,61 @@ static struct hibernation_ops acpi_hiber
 };
 #endif				/* CONFIG_SOFTWARE_SUSPEND */
 
+/**
+ *	acpi_pm_device_sleep_state - return the lowest power (highest number)
+ *				     ACPI device power state given device can be
+ *				     in while the system is in the sleep state
+ *				     indicated by %acpi_target_sleep_state
+ *	@handle: Represents the device the state is evaluated for
+ */
+
+int acpi_pm_device_sleep_state(acpi_handle handle)
+{
+	char acpi_method[] = "_SxD";
+	unsigned long d_min, d_max;
+	struct acpi_device *dev;
+
+	if (acpi_bus_get_device(handle, &dev)) {
+		printk(KERN_ERR "ACPI handle has no context!\n");
+		return ACPI_STATE_D3;
+	}
+	acpi_method[2] = '0' + acpi_target_sleep_state;
+	/*
+	 * If the sleep state is S0, we will return D3, but if the device has
+	 * _S0W, we will use the value from _S0W
+	 */
+	d_min = ACPI_STATE_D3;
+	d_max = ACPI_STATE_D3;
+
+	/*
+	 * If present, _SxD methods give the minimum D-state we may use
+	 * for each S-state ... with lowest latency state switching.
+	 *
+	 * We rely on acpi_evaluate_integer() not clobbering the integer
+	 * provided -- that's our fault recovery, we ignore retval.
+	 */
+	if (acpi_target_sleep_state > ACPI_STATE_S0)
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
+
+	/*
+	 * If _PRW says we can wake from the upcoming system state, the _SxD
+	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
+	 * methods exist (ACPI 3.x), they give the lowest power D-state that
+	 * can also wake the system.  _S0W can be valid.
+	 */
+	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
+	    (dev->wakeup.state.enabled &&
+	     dev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+		acpi_method[3] = 'W';
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
+	}
+	/*
+	 * Choose a state within d_min to d_max, we just choose the max
+	 * (ie. lower power)
+	 */
+	return d_max > d_min ? d_max : d_min;
+}
+
 /*
  * Toshiba fails to preserve interrupts over S1, reinitialization
  * of 8259 is needed after S1 resume.
Index: linux-2.6.22-rc6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.22-rc6.orig/include/acpi/acpi_bus.h	2007-06-25 21:34:04.000000000 +0200
+++ linux-2.6.22-rc6/include/acpi/acpi_bus.h	2007-06-25 21:53:19.000000000 +0200
@@ -364,6 +364,8 @@ acpi_handle acpi_get_child(acpi_handle, 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
+int acpi_pm_device_sleep_state(acpi_handle handle);
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
