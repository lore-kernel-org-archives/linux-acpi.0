From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PNP / ACPI: Use ACPI_COMPANION_SET() during initialization
Date: Fri, 13 Mar 2015 01:45:49 +0100
Message-ID: <1562702.j1oaNJkYhk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54011 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753364AbbCMAWD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 20:22:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

pnpacpi_add_device() calls acpi_bind_one() on an already registered
device, which is a mistake, but it can initialize the ACPI companion
field of the struct device to be registered using ACPI_COMPANION_SET()
instead, so make it do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-pm.orig/drivers/pnp/pnpacpi/core.c
+++ linux-pm/drivers/pnp/pnpacpi/core.c
@@ -248,6 +248,7 @@ static int __init pnpacpi_add_device(str
 	if (!dev)
 		return -ENOMEM;
 
+	ACPI_COMPANION_SET(&dev->dev, device);
 	dev->data = device;
 	/* .enabled means the device can decode the resources */
 	dev->active = device->status.enabled;
@@ -290,11 +291,9 @@ static int __init pnpacpi_add_device(str
 		return error;
 	}
 
-	error = acpi_bind_one(&dev->dev, device);
-
 	num++;
 
-	return error;
+	return 0;
 }
 
 static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,

