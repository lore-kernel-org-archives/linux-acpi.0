From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20100915 linuxized patches
Date: Fri, 17 Sep 2010 08:27:58 +0800
Message-ID: <1284683278.29775.27.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rggu8lXfL/M80PIgBKyl"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30261 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab0IQAZS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Sep 2010 20:25:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-rggu8lXfL/M80PIgBKyl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA release 20100915 linuxized patches attached.
Need to first apply release 20100806 patches and then these patches.

[PATCH 1/9] ACPICA: Obsolete the acpi_os_derive_pci_id OSL interface
[PATCH 2/9] ACPICA: Add ACPI_INLINE configuration parameter
[PATCH 3/9] ACPICA: Make acpi_thread_id no longer configurable, always u64
[PATCH 4/9] ACPICA: Update math module; no functional change
[PATCH 5/9] ACPICA: Make acpi_gbl_system_awake_and_running publically available
[PATCH 6/9] ACPICA: iASL/Disassembler: Write ACPI errors to stderr instead of output file
[PATCH 7/9] ACPICA: Add repair for _HID and _CID strings
[PATCH 8/9] ACPICA: Increase configurability of error messages
[PATCH 9/9] ACPICA: Update version to 20100915

Thanks,
Lin Ming


--=-rggu8lXfL/M80PIgBKyl
Content-Type: application/mbox; name="acpica-v20100915.mbox"
Content-Disposition: attachment; filename="acpica-v20100915.mbox"
Content-Transfer-Encoding: 7bit

>From d81d0f8d5b10f6b49d60cf486521bc96a32ec677 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 15 Sep 2010 13:22:46 +0800
Subject: [PATCH 1/9] ACPICA: Obsolete the acpi_os_derive_pci_id OSL interface

This function is not OS-dependent and has been replaced by
acpi_hw_derive_pci_id, which is now in the ACPICA core code.  Local
implementations of acpi_os_derive_pci_id are no longer necessary and
are removed. ACPICA BZ 857.

http://www.acpica.org/bugzilla/show_bug.cgi?id=857

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/achware.h  |    7 +
 drivers/acpi/acpica/evrgnini.c |   14 +-
 drivers/acpi/acpica/hwpci.c    |  412 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/osl.c             |   68 -------
 include/acpi/acpiosxf.h        |    7 -
 6 files changed, 430 insertions(+), 80 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 262903e..4fdcfdb 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -21,7 +21,7 @@ acpi-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
 	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
 	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o  exdebug.o
 
-acpi-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o
+acpi-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o hwpci.o
 
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 120b3af..e7c5545 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -123,6 +123,13 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 #ifdef	ACPI_FUTURE_USAGE
 /*
+ * hwpci - PCI configuration support
+ */
+acpi_status
+acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
+		      acpi_handle root_pci_device, acpi_handle pci_region);
+
+/*
  * hwtimer - ACPI Timer prototypes
  */
 acpi_status acpi_get_timer_resolution(u32 * resolution);
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index f40d271..0b47a6d 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -289,8 +289,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	}
 
 	/*
-	 * Get the PCI device and function numbers from the _ADR object contained
-	 * in the parent's scope.
+	 * Get the PCI device and function numbers from the _ADR object
+	 * contained in the parent's scope.
 	 */
 	status = acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR,
 						 pci_device_node, &pci_value);
@@ -320,9 +320,15 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 		pci_id->bus = ACPI_LOWORD(pci_value);
 	}
 
-	/* Complete this device's pci_id */
+	/* Complete/update the PCI ID for this device */
 
-	acpi_os_derive_pci_id(pci_root_node, region_obj->region.node, &pci_id);
+	status =
+	    acpi_hw_derive_pci_id(pci_id, pci_root_node,
+				  region_obj->region.node);
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(pci_id);
+		return_ACPI_STATUS(status);
+	}
 
 	*region_context = pci_id;
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
new file mode 100644
index 0000000..ad21c7d
--- /dev/null
+++ b/drivers/acpi/acpica/hwpci.c
@@ -0,0 +1,412 @@
+/*******************************************************************************
+ *
+ * Module Name: hwpci - Obtain PCI bus, device, and function numbers
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+#define _COMPONENT          ACPI_NAMESPACE
+ACPI_MODULE_NAME("hwpci")
+
+/* PCI configuration space values */
+#define PCI_CFG_HEADER_TYPE_REG             0x0E
+#define PCI_CFG_PRIMARY_BUS_NUMBER_REG      0x18
+#define PCI_CFG_SECONDARY_BUS_NUMBER_REG    0x19
+/* PCI header values */
+#define PCI_HEADER_TYPE_MASK                0x7F
+#define PCI_TYPE_BRIDGE                     0x01
+#define PCI_TYPE_CARDBUS_BRIDGE             0x02
+typedef struct acpi_pci_device {
+	acpi_handle device;
+	struct acpi_pci_device *next;
+
+} acpi_pci_device;
+
+/* Local prototypes */
+
+static acpi_status
+acpi_hw_build_pci_list(acpi_handle root_pci_device,
+		       acpi_handle pci_region,
+		       struct acpi_pci_device **return_list_head);
+
+static acpi_status
+acpi_hw_process_pci_list(struct acpi_pci_id *pci_id,
+			 struct acpi_pci_device *list_head);
+
+static void acpi_hw_delete_pci_list(struct acpi_pci_device *list_head);
+
+static acpi_status
+acpi_hw_get_pci_device_info(struct acpi_pci_id *pci_id,
+			    acpi_handle pci_device,
+			    u16 *bus_number, u8 *is_bridge);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_derive_pci_id
+ *
+ * PARAMETERS:  pci_id              - Initial values for the PCI ID. May be
+ *                                    modified by this function.
+ *              root_pci_device     - A handle to a PCI device object. This
+ *                                    object must be a PCI Root Bridge having a
+ *                                    _HID value of either PNP0A03 or PNP0A08
+ *              pci_region          - A handle to a PCI configuration space
+ *                                    Operation Region being initialized
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function derives a full PCI ID for a PCI device,
+ *              consisting of a Segment number, Bus number, Device number,
+ *              and function code.
+ *
+ *              The PCI hardware dynamically configures PCI bus numbers
+ *              depending on the bus topology discovered during system
+ *              initialization. This function is invoked during configuration
+ *              of a PCI_Config Operation Region in order to (possibly) update
+ *              the Bus/Device/Function numbers in the pci_id with the actual
+ *              values as determined by the hardware and operating system
+ *              configuration.
+ *
+ *              The pci_id parameter is initially populated during the Operation
+ *              Region initialization. This function is then called, and is
+ *              will make any necessary modifications to the Bus, Device, or
+ *              Function number PCI ID subfields as appropriate for the
+ *              current hardware and OS configuration.
+ *
+ * NOTE:        Created 08/2010. Replaces the previous OSL acpi_os_derive_pci_id
+ *              interface since this feature is OS-independent. This module
+ *              specifically avoids any use of recursion by building a local
+ *              temporary device list.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
+		      acpi_handle root_pci_device, acpi_handle pci_region)
+{
+	acpi_status status;
+	struct acpi_pci_device *list_head = NULL;
+
+	ACPI_FUNCTION_TRACE(hw_derive_pci_id);
+
+	if (!pci_id) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Build a list of PCI devices, from pci_region up to root_pci_device */
+
+	status =
+	    acpi_hw_build_pci_list(root_pci_device, pci_region, &list_head);
+	if (ACPI_SUCCESS(status)) {
+
+		/* Walk the list, updating the PCI device/function/bus numbers */
+
+		status = acpi_hw_process_pci_list(pci_id, list_head);
+	}
+
+	/* Always delete the list */
+
+	acpi_hw_delete_pci_list(list_head);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_build_pci_list
+ *
+ * PARAMETERS:  root_pci_device     - A handle to a PCI device object. This
+ *                                    object is guaranteed to be a PCI Root
+ *                                    Bridge having a _HID value of either
+ *                                    PNP0A03 or PNP0A08
+ *              pci_region          - A handle to the PCI configuration space
+ *                                    Operation Region
+ *              return_list_head    - Where the PCI device list is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Builds a list of devices from the input PCI region up to the
+ *              Root PCI device for this namespace subtree.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_build_pci_list(acpi_handle root_pci_device,
+		       acpi_handle pci_region,
+		       struct acpi_pci_device **return_list_head)
+{
+	acpi_handle current_device;
+	acpi_handle parent_device;
+	acpi_status status;
+	struct acpi_pci_device *list_element;
+	struct acpi_pci_device *list_head = NULL;
+
+	/*
+	 * Ascend namespace branch until the root_pci_device is reached, building
+	 * a list of device nodes. Loop will exit when either the PCI device is
+	 * found, or the root of the namespace is reached.
+	 */
+	current_device = pci_region;
+	while (1) {
+		status = acpi_get_parent(current_device, &parent_device);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Finished when we reach the PCI root device (PNP0A03 or PNP0A08) */
+
+		if (parent_device == root_pci_device) {
+			*return_list_head = list_head;
+			return (AE_OK);
+		}
+
+		list_element = ACPI_ALLOCATE(sizeof(struct acpi_pci_device));
+		if (!list_element) {
+			return (AE_NO_MEMORY);
+		}
+
+		/* Put new element at the head of the list */
+
+		list_element->next = list_head;
+		list_element->device = parent_device;
+		list_head = list_element;
+
+		current_device = parent_device;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_process_pci_list
+ *
+ * PARAMETERS:  pci_id              - Initial values for the PCI ID. May be
+ *                                    modified by this function.
+ *              list_head           - Device list created by
+ *                                    acpi_hw_build_pci_list
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Walk downward through the PCI device list, getting the device
+ *              info for each, via the PCI configuration space and updating
+ *              the PCI ID as necessary. Deletes the list during traversal.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_process_pci_list(struct acpi_pci_id *pci_id,
+			 struct acpi_pci_device *list_head)
+{
+	acpi_status status = AE_OK;
+	struct acpi_pci_device *info;
+	u16 bus_number;
+	u8 is_bridge = TRUE;
+
+	ACPI_FUNCTION_NAME(hw_process_pci_list);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+			  "Input PciId:  Seg %4.4X Bus %4.4X Dev %4.4X Func %4.4X\n",
+			  pci_id->segment, pci_id->bus, pci_id->device,
+			  pci_id->function));
+
+	bus_number = pci_id->bus;
+
+	/*
+	 * Descend down the namespace tree, collecting PCI device, function,
+	 * and bus numbers. bus_number is only important for PCI bridges.
+	 * Algorithm: As we descend the tree, use the last valid PCI device,
+	 * function, and bus numbers that are discovered, and assign them
+	 * to the PCI ID for the target device.
+	 */
+	info = list_head;
+	while (info) {
+		status = acpi_hw_get_pci_device_info(pci_id, info->device,
+						     &bus_number, &is_bridge);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+		info = info->next;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+			  "Output PciId: Seg %4.4X Bus %4.4X Dev %4.4X Func %4.4X "
+			  "Status %X BusNumber %X IsBridge %X\n",
+			  pci_id->segment, pci_id->bus, pci_id->device,
+			  pci_id->function, status, bus_number, is_bridge));
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_delete_pci_list
+ *
+ * PARAMETERS:  list_head           - Device list created by
+ *                                    acpi_hw_build_pci_list
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Free the entire PCI list.
+ *
+ ******************************************************************************/
+
+static void acpi_hw_delete_pci_list(struct acpi_pci_device *list_head)
+{
+	struct acpi_pci_device *next;
+	struct acpi_pci_device *previous;
+
+	next = list_head;
+	while (next) {
+		previous = next;
+		next = previous->next;
+		ACPI_FREE(previous);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_get_pci_device_info
+ *
+ * PARAMETERS:  pci_id              - Initial values for the PCI ID. May be
+ *                                    modified by this function.
+ *              pci_device          - Handle for the PCI device object
+ *              bus_number          - Where a PCI bridge bus number is returned
+ *              is_bridge           - Return value, indicates if this PCI
+ *                                    device is a PCI bridge
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get the device info for a single PCI device object. Get the
+ *              _ADR (contains PCI device and function numbers), and for PCI
+ *              bridge devices, get the bus number from PCI configuration
+ *              space.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_get_pci_device_info(struct acpi_pci_id *pci_id,
+			    acpi_handle pci_device,
+			    u16 *bus_number, u8 *is_bridge)
+{
+	acpi_status status;
+	acpi_object_type object_type;
+	u64 return_value;
+	u64 pci_value;
+
+	/* We only care about objects of type Device */
+
+	status = acpi_get_type(pci_device, &object_type);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	if (object_type != ACPI_TYPE_DEVICE) {
+		return (AE_OK);
+	}
+
+	/* We need an _ADR. Ignore device if not present */
+
+	status = acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR,
+						 pci_device, &return_value);
+	if (ACPI_FAILURE(status)) {
+		return (AE_OK);
+	}
+
+	/*
+	 * From _ADR, get the PCI Device and Function and
+	 * update the PCI ID.
+	 */
+	pci_id->device = ACPI_HIWORD(ACPI_LODWORD(return_value));
+	pci_id->function = ACPI_LOWORD(ACPI_LODWORD(return_value));
+
+	/*
+	 * If the previous device was a bridge, use the previous
+	 * device bus number
+	 */
+	if (*is_bridge) {
+		pci_id->bus = *bus_number;
+	}
+
+	/*
+	 * Get the bus numbers from PCI Config space:
+	 *
+	 * First, get the PCI header_type
+	 */
+	*is_bridge = FALSE;
+	status = acpi_os_read_pci_configuration(pci_id,
+						PCI_CFG_HEADER_TYPE_REG,
+						&pci_value, 8);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* We only care about bridges (1=pci_bridge, 2=card_bus_bridge) */
+
+	pci_value &= PCI_HEADER_TYPE_MASK;
+
+	if ((pci_value != PCI_TYPE_BRIDGE) &&
+	    (pci_value != PCI_TYPE_CARDBUS_BRIDGE)) {
+		return (AE_OK);
+	}
+
+	/* Bridge: Get the Primary bus_number */
+
+	status = acpi_os_read_pci_configuration(pci_id,
+						PCI_CFG_PRIMARY_BUS_NUMBER_REG,
+						&pci_value, 8);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	*is_bridge = TRUE;
+	pci_id->bus = (u16)pci_value;
+
+	/* Bridge: Get the Secondary bus_number */
+
+	status = acpi_os_read_pci_configuration(pci_id,
+						PCI_CFG_SECONDARY_BUS_NUMBER_REG,
+						&pci_value, 8);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	*bus_number = (u16)pci_value;
+	return (AE_OK);
+}
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 55ff9d7..6c4351b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -622,74 +622,6 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	return (result ? AE_ERROR : AE_OK);
 }
 
-/* TODO: Change code to take advantage of driver model more */
-static void acpi_os_derive_pci_id_2(acpi_handle rhandle,	/* upper bound  */
-				    acpi_handle chandle,	/* current node */
-				    struct acpi_pci_id **id,
-				    int *is_bridge, u8 * bus_number)
-{
-	acpi_handle handle;
-	struct acpi_pci_id *pci_id = *id;
-	acpi_status status;
-	unsigned long long temp;
-	acpi_object_type type;
-
-	acpi_get_parent(chandle, &handle);
-	if (handle != rhandle) {
-		acpi_os_derive_pci_id_2(rhandle, handle, &pci_id, is_bridge,
-					bus_number);
-
-		status = acpi_get_type(handle, &type);
-		if ((ACPI_FAILURE(status)) || (type != ACPI_TYPE_DEVICE))
-			return;
-
-		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
-					  &temp);
-		if (ACPI_SUCCESS(status)) {
-			u64 val;
-			pci_id->device = ACPI_HIWORD(ACPI_LODWORD(temp));
-			pci_id->function = ACPI_LOWORD(ACPI_LODWORD(temp));
-
-			if (*is_bridge)
-				pci_id->bus = *bus_number;
-
-			/* any nicer way to get bus number of bridge ? */
-			status =
-			    acpi_os_read_pci_configuration(pci_id, 0x0e, &val,
-							   8);
-			if (ACPI_SUCCESS(status)
-			    && ((val & 0x7f) == 1 || (val & 0x7f) == 2)) {
-				status =
-				    acpi_os_read_pci_configuration(pci_id, 0x18,
-								   &val, 8);
-				if (!ACPI_SUCCESS(status)) {
-					/* Certainly broken...  FIX ME */
-					return;
-				}
-				*is_bridge = 1;
-				pci_id->bus = val;
-				status =
-				    acpi_os_read_pci_configuration(pci_id, 0x19,
-								   &val, 8);
-				if (ACPI_SUCCESS(status)) {
-					*bus_number = val;
-				}
-			} else
-				*is_bridge = 0;
-		}
-	}
-}
-
-void acpi_os_derive_pci_id(acpi_handle rhandle,	/* upper bound  */
-			   acpi_handle chandle,	/* current node */
-			   struct acpi_pci_id **id)
-{
-	int is_bridge = 1;
-	u8 bus_number = (*id)->bus;
-
-	acpi_os_derive_pci_id_2(rhandle, chandle, id, &is_bridge, &bus_number);
-}
-
 static void acpi_os_execute_deferred(struct work_struct *work)
 {
 	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index c29b0af..4302743 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -230,13 +230,6 @@ acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
 				u32 reg, u64 value, u32 width);
 
 /*
- * Interim function needed for PCI IRQ routing
- */
-void
-acpi_os_derive_pci_id(acpi_handle device,
-		      acpi_handle region, struct acpi_pci_id **pci_id);
-
-/*
  * Miscellaneous
  */
 acpi_status

>From aa10257111aef9ca2d6ae3f0b88dc0ff4ba34d7a Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Wed, 15 Sep 2010 13:36:55 +0800
Subject: [PATCH 2/9] ACPICA: Add ACPI_INLINE configuration parameter

The C inline keyword is not standardized, ACPI_INLINE allows this
to be configured on a per-compiler basis.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbfadt.c  |    4 ++--
 include/acpi/platform/acenv.h |    6 ++++++
 include/acpi/platform/acgcc.h |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 1728cb9..d2ff432 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -49,7 +49,7 @@
 ACPI_MODULE_NAME("tbfadt")
 
 /* Local prototypes */
-static inline void
+static ACPI_INLINE void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id, u8 byte_width, u64 address);
 
@@ -181,7 +181,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
  *
  ******************************************************************************/
 
-static inline void
+static ACPI_INLINE void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id, u8 byte_width, u64 address)
 {
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index c05aeba..a3e334a 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -193,6 +193,12 @@
 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 #endif
 
+/* "inline" keywords - configurable since inline is not standardized */
+
+#ifndef ACPI_INLINE
+#define ACPI_INLINE
+#endif
+
 /*
  * Debugger threading model
  * Use single threaded if the entire subsystem is contained in an application
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 0cd53e3..5dcb953 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -44,6 +44,8 @@
 #ifndef __ACGCC_H__
 #define __ACGCC_H__
 
+#define ACPI_INLINE             __inline__
+
 /* Function name is used for debug output. Non-ANSI, compiler-dependent */
 
 #define ACPI_GET_FUNCTION_NAME          __func__

>From a49db9e1ead643cec20cac788b5268698e33f223 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Wed, 15 Sep 2010 13:55:13 +0800
Subject: [PATCH 3/9] ACPICA: Make acpi_thread_id no longer configurable, always u64

Change definition of acpi_thread_id to always be a u64. This
simplifies the code, especially any printf output. u64 is
the only common data type for all thread_id types across all
operating systems. We now force the OSL to cast the native
thread_id type to u64 before returning the value to ACPICA
(via acpi_os_get_thread_id).

Signed-off-by: Lin Ming <ming.m.lin@intel.com
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/achware.h   |    2 +-
 drivers/acpi/acpica/aclocal.h   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    2 +-
 drivers/acpi/acpica/evmisc.c    |    2 +-
 drivers/acpi/acpica/exmutex.c   |   10 +++++-----
 drivers/acpi/acpica/utdebug.c   |    7 +++----
 drivers/acpi/acpica/utmutex.c   |   29 ++++++++++++++++-------------
 include/acpi/actypes.h          |   17 ++++++++++-------
 include/acpi/platform/aclinux.h |    7 +++----
 9 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index e7c5545..167470a 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -121,7 +121,6 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
 				 void *context);
 
-#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwpci - PCI configuration support
  */
@@ -129,6 +128,7 @@ acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
 
+#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwtimer - ACPI Timer prototypes
  */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 53f7512..04ce322 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1001,7 +1001,7 @@ struct acpi_port_info {
 struct acpi_db_method_info {
 	acpi_handle main_thread_gate;
 	acpi_handle thread_complete_gate;
-	u32 *threads;
+	acpi_thread_id *threads;
 	u32 num_threads;
 	u32 num_created;
 	u32 num_completed;
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 64750ee..d94dd89 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -573,7 +573,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 				acpi_os_release_mutex(method_desc->method.
 						      mutex->mutex.os_mutex);
-				method_desc->method.mutex->mutex.thread_id = NULL;
+				method_desc->method.mutex->mutex.thread_id = 0;
 			}
 		}
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index df0aea9..fcaed9f 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -553,7 +553,7 @@ acpi_status acpi_ev_release_global_lock(void)
 	acpi_gbl_global_lock_acquired = FALSE;
 
 	/* Release the local GL mutex */
-	acpi_ev_global_lock_thread_id = NULL;
+	acpi_ev_global_lock_thread_id = 0;
 	acpi_ev_global_lock_acquired = 0;
 	acpi_os_release_mutex(acpi_gbl_global_lock_mutex->mutex.os_mutex);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index f73be97..6af14e4 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -336,7 +336,7 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 
 	/* Clear mutex info */
 
-	obj_desc->mutex.thread_id = NULL;
+	obj_desc->mutex.thread_id = 0;
 	return_ACPI_STATUS(status);
 }
 
@@ -393,10 +393,10 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	if ((owner_thread->thread_id != walk_state->thread->thread_id) &&
 	    (obj_desc != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
-			    ACPI_CAST_PTR(void, walk_state->thread->thread_id),
+			    "Thread %u cannot release Mutex [%4.4s] acquired by thread %u",
+			    (u32)walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    ACPI_CAST_PTR(void, owner_thread->thread_id)));
+			    (u32)owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
@@ -488,7 +488,7 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 		/* Mark mutex unowned */
 
 		obj_desc->mutex.owner_thread = NULL;
-		obj_desc->mutex.thread_id = NULL;
+		obj_desc->mutex.thread_id = 0;
 
 		/* Update Thread sync_level (Last mutex is the important one) */
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 9835106..f21c486 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -179,9 +179,8 @@ acpi_debug_print(u32 requested_debug_level,
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %p to TID %p ****\n\n",
-			     ACPI_CAST_PTR(void, acpi_gbl_prev_thread_id),
-			     ACPI_CAST_PTR(void, thread_id));
+			    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
+			     (u32)acpi_gbl_prev_thread_id, (u32)thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +193,7 @@ acpi_debug_print(u32 requested_debug_level,
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%p] ", ACPI_CAST_PTR(void, thread_id));
+		acpi_os_printf("[%u] ", (u32)thread_id);
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index b07b425..d9efa49 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -228,18 +228,17 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					ACPI_ERROR((AE_INFO,
-						    "Mutex [%s] already acquired by this thread [%p]",
+						    "Mutex [%s] already acquired by this thread [%u]",
 						    acpi_ut_get_mutex_name
 						    (mutex_id),
-						    ACPI_CAST_PTR(void,
-								  this_thread_id)));
+						    (u32)this_thread_id));
 
 					return (AE_ALREADY_ACQUIRED);
 				}
 
 				ACPI_ERROR((AE_INFO,
-					    "Invalid acquire order: Thread %p owns [%s], wants [%s]",
-					    ACPI_CAST_PTR(void, this_thread_id),
+					    "Invalid acquire order: Thread %u owns [%s], wants [%s]",
+					    (u32)this_thread_id,
 					    acpi_ut_get_mutex_name(i),
 					    acpi_ut_get_mutex_name(mutex_id)));
 
@@ -250,24 +249,24 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %p attempting to acquire Mutex [%s]\n",
-			  ACPI_CAST_PTR(void, this_thread_id),
+			  "Thread %u attempting to acquire Mutex [%s]\n",
+			  (u32)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %p acquired Mutex [%s]\n",
-				  ACPI_CAST_PTR(void, this_thread_id),
+				  "Thread %u acquired Mutex [%s]\n",
+				  (u32)this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %p could not acquire Mutex [0x%X]",
-				ACPI_CAST_PTR(void, this_thread_id), mutex_id));
+				"Thread %u could not acquire Mutex [0x%X]",
+				(u32)this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -287,10 +286,14 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 
 acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 {
+	acpi_thread_id this_thread_id;
+
 	ACPI_FUNCTION_NAME(ut_release_mutex);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %p releasing Mutex [%s]\n",
-			  ACPI_CAST_PTR(void, acpi_os_get_thread_id()),
+	this_thread_id = acpi_os_get_thread_id();
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %u releasing Mutex [%s]\n",
+			  (u32)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 332d076..864cfae 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -115,7 +115,6 @@
  *
  * ACPI_SIZE        16/32/64-bit unsigned value
  * ACPI_NATIVE_INT  16/32/64-bit signed value
- *
  */
 
 /*******************************************************************************
@@ -132,6 +131,16 @@ typedef COMPILER_DEPENDENT_INT64 INT64;
 
 /*! [End] no source code translation !*/
 
+/*
+ * Value returned by acpi_os_get_thread_id. There is no standard "thread_id"
+ * across operating systems or even the various UNIX systems. Since ACPICA
+ * only needs the thread ID as a unique thread identifier, we use a u64
+ * as the only common data type - it will accommodate any type of pointer or
+ * any type of integer. It is up to the host-dependent OSL to cast the
+ * native thread ID type to a u64 (in acpi_os_get_thread_id).
+ */
+#define acpi_thread_id                  u64
+
 /*******************************************************************************
  *
  * Types specific to 64-bit targets
@@ -211,12 +220,6 @@ typedef u32 acpi_physical_address;
  *
  ******************************************************************************/
 
-/* Value returned by acpi_os_get_thread_id */
-
-#ifndef acpi_thread_id
-#define acpi_thread_id			acpi_size
-#endif
-
 /* Flags for acpi_os_acquire_lock/acpi_os_release_lock */
 
 #ifndef acpi_cpu_flags
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 103f08a..572189e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -75,7 +75,6 @@
 #define acpi_cache_t                        struct kmem_cache
 #define acpi_spinlock                       spinlock_t *
 #define acpi_cpu_flags                      unsigned long
-#define acpi_thread_id                      struct task_struct *
 
 #else /* !__KERNEL__ */
 
@@ -88,7 +87,7 @@
 /* Host-dependent types and defines for user-space ACPICA */
 
 #define ACPI_FLUSH_CPU_CACHE()
-#define acpi_thread_id                      pthread_t
+#define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
 #if defined(__ia64__) || defined(__x86_64__)
 #define ACPI_MACHINE_WIDTH          64
@@ -113,12 +112,13 @@
 
 
 #ifdef __KERNEL__
+#include <acpi/actypes.h>
 /*
  * Overrides for in-kernel ACPICA
  */
 static inline acpi_thread_id acpi_os_get_thread_id(void)
 {
-	return current;
+	return (acpi_thread_id)(unsigned long)current;
 }
 
 /*
@@ -127,7 +127,6 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
  * However, boot has  (system_state != SYSTEM_RUNNING)
  * to quiet __might_sleep() in kmalloc() and resume does not.
  */
-#include <acpi/actypes.h>
 static inline void *acpi_os_allocate(acpi_size size)
 {
 	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);

>From 7fd7f3e4721368eb95c42e363dde136a3c9ad39e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 15 Sep 2010 14:00:53 +0800
Subject: [PATCH 4/9] ACPICA: Update math module; no functional change

Move the 64-bit overlay structures to the utmath module since
they are used nowhere else. Update module comment. ACPICA BZ 829.

http://www.acpica.org/bugzilla/show_bug.cgi?id=829

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utmath.c |   23 ++++++++++++++++++++---
 include/acpi/actypes.h       |   10 ----------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 35059a1..49cf7b7 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -48,11 +48,27 @@
 ACPI_MODULE_NAME("utmath")
 
 /*
- * Support for double-precision integer divide.  This code is included here
- * in order to support kernel environments where the double-precision math
- * library is not available.
+ * Optional support for 64-bit double-precision integer divide. This code
+ * is configurable and is implemented in order to support 32-bit kernel
+ * environments where a 64-bit double-precision math library is not available.
+ *
+ * Support for a more normal 64-bit divide/modulo (with check for a divide-
+ * by-zero) appears after this optional section of code.
  */
 #ifndef ACPI_USE_NATIVE_DIVIDE
+/* Structures used only for 64-bit divide */
+typedef struct uint64_struct {
+	u32 lo;
+	u32 hi;
+
+} uint64_struct;
+
+typedef union uint64_overlay {
+	u64 full;
+	struct uint64_struct part;
+
+} uint64_overlay;
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_short_divide
@@ -69,6 +85,7 @@ ACPI_MODULE_NAME("utmath")
  *              32-bit remainder.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ut_short_divide(u64 dividend,
 		     u32 divisor, u64 *out_quotient, u32 *out_remainder)
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 864cfae..2b134b6 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -378,16 +378,6 @@ typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 typedef u8 acpi_owner_id;
 #define ACPI_OWNER_ID_MAX               0xFF
 
-struct uint64_struct {
-	u32 lo;
-	u32 hi;
-};
-
-union uint64_overlay {
-	u64 full;
-	struct uint64_struct part;
-};
-
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
 

>From 98dcf3a6094d48bb5bc98c3ef16f09cf66423a19 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 15 Sep 2010 14:02:56 +0800
Subject: [PATCH 5/9] ACPICA: Make acpi_gbl_system_awake_and_running publically available

Added extern for this boolean in acpixf.h. Some hosts utilize
this value during suspend/restore operations.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 include/acpi/acpixf.h          |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fe50f57..b8dbb9b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -132,6 +132,7 @@ struct acpi_table_fadt acpi_gbl_FADT;
 u32 acpi_current_gpe_count;
 u32 acpi_gbl_trace_flags;
 acpi_name acpi_gbl_trace_method_name;
+u8 acpi_gbl_system_awake_and_running;
 
 #endif
 
@@ -278,7 +279,6 @@ ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
 ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
 ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
-ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 ACPI_EXTERN u8 acpi_gbl_osi_data;
 ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bfa252b..c156e5e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -72,6 +72,7 @@ extern u8 acpi_gbl_truncate_io_addresses;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
+extern u8 acpi_gbl_system_awake_and_running;
 
 extern u32 acpi_rsdt_forced;
 /*

>From aa6ccbcd936b0be3a761cad1777086aff39afebc Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 15 Sep 2010 14:09:14 +0800
Subject: [PATCH 6/9] ACPICA: iASL/Disassembler: Write ACPI errors to stderr instead of output file

This keeps the output files clean of random error messages that
may originate from within the namespace/interpreter code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/Makefile    |    2 +-
 drivers/acpi/acpica/acmacros.h  |    4 +-
 drivers/acpi/acpica/acnamesp.h  |   12 --
 drivers/acpi/acpica/acutils.h   |   39 +++--
 drivers/acpi/acpica/nsutils.c   |   98 ---------
 drivers/acpi/acpica/utmisc.c    |  162 ---------------
 drivers/acpi/acpica/utxferror.c |  415 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 445 insertions(+), 287 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 4fdcfdb..a7e1d1a 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -45,4 +45,4 @@ acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
 		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o \
-		utosi.o
+		utosi.o utxferror.o
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 9894929..8d5c9e0 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -338,8 +338,8 @@
  * the plist contains a set of parens to allow variable-length lists.
  * These macros are used for both the debug and non-debug versions of the code.
  */
-#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ns_report_error (AE_INFO, s, e);
-#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ns_report_method_error (AE_INFO, s, n, p, e);
+#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ut_namespace_error (AE_INFO, s, e);
+#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ut_method_error (AE_INFO, s, n, p, e);
 #define ACPI_WARN_PREDEFINED(plist)     acpi_ut_predefined_warning plist
 #define ACPI_INFO_PREDEFINED(plist)     acpi_ut_predefined_info plist
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 9f60ff0..d44d3bc 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -339,18 +339,6 @@ acpi_object_type acpi_ns_get_type(struct acpi_namespace_node *node);
 u32 acpi_ns_local(acpi_object_type type);
 
 void
-acpi_ns_report_error(const char *module_name,
-		     u32 line_number,
-		     const char *internal_name, acpi_status lookup_status);
-
-void
-acpi_ns_report_method_error(const char *module_name,
-			    u32 line_number,
-			    const char *message,
-			    struct acpi_namespace_node *node,
-			    const char *path, acpi_status lookup_status);
-
-void
 acpi_ns_print_node_pathname(struct acpi_namespace_node *node, const char *msg);
 
 acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info);
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 78e0121..72e4183 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -486,17 +486,6 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
 acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer);
 
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_warning(const char *module_name,
-			   u32 line_number,
-			   char *pathname,
-			   u8 node_flags, const char *format, ...);
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_info(const char *module_name,
-			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...);
-
 /* Values for Base above (16=Hex, 10=Decimal) */
 
 #define ACPI_ANY_BASE        0
@@ -587,6 +576,32 @@ acpi_status
 acpi_ut_create_list(char *list_name,
 		    u16 object_size, struct acpi_memory_list **return_cache);
 
-#endif
+#endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
+
+/*
+ * utxferror - various error/warning output functions
+ */
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_warning(const char *module_name,
+			   u32 line_number,
+			   char *pathname,
+			   u8 node_flags, const char *format, ...);
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...);
+
+void
+acpi_ut_namespace_error(const char *module_name,
+			u32 line_number,
+			const char *internal_name, acpi_status lookup_status);
+
+void
+acpi_ut_method_error(const char *module_name,
+		     u32 line_number,
+		     const char *message,
+		     struct acpi_namespace_node *node,
+		     const char *path, acpi_status lookup_status);
 
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index e1add34..a7d6ad9 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -60,104 +60,6 @@ acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node *node_to_search);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_report_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              internal_name       - Name or path of the namespace node
- *              lookup_status       - Exception code from NS lookup
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print warning message with full pathname
- *
- ******************************************************************************/
-
-void
-acpi_ns_report_error(const char *module_name,
-		     u32 line_number,
-		     const char *internal_name, acpi_status lookup_status)
-{
-	acpi_status status;
-	u32 bad_name;
-	char *name = NULL;
-
-	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
-
-	if (lookup_status == AE_BAD_CHARACTER) {
-
-		/* There is a non-ascii character in the name */
-
-		ACPI_MOVE_32_TO_32(&bad_name,
-				   ACPI_CAST_PTR(u32, internal_name));
-		acpi_os_printf("[0x%4.4X] (NON-ASCII)", bad_name);
-	} else {
-		/* Convert path to external format */
-
-		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
-						  internal_name, NULL, &name);
-
-		/* Print target name */
-
-		if (ACPI_SUCCESS(status)) {
-			acpi_os_printf("[%s]", name);
-		} else {
-			acpi_os_printf("[COULD NOT EXTERNALIZE NAME]");
-		}
-
-		if (name) {
-			ACPI_FREE(name);
-		}
-	}
-
-	acpi_os_printf(" Namespace lookup failure, %s\n",
-		       acpi_format_exception(lookup_status));
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_report_method_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              Message             - Error message to use on failure
- *              prefix_node         - Prefix relative to the path
- *              Path                - Path to the node (optional)
- *              method_status       - Execution status
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print warning message with full pathname
- *
- ******************************************************************************/
-
-void
-acpi_ns_report_method_error(const char *module_name,
-			    u32 line_number,
-			    const char *message,
-			    struct acpi_namespace_node *prefix_node,
-			    const char *path, acpi_status method_status)
-{
-	acpi_status status;
-	struct acpi_namespace_node *node = prefix_node;
-
-	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
-
-	if (path) {
-		status =
-		    acpi_ns_get_node(prefix_node, path, ACPI_NS_NO_UPSEARCH,
-				     &node);
-		if (ACPI_FAILURE(status)) {
-			acpi_os_printf("[Could not get node by pathname]");
-		}
-	}
-
-	acpi_ns_print_node_pathname(node, message);
-	acpi_os_printf(", %s\n", acpi_format_exception(method_status));
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_print_node_pathname
  *
  * PARAMETERS:  Node            - Object
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index e8d0724..c7d0e05 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -50,11 +50,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmisc")
 
-/*
- * Common suffix for messages
- */
-#define ACPI_COMMON_MSG_SUFFIX \
-	acpi_os_printf(" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_validate_exception
@@ -1044,160 +1039,3 @@ acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
 
 	return_ACPI_STATUS(AE_AML_INTERNAL);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_error, acpi_exception, acpi_warning, acpi_info
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              Format              - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print message with module/line/version info
- *
- ******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_error(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Error: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_exception(const char *module_name,
-	       u32 line_number, acpi_status status, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Exception: %s, ", acpi_format_exception(status));
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_warning(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Warning: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_info(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	acpi_os_printf("\n");
-	va_end(args);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_error)
-ACPI_EXPORT_SYMBOL(acpi_exception)
-ACPI_EXPORT_SYMBOL(acpi_warning)
-ACPI_EXPORT_SYMBOL(acpi_info)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_warning
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              Pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              Format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Warnings for the predefined validation module. Messages are
- *              only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of error
- *              messages for methods that are repeatedly evaluated.
- *
-******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_warning(const char *module_name,
-			   u32 line_number,
-			   char *pathname,
-			   u8 node_flags, const char *format, ...)
-{
-	va_list args;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf("ACPI Warning for %s: ", pathname);
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_info
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              Pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              Format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Info messages for the predefined validation module. Messages
- *              are only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of
- *              messages for methods that are repeatedly evaluated.
- *
- ******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_info(const char *module_name,
-			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...)
-{
-	va_list args;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf("ACPI Info for %s: ", pathname);
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
new file mode 100644
index 0000000..bf679c4
--- /dev/null
+++ b/drivers/acpi/acpica/utxferror.c
@@ -0,0 +1,415 @@
+/*******************************************************************************
+ *
+ * Module Name: utxferror - Various error/warning output functions
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utxferror")
+
+/*
+ * This module is used for the in-kernel ACPICA as well as the ACPICA
+ * tools/applications.
+ *
+ * For the i_aSL compiler case, the output is redirected to stderr so that
+ * any of the various ACPI errors and warnings do not appear in the output
+ * files, for either the compiler or disassembler portions of the tool.
+ */
+#ifdef ACPI_ASL_COMPILER
+#include <stdio.h>
+extern FILE *acpi_gbl_output_file;
+
+#define ACPI_MSG_REDIRECT_BEGIN \
+	FILE                            *output_file = acpi_gbl_output_file; \
+	acpi_os_redirect_output (stderr);
+
+#define ACPI_MSG_REDIRECT_END \
+	acpi_os_redirect_output (output_file);
+
+#else
+/*
+ * non-i_aSL case - no redirection, nothing to do
+ */
+#define ACPI_MSG_REDIRECT_BEGIN
+#define ACPI_MSG_REDIRECT_END
+#endif
+/*
+ * Common message prefixes
+ */
+#define ACPI_MSG_ERROR          "ACPI Error: "
+#define ACPI_MSG_EXCEPTION      "ACPI Exception: "
+#define ACPI_MSG_WARNING        "ACPI Warning: "
+#define ACPI_MSG_INFO           "ACPI: "
+/*
+ * Common message suffix
+ */
+#define ACPI_MSG_SUFFIX \
+	acpi_os_printf (" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Error" message with module/line/version info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_error(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_error)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_exception
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Status              - Status to be formatted
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Exception" message with module/line/version info
+ *              and decoded acpi_status.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_exception(const char *module_name,
+	       u32 line_number, acpi_status status, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
+		       acpi_format_exception(status));
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_exception)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_warning
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Warning" message with module/line/version info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_warning(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_WARNING);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_warning)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_info
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print generic "ACPI:" information message. There is no
+ *              module/line/version info in order to keep the message simple.
+ *
+ * TBD: module_name and line_number args are not needed, should be removed.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_info(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_INFO);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	acpi_os_printf("\n");
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_info)
+
+/*
+ * The remainder of this module contains internal error functions that may
+ * be configured out.
+ */
+#ifndef ACPI_NO_ERROR_MESSAGES
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_warning
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Warnings for the predefined validation module. Messages are
+ *              only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of error
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_warning(const char *module_name,
+			   u32 line_number,
+			   char *pathname,
+			   u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_WARNING "For %s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_info
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Info messages for the predefined validation module. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_INFO "For %s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_namespace_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              internal_name       - Name or path of the namespace node
+ *              lookup_status       - Exception code from NS lookup
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print error message with the full pathname for the NS node.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_namespace_error(const char *module_name,
+			u32 line_number,
+			const char *internal_name, acpi_status lookup_status)
+{
+	acpi_status status;
+	u32 bad_name;
+	char *name = NULL;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	if (lookup_status == AE_BAD_CHARACTER) {
+
+		/* There is a non-ascii character in the name */
+
+		ACPI_MOVE_32_TO_32(&bad_name,
+				   ACPI_CAST_PTR(u32, internal_name));
+		acpi_os_printf("[0x%4.4X] (NON-ASCII)", bad_name);
+	} else {
+		/* Convert path to external format */
+
+		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
+						  internal_name, NULL, &name);
+
+		/* Print target name */
+
+		if (ACPI_SUCCESS(status)) {
+			acpi_os_printf("[%s]", name);
+		} else {
+			acpi_os_printf("[COULD NOT EXTERNALIZE NAME]");
+		}
+
+		if (name) {
+			ACPI_FREE(name);
+		}
+	}
+
+	acpi_os_printf(" Namespace lookup failure, %s",
+		       acpi_format_exception(lookup_status));
+
+	ACPI_MSG_SUFFIX;
+	ACPI_MSG_REDIRECT_END;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_method_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Message             - Error message to use on failure
+ *              prefix_node         - Prefix relative to the path
+ *              Path                - Path to the node (optional)
+ *              method_status       - Execution status
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print error message with the full pathname for the method.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_method_error(const char *module_name,
+		     u32 line_number,
+		     const char *message,
+		     struct acpi_namespace_node *prefix_node,
+		     const char *path, acpi_status method_status)
+{
+	acpi_status status;
+	struct acpi_namespace_node *node = prefix_node;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	if (path) {
+		status =
+		    acpi_ns_get_node(prefix_node, path, ACPI_NS_NO_UPSEARCH,
+				     &node);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("[Could not get node by pathname]");
+		}
+	}
+
+	acpi_ns_print_node_pathname(node, message);
+	acpi_os_printf(", %s", acpi_format_exception(method_status));
+
+	ACPI_MSG_SUFFIX;
+	ACPI_MSG_REDIRECT_END;
+}
+
+#endif				/* ACPI_NO_ERROR_MESSAGES */

>From bd366fff2aac413667b6221e828e35fe06c6808e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 15 Sep 2010 14:11:02 +0800
Subject: [PATCH 7/9] ACPICA: Add repair for _HID and _CID strings

This dynamic repair will fix these problems:
1) Remove a leading asterisk in the string
2) Uppercase the entire string

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |  163 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 4009498..4ef9f43 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -74,10 +74,18 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_CID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_HID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_PSS(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
@@ -108,8 +116,10 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * As necessary:
  *
  * _ALR: Sort the list ascending by ambient_illuminance
+ * _CID: Strings: uppercase all, remove any leading asterisk
  * _FDE: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
+ * _HID: Strings: uppercase all, remove any leading asterisk
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
  *
@@ -122,8 +132,10 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  */
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},
+	{"_CID", acpi_ns_repair_CID},
 	{"_FDE", acpi_ns_repair_FDE},
 	{"_GTM", acpi_ns_repair_FDE},	/* _GTM has same repair as _FDE */
+	{"_HID", acpi_ns_repair_HID},
 	{"_PSS", acpi_ns_repair_PSS},
 	{"_TSS", acpi_ns_repair_TSS},
 	{{0, 0, 0, 0}, NULL}	/* Table terminator */
@@ -321,6 +333,157 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_CID
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _CID object. If a string, ensure that all
+ *              letters are uppercase and that there is no leading asterisk.
+ *              If a Package, ensure same for all string elements.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_CID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	acpi_status status;
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object **element_ptr;
+	union acpi_operand_object *original_element;
+	u16 original_ref_count;
+	u32 i;
+
+	/* Check for _CID as a simple string */
+
+	if (return_object->common.type == ACPI_TYPE_STRING) {
+		status = acpi_ns_repair_HID(data, return_object_ptr);
+		return (status);
+	}
+
+	/* Exit if not a Package */
+
+	if (return_object->common.type != ACPI_TYPE_PACKAGE) {
+		return (AE_OK);
+	}
+
+	/* Examine each element of the _CID package */
+
+	element_ptr = return_object->package.elements;
+	for (i = 0; i < return_object->package.count; i++) {
+		original_element = *element_ptr;
+		original_ref_count = original_element->common.reference_count;
+
+		status = acpi_ns_repair_HID(data, element_ptr);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Take care with reference counts */
+
+		if (original_element != *element_ptr) {
+
+			/* Element was replaced */
+
+			(*element_ptr)->common.reference_count =
+			    original_ref_count;
+
+			acpi_ut_remove_reference(original_element);
+		}
+
+		element_ptr++;
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_HID
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _HID object. If a string, ensure that all
+ *              letters are uppercase and that there is no leading asterisk.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_HID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object *new_string;
+	char *source;
+	char *dest;
+
+	ACPI_FUNCTION_NAME(ns_repair_HID);
+
+	/* We only care about string _HID objects (not integers) */
+
+	if (return_object->common.type != ACPI_TYPE_STRING) {
+		return (AE_OK);
+	}
+
+	if (return_object->string.length == 0) {
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Invalid zero-length _HID or _CID string"));
+
+		/* Return AE_OK anyway, let driver handle it */
+
+		data->flags |= ACPI_OBJECT_REPAIRED;
+		return (AE_OK);
+	}
+
+	/* It is simplest to always create a new string object */
+
+	new_string = acpi_ut_create_string_object(return_object->string.length);
+	if (!new_string) {
+		return (AE_NO_MEMORY);
+	}
+
+	/*
+	 * Remove a leading asterisk if present. For some unknown reason, there
+	 * are many machines in the field that contains IDs like this.
+	 *
+	 * Examples: "*PNP0C03", "*ACPI0003"
+	 */
+	source = return_object->string.pointer;
+	if (*source == '*') {
+		source++;
+		new_string->string.length--;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Removed invalid leading asterisk\n",
+				  data->pathname));
+	}
+
+	/*
+	 * Copy and uppercase the string. From the ACPI specification:
+	 *
+	 * A valid PNP ID must be of the form "AAA####" where A is an uppercase
+	 * letter and # is a hex digit. A valid ACPI ID must be of the form
+	 * "ACPI####" where # is a hex digit.
+	 */
+	for (dest = new_string->string.pointer; *source; dest++, source++) {
+		*dest = (char)ACPI_TOUPPER(*source);
+	}
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_string;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_TSS
  *
  * PARAMETERS:  Data                - Pointer to validation data structure

>From 0725307bfbc29d90198698c3287c77878e57608d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 17 Sep 2010 08:14:01 +0800
Subject: [PATCH 8/9] ACPICA: Increase configurability of error messages

Update to utxferror.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utxferror.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index bf679c4..6f12e31 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -221,7 +221,7 @@ ACPI_EXPORT_SYMBOL(acpi_info)
  * The remainder of this module contains internal error functions that may
  * be configured out.
  */
-#ifndef ACPI_NO_ERROR_MESSAGES
+#if !defined (ACPI_NO_ERROR_MESSAGES) && !defined (ACPI_BIN_APP)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_predefined_warning

>From e6c1d9afc756f8c8a8f10256bb20a60dc4566ae9 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 17 Sep 2010 08:15:02 +0800
Subject: [PATCH 9/9] ACPICA: Update version to 20100915

Version 20100915.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c156e5e..c6bc604 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100806
+#define ACPI_CA_VERSION                 0x20100915
 
 #include "actypes.h"
 #include "actbl.h"


--=-rggu8lXfL/M80PIgBKyl--

