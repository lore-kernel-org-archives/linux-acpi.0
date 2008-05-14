From: akpm@linux-foundation.org
Subject: [patch 07/11] acpi_pm_device_sleep_state() cleanup
Date: Wed, 14 May 2008 16:09:20 -0700
Message-ID: <200805142309.m4EN9KBX025994@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40459 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbYENXKV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 19:10:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, dbrownell@users.sourceforge.net, bjorn.helgaas@hp.com, jbarnes@virtuousgeek.org, pavel@ucw.cz, trenn@suse.de

From: David Brownell <dbrownell@users.sourceforge.net>

Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The only
legitimate value of that parameter must be derived from the first parameter,
which is what all the callers already do.  (However, this does not address the
fact that ACPI *still* doesn't set up those flags.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sleep/main.c  |    8 ++++----
 drivers/pci/pci-acpi.c     |    3 +--
 drivers/pnp/pnpacpi/core.c |    4 +---
 include/acpi/acpi_bus.h    |    4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff -puN drivers/acpi/sleep/main.c~acpi_pm_device_sleep_state-cleanup drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c~acpi_pm_device_sleep_state-cleanup
+++ a/drivers/acpi/sleep/main.c
@@ -369,8 +369,8 @@ int acpi_suspend(u32 acpi_state)
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
@@ -388,7 +388,7 @@ int acpi_suspend(u32 acpi_state)
  *	via @wake.
  */
 
-int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
+int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
 	struct acpi_device *adev;
@@ -427,7 +427,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (wake && adev->wakeup.state.enabled &&
+	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
 		acpi_status status;
 
diff -puN drivers/pci/pci-acpi.c~acpi_pm_device_sleep_state-cleanup drivers/pci/pci-acpi.c
--- a/drivers/pci/pci-acpi.c~acpi_pm_device_sleep_state-cleanup
+++ a/drivers/pci/pci-acpi.c
@@ -249,8 +249,7 @@ static pci_power_t acpi_pci_choose_state
 {
 	int acpi_state;
 
-	acpi_state = acpi_pm_device_sleep_state(&pdev->dev,
-		device_may_wakeup(&pdev->dev), NULL);
+	acpi_state = acpi_pm_device_sleep_state(&pdev->dev, NULL);
 	if (acpi_state < 0)
 		return PCI_POWER_ERROR;
 
diff -puN drivers/pnp/pnpacpi/core.c~acpi_pm_device_sleep_state-cleanup drivers/pnp/pnpacpi/core.c
--- a/drivers/pnp/pnpacpi/core.c~acpi_pm_device_sleep_state-cleanup
+++ a/drivers/pnp/pnpacpi/core.c
@@ -117,9 +117,7 @@ static int pnpacpi_suspend(struct pnp_de
 {
 	int power_state;
 
-	power_state = acpi_pm_device_sleep_state(&dev->dev,
-						device_may_wakeup(&dev->dev),
-						NULL);
+	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
 	if (power_state < 0)
 		power_state = (state.event == PM_EVENT_ON) ?
 				ACPI_STATE_D0 : ACPI_STATE_D3;
diff -puN include/acpi/acpi_bus.h~acpi_pm_device_sleep_state-cleanup include/acpi/acpi_bus.h
--- a/include/acpi/acpi_bus.h~acpi_pm_device_sleep_state-cleanup
+++ a/include/acpi/acpi_bus.h
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
_
