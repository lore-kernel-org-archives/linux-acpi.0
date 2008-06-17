From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/3] ACPI: Introduce acpi_bus_power_manageable
Date: Tue, 17 Jun 2008 02:11:08 +0200
Message-ID: <200806170211.09174.rjw@sisk.pl>
References: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60617 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYFQAQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2008 20:16:45 -0400
In-Reply-To: <200806170206.26616.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function acpi_bus_power_manageable() allowing other
(dependent) subsystems to check if ACPI is able to power manage given
device.  This may be useful, for example, for PCI device power
management.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   11 +++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 12 insertions(+)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
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
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -335,6 +335,7 @@ void acpi_bus_data_handler(acpi_handle h
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
+bool acpi_bus_power_manageable(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
