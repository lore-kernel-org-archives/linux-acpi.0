From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/13] ACPI / PM: Add function for device power state initialization
Date: Thu, 25 Nov 2010 00:08:36 +0100
Message-ID: <201011250008.36676.rjw@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201011250001.11297.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add function acpi_bus_init_power() for getting the initial power
state of an ACPI device and reference counting its power resources
as appropriate.

Make acpi_bus_get_power_flags() use the new function instead of
acpi_bus_get_power() that updates device->power.state without
reference counting the device's power resources.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   25 +++++++++++++++++++++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    5 +----
 3 files changed, 27 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -364,6 +364,31 @@ int acpi_bus_set_power(acpi_handle handl
 
 EXPORT_SYMBOL(acpi_bus_set_power);
 
+
+int acpi_bus_init_power(struct acpi_device *device)
+{
+	int state;
+	int result;
+
+	if (!device)
+		return -EINVAL;
+
+	device->power.state = ACPI_STATE_UNKNOWN;
+
+	result = __acpi_bus_get_power(device, &state);
+	if (result)
+		return result;
+
+	if (device->power.flags.power_resources)
+		result = acpi_power_on_resources(device, state);
+
+	if (!result)
+		device->power.state = state;
+
+	return result;
+}
+
+
 bool acpi_bus_power_manageable(acpi_handle handle)
 {
 	struct acpi_device *device;
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -881,10 +881,7 @@ static int acpi_bus_get_power_flags(stru
 	device->power.states[ACPI_STATE_D3].flags.valid = 1;
 	device->power.states[ACPI_STATE_D3].power = 0;
 
-	/* TBD: System wake support and resource requirements. */
-
-	device->power.state = ACPI_STATE_UNKNOWN;
-	acpi_bus_get_power(device->handle, &(device->power.state));
+	acpi_bus_init_power(device);
 
 	return 0;
 }
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -44,6 +44,7 @@ int acpi_device_sleep_wake(struct acpi_d
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
+int acpi_bus_init_power(struct acpi_device *device);
 extern int acpi_power_nocheck;
 
 int acpi_wakeup_device_init(void);
