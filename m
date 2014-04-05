From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / dock: Drop dock_device_ids[] table
Date: Sat, 05 Apr 2014 23:15:13 +0200
Message-ID: <2492304.xo8WybR2yT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58772 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752588AbaDEU7S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Apr 2014 16:59:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no references to dock_device_ids[] table anywhere in the
code and it is not even useful for module autoloading, because the
dock driver can only be built in, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dock.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -51,12 +51,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (d
 	" the driver to wait for userspace to write the undock sysfs file "
 	" before undocking");
 
-static const struct acpi_device_id dock_device_ids[] = {
-	{"LNXDOCK", 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, dock_device_ids);
-
 struct dock_station {
 	acpi_handle handle;
 	unsigned long last_dock_time;

