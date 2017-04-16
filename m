From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] ACPI / scan: Avoid enumerating devices more than once
Date: Mon, 17 Apr 2017 01:20:48 +0200
Message-ID: <2231844.zRx0dlJUx2@aspire.rjw.lan>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62336 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932292AbdDPX1D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Apr 2017 19:27:03 -0400
In-Reply-To: <20731969.imAyuWkf7P@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_bus_attach() does not check the visited flag for devices that
have been enumerated already and some of them may be enumerated
for multiple times as a result, because some callers of
acpi_bus_scan() don't check the visited flag either.

For this reason, modify acpi_bus_attach() to check the visited flag
and avoid enumerating devices that have already been enumerated.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1850,6 +1850,8 @@ static void acpi_bus_attach(struct acpi_
 			device->flags.power_manageable = 0;
 
 		device->flags.initialized = true;
+	} else if (device->flags.visited) {
+		goto ok;
 	}
 
 	ret = acpi_scan_attach_handler(device);

