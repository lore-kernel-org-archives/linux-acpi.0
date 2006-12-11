From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Mon, 11 Dec 2006 12:05:08 -0800
Message-ID: <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
References: <20061204224037.713257809@localhost.localdomain>
	<20061204144958.207e58e2.kristen.c.accardi@intel.com>
	<20061209115957.GA5254@homac2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763037AbWLKUF1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Dec 2006 15:05:27 -0500
In-Reply-To: <20061209115957.GA5254@homac2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>

On Sat, 9 Dec 2006 12:59:58 +0100
Holger Macht <hmacht@suse.de> wrote:

> Well, I like to have them ;-)

Ok - how is this?

Send a uevent to indicate a device change whenever we dock or
undock, so that userspace may now check the dock status via 
sysfs.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -326,10 +326,12 @@ static void hotplug_dock_devices(struct 
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
+	struct device *dev = &dock_device.dev;
 	/*
-	 * we don't do events until someone tells me that
-	 * they would like to have them.
+	 * Indicate that the status of the dock station has
+	 * changed.
 	 */
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 /**
