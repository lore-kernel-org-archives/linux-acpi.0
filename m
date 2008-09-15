From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] acpiphp: Match the variable types for ia64
Date: Mon, 15 Sep 2008 12:45:09 -0600
Message-ID: <20080915184509.GA29454@parisc-linux.org>
References: <200510232100.j9NL0MWA030225@shell0.pdx.osdl.net> <20080910002011.GF2772@parisc-linux.org> <20080910074940.GA12737@ldl.fc.hp.com> <200809101103.55222.jbarnes@virtuousgeek.org> <B57D568CB82B0C4B897F9CD9862DE8B733A328DF9E@GVW1097EXB.americas.hpqcorp.net> <20080911104345.GL2772@parisc-linux.org> <B57D568CB82B0C4B897F9CD9862DE8B733A328E8E0@GVW1097EXB.americas.hpqcorp.net> <20080912183213.GH10844@parisc-linux.org> <4911F71203A09E4D9981D27F9D8308584E454A@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:56163 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbYIOSp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2008 14:45:26 -0400
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308584E454A@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Chen, Justin" <justin.chen@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chiang, Alexander" <achiang@hp.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

On Fri, Sep 12, 2008 at 12:12:42PM -0700, Moore, Robert wrote:
> This is not an ACPICA interface, it is local to Linux (drivers/acpi/utils.c)
> 
> It should be a pointer to a 64-bit number always. acpi_integer * works well.

Thanks, Bob.

Len, could you drop this patch into your testing?  It compiles without
warnings for me, but I'll admit to not having test-booted.

----

[PATCH] Change acpi_evaluate_integer to support 64-bit on 32-bit kernels

As of version 2.0, ACPI can return 64-bit integers.  The current
acpi_evaluate_integer only supports 64-bit integers on 64-bit platforms.
Change the argument to take a pointer to an acpi_integer so we support
64-bit integers on all platforms.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 6568942..1a8440c 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -232,7 +232,7 @@ exit:
 static unsigned int
 get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
 {
-	unsigned long adr;
+	acpi_integer adr;
 	acpi_handle child;
 	unsigned int devfn;
 	int function;
@@ -292,8 +292,8 @@ get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
 static acpi_status
 find_matching_device(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	unsigned long bbn = -1;
-	unsigned long adr;
+	acpi_integer bbn = -1;
+	acpi_integer adr;
 	acpi_handle parent = NULL;
 	acpi_status status;
 	unsigned int devfn;
@@ -348,7 +348,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
 	unsigned int host_devfn;
 	struct sn_pcidev_match pcidev_match;
 	acpi_handle rootbus_handle;
-	unsigned long segment;
+	acpi_integer segment;
 	acpi_status status;
 
 	rootbus_handle = PCI_CONTROLLER(dev)->acpi_handle;
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 831883b..091a2f0 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -85,7 +85,7 @@ struct acpi_ac {
 	struct power_supply charger;
 #endif
 	struct acpi_device * device;
-	unsigned long state;
+	acpi_integer state;
 };
 
 #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 5f1127a..fe46301 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -194,8 +194,7 @@ acpi_memory_get_device(acpi_handle handle,
 
 static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
 {
-	unsigned long current_status;
-
+	acpi_integer current_status;
 
 	/* Get device present/absent information from the _STA */
 	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->device->handle, "_STA",
@@ -264,7 +263,7 @@ static int acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)
 	acpi_status status;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
-	unsigned long current_status;
+	acpi_integer current_status;
 
 
 	/* Issue the _EJ0 command */
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index d3d0886..6e14452 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -753,7 +753,7 @@ static int get_lcd_state(void)
 			/* That's what the AML code does */
 			lcd = out_obj.integer.value >> 8;
 	} else if (hotk->model == F3Sa) {
-		unsigned long tmp;
+		acpi_integer tmp;
 		union acpi_object param;
 		struct acpi_object_list input;
 		acpi_status status;
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 61b6c5b..1b382f3 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -90,7 +90,7 @@ static int is_ejectable(acpi_handle handle)
  */
 static int bay_present(struct bay *bay)
 {
-	unsigned long sta;
+	acpi_integer sta;
 	acpi_status status;
 
 	if (bay) {
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ccae305..8b27ca2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -77,7 +77,7 @@ EXPORT_SYMBOL(acpi_bus_get_device);
 int acpi_bus_get_status(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
-	unsigned long sta = 0;
+	acpi_integer sta = 0;
 
 
 	if (!device)
@@ -155,7 +155,7 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_device *device = NULL;
-	unsigned long psc = 0;
+	acpi_integer psc = 0;
 
 
 	result = acpi_bus_get_device(handle, &device);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1dfec41..aab2934 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -145,7 +145,7 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_button *button = seq->private;
 	acpi_status status;
-	unsigned long state;
+	acpi_integer state;
 
 	if (!button || !button->device)
 		return 0;
@@ -253,7 +253,7 @@ static int acpi_button_remove_fs(struct acpi_device *device)
    -------------------------------------------------------------------------- */
 static int acpi_lid_send_state(struct acpi_button *button)
 {
-	unsigned long state;
+	acpi_integer state;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL,
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 3c25ec7..3337669 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -76,7 +76,7 @@ static int is_device_present(acpi_handle handle)
 {
 	acpi_handle temp;
 	acpi_status status;
-	unsigned long sta;
+	acpi_integer sta;
 
 
 	status = acpi_get_handle(handle, "_STA", &temp);
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7d2edf1..3ff3506 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -229,7 +229,7 @@ EXPORT_SYMBOL_GPL(is_dock_device);
  */
 static int dock_present(struct dock_station *ds)
 {
-	unsigned long sta;
+	acpi_integer sta;
 	acpi_status status;
 
 	if (ds) {
@@ -727,13 +727,13 @@ static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
 static ssize_t show_dock_uid(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	unsigned long lbuf;
+	acpi_integer lbuf;
 	acpi_status status = acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
 	    return 0;
 
-	return snprintf(buf, PAGE_SIZE, "%lx\n", lbuf);
+	return snprintf(buf, PAGE_SIZE, "%llx\n", lbuf);
 }
 static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13593f9..2eade21 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -718,6 +718,7 @@ static acpi_status
 ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 {
 	acpi_status status;
+	acpi_integer tmp;
 
 	struct acpi_ec *ec = context;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
@@ -727,11 +728,13 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 
 	/* Get GPE bit assignment (EC events). */
 	/* TODO: Add support for _GPE returning a package */
-	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return status;
+	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
+	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
+	ec->global_lock = tmp;
 	ec->handle = handle;
 	return AE_CTRL_TERMINATE;
 }
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index cb9864e..4c79d1e 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -258,7 +258,7 @@ int __init acpi_numa_init(void)
 
 int acpi_get_pxm(acpi_handle h)
 {
-	unsigned long pxm;
+	acpi_integer pxm;
 	acpi_status status;
 	acpi_handle handle;
 	acpi_handle phandle = h;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..574f404 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -608,7 +608,7 @@ static void acpi_os_derive_pci_id_2(acpi_handle rhandle,	/* upper bound  */
 	acpi_handle handle;
 	struct acpi_pci_id *pci_id = *id;
 	acpi_status status;
-	unsigned long temp;
+	acpi_integer temp;
 	acpi_object_type type;
 
 	acpi_get_parent(chandle, &handle);
@@ -620,8 +620,7 @@ static void acpi_os_derive_pci_id_2(acpi_handle rhandle,	/* upper bound  */
 		if ((ACPI_FAILURE(status)) || (type != ACPI_TYPE_DEVICE))
 			return;
 
-		status =
-		    acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
+		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
 					  &temp);
 		if (ACPI_SUCCESS(status)) {
 			u32 val;
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c3fed31..a4577ca 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -190,7 +190,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	struct acpi_pci_root *root = NULL;
 	struct acpi_pci_root *tmp;
 	acpi_status status = AE_OK;
-	unsigned long value = 0;
+	acpi_integer value = 0;
 	acpi_handle handle = NULL;
 	struct acpi_device *child;
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index d5b4ef8..769a06a 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -76,10 +76,10 @@ static struct acpi_pci_driver acpi_pci_slot_driver = {
 };
 
 static int
-check_slot(acpi_handle handle, unsigned long *sun)
+check_slot(acpi_handle handle, acpi_integer *sun)
 {
 	int device = -1;
-	unsigned long adr, sta;
+	acpi_integer adr, sta;
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
@@ -132,7 +132,7 @@ static acpi_status
 register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	int device;
-	unsigned long sun;
+	acpi_integer sun;
 	char name[SLOT_NAME_SIZE];
 	struct acpi_pci_slot *slot;
 	struct pci_slot *pci_slot;
@@ -182,7 +182,7 @@ static acpi_status
 walk_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	int device, function;
-	unsigned long adr;
+	acpi_integer adr;
 	acpi_status status;
 	acpi_handle dummy_handle;
 	acpi_walk_callback user_function;
@@ -239,7 +239,7 @@ static int
 walk_root_bridge(acpi_handle handle, acpi_walk_callback user_function)
 {
 	int seg, bus;
-	unsigned long tmp;
+	acpi_integer tmp;
 	acpi_status status;
 	acpi_handle dummy_handle;
 	struct pci_bus *pci_bus;
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4ab21cb..8475fa0 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -131,7 +131,7 @@ acpi_power_get_context(acpi_handle handle,
 static int acpi_power_get_state(struct acpi_power_resource *resource, int *state)
 {
 	acpi_status status = AE_OK;
-	unsigned long sta = 0;
+	acpi_integer sta = 0;
 
 
 	if (!resource || !state)
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ee68ac5..cf5d9e5 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -563,7 +563,7 @@ static int acpi_processor_get_info(struct acpi_processor *pr, unsigned has_uid)
 
 	/* Check if it is a Device with HID and UID */
 	if (has_uid) {
-		unsigned long value;
+		acpi_integer value;
 		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
 						NULL, &value);
 		if (ACPI_FAILURE(status)) {
@@ -875,7 +875,7 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 static int is_processor_present(acpi_handle handle)
 {
 	acpi_status status;
-	unsigned long sta = 0;
+	acpi_integer sta = 0;
 
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 80c251e..66de7cb 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -126,7 +126,7 @@ static struct notifier_block acpi_ppc_notifier_block = {
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
-	unsigned long ppc = 0;
+	acpi_integer ppc = 0;
 
 
 	if (!pr)
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a56fc6c..628f981 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -274,7 +274,7 @@ static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
-	unsigned long tpc = 0;
+	acpi_integer tpc = 0;
 
 	if (!pr)
 		return -EINVAL;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index a4e3767..9e23dbe 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -258,7 +258,7 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 static int acpi_smbus_hc_add(struct acpi_device *device)
 {
 	int status;
-	unsigned long val;
+	acpi_integer val;
 	struct acpi_smb_hc *hc;
 
 	if (!device)
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index d13194a..621ea0c 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -444,7 +444,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
 	struct acpi_device *adev;
 	char acpi_method[] = "_SxD";
-	unsigned long d_min, d_max;
+	acpi_integer d_min, d_max;
 
 	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
 		printk(KERN_DEBUG "ACPI handle has no context!\n");
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9127036..0a0671c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -246,18 +246,18 @@ static const struct file_operations acpi_thermal_polling_fops = {
 static int acpi_thermal_get_temperature(struct acpi_thermal *tz)
 {
 	acpi_status status = AE_OK;
-
+	acpi_integer tmp;
 
 	if (!tz)
 		return -EINVAL;
 
 	tz->last_temperature = tz->temperature;
 
-	status =
-	    acpi_evaluate_integer(tz->device->handle, "_TMP", NULL, &tz->temperature);
+	status = acpi_evaluate_integer(tz->device->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	tz->temperature = tmp;
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n",
 			  tz->temperature));
 
@@ -267,17 +267,16 @@ static int acpi_thermal_get_temperature(struct acpi_thermal *tz)
 static int acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
 {
 	acpi_status status = AE_OK;
-
+	acpi_integer tmp;
 
 	if (!tz)
 		return -EINVAL;
 
-	status =
-	    acpi_evaluate_integer(tz->device->handle, "_TZP", NULL,
-				  &tz->polling_frequency);
+	status = acpi_evaluate_integer(tz->device->handle, "_TZP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	tz->polling_frequency = tmp;
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Polling frequency is %lu dS\n",
 			  tz->polling_frequency));
 
@@ -356,6 +355,7 @@ do {	\
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status = AE_OK;
+	acpi_integer tmp;
 	struct acpi_handle_list devices;
 	int valid = 0;
 	int i;
@@ -363,7 +363,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	/* Critical Shutdown (required) */
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle,
-				"_CRT", NULL, &tz->trips.critical.temperature);
+				"_CRT", NULL, &tmp);
 		/*
 		 * Treat freezing temperatures as invalid as well; some
 		 * BIOSes return really low values and cause reboots at startup.
@@ -377,6 +377,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					"No or invalid critical threshold"));
 			return -ENODEV;
 		} else {
+			tz->trips.critical.temperature = tmp;
 			tz->trips.critical.flags.valid = 1;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					"Found critical threshold [%lu]\n",
@@ -399,12 +400,13 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	/* Critical Sleep (optional) */
 	if (flag & ACPI_TRIPS_HOT) {
 		status = acpi_evaluate_integer(tz->device->handle,
-				"_HOT", NULL, &tz->trips.hot.temperature);
+				"_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
 			tz->trips.hot.flags.valid = 0;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					"No hot threshold\n"));
 		} else {
+			tz->trips.hot.temperature = tmp;
 			tz->trips.hot.flags.valid = 1;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					"Found hot threshold [%lu]\n",
@@ -418,33 +420,40 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tz->trips.passive.temperature = CELSIUS_TO_KELVIN(psv);
+			tmp = CELSIUS_TO_KELVIN(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
-				"_PSV", NULL, &tz->trips.passive.temperature);
+				"_PSV", NULL, &tmp);
 		}
 
 		if (ACPI_FAILURE(status))
 			tz->trips.passive.flags.valid = 0;
 		else {
+			tz->trips.passive.temperature = tmp;
 			tz->trips.passive.flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC1",
-						NULL, &tz->trips.passive.tc1);
+						NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
+				else
+					tz->trips.passive.tc1 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC2",
-						NULL, &tz->trips.passive.tc2);
+						NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
+				else
+					tz->trips.passive.tc2 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TSP",
-						NULL, &tz->trips.passive.tsp);
+						NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
+				else
+					tz->trips.passive.tsp = tmp;
 			}
 		}
 	}
@@ -479,7 +488,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 		if (flag & ACPI_TRIPS_ACTIVE) {
 			status = acpi_evaluate_integer(tz->device->handle,
-				name, NULL, &tz->trips.active[i].temperature);
+							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
 				tz->trips.active[i].flags.valid = 0;
 				if (i == 0)
@@ -500,8 +509,10 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 						tz->trips.active[i - 2].temperature :
 						CELSIUS_TO_KELVIN(act));
 				break;
-			} else
+			} else {
+				tz->trips.active[i].temperature = tmp;
 				tz->trips.active[i].flags.valid = 1;
+			}
 		}
 
 		name[2] = 'L';
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 1009261..b0a87df 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -256,7 +256,7 @@ EXPORT_SYMBOL(acpi_extract_package);
 acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
-		      struct acpi_object_list *arguments, unsigned long *data)
+		      struct acpi_object_list *arguments, acpi_integer *data)
 {
 	acpi_status status = AE_OK;
 	union acpi_object *element;
@@ -288,7 +288,7 @@ acpi_evaluate_integer(acpi_handle handle,
 	*data = element->integer.value;
 	kfree(element);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%lu]\n", *data));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));
 
 	return AE_OK;
 }
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e8a51a1..e5cdd95 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -291,20 +291,20 @@ static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
 static int acpi_video_device_lcd_get_level_current(
 			struct acpi_video_device *device,
-			unsigned long *level);
+			acpi_integer *level);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 static int acpi_video_device_get_state(struct acpi_video_device *device,
-			    unsigned long *state);
+			    acpi_integer *state);
 static int acpi_video_output_get(struct output_device *od);
 static int acpi_video_device_set_state(struct acpi_video_device *device, int state);
 
 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
 {
-	unsigned long cur_level;
+	acpi_integer cur_level;
 	int i;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
@@ -336,7 +336,7 @@ static struct backlight_ops acpi_backlight_ops = {
 /*video output device sysfs support*/
 static int acpi_video_output_get(struct output_device *od)
 {
-	unsigned long state;
+	acpi_integer state;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)dev_get_drvdata(&od->dev);
 	acpi_video_device_get_state(vd, &state);
@@ -370,7 +370,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
-	unsigned long level;
+	acpi_integer level;
 	int state;
 
 	acpi_video_device_lcd_get_level_current(video, &level);
@@ -410,7 +410,7 @@ static struct thermal_cooling_device_ops video_cooling_ops = {
 /* device */
 
 static int
-acpi_video_device_query(struct acpi_video_device *device, unsigned long *state)
+acpi_video_device_query(struct acpi_video_device *device, acpi_integer *state)
 {
 	int status;
 
@@ -421,7 +421,7 @@ acpi_video_device_query(struct acpi_video_device *device, unsigned long *state)
 
 static int
 acpi_video_device_get_state(struct acpi_video_device *device,
-			    unsigned long *state)
+			    acpi_integer *state)
 {
 	int status;
 
@@ -436,7 +436,7 @@ acpi_video_device_set_state(struct acpi_video_device *device, int state)
 	int status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
-	unsigned long ret;
+	acpi_integer ret;
 
 
 	arg0.integer.value = state;
@@ -495,7 +495,7 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 
 static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
-					unsigned long *level)
+					acpi_integer *level)
 {
 	if (device->cap._BQC)
 		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
@@ -549,7 +549,7 @@ static int
 acpi_video_bus_set_POST(struct acpi_video_bus *video, unsigned long option)
 {
 	int status;
-	unsigned long tmp;
+	acpi_integer tmp;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
@@ -564,7 +564,7 @@ acpi_video_bus_set_POST(struct acpi_video_bus *video, unsigned long option)
 }
 
 static int
-acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long *id)
+acpi_video_bus_get_POST(struct acpi_video_bus *video, acpi_integer *id)
 {
 	int status;
 
@@ -575,7 +575,7 @@ acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long *id)
 
 static int
 acpi_video_bus_POST_options(struct acpi_video_bus *video,
-			    unsigned long *options)
+			    acpi_integer *options)
 {
 	int status;
 
@@ -918,7 +918,7 @@ static int acpi_video_device_state_seq_show(struct seq_file *seq, void *offset)
 {
 	int status;
 	struct acpi_video_device *dev = seq->private;
-	unsigned long state;
+	acpi_integer state;
 
 
 	if (!dev)
@@ -927,14 +927,14 @@ static int acpi_video_device_state_seq_show(struct seq_file *seq, void *offset)
 	status = acpi_video_device_get_state(dev, &state);
 	seq_printf(seq, "state:     ");
 	if (ACPI_SUCCESS(status))
-		seq_printf(seq, "0x%02lx\n", state);
+		seq_printf(seq, "0x%02llx\n", state);
 	else
 		seq_printf(seq, "<not supported>\n");
 
 	status = acpi_video_device_query(dev, &state);
 	seq_printf(seq, "query:     ");
 	if (ACPI_SUCCESS(status))
-		seq_printf(seq, "0x%02lx\n", state);
+		seq_printf(seq, "0x%02llx\n", state);
 	else
 		seq_printf(seq, "<not supported>\n");
 
@@ -1217,7 +1217,7 @@ static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file)
 static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_video_bus *video = seq->private;
-	unsigned long options;
+	acpi_integer options;
 	int status;
 
 
@@ -1232,7 +1232,7 @@ static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
 			printk(KERN_WARNING PREFIX
 			       "This indicates a BIOS bug. Please contact the manufacturer.\n");
 		}
-		printk("%lx\n", options);
+		printk("%llx\n", options);
 		seq_printf(seq, "can POST: <integrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
@@ -1256,7 +1256,7 @@ static int acpi_video_bus_POST_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_video_bus *video = seq->private;
 	int status;
-	unsigned long id;
+	acpi_integer id;
 
 
 	if (!video)
@@ -1303,7 +1303,7 @@ acpi_video_bus_write_POST(struct file *file,
 	struct seq_file *m = file->private_data;
 	struct acpi_video_bus *video = m->private;
 	char str[12] = { 0 };
-	unsigned long opt, options;
+	acpi_integer opt, options;
 
 
 	if (!video || count + 1 > sizeof str)
@@ -1473,7 +1473,7 @@ static int
 acpi_video_bus_get_one_device(struct acpi_device *device,
 			      struct acpi_video_bus *video)
 {
-	unsigned long device_id;
+	acpi_integer device_id;
 	int status;
 	struct acpi_video_device *data;
 	struct acpi_video_device_attrib* attribute;
@@ -1724,7 +1724,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 static void
 acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 {
-	unsigned long level_current, level_next;
+	acpi_integer level_current, level_next;
 	if (!device->brightness)
 		return;
 	acpi_video_device_lcd_get_level_current(device, &level_current);
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9330b79..3b78291 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -180,7 +180,7 @@ static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
 	int wait = 0;
 	unsigned long flags;
 	acpi_handle handle, tmphandle;
-	unsigned long sta;
+	acpi_integer sta;
 	acpi_status status;
 
 	if (dev) {
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 7c6dfd0..0f40f07 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -280,7 +280,7 @@ static int write_acpi_int(acpi_handle handle, const char *method, int val,
 
 static int read_wireless_status(int mask)
 {
-	ulong status;
+	acpi_integer status;
 	acpi_status rv = AE_OK;
 
 	if (!wireless_status_handle)
@@ -297,7 +297,7 @@ static int read_wireless_status(int mask)
 
 static int read_gps_status(void)
 {
-	ulong status;
+	acpi_integer status;
 	acpi_status rv = AE_OK;
 
 	rv = acpi_evaluate_integer(gps_status_handle, NULL, NULL, &status);
@@ -404,7 +404,7 @@ static void lcd_blank(int blank)
 
 static int read_brightness(struct backlight_device *bd)
 {
-	ulong value;
+	acpi_integer value;
 	acpi_status rv = AE_OK;
 
 	rv = acpi_evaluate_integer(brightness_get_handle, NULL, NULL, &value);
@@ -455,7 +455,7 @@ static ssize_t show_infos(struct device *dev,
 			  struct device_attribute *attr, char *page)
 {
 	int len = 0;
-	ulong temp;
+	acpi_integer temp;
 	char buf[16];		//enough for all info
 	acpi_status rv = AE_OK;
 
@@ -603,7 +603,7 @@ static void set_display(int value)
 
 static int read_display(void)
 {
-	ulong value = 0;
+	acpi_integer value = 0;
 	acpi_status rv = AE_OK;
 
 	/* In most of the case, we know how to set the display, but sometime
@@ -849,7 +849,7 @@ static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
-	ulong bsts_result, hwrs_result;
+	acpi_integer bsts_result, hwrs_result;
 	char *string = NULL;
 	acpi_status status;
 
diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index facdb98..73b7c9f 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -204,7 +204,7 @@ static int write_acpi_int(acpi_handle handle, const char *method, int val,
 static int read_acpi_int(acpi_handle handle, const char *method, int *val)
 {
 	acpi_status status;
-	ulong result;
+	acpi_integer result;
 
 	status = acpi_evaluate_integer(handle, (char *)method, NULL, &result);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index 3e56203..a8cb722 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -224,7 +224,7 @@ static int set_lcd_level_alt(int level)
 
 static int get_lcd_level(void)
 {
-	unsigned long state = 0;
+	acpi_integer state = 0;
 	acpi_status status = AE_OK;
 
 	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get lcd level via GBLL\n");
@@ -246,7 +246,7 @@ static int get_lcd_level(void)
 
 static int get_max_brightness(void)
 {
-	unsigned long state = 0;
+	acpi_integer state = 0;
 	acpi_status status = AE_OK;
 
 	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get max lcd level via RBLL\n");
@@ -263,7 +263,7 @@ static int get_max_brightness(void)
 
 static int get_lcd_level_alt(void)
 {
-	unsigned long state = 0;
+	acpi_integer state = 0;
 	acpi_status status = AE_OK;
 
 	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get lcd level via GBLS\n");
@@ -384,7 +384,7 @@ static ssize_t store_lcd_level(struct device *dev,
 
 static int get_irb(void)
 {
-	unsigned long state = 0;
+	acpi_integer state = 0;
 	acpi_status status = AE_OK;
 
 	vdbg_printk(FUJLAPTOP_DBG_TRACE, "Get irb\n");
diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index 80a1363..bf76eb7 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -57,7 +57,7 @@ static int memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
 {
 	struct acpi_device *device = cdev->devdata;
 	acpi_handle handle = device->handle;
-	unsigned long value;
+	acpi_integer value;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
@@ -90,7 +90,7 @@ static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
 {
 	struct acpi_device *device = cdev->devdata;
 	acpi_handle handle = device->handle;
-	unsigned long value;
+	acpi_integer value;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
@@ -115,7 +115,7 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status;
-	int temp;
+	acpi_integer temp;
 	unsigned long max_state;
 
 	if (memory_get_int_max_bandwidth(cdev, &max_state))
@@ -131,7 +131,7 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
 
 	status =
 	    acpi_evaluate_integer(handle, MEMORY_SET_BANDWIDTH, &arg_list,
-				  (unsigned long *)&temp);
+				  &temp);
 
 	printk(KERN_INFO
 	       "Bandwidth value was %d: status is %d\n", state, status);
@@ -252,7 +252,8 @@ static DEFINE_MUTEX(intel_menlow_attr_lock);
  * @auxtype : AUX0/AUX1
  * @buf: syfs buffer
  */
-static int sensor_get_auxtrip(acpi_handle handle, int index, int *value)
+static int sensor_get_auxtrip(acpi_handle handle, int index,
+							acpi_integer *value)
 {
 	acpi_status status;
 
@@ -260,7 +261,7 @@ static int sensor_get_auxtrip(acpi_handle handle, int index, int *value)
 		return -EINVAL;
 
 	status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
-				       NULL, (unsigned long *)value);
+				       NULL, value);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -282,13 +283,13 @@ static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
 	struct acpi_object_list args = {
 		1, &arg
 	};
-	int temp;
+	acpi_integer temp;
 
 	if (index != 0 && index != 1)
 		return -EINVAL;
 
 	status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
-				       NULL, (unsigned long *)&temp);
+				       NULL, &temp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 	if ((index && value < temp) || (!index && value > temp))
@@ -296,7 +297,7 @@ static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
 
 	arg.integer.value = value;
 	status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
-				       &args, (unsigned long *)&temp);
+				       &args, &temp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -312,7 +313,7 @@ static ssize_t aux0_show(struct device *dev,
 			 struct device_attribute *dev_attr, char *buf)
 {
 	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	int value;
+	acpi_integer value;
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, 0, &value);
@@ -324,7 +325,7 @@ static ssize_t aux1_show(struct device *dev,
 			 struct device_attribute *dev_attr, char *buf)
 {
 	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	int value;
+	acpi_integer value;
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, 1, &value);
@@ -376,7 +377,7 @@ static ssize_t bios_enabled_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	acpi_status status;
-	unsigned long bios_enabled;
+	acpi_integer bios_enabled;
 
 	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
 	if (ACPI_FAILURE(status))
@@ -492,7 +493,7 @@ static int __init intel_menlow_module_init(void)
 {
 	int result = -ENODEV;
 	acpi_status status;
-	unsigned long enable;
+	acpi_integer enable;
 
 	if (acpi_disabled)
 		return result;
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index a3e4705..23c8483 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -180,7 +180,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	struct acpiphp_func *newfunc;
 	acpi_handle tmp;
 	acpi_status status = AE_OK;
-	unsigned long adr, sun;
+	acpi_integer adr, sun;
 	int device, function, retval;
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
@@ -528,7 +528,7 @@ find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
 	acpi_handle dummy_handle;
-	unsigned long tmp;
+	acpi_integer tmp;
 	int device, function;
 	struct pci_dev *dev;
 	struct pci_bus *pci_bus = context;
@@ -573,7 +573,7 @@ find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 static int add_bridge(acpi_handle handle)
 {
 	acpi_status status;
-	unsigned long tmp;
+	acpi_integer tmp;
 	int seg, bus;
 	acpi_handle dummy_handle;
 	struct pci_bus *pci_bus;
@@ -767,7 +767,7 @@ static int get_gsi_base(acpi_handle handle, u32 *gsi_base)
 {
 	acpi_status status;
 	int result = -1;
-	unsigned long gsb;
+	acpi_integer gsb;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
 	void *table;
@@ -808,7 +808,7 @@ static acpi_status
 ioapic_add(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	unsigned long sta;
+	acpi_integer sta;
 	acpi_handle tmp;
 	struct pci_dev *pdev;
 	u32 gsi_base;
@@ -872,7 +872,7 @@ static acpi_status
 ioapic_remove(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	unsigned long sta;
+	acpi_integer sta;
 	acpi_handle tmp;
 	u32 gsi_base;
 	struct acpiphp_ioapic *pos, *n, *ioapic = NULL;
@@ -1264,7 +1264,7 @@ static int disable_device(struct acpiphp_slot *slot)
 static unsigned int get_slot_status(struct acpiphp_slot *slot)
 {
 	acpi_status status;
-	unsigned long sta = 0;
+	acpi_integer sta = 0;
 	u32 dvid;
 	struct list_head *l;
 	struct acpiphp_func *func;
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 2b7c45e..0ce4f0e 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -183,7 +183,7 @@ static int ibm_set_attention_status(struct hotplug_slot *slot, u8 status)
 	union acpi_object args[2]; 
 	struct acpi_object_list params = { .pointer = args, .count = 2 };
 	acpi_status stat; 
-	unsigned long rc;
+	acpi_integer rc;
 	union apci_descriptor *ibm_slot;
 
 	ibm_slot = ibm_slot_from_id(hpslot_to_sun(slot));
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 410fe03..c653f68 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -418,7 +418,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	/*
 	 * Add the slot's devices to the ACPI infrastructure */
 	if (SN_ACPI_BASE_SUPPORT() && ssdt) {
-		unsigned long adr;
+		acpi_integer adr;
 		struct acpi_device *pdevice;
 		struct acpi_device *device;
 		acpi_handle phandle;
@@ -510,7 +510,7 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 	/* free the ACPI resources for the slot */
 	if (SN_ACPI_BASE_SUPPORT() &&
             PCI_CONTROLLER(slot->pci_bus)->acpi_handle) {
-		unsigned long adr;
+		acpi_integer adr;
 		struct acpi_device *device;
 		acpi_handle phandle;
 		acpi_handle chandle = NULL;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a5ac0bc..ed2c3ad 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -46,7 +46,7 @@ acpi_extract_package(union acpi_object *package,
 acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
-		      struct acpi_object_list *arguments, unsigned long *data);
+		      struct acpi_object_list *arguments, acpi_integer *data);
 acpi_status
 acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
