From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 2/7] acpi_pm_device_sleep_state() cleanup
Date: Thu, 20 Mar 2008 14:10:57 -0700
Message-ID: <200803201410.57801.david-b@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:39647 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757013AbYCTVan (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Mar 2008 17:30:43 -0400
In-Reply-To: <200803201408.33466.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The
only legitimate value of that parameter must be derived from the first
parameter, which is what all the callers already do.  (However, this
does not address the fact that ACPI still doesn't set up those flags.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/acpi/sleep/main.c  |    8 ++++----
 drivers/pci/pci-acpi.c     |    3 +--
 drivers/pnp/pnpacpi/core.c |    4 +---
 include/acpi/acpi_bus.h    |    4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

--- g26.orig/drivers/acpi/sleep/main.c	2008-02-24 02:07:56.000000000 -0800
+++ g26/drivers/acpi/sleep/main.c	2008-02-24 02:07:57.000000000 -0800
@@ -412,8 +412,8 @@ int acpi_suspend(u32 acpi_state)
 /**
  *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
  *		in the system sleep state given by %acpi_target_sleep_state
- *	@dev: device to examine
- *	@wake: if set, the device should be able to wake up the system
+ *	@dev: device to examine; its driver model wakeup flags control
+ *		whether it should be able to wake up the system
  *	@d_min_p: used to store the upper limit of allowed states range
  *	Return value: preferred power state of the device on success, -ENODEV on
  *		failure (ie. if there's no 'struct acpi_device' for @dev)
@@ -431,7 +431,7 @@ int acpi_suspend(u32 acpi_state)
  *	via @wake.
  */
 
-int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
+int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
 	struct acpi_device *adev;
@@ -470,7 +470,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (wake && adev->wakeup.state.enabled &&
+	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
 		acpi_status status;
 
--- g26.orig/drivers/pci/pci-acpi.c	2008-02-24 02:07:56.000000000 -0800
+++ g26/drivers/pci/pci-acpi.c	2008-02-24 02:07:57.000000000 -0800
@@ -249,8 +249,7 @@ static pci_power_t acpi_pci_choose_state
 {
 	int acpi_state;
 
-	acpi_state = acpi_pm_device_sleep_state(&pdev->dev,
-		device_may_wakeup(&pdev->dev), NULL);
+	acpi_state = acpi_pm_device_sleep_state(&pdev->dev, NULL);
 	if (acpi_state < 0)
 		return PCI_POWER_ERROR;
 
--- g26.orig/drivers/pnp/pnpacpi/core.c	2008-02-24 02:07:56.000000000 -0800
+++ g26/drivers/pnp/pnpacpi/core.c	2008-02-24 02:07:57.000000000 -0800
@@ -132,9 +132,7 @@ static int pnpacpi_suspend(struct pnp_de
 {
 	int power_state;
 
-	power_state = acpi_pm_device_sleep_state(&dev->dev,
-						device_may_wakeup(&dev->dev),
-						NULL);
+	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
 	if (power_state < 0)
 		power_state = (state.event == PM_EVENT_ON) ?
 				ACPI_STATE_D0 : ACPI_STATE_D3;
--- g26.orig/include/acpi/acpi_bus.h	2008-02-24 02:07:56.000000000 -0800
+++ g26/include/acpi/acpi_bus.h	2008-02-24 02:07:57.000000000 -0800
@@ -376,9 +376,9 @@ acpi_handle acpi_get_pci_rootbridge_hand
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
 #ifdef CONFIG_PM_SLEEP
-int acpi_pm_device_sleep_state(struct device *, int, int *);
+int acpi_pm_device_sleep_state(struct device *, int *);
 #else /* !CONFIG_PM_SLEEP */
-static inline int acpi_pm_device_sleep_state(struct device *d, int w, int *p)
+static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
 	if (p)
 		*p = ACPI_STATE_D0;
