From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 09/11] ACPI: Make ACPI update wake-up capability flag for devices that can wake up
Date: Mon, 23 Jun 2008 19:46:11 +0200
Message-ID: <200806231946.12326.rjw@sisk.pl>
References: <200806231934.08565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41948 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761455AbYFWRum (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jun 2008 13:50:42 -0400
In-Reply-To: <200806231934.08565.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Make ACPI update wake-up capability flag for devices that can wake up

Make ACPI code set the dev->power.can_wakeup flag for devices that
are found to be wake-up capable by it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/glue.c       |    2 ++
 drivers/acpi/sleep/proc.c |    5 ++++-
 include/linux/pm_wakeup.h |    5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

Index: linux-next/include/linux/pm_wakeup.h
===================================================================
--- linux-next.orig/include/linux/pm_wakeup.h
+++ linux-next/include/linux/pm_wakeup.h
@@ -35,6 +35,11 @@ static inline void device_init_wakeup(st
 	dev->power.can_wakeup = dev->power.should_wakeup = !!val;
 }
 
+static inline void device_set_wakeup_capable(struct device *dev, int val)
+{
+	dev->power.can_wakeup = !!val;
+}
+
 static inline int device_can_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup;
Index: linux-next/drivers/acpi/glue.c
===================================================================
--- linux-next.orig/drivers/acpi/glue.c
+++ linux-next/drivers/acpi/glue.c
@@ -165,6 +165,8 @@ static int acpi_bind_one(struct device *
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
+		if (acpi_dev->wakeup.flags.valid)
+			device_set_wakeup_capable(dev, true);
 	}
 
 	return 0;

