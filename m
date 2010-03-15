From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/34] ACPI: Battery: Add support for _BIX extended info method
Date: Sun, 14 Mar 2010 21:40:47 -0400
Message-ID: <c67fcd670b55e89e0c129fbf7fae854bd1f8bfa6.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46280 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0COBtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:49:32 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA008UVVQEQ0M0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:49:32 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   68 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b2b48f8..1ca0ea7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -54,6 +54,7 @@
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
+#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
@@ -90,9 +91,11 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
-	/* For buggy DSDTs that report negative 16-bit values for either charging
-	* or discharging current and/or report 0 as 65536 due to bad math.
-	*/
+	ACPI_BATTERY_XINFO_PRESENT,
+	/* For buggy DSDTs that report negative 16-bit values for either
+	 * charging or discharging current and/or report 0 as 65536
+	 * due to bad math.
+	 */
 	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
 };
 
@@ -112,6 +115,12 @@ struct acpi_battery {
 	int design_voltage;
 	int design_capacity_warning;
 	int design_capacity_low;
+	int cycle_count;
+	int measurement_accuracy;
+	int max_sampling_time;
+	int min_sampling_time;
+	int max_averaging_interval;
+	int min_averaging_interval;
 	int capacity_granularity_1;
 	int capacity_granularity_2;
 	int alarm;
@@ -200,6 +209,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = acpi_battery_technology(battery);
 		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		val->intval = battery->cycle_count;
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		val->intval = battery->design_voltage * 1000;
 		break;
@@ -241,6 +253,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -256,6 +269,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -307,6 +321,28 @@ static struct acpi_offsets info_offsets[] = {
 	{offsetof(struct acpi_battery, oem_info), 1},
 };
 
+static struct acpi_offsets extended_info_offsets[] = {
+	{offsetof(struct acpi_battery, power_unit), 0},
+	{offsetof(struct acpi_battery, design_capacity), 0},
+	{offsetof(struct acpi_battery, full_charge_capacity), 0},
+	{offsetof(struct acpi_battery, technology), 0},
+	{offsetof(struct acpi_battery, design_voltage), 0},
+	{offsetof(struct acpi_battery, design_capacity_warning), 0},
+	{offsetof(struct acpi_battery, design_capacity_low), 0},
+	{offsetof(struct acpi_battery, cycle_count), 0},
+	{offsetof(struct acpi_battery, measurement_accuracy), 0},
+	{offsetof(struct acpi_battery, max_sampling_time), 0},
+	{offsetof(struct acpi_battery, min_sampling_time), 0},
+	{offsetof(struct acpi_battery, max_averaging_interval), 0},
+	{offsetof(struct acpi_battery, min_averaging_interval), 0},
+	{offsetof(struct acpi_battery, capacity_granularity_1), 0},
+	{offsetof(struct acpi_battery, capacity_granularity_2), 0},
+	{offsetof(struct acpi_battery, model_number), 1},
+	{offsetof(struct acpi_battery, serial_number), 1},
+	{offsetof(struct acpi_battery, type), 1},
+	{offsetof(struct acpi_battery, oem_info), 1},
+};
+
 static int extract_package(struct acpi_battery *battery,
 			   union acpi_object *package,
 			   struct acpi_offsets *offsets, int num)
@@ -352,22 +388,29 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 {
 	int result = -EFAULT;
 	acpi_status status = 0;
+	char *name = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags)?
+			"_BIX" : "_BIF";
+
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	if (!acpi_battery_present(battery))
 		return 0;
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(battery->device->handle, "_BIF",
-				      NULL, &buffer);
+	status = acpi_evaluate_object(battery->device->handle, name,
+						NULL, &buffer);
 	mutex_unlock(&battery->lock);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s", name));
 		return -ENODEV;
 	}
-
-	result = extract_package(battery, buffer.pointer,
-				 info_offsets, ARRAY_SIZE(info_offsets));
+	if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
+		result = extract_package(battery, buffer.pointer,
+				extended_info_offsets,
+				ARRAY_SIZE(extended_info_offsets));
+	else
+		result = extract_package(battery, buffer.pointer,
+				info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
 	return result;
 }
@@ -414,7 +457,7 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	union acpi_object arg0 = { .type = ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	if (!acpi_battery_present(battery)||
+	if (!acpi_battery_present(battery) ||
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
@@ -592,6 +635,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 	seq_printf(seq, "design capacity low:     %d %sh\n",
 		   battery->design_capacity_low,
 		   acpi_battery_units(battery));
+	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
 	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
 		   battery->capacity_granularity_1,
 		   acpi_battery_units(battery));
@@ -843,6 +887,7 @@ static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_battery *battery = NULL;
+	acpi_handle handle;
 	if (!device)
 		return -EINVAL;
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
@@ -853,6 +898,9 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
 	mutex_init(&battery->lock);
+	if (ACPI_SUCCESS(acpi_get_handle(battery->device->handle,
+			"_BIX", &handle)))
+		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 	acpi_battery_update(battery);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
-- 
1.7.0.2.201.g80978

