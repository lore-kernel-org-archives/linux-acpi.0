From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/1] acpi: deliver acpi_device_id with acpi_op_add
Date: Thu, 30 Aug 2012 16:11:15 +0300
Message-ID: <1346332275-12366-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1346332275-12366-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14719 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab2H3NLK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Aug 2012 09:11:10 -0400
In-Reply-To: <1346332275-12366-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Deliver struct acpi_device_id from struct acpi_driver to the
drivers when driver->ops.add() is called. This allows the
drivers to get access to the driver_data in acpi_device_id.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 arch/ia64/hp/common/aml_nfw.c            |    3 ++-
 arch/ia64/hp/common/sba_iommu.c          |    2 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c   |    3 ++-
 drivers/acpi/ac.c                        |    6 ++++--
 drivers/acpi/acpi_memhotplug.c           |    6 ++++--
 drivers/acpi/acpi_pad.c                  |    3 ++-
 drivers/acpi/battery.c                   |    3 ++-
 drivers/acpi/button.c                    |    6 ++++--
 drivers/acpi/container.c                 |    6 ++++--
 drivers/acpi/ec.c                        |    3 ++-
 drivers/acpi/fan.c                       |    6 ++++--
 drivers/acpi/hed.c                       |    3 ++-
 drivers/acpi/pci_link.c                  |    6 ++++--
 drivers/acpi/pci_root.c                  |    6 ++++--
 drivers/acpi/power.c                     |    6 ++++--
 drivers/acpi/processor_driver.c          |    6 ++++--
 drivers/acpi/sbs.c                       |    3 ++-
 drivers/acpi/sbshc.c                     |    6 ++++--
 drivers/acpi/scan.c                      |   32 +++++++++++++++++++++---------
 drivers/acpi/thermal.c                   |    6 ++++--
 drivers/acpi/video.c                     |    6 ++++--
 drivers/char/hpet.c                      |    3 ++-
 drivers/char/sonypi.c                    |    3 ++-
 drivers/hv/vmbus_drv.c                   |    3 ++-
 drivers/hwmon/acpi_power_meter.c         |    3 ++-
 drivers/hwmon/asus_atk0110.c             |    5 +++--
 drivers/i2c/busses/i2c-scmi.c            |    3 ++-
 drivers/input/misc/atlas_btns.c          |    3 ++-
 drivers/platform/x86/asus-laptop.c       |    3 ++-
 drivers/platform/x86/classmate-laptop.c  |   15 +++++++++-----
 drivers/platform/x86/eeepc-laptop.c      |    3 ++-
 drivers/platform/x86/fujitsu-laptop.c    |    6 ++++--
 drivers/platform/x86/fujitsu-tablet.c    |    3 ++-
 drivers/platform/x86/hp_accel.c          |    3 ++-
 drivers/platform/x86/ideapad-laptop.c    |    3 ++-
 drivers/platform/x86/intel_menlow.c      |    3 ++-
 drivers/platform/x86/panasonic-laptop.c  |    6 ++++--
 drivers/platform/x86/sony-laptop.c       |    6 ++++--
 drivers/platform/x86/thinkpad_acpi.c     |    3 ++-
 drivers/platform/x86/topstar-laptop.c    |    3 ++-
 drivers/platform/x86/toshiba_acpi.c      |    3 ++-
 drivers/platform/x86/toshiba_bluetooth.c |    6 ++++--
 drivers/platform/x86/wmi.c               |    6 ++++--
 drivers/platform/x86/xo15-ebook.c        |    3 ++-
 drivers/staging/quickstart/quickstart.c  |    3 ++-
 drivers/video/backlight/apple_bl.c       |    3 ++-
 include/acpi/acpi_bus.h                  |    4 +++-
 47 files changed, 158 insertions(+), 77 deletions(-)

diff --git a/arch/ia64/hp/common/aml_nfw.c b/arch/ia64/hp/common/aml_nfw.c
index 6192f71..f9c09ec 100644
--- a/arch/ia64/hp/common/aml_nfw.c
+++ b/arch/ia64/hp/common/aml_nfw.c
@@ -180,7 +180,8 @@ static int aml_nfw_remove_global_handler(void)
 	return 0;
 }
 
-static int aml_nfw_add(struct acpi_device *device)
+static int aml_nfw_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	/*
 	 * We would normally allocate a new context structure and install
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index bcda5b2..8b2539f 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2042,7 +2042,7 @@ sba_map_ioc_to_node(struct ioc *ioc, acpi_handle handle)
 #endif
 
 static int __init
-acpi_sba_ioc_add(struct acpi_device *device)
+acpi_sba_ioc_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct ioc *ioc;
 	acpi_status status;
diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 2fdca25..508291d 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -147,7 +147,8 @@ static u32 xo15_sci_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
 }
 
-static int xo15_sci_add(struct acpi_device *device)
+static int
+xo15_sci_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	unsigned long long tmp;
 	acpi_status status;
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index d5fdd36..6859609 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -59,7 +59,8 @@ extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 #endif
 
-static int acpi_ac_add(struct acpi_device *device);
+static int acpi_ac_add(struct acpi_device *device,
+			const struct acpi_device_id *ent);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
@@ -264,7 +265,8 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 	return;
 }
 
-static int acpi_ac_add(struct acpi_device *device)
+static int acpi_ac_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	int result = 0;
 	struct acpi_ac *ac = NULL;
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 24c807f..0958aab 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -52,7 +52,8 @@ MODULE_LICENSE("GPL");
 #define MEMORY_POWER_ON_STATE	1
 #define MEMORY_POWER_OFF_STATE	2
 
-static int acpi_memory_device_add(struct acpi_device *device);
+static int acpi_memory_device_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id memory_device_ids[] = {
@@ -420,7 +421,8 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 	return;
 }
 
-static int acpi_memory_device_add(struct acpi_device *device)
+static int acpi_memory_device_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int result;
 	struct acpi_memory_device *mem_device = NULL;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index af4aad6..9fd8f61 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -462,7 +462,8 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 	}
 }
 
-static int acpi_pad_add(struct acpi_device *device)
+static int acpi_pad_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 45e3e17..dc0d97f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -985,7 +985,8 @@ static int battery_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static int acpi_battery_add(struct acpi_device *device)
+static int
+acpi_battery_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	int result = 0;
 	struct acpi_battery *battery = NULL;
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 314a3b8..f855863 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -74,7 +74,8 @@ static const struct acpi_device_id button_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
 
-static int acpi_button_add(struct acpi_device *device);
+static int
+acpi_button_add(struct acpi_device *device, const struct acpi_device_id *ent);
 static int acpi_button_remove(struct acpi_device *device, int type);
 static void acpi_button_notify(struct acpi_device *device, u32 event);
 
@@ -324,7 +325,8 @@ static int acpi_button_resume(struct device *dev)
 }
 #endif
 
-static int acpi_button_add(struct acpi_device *device)
+static int
+acpi_button_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct acpi_button *button;
 	struct input_dev *input;
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 1f9f7d7..1cc638f 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -51,7 +51,8 @@ MODULE_AUTHOR("Anil S Keshavamurthy");
 MODULE_DESCRIPTION("ACPI container driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_container_add(struct acpi_device *device);
+static int acpi_container_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_container_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id container_device_ids[] = {
@@ -93,7 +94,8 @@ static int is_device_present(acpi_handle handle)
 }
 
 /*******************************************************************/
-static int acpi_container_add(struct acpi_device *device)
+static int acpi_container_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	struct acpi_container *container;
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7edaccc..f5f978a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -789,7 +789,8 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	clear_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
 }
 
-static int acpi_ec_add(struct acpi_device *device)
+static int
+acpi_ec_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct acpi_ec *ec = NULL;
 	int ret;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index bc36a47..0a468b1 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -44,7 +44,8 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_fan_add(struct acpi_device *device);
+static int acpi_fan_add(struct acpi_device *device,
+			const struct acpi_device_id *ent);
 static int acpi_fan_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id fan_device_ids[] = {
@@ -123,7 +124,8 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_fan_add(struct acpi_device *device)
+static int acpi_fan_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	int result = 0;
 	struct thermal_cooling_device *cdev;
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index d0c1967..594486d 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -61,7 +61,8 @@ static void acpi_hed_notify(struct acpi_device *device, u32 event)
 	blocking_notifier_call_chain(&acpi_hed_notify_list, 0, NULL);
 }
 
-static int __devinit acpi_hed_add(struct acpi_device *device)
+static int __devinit
+acpi_hed_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	/* Only one hardware error device */
 	if (hed_handle)
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index a128082..ab2b600 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -53,7 +53,8 @@ ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
-static int acpi_pci_link_add(struct acpi_device *device);
+static int acpi_pci_link_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_pci_link_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id link_device_ids[] = {
@@ -692,7 +693,8 @@ int acpi_pci_link_free_irq(acpi_handle handle)
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_pci_link_add(struct acpi_device *device)
+static int acpi_pci_link_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int result;
 	struct acpi_pci_link *link;
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 72a2c98..40db950 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -45,7 +45,8 @@
 ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
-static int acpi_pci_root_add(struct acpi_device *device);
+static int acpi_pci_root_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
 static int acpi_pci_root_start(struct acpi_device *device);
 
@@ -449,7 +450,8 @@ out:
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
-static int __devinit acpi_pci_root_add(struct acpi_device *device)
+static int __devinit
+acpi_pci_root_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	unsigned long long segment, bus;
 	acpi_status status;
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fc18034..664b2e3 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -58,7 +58,8 @@ ACPI_MODULE_NAME("power");
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-static int acpi_power_add(struct acpi_device *device);
+static int
+acpi_power_add(struct acpi_device *device, const struct acpi_device_id *ent);
 static int acpi_power_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id power_device_ids[] = {
@@ -703,7 +704,8 @@ int acpi_power_transition(struct acpi_device *device, int state)
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_power_add(struct acpi_device *device)
+static int
+acpi_power_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	int result = 0, state;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bfc31cb..fd211e9 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -79,7 +79,8 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_processor_add(struct acpi_device *device);
+static int acpi_processor_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
 static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
@@ -520,7 +521,8 @@ err_power_exit:
  * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
  * Such things have to be put in and set up above in acpi_processor_start()
  */
-static int __cpuinit acpi_processor_add(struct acpi_device *device)
+static int __cpuinit acpi_processor_add(struct acpi_device *device,
+					const struct acpi_device_id *ent)
 {
 	struct acpi_processor *pr = NULL;
 	int result = 0;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index ff0740e..69903b6 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -914,7 +914,8 @@ static void acpi_sbs_callback(void *context)
 	}
 }
 
-static int acpi_sbs_add(struct acpi_device *device)
+static int acpi_sbs_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	struct acpi_sbs *sbs;
 	int result = 0;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index f8d2a47..771b8e6 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -32,7 +32,8 @@ struct acpi_smb_hc {
 	void *context;
 };
 
-static int acpi_smbus_hc_add(struct acpi_device *device);
+static int acpi_smbus_hc_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_smbus_hc_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id sbs_device_ids[] = {
@@ -258,7 +259,8 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 
-static int acpi_smbus_hc_add(struct acpi_device *device)
+static int acpi_smbus_hc_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int status;
 	unsigned long long val;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1ecca2..97c8f89 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -290,12 +290,23 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
 
-int acpi_match_device_ids(struct acpi_device *device,
-			  const struct acpi_device_id *ids)
+static const struct acpi_device_id
+*acpi_get_device_id(struct acpi_device *device,
+			const struct acpi_device_id *ids)
 {
 	const struct acpi_device_id *id;
-	struct acpi_hardware_id *hwid;
+	const char *hid = acpi_device_hid(device);
+
+	for (id = ids; id->id[0]; id++)
+		if (!strcmp(id->id, hid))
+			return id;
 
+	return NULL;
+}
+
+int acpi_match_device_ids(struct acpi_device *device,
+			  const struct acpi_device_id *ids)
+{
 	/*
 	 * If the device is not present, it is unnecessary to load device
 	 * driver for it.
@@ -303,12 +314,10 @@ int acpi_match_device_ids(struct acpi_device *device,
 	if (!device->status.present)
 		return -ENODEV;
 
-	for (id = ids; id->id[0]; id++)
-		list_for_each_entry(hwid, &device->pnp.ids, list)
-			if (!strcmp((char *) id->id, hwid->id))
-				return 0;
+	if (!acpi_get_device_id(device, ids))
+		return -ENOENT;
 
-	return -ENOENT;
+	return 0;
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
@@ -572,6 +581,7 @@ static void acpi_device_unregister(struct acpi_device *device, int type)
 static int
 acpi_bus_driver_init(struct acpi_device *device, struct acpi_driver *driver)
 {
+	const struct acpi_device_id *id;
 	int result = 0;
 
 	if (!device || !driver)
@@ -580,7 +590,11 @@ acpi_bus_driver_init(struct acpi_device *device, struct acpi_driver *driver)
 	if (!driver->ops.add)
 		return -ENOSYS;
 
-	result = driver->ops.add(device);
+	id = acpi_get_device_id(device, driver->ids);
+	if (!id)
+		return -ENOENT;
+
+	result = driver->ops.add(device, id);
 	if (result) {
 		device->driver = NULL;
 		device->driver_data = NULL;
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index edda74a..e3cef51 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -96,7 +96,8 @@ static int psv;
 module_param(psv, int, 0644);
 MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 
-static int acpi_thermal_add(struct acpi_device *device);
+static int acpi_thermal_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static void acpi_thermal_notify(struct acpi_device *device, u32 event);
 
@@ -986,7 +987,8 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 		tz->kelvin_offset = 2732;
 }
 
-static int acpi_thermal_add(struct acpi_device *device)
+static int acpi_thermal_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int result = 0;
 	struct acpi_thermal *tz = NULL;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..ad44dfc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -87,7 +87,8 @@ static bool use_bios_initial_backlight = 1;
 module_param(use_bios_initial_backlight, bool, 0644);
 
 static int register_count = 0;
-static int acpi_video_bus_add(struct acpi_device *device);
+static int acpi_video_bus_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 
@@ -1606,7 +1607,8 @@ acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
 
 static int instance;
 
-static int acpi_video_bus_add(struct acpi_device *device)
+static int acpi_video_bus_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	struct acpi_video_bus *video;
 	struct input_dev *input;
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index dfd7876..cf0c2c2 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -1014,7 +1014,8 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 	return AE_OK;
 }
 
-static int hpet_acpi_add(struct acpi_device *device)
+static int
+hpet_acpi_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	acpi_status result;
 	struct hpet_data data;
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index f877805..216c07d 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1134,7 +1134,8 @@ static int sonypi_disable(void)
 }
 
 #ifdef CONFIG_ACPI
-static int sonypi_acpi_add(struct acpi_device *device)
+static int sonypi_acpi_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	sonypi_acpi_device = device;
 	strcpy(acpi_device_name(device), "Sony laptop hotkeys");
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4748086..c0686389 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -721,7 +721,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *irq)
 	return AE_OK;
 }
 
-static int vmbus_acpi_add(struct acpi_device *device)
+static int vmbus_acpi_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	acpi_status result;
 
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 23ab3c4..64002ae 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -862,7 +862,8 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 					dev_name(&device->dev), event, 0);
 }
 
-static int acpi_power_meter_add(struct acpi_device *device)
+static int acpi_power_meter_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int res;
 	struct acpi_power_meter_resource *resource;
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 4ee5789..fce8539 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -187,7 +187,8 @@ struct atk_acpi_input_buf {
 	u32 param2;
 };
 
-static int atk_add(struct acpi_device *device);
+static int atk_add(struct acpi_device *device,
+			const struct acpi_device_id *ent);
 static int atk_remove(struct acpi_device *device, int type);
 static void atk_print_sensor(struct atk_data *data, union acpi_object *obj);
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value);
@@ -1341,7 +1342,7 @@ static int atk_probe_if(struct atk_data *data)
 	return err;
 }
 
-static int atk_add(struct acpi_device *device)
+static int atk_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	acpi_status ret;
 	int err;
diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 388cbdc..5d78d4f 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -356,7 +356,8 @@ static acpi_status acpi_smbus_cmi_query_methods(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-static int acpi_smbus_cmi_add(struct acpi_device *device)
+static int acpi_smbus_cmi_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	struct acpi_smbus_cmi *smbus_cmi;
 	const struct acpi_device_id *id;
diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 601f737..32cf583 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -72,7 +72,8 @@ static acpi_status acpi_atlas_button_handler(u32 function,
 	return status;
 }
 
-static int atlas_acpi_button_add(struct acpi_device *device)
+static int atlas_acpi_button_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	acpi_status status;
 	int i;
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index e38f91b..0b51556 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1839,7 +1839,8 @@ static void __devinit asus_dmi_check(void)
 
 static bool asus_device_present;
 
-static int __devinit asus_acpi_add(struct acpi_device *device)
+static int __devinit
+asus_acpi_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct asus_laptop *asus;
 	int result;
diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index c87ff16..3e0f177 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -387,7 +387,8 @@ static int cmpc_accel_resume_v4(struct device *dev)
 }
 #endif
 
-static int cmpc_accel_add_v4(struct acpi_device *acpi)
+static int cmpc_accel_add_v4(struct acpi_device *acpi,
+				const struct acpi_device_id *ent)
 {
 	int error;
 	struct input_dev *inputdev;
@@ -634,7 +635,8 @@ static void cmpc_accel_idev_init(struct input_dev *inputdev)
 	inputdev->close = cmpc_accel_close;
 }
 
-static int cmpc_accel_add(struct acpi_device *acpi)
+static int cmpc_accel_add(struct acpi_device *acpi,
+			const struct acpi_device_id *ent)
 {
 	int error;
 	struct input_dev *inputdev;
@@ -747,7 +749,8 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 	}
 }
 
-static int cmpc_tablet_add(struct acpi_device *acpi)
+static int cmpc_tablet_add(struct acpi_device *acpi,
+			const struct acpi_device_id *ent)
 {
 	return cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
 					   cmpc_tablet_idev_init);
@@ -956,7 +959,8 @@ struct ipml200_dev {
 	struct rfkill *rf;
 };
 
-static int cmpc_ipml_add(struct acpi_device *acpi)
+static int cmpc_ipml_add(struct acpi_device *acpi,
+			const struct acpi_device_id *ent)
 {
 	int retval;
 	struct ipml200_dev *ipml;
@@ -1073,7 +1077,8 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 		set_bit(cmpc_keys_codes[i], inputdev->keybit);
 }
 
-static int cmpc_keys_add(struct acpi_device *acpi)
+static int cmpc_keys_add(struct acpi_device *acpi,
+			const struct acpi_device_id *ent)
 {
 	return cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
 					   cmpc_keys_idev_init);
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index dab91b4..e674ccc 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1417,7 +1417,8 @@ static void __devinit eeepc_enable_camera(struct eeepc_laptop *eeepc)
 
 static bool eeepc_device_present;
 
-static int __devinit eeepc_acpi_add(struct acpi_device *device)
+static int __devinit
+eeepc_acpi_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct eeepc_laptop *eeepc;
 	int result;
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index c4c1a54..99e0fb5 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -651,7 +651,8 @@ static struct dmi_system_id fujitsu_dmi_table[] = {
 
 /* ACPI device for LCD brightness control */
 
-static int acpi_fujitsu_add(struct acpi_device *device)
+static int
+acpi_fujitsu_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	acpi_handle handle;
 	int result = 0;
@@ -805,7 +806,8 @@ static void acpi_fujitsu_notify(struct acpi_device *device, u32 event)
 
 /* ACPI device for hotkey handling */
 
-static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
+static int acpi_fujitsu_hotkey_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	acpi_handle handle;
 	int result = 0;
diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 7acae3f..aab2ed3 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -390,7 +390,8 @@ fujitsu_walk_resources(struct acpi_resource *res, void *data)
 	}
 }
 
-static int __devinit acpi_fujitsu_add(struct acpi_device *adev)
+static int __devinit
+acpi_fujitsu_add(struct acpi_device *adev, const struct acpi_device_id *ent)
 {
 	acpi_status status;
 	int error;
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 6b9af98..7f88cbb 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -293,7 +293,8 @@ static void lis3lv02d_enum_resources(struct acpi_device *device)
 		printk(KERN_DEBUG DRIVER_NAME ": Error getting resources\n");
 }
 
-static int lis3lv02d_add(struct acpi_device *device)
+static int lis3lv02d_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	int ret;
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index dae7abe..d5d9977 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -776,7 +776,8 @@ static void ideapad_sync_touchpad_state(struct acpi_device *adevice)
 	}
 }
 
-static int __devinit ideapad_acpi_add(struct acpi_device *adevice)
+static int __devinit
+ideapad_acpi_add(struct acpi_device *adevice, const struct acpi_device_id *ent)
 {
 	int ret, i;
 	int cfg;
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index 3271ac8..3f9d7f9 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -153,7 +153,8 @@ static struct thermal_cooling_device_ops memory_cooling_ops = {
 /*
  * Memory Device Management
  */
-static int intel_menlow_memory_add(struct acpi_device *device)
+static int intel_menlow_memory_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int result = -ENODEV;
 	acpi_status status = AE_OK;
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 8e8caa7..7412cf2 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -175,7 +175,8 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 	};
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
 
-static int acpi_pcc_hotkey_add(struct acpi_device *device);
+static int acpi_pcc_hotkey_add(struct acpi_device *device,
+				const struct acpi_device_id);
 static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type);
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
 
@@ -561,7 +562,8 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 }
 #endif
 
-static int acpi_pcc_hotkey_add(struct acpi_device *device)
+static int acpi_pcc_hotkey_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	struct backlight_properties props;
 	struct pcc_acpi *pcc;
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index daaddec..8f3958d 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2612,7 +2612,8 @@ static void sony_nc_backlight_cleanup(void)
 		backlight_device_unregister(sony_bl_props.dev);
 }
 
-static int sony_nc_add(struct acpi_device *device)
+static int sony_nc_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	acpi_status status;
 	int result = 0;
@@ -4150,7 +4151,8 @@ static int sony_pic_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int sony_pic_add(struct acpi_device *device)
+static int sony_pic_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	int result;
 	struct sony_pic_ioport *io, *tmp_io;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 80e3779..bd68904 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -788,7 +788,8 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 	return 0;
 }
 
-static int __init tpacpi_device_add(struct acpi_device *device)
+static int __init
+tpacpi_device_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	return 0;
 }
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index d528daa..a4b7248 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -132,7 +132,8 @@ static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 	return error;
 }
 
-static int acpi_topstar_add(struct acpi_device *device)
+static int
+acpi_topstar_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct topstar_hkey *tps_hkey;
 
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 5f1256d..303b1e5 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1170,7 +1170,8 @@ static const char * __devinit find_hci_method(acpi_handle handle)
 	return NULL;
 }
 
-static int __devinit toshiba_acpi_add(struct acpi_device *acpi_dev)
+static int __devinit
+toshiba_acpi_add(struct acpi_device *acpi_dev, const struct acpi_device_id *ent)
 {
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index 5e5d631..662f57c 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -31,7 +31,8 @@ MODULE_DESCRIPTION("Toshiba Laptop ACPI Bluetooth Enable Driver");
 MODULE_LICENSE("GPL");
 
 
-static int toshiba_bt_rfkill_add(struct acpi_device *device);
+static int toshiba_bt_rfkill_add(struct acpi_device *device,
+				const struct acpi_device_id *ent);
 static int toshiba_bt_rfkill_remove(struct acpi_device *device, int type);
 static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event);
 
@@ -99,7 +100,8 @@ static int toshiba_bt_resume(struct device *dev)
 }
 #endif
 
-static int toshiba_bt_rfkill_add(struct acpi_device *device)
+static int toshiba_bt_rfkill_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	acpi_status status;
 	u64 bt_present;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 42a4dcc..a09e96e 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -93,7 +93,8 @@ MODULE_PARM_DESC(debug_dump_wdg,
 		 "Dump available WMI interfaces [0/1]");
 
 static int acpi_wmi_remove(struct acpi_device *device, int type);
-static int acpi_wmi_add(struct acpi_device *device);
+static int acpi_wmi_add(struct acpi_device *device,
+			const struct acpi_device_id *ent);
 static void acpi_wmi_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id wmi_device_ids[] = {
@@ -926,7 +927,8 @@ static int acpi_wmi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int acpi_wmi_add(struct acpi_device *device)
+static int acpi_wmi_add(struct acpi_device *device,
+			const struct acpi_device_id *ent)
 {
 	acpi_status status;
 	int error;
diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 38ba39d..922d7a9 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -86,7 +86,8 @@ static int ebook_switch_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
 
-static int ebook_switch_add(struct acpi_device *device)
+static int
+ebook_switch_add(struct acpi_device *device, const struct acpi_device_id *ent)
 {
 	struct ebook_switch *button;
 	struct input_dev *input;
diff --git a/drivers/staging/quickstart/quickstart.c b/drivers/staging/quickstart/quickstart.c
index cac3207..4ac2c7d 100644
--- a/drivers/staging/quickstart/quickstart.c
+++ b/drivers/staging/quickstart/quickstart.c
@@ -243,7 +243,8 @@ static int quickstart_acpi_config(struct quickstart_acpi *quickstart)
 	return 0;
 }
 
-static int quickstart_acpi_add(struct acpi_device *device)
+static int quickstart_acpi_add(struct acpi_device *device,
+				const struct acpi_device_id *ent)
 {
 	int ret;
 	acpi_status status;
diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index 9dc73ac..96f97aa 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -137,7 +137,8 @@ static const struct hw_data nvidia_chipset_data = {
 	.set_brightness = nvidia_chipset_set_brightness,
 };
 
-static int __devinit apple_bl_add(struct acpi_device *dev)
+static int __devinit
+apple_bl_add(struct acpi_device *dev, const struct acpi_device_id *ent)
 {
 	struct backlight_properties props;
 	struct pci_dev *host;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..d422f7c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -111,13 +111,15 @@ enum acpi_bus_device_type {
 
 struct acpi_driver;
 struct acpi_device;
+struct acpi_device_id;
 
 /*
  * ACPI Driver
  * -----------
  */
 
-typedef int (*acpi_op_add) (struct acpi_device * device);
+typedef int (*acpi_op_add) (struct acpi_device * device,
+				const struct acpi_device_id *ent);
 typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
-- 
1.7.10.4

