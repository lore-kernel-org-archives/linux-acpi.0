From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 5/9] ACPI: Introduce new device wakeup flag 'prepared'
Date: Fri, 20 Jun 2008 01:50:19 +0200
Message-ID: <200806200150.19620.rjw@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52508 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbYFSX6D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2008 19:58:03 -0400
In-Reply-To: <200806200145.33053.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Introduce new device wakeup flag 'prepared'

Introduce additional flag 'prepared' in
struct acpi_device_wakeup_flags and use it to prevent devices from
being enable/disabled do wake up the system multiple times in a row
(this does not happen currently, but will be possible after some of
the following patches).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c    |   24 ++++++++++++++++++++++--
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

Index: linux-next/drivers/acpi/power.c
===================================================================
--- linux-next.orig/drivers/acpi/power.c
+++ linux-next/drivers/acpi/power.c
@@ -363,11 +363,18 @@ int acpi_device_sleep_wake(struct acpi_d
  */
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
 {
-	int i;
+	int i, err;
 
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
+	/*
+	 * Do not execute the code below twice in a row without calling
+	 * acpi_disable_wakeup_device_power() in between for the same device
+	 */
+	if (dev->wakeup.flags.prepared)
+		return 0;
+
 	/* Open power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
 		int ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
@@ -382,7 +389,11 @@ int acpi_enable_wakeup_device_power(stru
 	 * Passing 3 as the third argument below means the device may be placed
 	 * in arbitrary power state afterwards.
 	 */
-	return acpi_device_sleep_wake(dev, 1, sleep_state, 3);
+	err = acpi_device_sleep_wake(dev, 1, sleep_state, 3);
+	if (!err)
+		dev->wakeup.flags.prepared = 1;
+
+	return err;
 }
 
 /*
@@ -398,6 +409,15 @@ int acpi_disable_wakeup_device_power(str
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
+	/*
+	 * Do not execute the code below twice in a row without calling
+	 * acpi_enable_wakeup_device_power() in between for the same device
+	 */
+	if (!dev->wakeup.flags.prepared)
+		return 0;
+
+	dev->wakeup.flags.prepared = 0;
+
 	ret = acpi_device_sleep_wake(dev, 0, 0, 0);
 	if (ret)
 		return ret;
Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -259,6 +259,7 @@ struct acpi_device_perf {
 /* Wakeup Management */
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
+	u8 prepared:1;		/* Has the wake-up capability been enabled? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
 };
 

