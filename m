From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4/6] driver core: Don't leak secondary fwnode on device
 removal
Date: Thu, 28 Jul 2016 02:25:41 +0200
Message-ID: <ef34b0d31d1fb9bc6a48a07d265fd103527b3f30.1469616641.git.lukas__23328.6058683463$1469665616$gmane$org@wunner.de>
References: <cover.1469616641.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:53639 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162467AbcG1A0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2016 20:26:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 269CF101A7205
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:44 +0200 (CEST)
Received: from localhost (4-38-90-81.adsl.cmo.de [81.90.38.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 3C8F56098323
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:43 +0200 (CEST)
In-Reply-To: <cover.1469616641.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-efi@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, Pierre Moreau <pierre.morrow@free.fr>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org

If device_add_property_set() is called for a device, a secondary fwnode
is allocated and assigned to the device but currently not freed once the
device is removed.

This can be triggered on Apple Macs if a Thunderbolt device is plugged
in on boot since Apple's NHI EFI driver sets a number of properties for
that device which are leaked on unplug.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0a8bdad..70c5be5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1266,6 +1266,7 @@ void device_del(struct device *dev)
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
+	device_remove_properties(dev);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
-- 
2.8.1

