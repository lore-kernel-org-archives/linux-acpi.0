From: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/16] ACPI: Add acpi_pm_device_sleep_state helper routine
Date: Wed, 25 Jul 2007 01:51:11 -0400
Message-ID: <1185342687164-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30960 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbXGYFv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:29 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <fd4aff1a28eecbd729b409bf7d3eff5948f20414.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

Based on the David Brownell's patch at
http://marc.info/?l=linux-acpi&m=117873972806360&w=2
updated by: Rafael J. Wysocki <rjw@sisk.pl>

Add a helper routine returning the lowest power (highest number) ACPI device
power state that given device can be in while the system is in the sleep state
indicated by acpi_target_sleep_state .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   75 +++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h   |    2 +
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 19f8557..55eca6e 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -260,6 +260,81 @@ static struct hibernation_ops acpi_hibernation_ops = {
 };
 #endif				/* CONFIG_SOFTWARE_SUSPEND */
 
+/**
+ *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
+ *		in the system sleep state given by %acpi_target_sleep_state
+ *	@dev: device to examine
+ *	@wake: if set, the device should be able to wake up the system
+ *	@d_min_p: used to store the upper limit of allowed states range
+ *	Return value: preferred power state of the device on success, -ENODEV on
+ *		failure (ie. if there's no 'struct acpi_device' for @dev)
+ *
+ *	Find the lowest power (highest number) ACPI device power state that
+ *	device @dev can be in while the system is in the sleep state represented
+ *	by %acpi_target_sleep_state.  If @wake is nonzero, the device should be
+ *	able to wake up the system from this sleep state.  If @d_min_p is set,
+ *	the highest power (lowest number) device power state of @dev allowed
+ *	in this system sleep state is stored at the location pointed to by it.
+ *
+ *	The caller must ensure that @dev is valid before using this function.
+ *	The caller is also responsible for figuring out if the device is
+ *	supposed to be able to wake up the system and passing this information
+ *	via @wake.
+ */
+
+int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	struct acpi_device *adev;
+	char acpi_method[] = "_SxD";
+	unsigned long d_min, d_max;
+
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+		printk(KERN_ERR "ACPI handle has no context!\n");
+		return -ENODEV;
+	}
+
+	acpi_method[2] = '0' + acpi_target_sleep_state;
+	/*
+	 * If the sleep state is S0, we will return D3, but if the device has
+	 * _S0W, we will use the value from _S0W
+	 */
+	d_min = ACPI_STATE_D0;
+	d_max = ACPI_STATE_D3;
+
+	/*
+	 * If present, _SxD methods return the minimum D-state (highest power
+	 * state) we can use for the corresponding S-states.  Otherwise, the
+	 * minimum D-state is D0 (ACPI 3.x).
+	 *
+	 * NOTE: We rely on acpi_evaluate_integer() not clobbering the integer
+	 * provided -- that's our fault recovery, we ignore retval.
+	 */
+	if (acpi_target_sleep_state > ACPI_STATE_S0)
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
+
+	/*
+	 * If _PRW says we can wake up the system from the target sleep state,
+	 * the D-state returned by _SxD is sufficient for that (we assume a
+	 * wakeup-aware driver if wake is set).  Still, if _SxW exists
+	 * (ACPI 3.x), it should return the maximum (lowest power) D-state that
+	 * can wake the system.  _S0W may be valid, too.
+	 */
+	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
+	    (wake && adev->wakeup.state.enabled &&
+	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+		acpi_method[3] = 'W';
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
+		/* Sanity check */
+		if (d_max < d_min)
+			d_min = d_max;
+	}
+
+	if (d_min_p)
+		*d_min_p = d_min;
+	return d_max;
+}
+
 /*
  * Toshiba fails to preserve interrupts over S1, reinitialization
  * of 8259 is needed after S1 resume.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c6fa5e0..529d035 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -364,6 +364,8 @@ acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
+int acpi_pm_device_sleep_state(struct device *, int, int *);
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
1.5.3.rc2.22.g69a9b
