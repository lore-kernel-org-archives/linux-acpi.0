From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 06/12] ACPI/IPMI: Fix issue caused by the per-device registration of the IPMI operation region handler
Date: Fri, 13 Sep 2013 13:14:02 +0800
Message-ID: <6d83c9b7669ce3cf4d802209b9cca8c939cf93c1.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab3IMFOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:09 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

It is found on a real machine, in its ACPI namespace, the IPMI
OperationRegions (in the ACPI000D - ACPI power meter) are not defined under
the IPMI system interface device (the IPI0001 with KCS type returned from
_IFT control method):
  Device (PMI0)
  {
      Name (_HID, "ACPI000D")  // _HID: Hardware ID
      OperationRegion (SYSI, IPMI, 0x0600, 0x0100)
      Field (SYSI, BufferAcc, Lock, Preserve)
      {
          AccessAs (BufferAcc, 0x01),
          Offset (0x58),
          SCMD,   8,
          GCMD,   8
      }

      OperationRegion (POWR, IPMI, 0x3000, 0x0100)
      Field (POWR, BufferAcc, Lock, Preserve)
      {
          AccessAs (BufferAcc, 0x01),
          Offset (0xB3),
          GPMM,   8
      }
  }

  Device (PCI0)
  {
      Device (ISA)
      {
          Device (NIPM)
          {
              Name (_HID, EisaId ("IPI0001"))  // _HID: Hardware ID
              Method (_IFT, 0, NotSerialized)  // _IFT: IPMI Interface Type
              {
                  Return (0x01)
              }
          }
      }
  }
Current ACPI_IPMI code registers IPMI operation region handler on a
per-device basis, so that for above namespace, the IPMI operation region
handler is registered only under the scope of \_SB.PCI0.ISA.NIPM.  Thus
when an IPMI operation region field of \PMI0 is accessed, there are errors
reported on such platform:
  ACPI Error: No handlers for Region [IPMI]
  ACPI Error: Region IPMI(7) has no handler
The solution is to install IPMI operation region handler from root node so
that every object that defines IPMI OperationRegion can get an address
space handler registered.

When an IPMI operation region field is accessed, the Network Function
(0x06 for SYSI and 0x30 for POWR) and the Command (SCMD, GCMD, GPMM) are
passed to the operation region handler, there is no system interface
specified by the BIOS.  The patch tries to select one system interface by
monitoring the system interface notification.  IPMI messages passed from
the ACPI codes are sent to this selected global IPMI system interface.

Known issues:
- How to select the IPMI system interface:
  Currently, the ACPI_IPMI always selects the first registered one with the
  ACPI handle set (i.e., defined in the ACPI namespace).  It's hard to
  determine the selection when there are multiple IPMI system interfaces
  defined in the ACPI namespace.
  According to the IPMI specification:
  A BMC device may make available multiple system interfaces, but only one
  management controller is allowed to be 'active' BMC that provides BMC
  functionality for the system (in case of a 'partitioned' system, there
  can be only one active BMC per partition).  Only the system interface(s)
  for the active BMC allowed to respond to the 'Get Device Id' command.
  According to the ipmi_si desigin:
  The ipmi_si registeration notifications can only happen after a
  successful "Get Device ID" command.
  Thus it should be OK for non-partitioned systems to do such selection.
  But we do not have too much knowledges on 'partitioned' systems.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=46741
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |   81 +++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index b285386..7ec4cd1 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -46,7 +46,6 @@ MODULE_AUTHOR("Zhao Yakui");
 MODULE_DESCRIPTION("ACPI IPMI Opregion driver");
 MODULE_LICENSE("GPL");
 
-#define IPMI_FLAGS_HANDLER_INSTALL	0
 
 #define ACPI_IPMI_OK			0
 #define ACPI_IPMI_TIMEOUT		0x10
@@ -66,7 +65,6 @@ struct acpi_ipmi_device {
 	ipmi_user_t	user_interface;
 	int ipmi_ifnum; /* IPMI interface number */
 	long curr_msgid;
-	unsigned long flags;
 	struct ipmi_smi_info smi_data;
 	bool dead;
 	struct kref kref;
@@ -77,6 +75,14 @@ struct ipmi_driver_data {
 	struct ipmi_smi_watcher	bmc_events;
 	struct ipmi_user_hndl	ipmi_hndlrs;
 	struct mutex		ipmi_lock;
+	/*
+	 * NOTE: IPMI System Interface Selection
+	 * There is no system interface specified by the IPMI operation
+	 * region access.  We try to select one system interface with ACPI
+	 * handle set.  IPMI messages passed from the ACPI codes are sent
+	 * to this selected global IPMI system interface.
+	 */
+	struct acpi_ipmi_device *selected_smi;
 };
 
 struct acpi_ipmi_msg {
@@ -110,8 +116,6 @@ struct acpi_ipmi_buffer {
 static void ipmi_register_bmc(int iface, struct device *dev);
 static void ipmi_bmc_gone(int iface);
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
-static int ipmi_install_space_handler(struct acpi_ipmi_device *ipmi);
-static void ipmi_remove_space_handler(struct acpi_ipmi_device *ipmi);
 
 static struct ipmi_driver_data driver_data = {
 	.ipmi_devices = LIST_HEAD_INIT(driver_data.ipmi_devices),
@@ -154,14 +158,12 @@ ipmi_dev_alloc(int iface, struct ipmi_smi_info *smi_data, acpi_handle handle)
 		return NULL;
 	}
 	ipmi_device->user_interface = user;
-	ipmi_install_space_handler(ipmi_device);
 
 	return ipmi_device;
 }
 
 static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
 {
-	ipmi_remove_space_handler(ipmi_device);
 	ipmi_destroy_user(ipmi_device->user_interface);
 	put_device(ipmi_device->smi_data.dev);
 	kfree(ipmi_device);
@@ -178,6 +180,8 @@ static void ipmi_dev_release_kref(struct kref *kref)
 static void __ipmi_dev_kill(struct acpi_ipmi_device *ipmi_device)
 {
 	list_del(&ipmi_device->head);
+	if (driver_data.selected_smi == ipmi_device)
+		driver_data.selected_smi = NULL;
 	/*
 	 * Always setting dead flag after deleting from the list or
 	 * list_for_each_entry() codes must get changed.
@@ -185,17 +189,14 @@ static void __ipmi_dev_kill(struct acpi_ipmi_device *ipmi_device)
 	ipmi_device->dead = true;
 }
 
-static struct acpi_ipmi_device *acpi_ipmi_dev_get(int iface)
+static struct acpi_ipmi_device *acpi_ipmi_dev_get(void)
 {
-	struct acpi_ipmi_device *temp, *ipmi_device = NULL;
+	struct acpi_ipmi_device *ipmi_device = NULL;
 
 	mutex_lock(&driver_data.ipmi_lock);
-	list_for_each_entry(temp, &driver_data.ipmi_devices, head) {
-		if (temp->ipmi_ifnum == iface) {
-			ipmi_device = temp;
-			kref_get(&ipmi_device->kref);
-			break;
-		}
+	if (driver_data.selected_smi) {
+		ipmi_device = driver_data.selected_smi;
+		kref_get(&ipmi_device->kref);
 	}
 	mutex_unlock(&driver_data.ipmi_lock);
 
@@ -416,6 +417,8 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 			goto err_lock;
 	}
 
+	if (!driver_data.selected_smi)
+		driver_data.selected_smi = ipmi_device;
 	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
 	mutex_unlock(&driver_data.ipmi_lock);
 	put_device(smi_data.dev);
@@ -443,6 +446,10 @@ static void ipmi_bmc_gone(int iface)
 			break;
 		}
 	}
+	if (!driver_data.selected_smi)
+		driver_data.selected_smi = list_first_entry_or_null(
+					&driver_data.ipmi_devices,
+					struct acpi_ipmi_device, head);
 	mutex_unlock(&driver_data.ipmi_lock);
 	if (dev_found) {
 		ipmi_flush_tx_msg(ipmi_device);
@@ -471,7 +478,6 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 		      void *handler_context, void *region_context)
 {
 	struct acpi_ipmi_msg *tx_msg;
-	int iface = (long)handler_context;
 	struct acpi_ipmi_device *ipmi_device;
 	int err;
 	acpi_status status;
@@ -485,7 +491,7 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	if ((function & ACPI_IO_MASK) == ACPI_READ)
 		return AE_TYPE;
 
-	ipmi_device = acpi_ipmi_dev_get(iface);
+	ipmi_device = acpi_ipmi_dev_get();
 	if (!ipmi_device)
 		return AE_NOT_EXIST;
 
@@ -534,47 +540,26 @@ out_ref:
 	return status;
 }
 
-static void ipmi_remove_space_handler(struct acpi_ipmi_device *ipmi)
-{
-	if (!test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
-		return;
-
-	acpi_remove_address_space_handler(ipmi->handle,
-				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler);
-
-	clear_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
-}
-
-static int ipmi_install_space_handler(struct acpi_ipmi_device *ipmi)
-{
-	acpi_status status;
-
-	if (test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
-		return 0;
-
-	status = acpi_install_address_space_handler(ipmi->handle,
-				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler,
-				NULL, (void *)((long)ipmi->ipmi_ifnum));
-	if (ACPI_FAILURE(status)) {
-		struct pnp_dev *pnp_dev = ipmi->pnp_dev;
-		dev_warn(&pnp_dev->dev, "Can't register IPMI opregion space "
-			"handle\n");
-		return -EINVAL;
-	}
-	set_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
-	return 0;
-}
-
 static int __init acpi_ipmi_init(void)
 {
 	int result = 0;
+	acpi_status status;
 
 	if (acpi_disabled)
 		return result;
 
 	mutex_init(&driver_data.ipmi_lock);
 
+	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
+				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler,
+				NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_warn("Can't register IPMI opregion space handle\n");
+		return -EINVAL;
+	}
 	result = ipmi_smi_watcher_register(&driver_data.bmc_events);
+	if (result)
+		pr_err("Can't register IPMI system interface watcher\n");
 
 	return result;
 }
@@ -608,6 +593,8 @@ static void __exit acpi_ipmi_exit(void)
 		mutex_lock(&driver_data.ipmi_lock);
 	}
 	mutex_unlock(&driver_data.ipmi_lock);
+	acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
+				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler);
 }
 
 module_init(acpi_ipmi_init);
-- 
1.7.10

