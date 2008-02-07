From: Len Brown <lenb@kernel.org>
Subject: [PATCH 106/112] ACPI: misc cleanups
Date: Thu,  7 Feb 2008 04:35:08 -0500
Message-ID: <e5685b9d35c2cc0a98425b05df30cb837dd1e632.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758554AbYBGJg6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:58 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

    This patch contains the following possible cleanups:
    - make the following needlessly global code static:
      - drivers/acpi/bay.c:dev_attr_eject
      - drivers/acpi/bay.c:dev_attr_present
      - drivers/acpi/dock.c:dev_attr_docked
      - drivers/acpi/dock.c:dev_attr_flags
      - drivers/acpi/dock.c:dev_attr_uid
      - drivers/acpi/dock.c:dev_attr_undock
      - drivers/acpi/pci_bind.c:acpi_pci_unbind()
      - drivers/acpi/pci_link.c:acpi_link_lock
      - drivers/acpi/sbs.c:acpi_sbs_callback()
      - drivers/acpi/sbshc.c:acpi_smbus_transaction()
      - drivers/acpi/sleep/main.c:acpi_sleep_prepare()
    - #if 0 the following unused global functions:
      - drivers/acpi/numa.c:acpi_unmap_pxm_to_node()
    - remove the following unused EXPORT_SYMBOL's:
      - acpi_register_gsi
      - acpi_unregister_gsi
      - acpi_strict
      - acpi_bus_receive_event
      - register_acpi_bus_type
      - unregister_acpi_bus_type
      - acpi_os_printf
      - acpi_os_sleep
      - acpi_os_stall
      - acpi_os_read_pci_configuration
      - acpi_os_create_semaphore
      - acpi_os_delete_semaphore
      - acpi_os_wait_semaphore
      - acpi_os_signal_semaphore
      - acpi_os_signal
      - acpi_pci_irq_enable
      - acpi_get_pxm

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi.c     |    4 ----
 arch/x86/kernel/acpi/boot.c |    3 ---
 drivers/acpi/bay.c          |    4 ++--
 drivers/acpi/bus.c          |    1 -
 drivers/acpi/dock.c         |    8 ++++----
 drivers/acpi/glue.c         |    4 ----
 drivers/acpi/numa.c         |    3 ++-
 drivers/acpi/osl.c          |   18 ------------------
 drivers/acpi/pci_bind.c     |    4 +++-
 drivers/acpi/pci_irq.c      |    2 --
 drivers/acpi/pci_link.c     |    2 +-
 drivers/acpi/sbs.c          |    2 +-
 drivers/acpi/sbshc.c        |    4 ++--
 include/acpi/acpi_drivers.h |    1 -
 include/acpi/acpi_numa.h    |    1 -
 15 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 00b5d08..78206f1 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -601,8 +601,6 @@ int acpi_register_gsi(u32 gsi, int triggering, int polarity)
 				     IOSAPIC_LEVEL);
 }
 
-EXPORT_SYMBOL(acpi_register_gsi);
-
 void acpi_unregister_gsi(u32 gsi)
 {
 	if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM)
@@ -611,8 +609,6 @@ void acpi_unregister_gsi(u32 gsi)
 	iosapic_unregister_intr(gsi);
 }
 
-EXPORT_SYMBOL(acpi_unregister_gsi);
-
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
 	struct acpi_table_header *fadt_header;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d2a5843..529e52d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -78,7 +78,6 @@ int acpi_ht __initdata = 1;	/* enable HT */
 int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
-EXPORT_SYMBOL(acpi_strict);
 
 u8 acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
@@ -490,8 +489,6 @@ int acpi_register_gsi(u32 gsi, int triggering, int polarity)
 	return irq;
 }
 
-EXPORT_SYMBOL(acpi_register_gsi);
-
 /*
  *  ACPI based hotplug support for CPU
  */
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 6daf608..0c81294 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -128,7 +128,7 @@ static ssize_t show_present(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", bay_present(bay));
 
 }
-DEVICE_ATTR(present, S_IRUGO, show_present, NULL);
+static DEVICE_ATTR(present, S_IRUGO, show_present, NULL);
 
 /*
  * write_eject - write method for "eject" file in sysfs
@@ -144,7 +144,7 @@ static ssize_t write_eject(struct device *dev, struct device_attribute *attr,
 	eject_device(bay->handle);
 	return count;
 }
-DEVICE_ATTR(eject, S_IWUSR, NULL, write_eject);
+static DEVICE_ATTR(eject, S_IWUSR, NULL, write_eject);
 
 /**
  * is_ata - see if a device is an ata device
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1b4cf98..2994bb2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -366,7 +366,6 @@ int acpi_bus_receive_event(struct acpi_bus_event *event)
 	return 0;
 }
 
-EXPORT_SYMBOL(acpi_bus_receive_event);
 #endif	/* CONFIG_ACPI_PROC_EVENT */
 
 /* --------------------------------------------------------------------------
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 1dabdf4..7e47a98 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -680,7 +680,7 @@ static ssize_t show_docked(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
 }
-DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
+static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
 /*
  * show_flags - read method for flags file in sysfs
@@ -691,7 +691,7 @@ static ssize_t show_flags(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
 
 }
-DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
+static DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
 
 /*
  * write_undock - write method for "undock" file in sysfs
@@ -707,7 +707,7 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
 	return ret ? ret: count;
 }
-DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
+static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
 
 /*
  * show_dock_uid - read method for "uid" file in sysfs
@@ -723,7 +723,7 @@ static ssize_t show_dock_uid(struct device *dev,
 
 	return snprintf(buf, PAGE_SIZE, "%lx\n", lbuf);
 }
-DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
+static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
 /**
  * dock_add - add a new dock station
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 4893e25..eda0978 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -36,8 +36,6 @@ int register_acpi_bus_type(struct acpi_bus_type *type)
 	return -ENODEV;
 }
 
-EXPORT_SYMBOL(register_acpi_bus_type);
-
 int unregister_acpi_bus_type(struct acpi_bus_type *type)
 {
 	if (acpi_disabled)
@@ -53,8 +51,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *type)
 	return -ENODEV;
 }
 
-EXPORT_SYMBOL(unregister_acpi_bus_type);
-
 static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 {
 	struct acpi_bus_type *tmp, *ret = NULL;
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 0822d9f..5d59cb3 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -78,6 +78,7 @@ int acpi_map_pxm_to_node(int pxm)
 	return node;
 }
 
+#if 0
 void __cpuinit acpi_unmap_pxm_to_node(int node)
 {
 	int pxm = node_to_pxm_map[node];
@@ -85,6 +86,7 @@ void __cpuinit acpi_unmap_pxm_to_node(int node)
 	node_to_pxm_map[node] = PXM_INVAL;
 	node_clear(node, nodes_found_map);
 }
+#endif  /*  0  */
 
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
@@ -247,7 +249,6 @@ int acpi_get_pxm(acpi_handle h)
 	} while (ACPI_SUCCESS(status));
 	return -1;
 }
-EXPORT_SYMBOL(acpi_get_pxm);
 
 int acpi_get_node(acpi_handle *handle)
 {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e53fb51..7fcacc5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -219,8 +219,6 @@ void acpi_os_printf(const char *fmt, ...)
 	va_end(args);
 }
 
-EXPORT_SYMBOL(acpi_os_printf);
-
 void acpi_os_vprintf(const char *fmt, va_list args)
 {
 	static char buffer[512];
@@ -384,8 +382,6 @@ void acpi_os_sleep(acpi_integer ms)
 	schedule_timeout_interruptible(msecs_to_jiffies(ms));
 }
 
-EXPORT_SYMBOL(acpi_os_sleep);
-
 void acpi_os_stall(u32 us)
 {
 	while (us) {
@@ -399,8 +395,6 @@ void acpi_os_stall(u32 us)
 	}
 }
 
-EXPORT_SYMBOL(acpi_os_stall);
-
 /*
  * Support ACPI 3.0 AML Timer operand
  * Returns 64-bit free-running, monotonically increasing timer
@@ -550,8 +544,6 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	return (result ? AE_ERROR : AE_OK);
 }
 
-EXPORT_SYMBOL(acpi_os_read_pci_configuration);
-
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				acpi_integer value, u32 width)
@@ -793,8 +785,6 @@ acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 	return AE_OK;
 }
 
-EXPORT_SYMBOL(acpi_os_create_semaphore);
-
 /*
  * TODO: A better way to delete semaphores?  Linux doesn't have a
  * 'delete_semaphore()' function -- may result in an invalid
@@ -818,8 +808,6 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 	return AE_OK;
 }
 
-EXPORT_SYMBOL(acpi_os_delete_semaphore);
-
 /*
  * TODO: The kernel doesn't have a 'down_timeout' function -- had to
  * improvise.  The process is to sleep for one scheduler quantum
@@ -912,8 +900,6 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 	return status;
 }
 
-EXPORT_SYMBOL(acpi_os_wait_semaphore);
-
 /*
  * TODO: Support for units > 1?
  */
@@ -936,8 +922,6 @@ acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 	return AE_OK;
 }
 
-EXPORT_SYMBOL(acpi_os_signal_semaphore);
-
 #ifdef ACPI_FUTURE_USAGE
 u32 acpi_os_get_line(char *buffer)
 {
@@ -981,8 +965,6 @@ acpi_status acpi_os_signal(u32 function, void *info)
 	return AE_OK;
 }
 
-EXPORT_SYMBOL(acpi_os_signal);
-
 static int __init acpi_os_name_setup(char *str)
 {
 	char *p = acpi_os_name;
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 388300d..4b252ea 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -44,6 +44,8 @@ struct acpi_pci_data {
 	struct pci_dev *dev;
 };
 
+static int acpi_pci_unbind(struct acpi_device *device);
+
 static void acpi_pci_data_handler(acpi_handle handle, u32 function,
 				  void *context)
 {
@@ -267,7 +269,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	return result;
 }
 
-int acpi_pci_unbind(struct acpi_device *device)
+static int acpi_pci_unbind(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 62010c2..8229473 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -478,8 +478,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	return 0;
 }
 
-EXPORT_SYMBOL(acpi_pci_irq_enable);
-
 /* FIXME: implement x86/x86_64 version */
 void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
 {
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 5400ea1..233c40c 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -95,7 +95,7 @@ static struct {
 	int count;
 	struct list_head entries;
 } acpi_link;
-DEFINE_MUTEX(acpi_link_lock);
+static DEFINE_MUTEX(acpi_link_lock);
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f136c7d..1194105 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -888,7 +888,7 @@ static void acpi_charger_remove(struct acpi_sbs *sbs)
 #endif
 }
 
-void acpi_sbs_callback(void *context)
+static void acpi_sbs_callback(void *context)
 {
 	int id;
 	struct acpi_sbs *sbs = context;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index fd40b6a..ae9a904 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -111,8 +111,8 @@ static int wait_transaction_complete(struct acpi_smb_hc *hc, int timeout)
 		return -ETIME;
 }
 
-int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol, u8 address,
-		    u8 command, u8 *data, u8 length)
+static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
+				  u8 address, u8 command, u8 *data, u8 length)
 {
 	int ret = -EFAULT, i;
 	u8 temp, sz = 0;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index f85f77a..a77196b 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -73,7 +73,6 @@ struct pci_bus;
 
 acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
 int acpi_pci_bind(struct acpi_device *device);
-int acpi_pci_unbind(struct acpi_device *device);
 int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
 		       struct pci_bus *bus);
 
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 62c5ee4..1739726 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -15,7 +15,6 @@ extern int pxm_to_node(int);
 extern int node_to_pxm(int);
 extern void __acpi_map_pxm_to_node(int, int);
 extern int acpi_map_pxm_to_node(int);
-extern void __cpuinit acpi_unmap_pxm_to_node(int);
 
 #endif				/* CONFIG_ACPI_NUMA */
 #endif				/* __ACP_NUMA_H */
-- 
1.5.4.23.gef5b9

