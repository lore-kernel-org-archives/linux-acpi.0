From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Coding style in acpi/scan.c
Date: Mon, 10 Feb 2003 17:40:33 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030210164033.GA1142@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This should fix whitespace, please apply,
								Pavel

--- clean/drivers/acpi/scan.c	2003-01-17 23:09:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/scan.c	2003-02-03 18:27:40.000000000 +0100
@@ -295,15 +295,15 @@
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
 	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node,next,&acpi_device_list) {
-		struct acpi_device * dev = container_of(node,struct acpi_device,g_list);
+	list_for_each_safe(node, next, &acpi_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, g_list);
 
 		if (dev->driver || !dev->status.present)
 			continue;
 		spin_unlock(&acpi_device_lock);
 
-		if (!acpi_bus_match(dev,drv)) {
-			if (!acpi_bus_driver_init(dev,drv)) {
+		if (!acpi_bus_match(dev, drv)) {
+			if (!acpi_bus_driver_init(dev, drv)) {
 				atomic_inc(&drv->references);
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
