From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Battery: Add support for _BIX extended info method
Date: Fri, 16 Oct 2009 13:46:59 +0400
Message-ID: <20091016094659.19078.98853.stgit@thinkpad>
References: <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56445 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757450AbZJPJri (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 16 Oct 2009 05:47:38 -0400
In-Reply-To: <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |   61 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 55 insertions(+), 6 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7adc1fa..4d272db 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -54,6 +54,7 @@
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
+#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
@@ -90,6 +91,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
+	ACPI_BATTERY_XINFO_PRESENT,
 	/* For buggy DSDTs that report negative 16-bit values for either charging
 	* or discharging current and/or report 0 as 65536 due to bad math.
 	*/
@@ -112,6 +114,12 @@ struct acpi_battery {
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
@@ -200,6 +208,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = acpi_battery_technology(battery);
 		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		val->intval = battery->cycle_count;
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		val->intval = battery->design_voltage * 1000;
 		break;
@@ -241,6 +252,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -256,6 +268,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -307,6 +320,28 @@ static struct acpi_offsets info_offsets[] = {
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
@@ -352,22 +387,31 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
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
+	else {
+		battery->cycle_count = -1;
+		result = extract_package(battery, buffer.pointer,
+				info_offsets, ARRAY_SIZE(info_offsets));
+	}
 	kfree(buffer.pointer);
 	return result;
 }
@@ -592,6 +636,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 	seq_printf(seq, "design capacity low:     %d %sh\n",
 		   battery->design_capacity_low,
 		   acpi_battery_units(battery));
+	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
 	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
 		   battery->capacity_granularity_1,
 		   acpi_battery_units(battery));
@@ -843,6 +888,7 @@ static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_battery *battery = NULL;
+	acpi_handle handle;
 	if (!device)
 		return -EINVAL;
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
@@ -853,6 +899,9 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
 	mutex_init(&battery->lock);
+	if (ACPI_SUCCESS(acpi_get_handle(battery->device->handle,
+			"_BIX", &handle)))
+		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 	acpi_battery_update(battery);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);

