From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/8] ACPI: Introduce acpi_bus_power_manageable function
Date: Mon, 7 Jul 2008 03:30:55 +0200
Message-ID: <200807070330.56671.rjw@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57088 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYGGBe6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jul 2008 21:34:58 -0400
In-Reply-To: <200807070330.02849.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Pavel Machek <pavel@suse.cz>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Introduce acpi_bus_power_manageable function

Introduce function acpi_bus_power_manageable() allowing other
(dependent) subsystems to check if ACPI is able to power manage given
device.  This may be useful, for example, for PCI device power
management.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/acpi/bus.c      |   11 +++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 12 insertions(+)

Index: linux-next/drivers/acpi/bus.c
===================================================================
--- linux-next.orig/drivers/acpi/bus.c
+++ linux-next/drivers/acpi/bus.c
@@ -295,6 +295,17 @@ int acpi_bus_set_power(acpi_handle handl
 
 EXPORT_SYMBOL(acpi_bus_set_power);
 
+bool acpi_bus_power_manageable(acpi_handle handle)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	return result ? false : device->flags.power_manageable;
+}
+
+EXPORT_SYMBOL(acpi_bus_power_manageable);
+
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -335,6 +335,7 @@ void acpi_bus_data_handler(acpi_handle h
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
+bool acpi_bus_power_manageable(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
