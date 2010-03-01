From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/9] ACPI: replace acpi_integer by u64
Date: Mon, 01 Mar 2010 01:56:18 -0500
Message-ID: <439913fffd39374c3737186b22d2d56c3a0ae526.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56497 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0CAG4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:23 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL00F0DCLY9254@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:56:23 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

acpi_integer is now obsolete and removed from the ACPICA code base,
replaced by u64.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/hp/common/aml_nfw.c             |    6 ++--
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    6 ++--
 drivers/acpi/battery.c                    |    4 +-
 drivers/acpi/ec.c                         |    4 +-
 drivers/acpi/glue.c                       |    4 +-
 drivers/acpi/osl.c                        |    4 +-
 drivers/acpi/power_meter.c                |   30 ++++++++++----------
 drivers/acpi/processor_idle.c             |    2 +-
 drivers/acpi/processor_throttling.c       |   24 ++++++++--------
 drivers/acpi/utils.c                      |   16 +++++-----
 drivers/acpi/video.c                      |    2 +-
 drivers/ata/libata-acpi.c                 |    4 +-
 drivers/ide/ide-acpi.c                    |    8 +++---
 drivers/input/misc/atlas_btns.c           |    2 +-
 drivers/pci/pci-acpi.c                    |    2 +-
 drivers/platform/x86/toshiba_bluetooth.c  |    4 +-
 drivers/platform/x86/wmi.c                |    4 +-
 include/acpi/acpi_bus.h                   |    6 ++--
 include/acpi/processor.h                  |   42 ++++++++++++++--------------
 19 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/arch/ia64/hp/common/aml_nfw.c b/arch/ia64/hp/common/aml_nfw.c
index 4abd2c7..2207848 100644
--- a/arch/ia64/hp/common/aml_nfw.c
+++ b/arch/ia64/hp/common/aml_nfw.c
@@ -77,7 +77,7 @@ static void aml_nfw_execute(struct ia64_nfw_context *c)
 		     c->arg[4], c->arg[5], c->arg[6], c->arg[7]);
 }
 
-static void aml_nfw_read_arg(u8 *offset, u32 bit_width, acpi_integer *value)
+static void aml_nfw_read_arg(u8 *offset, u32 bit_width, u64 *value)
 {
 	switch (bit_width) {
 	case 8:
@@ -95,7 +95,7 @@ static void aml_nfw_read_arg(u8 *offset, u32 bit_width, acpi_integer *value)
 	}
 }
 
-static void aml_nfw_write_arg(u8 *offset, u32 bit_width, acpi_integer *value)
+static void aml_nfw_write_arg(u8 *offset, u32 bit_width, u64 *value)
 {
 	switch (bit_width) {
 	case 8:
@@ -114,7 +114,7 @@ static void aml_nfw_write_arg(u8 *offset, u32 bit_width, acpi_integer *value)
 }
 
 static acpi_status aml_nfw_handler(u32 function, acpi_physical_address address,
-	u32 bit_width, acpi_integer *value, void *handler_context,
+	u32 bit_width, u64 *value, void *handler_context,
 	void *region_context)
 {
 	struct ia64_nfw_context *context = handler_context;
diff --git a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
index f125e5c..55d42bc 100644
--- a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
@@ -806,7 +806,7 @@ static int find_psb_table(struct powernow_k8_data *data)
 static void powernow_k8_acpi_pst_values(struct powernow_k8_data *data,
 		unsigned int index)
 {
-	acpi_integer control;
+	u64 control;
 
 	if (!data->acpi_data.state_count || (cpu_family == CPU_HW_PSTATE))
 		return;
@@ -824,7 +824,7 @@ static int powernow_k8_cpu_init_acpi(struct powernow_k8_data *data)
 {
 	struct cpufreq_frequency_table *powernow_table;
 	int ret_val = -ENODEV;
-	acpi_integer control, status;
+	u64 control, status;
 
 	if (acpi_processor_register_performance(&data->acpi_data, data->cpu)) {
 		dprintk("register performance failed: bad ACPI data\n");
@@ -948,7 +948,7 @@ static int fill_powernow_table_fidvid(struct powernow_k8_data *data,
 		u32 fid;
 		u32 vid;
 		u32 freq, index;
-		acpi_integer status, control;
+		u64 status, control;
 
 		if (data->exttype) {
 			status =  data->acpi_data.states[i].status;
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cada73f..58d2c91 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -324,8 +324,8 @@ static int extract_package(struct acpi_battery *battery,
 				strncpy(ptr, element->string.pointer, 32);
 			else if (element->type == ACPI_TYPE_INTEGER) {
 				strncpy(ptr, (u8 *)&element->integer.value,
-					sizeof(acpi_integer));
-				ptr[sizeof(acpi_integer)] = 0;
+					sizeof(u64));
+				ptr[sizeof(u64)] = 0;
 			} else
 				*ptr = 0; /* don't have value */
 		} else {
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d6471bb..748ced8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -589,7 +589,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 
 static acpi_status
 acpi_ec_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, acpi_integer *value,
+		      u32 bits, u64 *value,
 		      void *handler_context, void *region_context)
 {
 	struct acpi_ec *ec = handler_context;
@@ -620,7 +620,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		++address;
 		if (function == ACPI_READ) {
 			result = acpi_ec_read(ec, address, &temp);
-			(*value) |= ((acpi_integer)temp) << i;
+			(*value) |= ((u64)temp) << i;
 		} else {
 			temp = 0xff & ((*value) >> i);
 			result = acpi_ec_write(ec, address, temp);
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 4c8fcff..6d5b64b 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -87,7 +87,7 @@ static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
 	acpi_handle handle;
-	acpi_integer address;
+	u64 address;
 };
 
 static acpi_status
@@ -106,7 +106,7 @@ do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
-acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address)
+acpi_handle acpi_get_child(acpi_handle parent, u64 address)
 {
 	struct acpi_find_child find = { NULL, address };
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 02e8464..8e6d866 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -436,7 +436,7 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
  * Running in interpreter thread context, safe to sleep
  */
 
-void acpi_os_sleep(acpi_integer ms)
+void acpi_os_sleep(u64 ms)
 {
 	schedule_timeout_interruptible(msecs_to_jiffies(ms));
 }
@@ -603,7 +603,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
-				acpi_integer value, u32 width)
+				u64 value, u32 width)
 {
 	int result, size;
 
diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
index dc4ffad..834c5af 100644
--- a/drivers/acpi/power_meter.c
+++ b/drivers/acpi/power_meter.c
@@ -71,17 +71,17 @@ static const struct acpi_device_id power_meter_ids[] = {
 MODULE_DEVICE_TABLE(acpi, power_meter_ids);
 
 struct acpi_power_meter_capabilities {
-	acpi_integer		flags;
-	acpi_integer		units;
-	acpi_integer		type;
-	acpi_integer		accuracy;
-	acpi_integer		sampling_time;
-	acpi_integer		min_avg_interval;
-	acpi_integer		max_avg_interval;
-	acpi_integer		hysteresis;
-	acpi_integer		configurable_cap;
-	acpi_integer		min_cap;
-	acpi_integer		max_cap;
+	u64		flags;
+	u64		units;
+	u64		type;
+	u64		accuracy;
+	u64		sampling_time;
+	u64		min_avg_interval;
+	u64		max_avg_interval;
+	u64		hysteresis;
+	u64		configurable_cap;
+	u64		min_cap;
+	u64		max_cap;
 };
 
 struct acpi_power_meter_resource {
@@ -93,9 +93,9 @@ struct acpi_power_meter_resource {
 	acpi_string		model_number;
 	acpi_string		serial_number;
 	acpi_string		oem_info;
-	acpi_integer		power;
-	acpi_integer		cap;
-	acpi_integer		avg_interval;
+	u64		power;
+	u64		cap;
+	u64		avg_interval;
 	int			sensors_valid;
 	unsigned long		sensors_last_updated;
 	struct sensor_device_attribute	sensors[NUM_SENSORS];
@@ -402,7 +402,7 @@ static ssize_t show_val(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	acpi_integer val = 0;
+	u64 val = 0;
 
 	switch (attr->index) {
 	case 0:
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7c0441f..3455d7a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -352,7 +352,7 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
-	acpi_integer count;
+	u64 count;
 	int current_count;
 	int i;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 1c5d7a8..7ded754 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -660,7 +660,7 @@ static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 
 #ifdef CONFIG_X86
 static int acpi_throttling_rdmsr(struct acpi_processor *pr,
-					acpi_integer * value)
+					u64 *value)
 {
 	struct cpuinfo_x86 *c;
 	u64 msr_high, msr_low;
@@ -681,13 +681,13 @@ static int acpi_throttling_rdmsr(struct acpi_processor *pr,
 		rdmsr_safe(MSR_IA32_THERM_CONTROL,
 			(u32 *)&msr_low , (u32 *) &msr_high);
 		msr = (msr_high << 32) | msr_low;
-		*value = (acpi_integer) msr;
+		*value = (u64) msr;
 		ret = 0;
 	}
 	return ret;
 }
 
-static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
+static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
 {
 	struct cpuinfo_x86 *c;
 	unsigned int cpu;
@@ -711,14 +711,14 @@ static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
 }
 #else
 static int acpi_throttling_rdmsr(struct acpi_processor *pr,
-				acpi_integer * value)
+				u64 *value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
 
-static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
+static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
@@ -727,7 +727,7 @@ static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
 #endif
 
 static int acpi_read_throttling_status(struct acpi_processor *pr,
-					acpi_integer *value)
+					u64 *value)
 {
 	u32 bit_width, bit_offset;
 	u64 ptc_value;
@@ -746,7 +746,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 				  address, (u32 *) &ptc_value,
 				  (u32) (bit_width + bit_offset));
 		ptc_mask = (1 << bit_width) - 1;
-		*value = (acpi_integer) ((ptc_value >> bit_offset) & ptc_mask);
+		*value = (u64) ((ptc_value >> bit_offset) & ptc_mask);
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
@@ -760,7 +760,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 }
 
 static int acpi_write_throttling_state(struct acpi_processor *pr,
-				acpi_integer value)
+				u64 value)
 {
 	u32 bit_width, bit_offset;
 	u64 ptc_value;
@@ -793,7 +793,7 @@ static int acpi_write_throttling_state(struct acpi_processor *pr,
 }
 
 static int acpi_get_throttling_state(struct acpi_processor *pr,
-				acpi_integer value)
+				u64 value)
 {
 	int i;
 
@@ -808,7 +808,7 @@ static int acpi_get_throttling_state(struct acpi_processor *pr,
 }
 
 static int acpi_get_throttling_value(struct acpi_processor *pr,
-			int state, acpi_integer *value)
+			int state, u64 *value)
 {
 	int ret = -1;
 
@@ -826,7 +826,7 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 {
 	int state = 0;
 	int ret;
-	acpi_integer value;
+	u64 value;
 
 	if (!pr)
 		return -EINVAL;
@@ -993,7 +993,7 @@ static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
 					     int state, bool force)
 {
 	int ret;
-	acpi_integer value;
+	u64 value;
 
 	if (!pr)
 		return -EINVAL;
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 811fec1..11882db 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -107,12 +107,12 @@ acpi_extract_package(union acpi_object *package,
 		case ACPI_TYPE_INTEGER:
 			switch (format_string[i]) {
 			case 'N':
-				size_required += sizeof(acpi_integer);
-				tail_offset += sizeof(acpi_integer);
+				size_required += sizeof(u64);
+				tail_offset += sizeof(u64);
 				break;
 			case 'S':
 				size_required +=
-				    sizeof(char *) + sizeof(acpi_integer) +
+				    sizeof(char *) + sizeof(u64) +
 				    sizeof(char);
 				tail_offset += sizeof(char *);
 				break;
@@ -193,17 +193,17 @@ acpi_extract_package(union acpi_object *package,
 		case ACPI_TYPE_INTEGER:
 			switch (format_string[i]) {
 			case 'N':
-				*((acpi_integer *) head) =
+				*((u64 *) head) =
 				    element->integer.value;
-				head += sizeof(acpi_integer);
+				head += sizeof(u64);
 				break;
 			case 'S':
 				pointer = (u8 **) head;
 				*pointer = tail;
-				*((acpi_integer *) tail) =
+				*((u64 *) tail) =
 				    element->integer.value;
-				head += sizeof(acpi_integer *);
-				tail += sizeof(acpi_integer);
+				head += sizeof(u64 *);
+				tail += sizeof(u64);
 				/* NULL terminate string */
 				*tail = (char)0;
 				tail += sizeof(char);
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b765790..6e9b491 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -759,7 +759,7 @@ acpi_video_bus_POST_options(struct acpi_video_bus *video,
 static int
 acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
 {
-	acpi_integer status = 0;
+	u64 status = 0;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 1245838..292fdbc 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -64,7 +64,7 @@ void ata_acpi_associate_sata_port(struct ata_port *ap)
 	WARN_ON(!(ap->flags & ATA_FLAG_ACPI_SATA));
 
 	if (!sata_pmp_attached(ap)) {
-		acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
+		u64 adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
 
 		ap->link.device->acpi_handle =
 			acpi_get_child(ap->host->acpi_handle, adr);
@@ -74,7 +74,7 @@ void ata_acpi_associate_sata_port(struct ata_port *ap)
 		ap->link.device->acpi_handle = NULL;
 
 		ata_for_each_link(link, ap, EDGE) {
-			acpi_integer adr = SATA_ADR(ap->port_no, link->pmp);
+			u64 adr = SATA_ADR(ap->port_no, link->pmp);
 
 			link->device->acpi_handle =
 				acpi_get_child(ap->host->acpi_handle, adr);
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index c0cf45a..5cb01e5 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -108,11 +108,11 @@ bool ide_port_acpi(ide_hwif_t *hwif)
  * Returns 0 on success, <0 on error.
  */
 static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
-			       acpi_integer *pcidevfn)
+			       u64 *pcidevfn)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned int bus, devnum, func;
-	acpi_integer addr;
+	u64 addr;
 	acpi_handle dev_handle;
 	acpi_status status;
 	struct acpi_device_info	*dinfo = NULL;
@@ -122,7 +122,7 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 	devnum = PCI_SLOT(pdev->devfn);
 	func = PCI_FUNC(pdev->devfn);
 	/* ACPI _ADR encoding for PCI bus: */
-	addr = (acpi_integer)(devnum << 16 | func);
+	addr = (u64)(devnum << 16 | func);
 
 	DEBPRINT("ENTER: pci %02x:%02x.%01x\n", bus, devnum, func);
 
@@ -169,7 +169,7 @@ static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
 {
 	struct device		*dev = hwif->gendev.parent;
 	acpi_handle		uninitialized_var(dev_handle);
-	acpi_integer		pcidevfn;
+	u64			pcidevfn;
 	acpi_handle		chan_handle;
 	int			err;
 
diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 1b87191..dfaa9a0 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -47,7 +47,7 @@ static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
 
 static acpi_status acpi_atlas_button_handler(u32 function,
 		      acpi_physical_address address,
-		      u32 bit_width, acpi_integer *value,
+		      u32 bit_width, u64 *value,
 		      void *handler_context, void *region_context)
 {
 	acpi_status status;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7e28295..441326c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -143,7 +143,7 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct pci_dev * pci_dev;
-	acpi_integer	addr;
+	u64	addr;
 
 	pci_dev = to_pci_dev(dev);
 	/* Please ref to ACPI spec for the syntax of _ADR */
diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index a350418..9440686 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -57,7 +57,7 @@ static struct acpi_driver toshiba_bt_rfkill_driver = {
 static int toshiba_bluetooth_enable(acpi_handle handle)
 {
 	acpi_status res1, res2;
-	acpi_integer result;
+	u64 result;
 
 	/*
 	 * Query ACPI to verify RFKill switch is set to 'on'.
@@ -95,7 +95,7 @@ static int toshiba_bt_resume(struct acpi_device *device)
 static int toshiba_bt_rfkill_add(struct acpi_device *device)
 {
 	acpi_status status;
-	acpi_integer bt_present;
+	u64 bt_present;
 	int result = -ENODEV;
 
 	/*
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index b104302..09e9918 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -796,7 +796,7 @@ static __init acpi_status parse_wdg(acpi_handle handle)
  */
 static acpi_status
 acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, acpi_integer * value,
+		      u32 bits, u64 *value,
 		      void *handler_context, void *region_context)
 {
 	int result = 0, i = 0;
@@ -813,7 +813,7 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 
 	if (function == ACPI_READ) {
 		result = ec_read(address, &temp);
-		(*value) |= ((acpi_integer)temp) << i;
+		(*value) |= ((u64)temp) << i;
 	} else {
 		temp = 0xff & ((*value) >> i);
 		result = ec_write(address, temp);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3cd9ccd..71c105c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -250,8 +250,8 @@ struct acpi_device_wakeup_state {
 
 struct acpi_device_wakeup {
 	acpi_handle gpe_device;
-	acpi_integer gpe_number;
-	acpi_integer sleep_state;
+	u64 gpe_number;
+	u64 sleep_state;
 	struct acpi_handle_list resources;
 	struct acpi_device_wakeup_state state;
 	struct acpi_device_wakeup_flags flags;
@@ -380,7 +380,7 @@ struct acpi_pci_root {
 };
 
 /* helper */
-acpi_handle acpi_get_child(acpi_handle, acpi_integer);
+acpi_handle acpi_get_child(acpi_handle, u64);
 int acpi_is_root_bridge(acpi_handle);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 0ea5ef4..2983176 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -92,11 +92,11 @@ struct acpi_processor_power {
 /* Performance Management */
 
 struct acpi_psd_package {
-	acpi_integer num_entries;
-	acpi_integer revision;
-	acpi_integer domain;
-	acpi_integer coord_type;
-	acpi_integer num_processors;
+	u64 num_entries;
+	u64 revision;
+	u64 domain;
+	u64 coord_type;
+	u64 num_processors;
 } __attribute__ ((packed));
 
 struct acpi_pct_register {
@@ -110,12 +110,12 @@ struct acpi_pct_register {
 } __attribute__ ((packed));
 
 struct acpi_processor_px {
-	acpi_integer core_frequency;	/* megahertz */
-	acpi_integer power;	/* milliWatts */
-	acpi_integer transition_latency;	/* microseconds */
-	acpi_integer bus_master_latency;	/* microseconds */
-	acpi_integer control;	/* control value */
-	acpi_integer status;	/* success indicator */
+	u64 core_frequency;	/* megahertz */
+	u64 power;	/* milliWatts */
+	u64 transition_latency;	/* microseconds */
+	u64 bus_master_latency;	/* microseconds */
+	u64 control;	/* control value */
+	u64 status;	/* success indicator */
 };
 
 struct acpi_processor_performance {
@@ -133,11 +133,11 @@ struct acpi_processor_performance {
 /* Throttling Control */
 
 struct acpi_tsd_package {
-	acpi_integer num_entries;
-	acpi_integer revision;
-	acpi_integer domain;
-	acpi_integer coord_type;
-	acpi_integer num_processors;
+	u64 num_entries;
+	u64 revision;
+	u64 domain;
+	u64 coord_type;
+	u64 num_processors;
 } __attribute__ ((packed));
 
 struct acpi_ptc_register {
@@ -151,11 +151,11 @@ struct acpi_ptc_register {
 } __attribute__ ((packed));
 
 struct acpi_processor_tx_tss {
-	acpi_integer freqpercentage;	/* */
-	acpi_integer power;	/* milliWatts */
-	acpi_integer transition_latency;	/* microseconds */
-	acpi_integer control;	/* control value */
-	acpi_integer status;	/* success indicator */
+	u64 freqpercentage;	/* */
+	u64 power;	/* milliWatts */
+	u64 transition_latency;	/* microseconds */
+	u64 control;	/* control value */
+	u64 status;	/* success indicator */
 };
 struct acpi_processor_tx {
 	u16 power;
-- 
1.6.0.6

