From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] ACPI / dock: Associate dock platform devices with ACPI device objects
Date: Tue, 11 Feb 2014 01:11:25 +0100
Message-ID: <4270057.BdBl87QbAX@vostro.rjw.lan>
References: <3728252.WpMGKRKmqq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57667 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752394AbaBJX5U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 18:57:20 -0500
In-Reply-To: <3728252.WpMGKRKmqq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To allow user space to check which ACPI device object the dock
station is represented by, make acpi_dock_add() indicate to
platform_device_register_full() which ACPI device object should
be the companion of the new platform device.

This also ensures that the ACPI device object in question will
not go away while the dock platform device is present (which is
always).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dock.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -771,12 +771,18 @@ static struct attribute_group dock_attri
 void acpi_dock_add(struct acpi_device *adev)
 {
 	struct dock_station *dock_station, ds = { NULL, };
+	struct platform_device_info pdevinfo;
 	acpi_handle handle = adev->handle;
 	struct platform_device *dd;
 	int ret;
 
-	dd = platform_device_register_data(NULL, "dock", dock_station_count,
-					   &ds, sizeof(ds));
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = "dock";
+	pdevinfo.id = dock_station_count;
+	pdevinfo.acpi_node.companion = adev;
+	pdevinfo.data = &ds;
+	pdevinfo.size_data = sizeof(ds);
+	dd = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(dd))
 		return;
 

