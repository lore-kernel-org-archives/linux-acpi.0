From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 11/11] ACPI / Battery: Update information on info notification and resume
Date: Thu, 6 Jan 2011 23:42:27 +0100
Message-ID: <201101062342.28168.rjw@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

A notification event 0x81 from an ACPI battery device requires us to
re-read the battery information structure.  Follow this requirement
and remove and re-create the battery's attibutes in sysfs so that
they reflect the reporting units used by the battery at the moment
(those units may actually change sometimes at run time, which happens
on some Thinkpads).

The approach used in this patch was suggested by Matthew Garrett.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/battery.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -631,6 +631,17 @@ static int acpi_battery_update(struct ac
 	return result;
 }
 
+static void acpi_battery_refresh(struct acpi_battery *battery)
+{
+	if (!battery->bat.dev)
+		return;
+
+	acpi_battery_get_info(battery);
+	/* The battery may have changed its reporting units. */
+	sysfs_remove_battery(battery);
+	sysfs_add_battery(battery);
+}
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -914,6 +925,8 @@ static void acpi_battery_notify(struct a
 	if (!battery)
 		return;
 	old = battery->bat.dev;
+	if (event == ACPI_BATTERY_NOTIFY_INFO)
+		acpi_battery_refresh(battery);
 	acpi_battery_update(battery);
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
@@ -983,6 +996,7 @@ static int acpi_battery_resume(struct ac
 	if (!device)
 		return -EINVAL;
 	battery = acpi_driver_data(device);
+	acpi_battery_refresh(battery);
 	battery->update_time = 0;
 	acpi_battery_update(battery);
 	return 0;
