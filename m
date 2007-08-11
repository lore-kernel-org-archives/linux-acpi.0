From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: ACPI battery cleanup.
Date: Sat, 11 Aug 2007 17:34:39 +0400
Message-ID: <46BDBAEF.5030204@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080008030608030701070806"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35420 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751750AbXHKNex (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Aug 2007 09:34:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080008030608030701070806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Len,

Here are patches to clean up ACPI battery driver. Please review and add
to -mm series.

Regards,
Alex

--------------080008030608030701070806
Content-Type: text/plain;
 name="battery-redesign.mbox"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="battery-redesign.mbox"

>From nobody Sat Aug 11 17:21:21 2007
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/3] ACPI: Battery: don't use acpi_extract_package()
To: Len Brown <lenb@kernel.org>
Bcc: astarikovskiy@suse.de
Date: Sat, 11 Aug 2007 17:21:21 +0400
Message-ID: <20070811132121.6514.99078.stgit@z61m>
User-Agent: StGIT/0.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <astarikivskiy@suse.de>

acpi_extract_package() creates more problems with memory management than
solves as helper for package handling.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |  309 +++++++++++++++++++-----------------------------
 1 files changed, 123 insertions(+), 186 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d7e6683..14bdfad 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -36,9 +36,6 @@
 
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
-#define ACPI_BATTERY_FORMAT_BIF	"NNNNNNNNNSSSS"
-#define ACPI_BATTERY_FORMAT_BST	"NNNN"
-
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
@@ -90,29 +87,6 @@ static struct acpi_driver acpi_battery_driver = {
 		},
 };
 
-struct acpi_battery_state {
-	acpi_integer state;
-	acpi_integer present_rate;
-	acpi_integer remaining_capacity;
-	acpi_integer present_voltage;
-};
-
-struct acpi_battery_info {
-	acpi_integer power_unit;
-	acpi_integer design_capacity;
-	acpi_integer last_full_capacity;
-	acpi_integer battery_technology;
-	acpi_integer design_voltage;
-	acpi_integer design_capacity_warning;
-	acpi_integer design_capacity_low;
-	acpi_integer battery_capacity_granularity_1;
-	acpi_integer battery_capacity_granularity_2;
-	acpi_string model_number;
-	acpi_string serial_number;
-	acpi_string battery_type;
-	acpi_string oem_info;
-};
-
 enum acpi_battery_files {
 	ACPI_BATTERY_INFO = 0,
 	ACPI_BATTERY_STATE,
@@ -120,32 +94,42 @@ enum acpi_battery_files {
 	ACPI_BATTERY_NUMFILES,
 };
 
-struct acpi_battery_flags {
-	u8 battery_present_prev;
-	u8 alarm_present;
-	u8 init_update;
-	u8 update[ACPI_BATTERY_NUMFILES];
-	u8 power_unit;
-};
-
 struct acpi_battery {
 	struct acpi_device *device;
-	struct acpi_battery_flags flags;
-	struct acpi_buffer bif_data;
-	struct acpi_buffer bst_data;
 	struct mutex lock;
 	unsigned long alarm;
 	unsigned long update_time[ACPI_BATTERY_NUMFILES];
-	
+	int state;
+	int present_rate;
+	int remaining_capacity;
+	int present_voltage;
+	int power_unit;
+	int design_capacity;
+	int last_full_capacity;
+	int technology;
+	int design_voltage;
+	int design_capacity_warning;
+	int design_capacity_low;
+	int capacity_granularity_1;
+	int capacity_granularity_2;
+	char model_number[32];
+	char serial_number[32];
+	char type[32];
+	char oem_info[32];
+	u8 present_prev;
+	u8 alarm_present;
+	u8 init_update;
+	u8 update[ACPI_BATTERY_NUMFILES];
 };
 
 inline int acpi_battery_present(struct acpi_battery *battery)
 {
 	return battery->device->status.battery_present;
 }
+
 inline char *acpi_battery_power_units(struct acpi_battery *battery)
 {
-	if (battery->flags.power_unit)
+	if (battery->power_unit)
 		return ACPI_BATTERY_UNITS_AMPS;
 	else
 		return ACPI_BATTERY_UNITS_WATTS;
@@ -166,43 +150,63 @@ static void acpi_battery_check_result(struct acpi_battery *battery, int result)
 		return;
 
 	if (result) {
-		battery->flags.init_update = 1;
+		battery->init_update = 1;
 	}
 }
 
-static int acpi_battery_extract_package(struct acpi_battery *battery,
-					union acpi_object *package,
-					struct acpi_buffer *format,
-					struct acpi_buffer *data,
-					char *package_name)
-{
-	acpi_status status = AE_OK;
-	struct acpi_buffer data_null = { 0, NULL };
+struct acpi_offsets {
+	size_t offset;		/* offset inside struct acpi_sbs_battery */
+	u8 mode;		/* int or string? */
+};
 
-	status = acpi_extract_package(package, format, &data_null);
-	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_EXCEPTION((AE_INFO, status, "Extracting size %s",
-				package_name));
-		return -ENODEV;
-	}
+static struct acpi_offsets state_offsets[] = {
+	{offsetof(struct acpi_battery, state), 0},
+	{offsetof(struct acpi_battery, present_rate), 0},
+	{offsetof(struct acpi_battery, remaining_capacity), 0},
+	{offsetof(struct acpi_battery, present_voltage), 0},
+};
 
-	if (data_null.length != data->length) {
-		kfree(data->pointer);
-		data->pointer = kzalloc(data_null.length, GFP_KERNEL);
-		if (!data->pointer) {
-			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "kzalloc()"));
-			return -ENOMEM;
-		}
-		data->length = data_null.length;
-	}
+static struct acpi_offsets info_offsets[] = {
+	{offsetof(struct acpi_battery, power_unit), 0},
+	{offsetof(struct acpi_battery, design_capacity), 0},
+	{offsetof(struct acpi_battery, last_full_capacity), 0},
+	{offsetof(struct acpi_battery, technology), 0},
+	{offsetof(struct acpi_battery, design_voltage), 0},
+	{offsetof(struct acpi_battery, design_capacity_warning), 0},
+	{offsetof(struct acpi_battery, design_capacity_low), 0},
+	{offsetof(struct acpi_battery, capacity_granularity_1), 0},
+	{offsetof(struct acpi_battery, capacity_granularity_2), 0},
+	{offsetof(struct acpi_battery, model_number), 1},
+	{offsetof(struct acpi_battery, serial_number), 1},
+	{offsetof(struct acpi_battery, type), 1},
+	{offsetof(struct acpi_battery, oem_info), 1},
+};
 
-	status = acpi_extract_package(package, format, data);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Extracting %s",
-				package_name));
-		return -ENODEV;
+static int extract_package(struct acpi_battery *battery,
+			   union acpi_object *package,
+			   struct acpi_offsets *offsets, int num)
+{
+	int i, *x;
+	union acpi_object *element;
+	if (package->type != ACPI_TYPE_PACKAGE)
+		return -EFAULT;
+	for (i = 0; i < num; ++i) {
+		if (package->package.count <= i)
+			return -EFAULT;
+		element = &package->package.elements[i];
+		if (offsets[i].mode) {
+			if (element->type != ACPI_TYPE_STRING &&
+			    element->type != ACPI_TYPE_BUFFER)
+				return -EFAULT;
+			strncpy((u8 *)battery + offsets[i].offset,
+				element->string.pointer, 32);
+		} else {
+			if (element->type != ACPI_TYPE_INTEGER)
+				return -EFAULT;
+			x = (int *)((u8 *)battery + offsets[i].offset);
+			*x = element->integer.value;
+		}
 	}
-
 	return 0;
 }
 
@@ -223,19 +227,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer format = { sizeof(ACPI_BATTERY_FORMAT_BIF),
-		ACPI_BATTERY_FORMAT_BIF
-	};
-	union acpi_object *package = NULL;
-	struct acpi_buffer *data = NULL;
-	struct acpi_battery_info *bif = NULL;
 
 	battery->update_time[ACPI_BATTERY_INFO] = get_seconds();
-
 	if (!acpi_battery_present(battery))
 		return 0;
-
-	/* Evaluate _BIF */
 	mutex_lock(&battery->lock);
 	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF",
 				      NULL, &buffer);
@@ -244,28 +239,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
 	}
-
-	package = buffer.pointer;
-
-	data = &battery->bif_data;
-
-	/* Extract Package Data */
-
-	result =
-	    acpi_battery_extract_package(battery, package, &format, data,
-					 "_BIF");
-	if (result)
-		goto end;
-
-      end:
-
+	result = extract_package(battery, buffer.pointer,
+				 info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
-
-	if (!result) {
-		bif = data->pointer;
-		battery->flags.power_unit = bif->power_unit;
-	}
-
 	return result;
 }
 
@@ -274,11 +250,6 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer format = { sizeof(ACPI_BATTERY_FORMAT_BST),
-		ACPI_BATTERY_FORMAT_BST
-	};
-	union acpi_object *package = NULL;
-	struct acpi_buffer *data = NULL;
 
 	battery->update_time[ACPI_BATTERY_STATE] = get_seconds();
 
@@ -294,22 +265,9 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
 	}
-
-	package = buffer.pointer;
-
-	data = &battery->bst_data;
-
-	/* Extract Package Data */
-
-	result =
-	    acpi_battery_extract_package(battery, package, &format, data,
-					 "_BST");
-	if (result)
-		goto end;
-
-      end:
+	result = extract_package(battery, buffer.pointer,
+				 state_offsets, ARRAY_SIZE(state_offsets));
 	kfree(buffer.pointer);
-
 	return result;
 }
 
@@ -332,7 +290,7 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	if (!acpi_battery_present(battery))
 		return -ENODEV;
 
-	if (!battery->flags.alarm_present)
+	if (!battery->alarm_present)
 		return -ENODEV;
 
 	arg0.integer.value = alarm;
@@ -356,22 +314,21 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	int result = 0;
 	acpi_status status = AE_OK;
 	acpi_handle handle = NULL;
-	struct acpi_battery_info *bif = battery->bif_data.pointer;
 	unsigned long alarm = battery->alarm;
 
 	/* See if alarms are supported, and if so, set default */
 
 	status = acpi_get_handle(acpi_battery_handle(battery), "_BTP", &handle);
 	if (ACPI_SUCCESS(status)) {
-		battery->flags.alarm_present = 1;
-		if (!alarm && bif) {
-			alarm = bif->design_capacity_warning;
+		battery->alarm_present = 1;
+		if (!alarm) {
+			alarm = battery->design_capacity_warning;
 		}
 		result = acpi_battery_set_alarm(battery, alarm);
 		if (result)
 			goto end;
 	} else {
-		battery->flags.alarm_present = 0;
+		battery->alarm_present = 0;
 	}
 
       end:
@@ -387,7 +344,7 @@ static int acpi_battery_init_update(struct acpi_battery *battery)
 	if (result)
 		return result;
 
-	battery->flags.battery_present_prev = acpi_battery_present(battery);
+	battery->present_prev = acpi_battery_present(battery);
 
 	if (acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
@@ -413,7 +370,7 @@ static int acpi_battery_update(struct acpi_battery *battery,
 		update = 1;
 	}
 
-	if (battery->flags.init_update) {
+	if (battery->init_update) {
 		result = acpi_battery_init_update(battery);
 		if (result)
 			goto end;
@@ -422,8 +379,8 @@ static int acpi_battery_update(struct acpi_battery *battery,
 		result = acpi_battery_get_status(battery);
 		if (result)
 			goto end;
-		if ((!battery->flags.battery_present_prev & acpi_battery_present(battery))
-		    || (battery->flags.battery_present_prev & !acpi_battery_present(battery))) {
+		if ((!battery->present_prev & acpi_battery_present(battery))
+		    || (battery->present_prev & !acpi_battery_present(battery))) {
 			result = acpi_battery_init_update(battery);
 			if (result)
 				goto end;
@@ -435,7 +392,7 @@ static int acpi_battery_update(struct acpi_battery *battery,
 
       end:
 
-	battery->flags.init_update = (result != 0);
+	battery->init_update = (result != 0);
 
 	*update_result_ptr = update_result;
 
@@ -446,19 +403,19 @@ static void acpi_battery_notify_update(struct acpi_battery *battery)
 {
 	acpi_battery_get_status(battery);
 
-	if (battery->flags.init_update) {
+	if (battery->init_update) {
 		return;
 	}
 
-	if ((!battery->flags.battery_present_prev &
+	if ((!battery->present_prev &
 	     acpi_battery_present(battery)) ||
-	    (battery->flags.battery_present_prev &
+	    (battery->present_prev &
 	     !acpi_battery_present(battery))) {
-		battery->flags.init_update = 1;
+		battery->init_update = 1;
 	} else {
-		battery->flags.update[ACPI_BATTERY_INFO] = 1;
-		battery->flags.update[ACPI_BATTERY_STATE] = 1;
-		battery->flags.update[ACPI_BATTERY_ALARM] = 1;
+		battery->update[ACPI_BATTERY_INFO] = 1;
+		battery->update[ACPI_BATTERY_STATE] = 1;
+		battery->update[ACPI_BATTERY_ALARM] = 1;
 	}
 }
 
@@ -471,7 +428,6 @@ static struct proc_dir_entry *acpi_battery_dir;
 static int acpi_battery_print_info(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	struct acpi_battery_info *bif = NULL;
 	char *units = "?";
 
 	if (result)
@@ -484,30 +440,23 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 		goto end;
 	}
 
-	bif = battery->bif_data.pointer;
-	if (!bif) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "BIF buffer is NULL"));
-		result = -ENODEV;
-		goto end;
-	}
-
 	/* Battery Units */
 
 	units = acpi_battery_power_units(battery);
 
-	if (bif->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
 	else
 		seq_printf(seq, "design capacity:         %d %sh\n",
-			   (u32) bif->design_capacity, units);
+			   (u32) battery->design_capacity, units);
 
-	if (bif->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "last full capacity:      unknown\n");
 	else
 		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   (u32) bif->last_full_capacity, units);
+			   (u32) battery->last_full_capacity, units);
 
-	switch ((u32) bif->battery_technology) {
+	switch ((u32) battery->technology) {
 	case 0:
 		seq_printf(seq, "battery technology:      non-rechargeable\n");
 		break;
@@ -519,23 +468,23 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 		break;
 	}
 
-	if (bif->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design voltage:          unknown\n");
 	else
 		seq_printf(seq, "design voltage:          %d mV\n",
-			   (u32) bif->design_voltage);
+			   (u32) battery->design_voltage);
 	seq_printf(seq, "design capacity warning: %d %sh\n",
-		   (u32) bif->design_capacity_warning, units);
+		   (u32) battery->design_capacity_warning, units);
 	seq_printf(seq, "design capacity low:     %d %sh\n",
-		   (u32) bif->design_capacity_low, units);
+		   (u32) battery->design_capacity_low, units);
 	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
-		   (u32) bif->battery_capacity_granularity_1, units);
+		   (u32) battery->capacity_granularity_1, units);
 	seq_printf(seq, "capacity granularity 2:  %d %sh\n",
-		   (u32) bif->battery_capacity_granularity_2, units);
-	seq_printf(seq, "model number:            %s\n", bif->model_number);
-	seq_printf(seq, "serial number:           %s\n", bif->serial_number);
-	seq_printf(seq, "battery type:            %s\n", bif->battery_type);
-	seq_printf(seq, "OEM info:                %s\n", bif->oem_info);
+		   (u32) battery->capacity_granularity_2, units);
+	seq_printf(seq, "model number:            %s\n", battery->model_number);
+	seq_printf(seq, "serial number:           %s\n", battery->serial_number);
+	seq_printf(seq, "battery type:            %s\n", battery->type);
+	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
 
       end:
 
@@ -548,7 +497,6 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 static int acpi_battery_print_state(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	struct acpi_battery_state *bst = NULL;
 	char *units = "?";
 
 	if (result)
@@ -561,50 +509,43 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 		goto end;
 	}
 
-	bst = battery->bst_data.pointer;
-	if (!bst) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "BST buffer is NULL"));
-		result = -ENODEV;
-		goto end;
-	}
-
 	/* Battery Units */
 
 	units = acpi_battery_power_units(battery);
 
-	if (!(bst->state & 0x04))
+	if (!(battery->state & 0x04))
 		seq_printf(seq, "capacity state:          ok\n");
 	else
 		seq_printf(seq, "capacity state:          critical\n");
 
-	if ((bst->state & 0x01) && (bst->state & 0x02)) {
+	if ((battery->state & 0x01) && (battery->state & 0x02)) {
 		seq_printf(seq,
 			   "charging state:          charging/discharging\n");
-	} else if (bst->state & 0x01)
+	} else if (battery->state & 0x01)
 		seq_printf(seq, "charging state:          discharging\n");
-	else if (bst->state & 0x02)
+	else if (battery->state & 0x02)
 		seq_printf(seq, "charging state:          charging\n");
 	else {
 		seq_printf(seq, "charging state:          charged\n");
 	}
 
-	if (bst->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
-			   (u32) bst->present_rate, units);
+			   (u32) battery->present_rate, units);
 
-	if (bst->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "remaining capacity:      unknown\n");
 	else
 		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   (u32) bst->remaining_capacity, units);
+			   (u32) battery->remaining_capacity, units);
 
-	if (bst->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present voltage:         unknown\n");
 	else
 		seq_printf(seq, "present voltage:         %d mV\n",
-			   (u32) bst->present_voltage);
+			   (u32) battery->present_voltage);
 
       end:
 
@@ -713,7 +654,7 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
 	int update = 0;
 
 	update = (get_seconds() - battery->update_time[fid] >= update_time);
-	update = (update | battery->flags.update[fid]);
+	update = (update | battery->update[fid]);
 
 	result = acpi_battery_update(battery, update, &update_result);
 	if (result)
@@ -728,7 +669,7 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
       end:
 	result = acpi_read_funcs[fid].print(seq, result);
 	acpi_battery_check_result(battery, result);
-	battery->flags.update[fid] = result;
+	battery->update[fid] = result;
 	return result;
 }
 
@@ -902,7 +843,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-	battery->flags.init_update = 1;
+	battery->init_update = 1;
 
 	result = acpi_battery_add_fs(device);
 	if (result)
@@ -948,10 +889,6 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	acpi_battery_remove_fs(device);
 
-	kfree(battery->bif_data.pointer);
-
-	kfree(battery->bst_data.pointer);
-
 	mutex_destroy(&battery->lock);
 
 	kfree(battery);
@@ -969,7 +906,7 @@ static int acpi_battery_resume(struct acpi_device *device)
 
 	battery = device->driver_data;
 
-	battery->flags.init_update = 1;
+	battery->init_update = 1;
 
 	return 0;
 }


>From nobody Sat Aug 11 17:21:21 2007
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/3] ACPI: Battery: simplify update scheme
To: Len Brown <lenb@kernel.org>
Bcc: astarikovskiy@suse.de
Date: Sat, 11 Aug 2007 17:21:21 +0400
Message-ID: <20070811132121.6514.49032.stgit@z61m>
In-Reply-To: <20070811132121.6514.99078.stgit@z61m>
References: <20070811132121.6514.99078.stgit@z61m>
User-Agent: StGIT/0.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |  274 +++++++++---------------------------------------
 1 files changed, 52 insertions(+), 222 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 14bdfad..eea4dd9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/jiffies.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -41,27 +42,18 @@
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_UNITS_WATTS	"mW"
-#define ACPI_BATTERY_UNITS_AMPS		"mA"
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
-#define ACPI_BATTERY_UPDATE_TIME	0
-
-#define ACPI_BATTERY_NONE_UPDATE	0
-#define ACPI_BATTERY_EASY_UPDATE	1
-#define ACPI_BATTERY_INIT_UPDATE	2
-
 ACPI_MODULE_NAME("battery");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
-static unsigned int update_time = ACPI_BATTERY_UPDATE_TIME;
-
-/* 0 - every time, > 0 - by update_time */
-module_param(update_time, uint, 0644);
+static unsigned int cache_time = 1000;
+module_param(cache_time, uint, 0644);
+MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
@@ -95,15 +87,12 @@ enum acpi_battery_files {
 };
 
 struct acpi_battery {
-	struct acpi_device *device;
 	struct mutex lock;
-	unsigned long alarm;
-	unsigned long update_time[ACPI_BATTERY_NUMFILES];
-	int state;
+	struct acpi_device *device;
+	unsigned long update_time;
 	int present_rate;
 	int remaining_capacity;
 	int present_voltage;
-	int power_unit;
 	int design_capacity;
 	int last_full_capacity;
 	int technology;
@@ -112,14 +101,14 @@ struct acpi_battery {
 	int design_capacity_low;
 	int capacity_granularity_1;
 	int capacity_granularity_2;
+	int alarm;
 	char model_number[32];
 	char serial_number[32];
 	char type[32];
 	char oem_info[32];
-	u8 present_prev;
+	int state;
+	int power_unit;
 	u8 alarm_present;
-	u8 init_update;
-	u8 update[ACPI_BATTERY_NUMFILES];
 };
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -127,33 +116,15 @@ inline int acpi_battery_present(struct acpi_battery *battery)
 	return battery->device->status.battery_present;
 }
 
-inline char *acpi_battery_power_units(struct acpi_battery *battery)
+inline char *acpi_battery_units(struct acpi_battery *battery)
 {
-	if (battery->power_unit)
-		return ACPI_BATTERY_UNITS_AMPS;
-	else
-		return ACPI_BATTERY_UNITS_WATTS;
-}
-
-inline acpi_handle acpi_battery_handle(struct acpi_battery *battery)
-{
-	return battery->device->handle;
+	return (battery->power_unit)?"mA":"mW";
 }
 
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
 
-static void acpi_battery_check_result(struct acpi_battery *battery, int result)
-{
-	if (!battery)
-		return;
-
-	if (result) {
-		battery->init_update = 1;
-	}
-}
-
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
 	u8 mode;		/* int or string? */
@@ -228,11 +199,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	battery->update_time[ACPI_BATTERY_INFO] = get_seconds();
 	if (!acpi_battery_present(battery))
 		return 0;
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF",
+	status = acpi_evaluate_object(battery->device->handle, "_BIF",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status)) {
@@ -251,14 +221,17 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	battery->update_time[ACPI_BATTERY_STATE] = get_seconds();
-
 	if (!acpi_battery_present(battery))
 		return 0;
 
+	if (battery->update_time &&
+	    time_before(jiffies, battery->update_time +
+			msecs_to_jiffies(cache_time)))
+		return 0;
+
 	/* Evaluate _BST */
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BST",
+	status = acpi_evaluate_object(battery->device->handle, "_BST",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status)) {
@@ -267,14 +240,13 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	}
 	result = extract_package(battery, buffer.pointer,
 				 state_offsets, ARRAY_SIZE(state_offsets));
+	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 	return result;
 }
 
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
-	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
-
 	return 0;
 }
 
@@ -285,8 +257,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
-
 	if (!acpi_battery_present(battery))
 		return -ENODEV;
 
@@ -296,7 +266,7 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	arg0.integer.value = alarm;
 
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
+	status = acpi_evaluate_object(battery->device->handle, "_BTP",
 				 &arg_list, NULL);
 	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status))
@@ -311,112 +281,36 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
 	acpi_handle handle = NULL;
-	unsigned long alarm = battery->alarm;
 
 	/* See if alarms are supported, and if so, set default */
-
-	status = acpi_get_handle(acpi_battery_handle(battery), "_BTP", &handle);
-	if (ACPI_SUCCESS(status)) {
-		battery->alarm_present = 1;
-		if (!alarm) {
-			alarm = battery->design_capacity_warning;
-		}
-		result = acpi_battery_set_alarm(battery, alarm);
-		if (result)
-			goto end;
-	} else {
+	status = acpi_get_handle(battery->device->handle, "_BTP", &handle);
+	if (ACPI_FAILURE(status)) {
 		battery->alarm_present = 0;
+		return 0;
 	}
-
-      end:
-
-	return result;
+	battery->alarm_present = 1;
+	if (!battery->alarm)
+		battery->alarm = battery->design_capacity_warning;
+	return acpi_battery_set_alarm(battery, battery->alarm);
 }
 
-static int acpi_battery_init_update(struct acpi_battery *battery)
+static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result = 0;
-
-	result = acpi_battery_get_status(battery);
-	if (result)
+	int saved_present = acpi_battery_present(battery);
+	int result = acpi_battery_get_status(battery);
+	if (result || !acpi_battery_present(battery))
 		return result;
-
-	battery->present_prev = acpi_battery_present(battery);
-
-	if (acpi_battery_present(battery)) {
+	if (saved_present != acpi_battery_present(battery) ||
+	    !battery->update_time) {
+		battery->update_time = 0;
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-		result = acpi_battery_get_state(battery);
-		if (result)
-			return result;
-
 		acpi_battery_init_alarm(battery);
 	}
-
-	return result;
-}
-
-static int acpi_battery_update(struct acpi_battery *battery,
-			       int update, int *update_result_ptr)
-{
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-
-	if (!acpi_battery_present(battery)) {
-		update = 1;
-	}
-
-	if (battery->init_update) {
-		result = acpi_battery_init_update(battery);
-		if (result)
-			goto end;
-		update_result = ACPI_BATTERY_INIT_UPDATE;
-	} else if (update) {
-		result = acpi_battery_get_status(battery);
-		if (result)
-			goto end;
-		if ((!battery->present_prev & acpi_battery_present(battery))
-		    || (battery->present_prev & !acpi_battery_present(battery))) {
-			result = acpi_battery_init_update(battery);
-			if (result)
-				goto end;
-			update_result = ACPI_BATTERY_INIT_UPDATE;
-		} else {
-			update_result = ACPI_BATTERY_EASY_UPDATE;
-		}
-	}
-
-      end:
-
-	battery->init_update = (result != 0);
-
-	*update_result_ptr = update_result;
-
-	return result;
-}
-
-static void acpi_battery_notify_update(struct acpi_battery *battery)
-{
-	acpi_battery_get_status(battery);
-
-	if (battery->init_update) {
-		return;
-	}
-
-	if ((!battery->present_prev &
-	     acpi_battery_present(battery)) ||
-	    (battery->present_prev &
-	     !acpi_battery_present(battery))) {
-		battery->init_update = 1;
-	} else {
-		battery->update[ACPI_BATTERY_INFO] = 1;
-		battery->update[ACPI_BATTERY_STATE] = 1;
-		battery->update[ACPI_BATTERY_ALARM] = 1;
-	}
+	return acpi_battery_get_state(battery);
 }
 
 /* --------------------------------------------------------------------------
@@ -442,7 +336,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
@@ -511,7 +405,7 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	if (!(battery->state & 0x04))
 		seq_printf(seq, "capacity state:          ok\n");
@@ -571,13 +465,13 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	seq_printf(seq, "alarm:                   ");
 	if (!battery->alarm)
 		seq_printf(seq, "unsupported\n");
 	else
-		seq_printf(seq, "%lu %sh\n", battery->alarm, units);
+		seq_printf(seq, "%u %sh\n", battery->alarm, units);
 
       end:
 
@@ -587,50 +481,35 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 	return result;
 }
 
-static ssize_t
-acpi_battery_write_alarm(struct file *file,
-			 const char __user * buffer,
-			 size_t count, loff_t * ppos)
+static ssize_t acpi_battery_write_alarm(struct file *file,
+					const char __user * buffer,
+					size_t count, loff_t * ppos)
 {
 	int result = 0;
 	char alarm_string[12] = { '\0' };
 	struct seq_file *m = file->private_data;
 	struct acpi_battery *battery = m->private;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
 
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
-
-	result = acpi_battery_update(battery, 1, &update_result);
 	if (result) {
 		result = -ENODEV;
 		goto end;
 	}
-
 	if (!acpi_battery_present(battery)) {
 		result = -ENODEV;
 		goto end;
 	}
-
 	if (copy_from_user(alarm_string, buffer, count)) {
 		result = -EFAULT;
 		goto end;
 	}
-
 	alarm_string[count] = '\0';
-
-	result = acpi_battery_set_alarm(battery,
-					simple_strtoul(alarm_string, NULL, 0));
-	if (result)
-		goto end;
-
+	battery->alarm = simple_strtol(alarm_string, NULL, 0);
+	result = acpi_battery_set_alarm(battery, battery->alarm);
       end:
-
-	acpi_battery_check_result(battery, result);
-
 	if (!result)
 		return count;
-
 	return result;
 }
 
@@ -649,28 +528,8 @@ static struct acpi_read_mux {
 static int acpi_battery_read(int fid, struct seq_file *seq)
 {
 	struct acpi_battery *battery = seq->private;
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-	int update = 0;
-
-	update = (get_seconds() - battery->update_time[fid] >= update_time);
-	update = (update | battery->update[fid]);
-
-	result = acpi_battery_update(battery, update, &update_result);
-	if (result)
-		goto end;
-
-	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
-		result = acpi_read_funcs[fid].get(battery);
-		if (result)
-			goto end;
-	}
-
-      end:
-	result = acpi_read_funcs[fid].print(seq, result);
-	acpi_battery_check_result(battery, result);
-	battery->update[fid] = result;
-	return result;
+	int result = acpi_battery_update(battery);
+	return acpi_read_funcs[fid].print(seq, result);
 }
 
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
@@ -794,30 +653,11 @@ static int acpi_battery_remove_fs(struct acpi_device *device)
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_battery *battery = data;
-	struct acpi_device *device = NULL;
-
 	if (!battery)
 		return;
-
-	device = battery->device;
-
-	switch (event) {
-	case ACPI_BATTERY_NOTIFY_STATUS:
-	case ACPI_BATTERY_NOTIFY_INFO:
-	case ACPI_NOTIFY_BUS_CHECK:
-	case ACPI_NOTIFY_DEVICE_CHECK:
-		device = battery->device;
-		acpi_battery_notify_update(battery);
-		acpi_bus_generate_event(device, event,
-					acpi_battery_present(battery));
-		break;
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
-		break;
-	}
-
-	return;
+	acpi_battery_update(battery);
+	acpi_bus_generate_event(battery->device, event,
+				acpi_battery_present(battery));
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -838,13 +678,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	acpi_driver_data(device) = battery;
-
-	result = acpi_battery_get_status(battery);
-	if (result)
-		goto end;
-
-	battery->init_update = 1;
-
+	acpi_battery_update(battery);
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
@@ -900,14 +734,10 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 static int acpi_battery_resume(struct acpi_device *device)
 {
 	struct acpi_battery *battery;
-
 	if (!device)
 		return -EINVAL;
-
-	battery = device->driver_data;
-
-	battery->init_update = 1;
-
+	battery = acpi_driver_data(device);
+	battery->update_time = 0;
 	return 0;
 }
 


>From nobody Sat Aug 11 17:21:21 2007
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/3] ACPI: Battery: Misc clean-ups, no functional changes
To: Len Brown <lenb@kernel.org>
Bcc: astarikovskiy@suse.de
Date: Sat, 11 Aug 2007 17:21:21 +0400
Message-ID: <20070811132121.6514.92718.stgit@z61m>
In-Reply-To: <20070811132121.6514.99078.stgit@z61m>
References: <20070811132121.6514.99078.stgit@z61m>
User-Agent: StGIT/0.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |  346 +++++++++++++++++-------------------------------
 1 files changed, 126 insertions(+), 220 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index eea4dd9..d93072d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1,6 +1,8 @@
 /*
- *  acpi_battery.c - ACPI Battery Driver ($Revision: 37 $)
+ *  battery.c - ACPI Battery Driver (Revision: 2.0)
  *
+ *  Copyright (C) 2007 Alexey Starikovskiy <astarikovskiy@suse.de>
+ *  Copyright (C) 2004-2007 Vladimir Lebedev <vladimir.p.lebedev@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *
@@ -48,6 +50,7 @@
 ACPI_MODULE_NAME("battery");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
@@ -58,31 +61,17 @@ MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
-static int acpi_battery_add(struct acpi_device *device);
-static int acpi_battery_remove(struct acpi_device *device, int type);
-static int acpi_battery_resume(struct acpi_device *device);
-
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
 	{"", 0},
 };
-MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
-static struct acpi_driver acpi_battery_driver = {
-	.name = "battery",
-	.class = ACPI_BATTERY_CLASS,
-	.ids = battery_device_ids,
-	.ops = {
-		.add = acpi_battery_add,
-		.resume = acpi_battery_resume,
-		.remove = acpi_battery_remove,
-		},
-};
+MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
 enum acpi_battery_files {
-	ACPI_BATTERY_INFO = 0,
-	ACPI_BATTERY_STATE,
-	ACPI_BATTERY_ALARM,
+	info_tag = 0,
+	state_tag,
+	alarm_tag,
 	ACPI_BATTERY_NUMFILES,
 };
 
@@ -124,7 +113,6 @@ inline char *acpi_battery_units(struct acpi_battery *battery)
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
-
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
 	u8 mode;		/* int or string? */
@@ -183,19 +171,16 @@ static int extract_package(struct acpi_battery *battery,
 
 static int acpi_battery_get_status(struct acpi_battery *battery)
 {
-	int result = 0;
-
-	result = acpi_bus_get_status(battery->device);
-	if (result) {
+	if (acpi_bus_get_status(battery->device)) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
 		return -ENODEV;
 	}
-	return result;
+	return 0;
 }
 
 static int acpi_battery_get_info(struct acpi_battery *battery)
 {
-	int result = 0;
+	int result = -EFAULT;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
@@ -205,10 +190,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	status = acpi_evaluate_object(battery->device->handle, "_BIF",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
 	}
+	
 	result = extract_package(battery, buffer.pointer,
 				 info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
@@ -234,10 +221,12 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	status = acpi_evaluate_object(battery->device->handle, "_BST",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
 	}
+
 	result = extract_package(battery, buffer.pointer,
 				 state_offsets, ARRAY_SIZE(state_offsets));
 	battery->update_time = jiffies;
@@ -245,37 +234,26 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
-static int acpi_battery_get_alarm(struct acpi_battery *battery)
-{
-	return 0;
-}
-
-static int acpi_battery_set_alarm(struct acpi_battery *battery,
-				  unsigned long alarm)
+static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	union acpi_object arg0 = { .type = ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	if (!acpi_battery_present(battery))
+	if (!acpi_battery_present(battery)|| !battery->alarm_present)
 		return -ENODEV;
 
-	if (!battery->alarm_present)
-		return -ENODEV;
-
-	arg0.integer.value = alarm;
+	arg0.integer.value = battery->alarm;
 
 	mutex_lock(&battery->lock);
 	status = acpi_evaluate_object(battery->device->handle, "_BTP",
 				 &arg_list, NULL);
 	mutex_unlock(&battery->lock);
+
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", (u32) alarm));
-
-	battery->alarm = alarm;
-
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
 	return 0;
 }
 
@@ -293,7 +271,7 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	battery->alarm_present = 1;
 	if (!battery->alarm)
 		battery->alarm = battery->design_capacity_warning;
-	return acpi_battery_set_alarm(battery, battery->alarm);
+	return acpi_battery_set_alarm(battery);
 }
 
 static int acpi_battery_update(struct acpi_battery *battery)
@@ -322,130 +300,101 @@ static struct proc_dir_entry *acpi_battery_dir;
 static int acpi_battery_print_info(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
 
-	if (acpi_battery_present(battery))
-		seq_printf(seq, "present:                 yes\n");
-	else {
-		seq_printf(seq, "present:                 no\n");
+	seq_printf(seq, "present:                 %s\n",
+		   acpi_battery_present(battery)?"yes":"no");
+	if (!acpi_battery_present(battery))
 		goto end;
-	}
-
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
-
 	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
 	else
 		seq_printf(seq, "design capacity:         %d %sh\n",
-			   (u32) battery->design_capacity, units);
+			   battery->design_capacity,
+			   acpi_battery_units(battery));
 
 	if (battery->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "last full capacity:      unknown\n");
 	else
 		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   (u32) battery->last_full_capacity, units);
-
-	switch ((u32) battery->technology) {
-	case 0:
-		seq_printf(seq, "battery technology:      non-rechargeable\n");
-		break;
-	case 1:
-		seq_printf(seq, "battery technology:      rechargeable\n");
-		break;
-	default:
-		seq_printf(seq, "battery technology:      unknown\n");
-		break;
-	}
+			   battery->last_full_capacity,
+			   acpi_battery_units(battery));
+
+	seq_printf(seq, "battery technology:      %srechargeable\n",
+		   (!battery->technology)?"non-":"");
 
 	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design voltage:          unknown\n");
 	else
 		seq_printf(seq, "design voltage:          %d mV\n",
-			   (u32) battery->design_voltage);
+			   battery->design_voltage);
 	seq_printf(seq, "design capacity warning: %d %sh\n",
-		   (u32) battery->design_capacity_warning, units);
+		   battery->design_capacity_warning,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "design capacity low:     %d %sh\n",
-		   (u32) battery->design_capacity_low, units);
+		   battery->design_capacity_low,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
-		   (u32) battery->capacity_granularity_1, units);
+		   battery->capacity_granularity_1,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "capacity granularity 2:  %d %sh\n",
-		   (u32) battery->capacity_granularity_2, units);
+		   battery->capacity_granularity_2,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "model number:            %s\n", battery->model_number);
 	seq_printf(seq, "serial number:           %s\n", battery->serial_number);
 	seq_printf(seq, "battery type:            %s\n", battery->type);
 	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
-
       end:
-
 	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery info\n");
-
 	return result;
 }
 
 static int acpi_battery_print_state(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
 
-	if (acpi_battery_present(battery))
-		seq_printf(seq, "present:                 yes\n");
-	else {
-		seq_printf(seq, "present:                 no\n");
+	seq_printf(seq, "present:                 %s\n",
+		   acpi_battery_present(battery)?"yes":"no");
+	if (!acpi_battery_present(battery))
 		goto end;
-	}
 
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
-
-	if (!(battery->state & 0x04))
-		seq_printf(seq, "capacity state:          ok\n");
-	else
-		seq_printf(seq, "capacity state:          critical\n");
-
-	if ((battery->state & 0x01) && (battery->state & 0x02)) {
+	seq_printf(seq, "capacity state:          %s\n",
+			(battery->state & 0x04)?"critical":"ok");
+	if ((battery->state & 0x01) && (battery->state & 0x02))
 		seq_printf(seq,
 			   "charging state:          charging/discharging\n");
-	} else if (battery->state & 0x01)
+	else if (battery->state & 0x01)
 		seq_printf(seq, "charging state:          discharging\n");
 	else if (battery->state & 0x02)
 		seq_printf(seq, "charging state:          charging\n");
-	else {
+	else
 		seq_printf(seq, "charging state:          charged\n");
-	}
 
 	if (battery->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
-			   (u32) battery->present_rate, units);
+			   battery->present_rate, acpi_battery_units(battery));
 
 	if (battery->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "remaining capacity:      unknown\n");
 	else
 		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   (u32) battery->remaining_capacity, units);
-
+			   battery->remaining_capacity, acpi_battery_units(battery));
 	if (battery->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present voltage:         unknown\n");
 	else
 		seq_printf(seq, "present voltage:         %d mV\n",
-			   (u32) battery->present_voltage);
-
+			   battery->present_voltage);
       end:
-
-	if (result) {
+	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery state\n");
-	}
 
 	return result;
 }
@@ -453,7 +402,6 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
@@ -462,22 +410,15 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
-
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
-
 	seq_printf(seq, "alarm:                   ");
 	if (!battery->alarm)
 		seq_printf(seq, "unsupported\n");
 	else
-		seq_printf(seq, "%u %sh\n", battery->alarm, units);
-
+		seq_printf(seq, "%u %sh\n", battery->alarm,
+				acpi_battery_units(battery));
       end:
-
 	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery alarm\n");
-
 	return result;
 }
 
@@ -506,7 +447,7 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
 	}
 	alarm_string[count] = '\0';
 	battery->alarm = simple_strtol(alarm_string, NULL, 0);
-	result = acpi_battery_set_alarm(battery, battery->alarm);
+	result = acpi_battery_set_alarm(battery);
       end:
 	if (!result)
 		return count;
@@ -514,95 +455,76 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
 }
 
 typedef int(*print_func)(struct seq_file *seq, int result);
-typedef int(*get_func)(struct acpi_battery *battery);
-
-static struct acpi_read_mux {
-	print_func print;
-	get_func get;
-} acpi_read_funcs[ACPI_BATTERY_NUMFILES] = {
-	{.get = acpi_battery_get_info, .print = acpi_battery_print_info},
-	{.get = acpi_battery_get_state, .print = acpi_battery_print_state},
-	{.get = acpi_battery_get_alarm, .print = acpi_battery_print_alarm},
+
+static print_func acpi_print_funcs[ACPI_BATTERY_NUMFILES] = {
+	acpi_battery_print_info,
+	acpi_battery_print_state,
+	acpi_battery_print_alarm,
 };
 
 static int acpi_battery_read(int fid, struct seq_file *seq)
 {
 	struct acpi_battery *battery = seq->private;
 	int result = acpi_battery_update(battery);
-	return acpi_read_funcs[fid].print(seq, result);
-}
-
-static int acpi_battery_read_info(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_INFO, seq);
-}
-
-static int acpi_battery_read_state(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_STATE, seq);
-}
-
-static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_ALARM, seq);
+	return acpi_print_funcs[fid](seq, result);
 }
 
-static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
+#define DECLARE_FILE_FUNCTIONS(_name) \
+static int acpi_battery_read_##_name(struct seq_file *seq, void *offset) \
+{ \
+	return acpi_battery_read(_name##_tag, seq); \
+} \
+static int acpi_battery_##_name##_open_fs(struct inode *inode, struct file *file) \
+{ \
+	return single_open(file, acpi_battery_read_##_name, PDE(inode)->data); \
 }
 
-static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
-}
+DECLARE_FILE_FUNCTIONS(info);
+DECLARE_FILE_FUNCTIONS(state);
+DECLARE_FILE_FUNCTIONS(alarm);
+
+#undef DECLARE_FILE_FUNCTIONS
+
+#define FILE_DESCRIPTION_RO(_name) \
+	{ \
+	.name = __stringify(_name), \
+	.mode = S_IRUGO, \
+	.ops = { \
+		.open = acpi_battery_##_name##_open_fs, \
+		.read = seq_read, \
+		.llseek = seq_lseek, \
+		.release = single_release, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
 
-static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
-}
+#define FILE_DESCRIPTION_RW(_name) \
+	{ \
+	.name = __stringify(_name), \
+	.mode = S_IFREG | S_IRUGO | S_IWUSR, \
+	.ops = { \
+		.open = acpi_battery_##_name##_open_fs, \
+		.read = seq_read, \
+		.llseek = seq_lseek, \
+		.write = acpi_battery_write_##_name, \
+		.release = single_release, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
 
 static struct battery_file {
 	struct file_operations ops;
 	mode_t mode;
 	char *name;
 } acpi_battery_file[] = {
-	{
-	.name = "info",
-	.mode = S_IRUGO,
-	.ops = {
-	.open = acpi_battery_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
-	{
-	.name = "state",
-	.mode = S_IRUGO,
-	.ops = {
-	.open = acpi_battery_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
-	{
-	.name = "alarm",
-	.mode = S_IFREG | S_IRUGO | S_IWUSR,
-	.ops = {
-	.open = acpi_battery_alarm_open_fs,
-	.read = seq_read,
-	.write = acpi_battery_write_alarm,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
+	FILE_DESCRIPTION_RO(info),
+	FILE_DESCRIPTION_RO(state),
+	FILE_DESCRIPTION_RW(alarm),
 };
 
+#undef FILE_DESCRIPTION_RO
+#undef FILE_DESCRIPTION_RW
+
 static int acpi_battery_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
@@ -627,23 +549,20 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 			entry->owner = THIS_MODULE;
 		}
 	}
-
 	return 0;
 }
 
-static int acpi_battery_remove_fs(struct acpi_device *device)
+static void acpi_battery_remove_fs(struct acpi_device *device)
 {
 	int i;
-	if (acpi_device_dir(device)) {
-		for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
-			remove_proc_entry(acpi_battery_file[i].name,
+	if (!acpi_device_dir(device))
+		return;
+	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i)
+		remove_proc_entry(acpi_battery_file[i].name,
 				  acpi_device_dir(device));
-		}
-		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
-		acpi_device_dir(device) = NULL;
-	}
 
-	return 0;
+	remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
+	acpi_device_dir(device) = NULL;
 }
 
 /* --------------------------------------------------------------------------
@@ -665,14 +584,11 @@ static int acpi_battery_add(struct acpi_device *device)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
-
 	if (!device)
 		return -EINVAL;
-
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
-
 	mutex_init(&battery->lock);
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
@@ -682,7 +598,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
-
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
@@ -691,19 +606,14 @@ static int acpi_battery_add(struct acpi_device *device)
 		result = -ENODEV;
 		goto end;
 	}
-
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 	       device->status.battery_present ? "present" : "absent");
-
       end:
-
 	if (result) {
 		acpi_battery_remove_fs(device);
 		kfree(battery);
 	}
-
-
 	return result;
 }
 
@@ -714,19 +624,13 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-
 	battery = acpi_driver_data(device);
-
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
-
 	acpi_battery_remove_fs(device);
-
 	mutex_destroy(&battery->lock);
-
 	kfree(battery);
-
 	return 0;
 }
 
@@ -741,33 +645,35 @@ static int acpi_battery_resume(struct acpi_device *device)
 	return 0;
 }
 
+static struct acpi_driver acpi_battery_driver = {
+	.name = "battery",
+	.class = ACPI_BATTERY_CLASS,
+	.ids = battery_device_ids,
+	.ops = {
+		.add = acpi_battery_add,
+		.resume = acpi_battery_resume,
+		.remove = acpi_battery_remove,
+		},
+};
+
 static int __init acpi_battery_init(void)
 {
-	int result;
-
 	if (acpi_disabled)
 		return -ENODEV;
-
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_battery_driver);
-	if (result < 0) {
+	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
 		acpi_unlock_battery_dir(acpi_battery_dir);
 		return -ENODEV;
 	}
-
 	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-
 	acpi_unlock_battery_dir(acpi_battery_dir);
-
-	return;
 }
 
 module_init(acpi_battery_init);



--------------080008030608030701070806--
