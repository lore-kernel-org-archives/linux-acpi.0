From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] acpi: make message more descriptive/meaningful
Date: Mon, 6 Feb 2006 19:29:10 -0800
Message-ID: <20060206192910.66cb9c86.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:16347 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964918AbWBGD2f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 22:28:35 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Mon, 6 Feb 2006 19:28:33 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

[resend]

From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>

Identify which device is not power-manageable to make
the message more useful.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/bus.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2615-rc6g4.orig/drivers/acpi/bus.c
+++ linux-2615-rc6g4/drivers/acpi/bus.c
@@ -198,7 +198,8 @@ int acpi_bus_set_power(acpi_handle handl
 
 	if (!device->flags.power_manageable) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Device is not power manageable\n"));
+				  "Device '%s' is not power manageable\n",
+					device->kobj.name));
 		return_VALUE(-ENODEV);
 	}
 	/*


---
