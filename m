From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Tue, 2 Aug 2005 16:41:25 -0600
Message-ID: <200508021641.26007.bjorn.helgaas@hp.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200508011620.02609.bjorn.helgaas@hp.com> <20050801170345.A16268@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050801170345.A16268-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 01 August 2005 6:03 pm, Keshavamurthy Anil S wrote:
> I have patch to trigger
> fake SCI add and remove notifications to test some of this.
> Let me know if you need such patch for your testing.

Yes, I'd be interested in your patch.

Here's a patch (not ready for merging) that makes
acpi_bus_notify() pass the handle, rather than the device,
down to acpi_bus_check_device(), which then adds the device
if it didn't previously exist.

Is this heading down the right track?

Index: work/drivers/acpi/bus.c
===================================================================
--- work.orig/drivers/acpi/bus.c	2005-08-01 13:40:31.000000000 -0600
+++ work/drivers/acpi/bus.c	2005-08-02 15:31:24.000000000 -0600
@@ -383,15 +383,62 @@
    -------------------------------------------------------------------------- */
 
 static int
+acpi_bus_add_device (
+	acpi_handle		handle)
+{
+	struct acpi_device	*child = NULL;
+	struct acpi_device	*parent = NULL;
+	acpi_handle		phandle = NULL;
+	acpi_object_type	type = 0;
+
+	/* TBD: fold this into acpi_bus_add? */
+
+	if (acpi_get_parent(handle, &phandle))
+		return -EINVAL;
+
+	if (acpi_bus_get_device(phandle, &parent))
+		return -EINVAL;
+
+	if (acpi_get_type(handle, &type))
+		return -EINVAL;
+
+	switch (type) {
+	case ACPI_TYPE_DEVICE:
+		type = ACPI_BUS_TYPE_DEVICE;
+		break;
+	case ACPI_TYPE_PROCESSOR:
+		type = ACPI_BUS_TYPE_PROCESSOR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return acpi_bus_add(&child, parent, handle, type);
+}
+
+static int
 acpi_bus_check_device (
-	struct acpi_device	*device,
+	acpi_handle		handle,
 	int			*status_changed)
 {
 	acpi_status             status = 0;
+	struct acpi_device	*device = NULL;
 	struct acpi_device_status old_status;
+	int			result;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_check_device");
 
+	/*
+	 * If no device exists for this namespace node, a DEVICE_CHECK
+	 * notification means the device has appeared.
+	 */
+	if (acpi_bus_get_device(handle, &device)) {
+		result = acpi_bus_add_device(handle);
+		if (status_changed && result == 0)
+			*status_changed = 1;
+		return_VALUE(result);
+	}
+
 	if (!device)
 		return_VALUE(-EINVAL);
 
@@ -422,15 +469,11 @@
 
 	if (status_changed)
 		*status_changed = 1;
-	
+
 	/*
-	 * Device Insertion/Removal
+	 * Device Removal
 	 */
-	if ((device->status.present) && !(old_status.present)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device insertion detected\n"));
-		/* TBD: Handle device insertion */
-	}
-	else if (!(device->status.present) && (old_status.present)) {
+	if (!(device->status.present) && (old_status.present)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device removal detected\n"));
 		/* TBD: Handle device removal */
 	}
@@ -441,18 +484,15 @@
 
 static int
 acpi_bus_check_scope (
-	struct acpi_device	*device)
+	acpi_handle		handle)
 {
 	int			result = 0;
 	int			status_changed = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_check_scope");
 
-	if (!device)
-		return_VALUE(-EINVAL);
-
 	/* Status Change? */
-	result = acpi_bus_check_device(device, &status_changed);
+	result = acpi_bus_check_device(handle, &status_changed);
 	if (result)
 		return_VALUE(result);
 
@@ -480,19 +520,15 @@
 	void                    *data)
 {
 	int			result = 0;
-	struct acpi_device	*device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_notify");
 
-	if (acpi_bus_get_device(handle, &device))
-		return_VOID;
-
 	switch (type) {
 
 	case ACPI_NOTIFY_BUS_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received BUS CHECK notification for device [%s]\n", 
-			device->pnp.bus_id));
-		result = acpi_bus_check_scope(device);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received BUS CHECK notification for handle 0x%p\n",
+			handle));
+		result = acpi_bus_check_scope(handle);
 		/* 
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *	drivers via the device manager (device.c).
@@ -500,9 +536,9 @@
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE CHECK notification for device [%s]\n", 
-			device->pnp.bus_id));
-		result = acpi_bus_check_device(device, NULL);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE CHECK notification for handle 0x%p\n",
+			handle));
+		result = acpi_bus_check_device(handle, NULL);
 		/* 
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *	drivers via the device manager (device.c).
@@ -510,38 +546,38 @@
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE WAKE notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE WAKE notification for handle 0x%p\n",
+			handle));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received EJECT REQUEST notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received EJECT REQUEST notification for handle 0x%p\n",
+			handle));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE CHECK LIGHT notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received DEVICE CHECK LIGHT notification for handle 0x%p\n",
+			handle));
 		/* TBD: Exactly what does 'light' mean? */
 		break;
 
 	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received FREQUENCY MISMATCH notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received FREQUENCY MISMATCH notification for handle 0x%p\n",
+			handle));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received BUS MODE MISMATCH notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received BUS MODE MISMATCH notification for handle 0x%p\n",
+			handle));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_POWER_FAULT:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received POWER FAULT notification for device [%s]\n", 
-			device->pnp.bus_id));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Received POWER FAULT notification for handle 0x%p\n",
+			handle));
 		/* TBD */
 		break;
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
