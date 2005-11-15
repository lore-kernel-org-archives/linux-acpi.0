From: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Tue, 15 Nov 2005 18:29:42 +0900
Message-ID: <4379AA86.5040901@jp.fujitsu.com>
References: <1131399845.6313.73.camel@knk>  <1131677135.20603.22.camel@knk>	 <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080800080309090300060804"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132033003.3798.21.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800080309090300060804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

keith wrote:
> Hello,
> 
>   I am submitting this patch for inclusion in the acpi development tree.
> I have not received any feedback of my beta patch or emails over the
> past week.  I cleaned my previous patch up and made the error handling
> match the rest of the driver.  I need this patch to support my hardware
> (IBM x460/x366/x445) acpi hot-add memory events.   
> 

Sorry, I missed your previous e-mail.

>   In general acpi_bus_get_device fails for my event. 
> acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
>   The current driver relies on acpi_bus_get_device to create the acpi
> memory_device but these call fails for my hardware.  
>   

I think the case in which a device is not onlined at boot time and
not -scaned- is not correctly managed. Could you try attached patch ?

-- Kame <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

==
Fix acpi_memory_get_device().
A case of "memory object is not onlined at boot time but hot-added" is managed.


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


Index: linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
@@ -77,6 +77,24 @@ struct acpi_memory_device {
  	u64 end_addr;		/* Memory Range end physical addr */
  };

+/* Maybe the same function in acpi_contaiener.c should be exported ..*/
+#define ACPI_STA_PRESENT                (0x00000001)
+static int is_memory_device_present(acpi_handle handle)
+{
+	acpi_status status;
+	unsigned long sta;
+	acpi_handle temp;
+	ACPI_FUNCTION_TRACE("is_memory_device_present");
+	status = acpi_get_handle(handle, "_STA", &temp);
+	if (ACPI_FAILURE(status))
+		return_VALUE(1);	/* _STA not found, assume present */
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return_VALUE(0);
+	return_VALUE((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
+}
+
+
  static int
  acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
  {
@@ -112,18 +130,14 @@ acpi_memory_get_device_resources(struct

  static int
  acpi_memory_get_device(acpi_handle handle,
-		       struct acpi_memory_device **mem_device)
+		       struct acpi_device **device)
  {
  	acpi_status status;
  	acpi_handle phandle;
-	struct acpi_device *device = NULL;
  	struct acpi_device *pdevice = NULL;

  	ACPI_FUNCTION_TRACE("acpi_memory_get_device");

-	if (!acpi_bus_get_device(handle, &device) && device)
-		goto end;
-
  	status = acpi_get_parent(handle, &phandle);
  	if (ACPI_FAILURE(status)) {
  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_get_parent\n"));
@@ -138,23 +152,12 @@ acpi_memory_get_device(acpi_handle handl
  		return_VALUE(-EINVAL);
  	}

-	/*
-	 * Now add the notified device.  This creates the acpi_device
-	 * and invokes .add function
-	 */
-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
+	status = acpi_bus_add(device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
  	if (ACPI_FAILURE(status)) {
  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
  		return_VALUE(-EINVAL);
  	}

-      end:
-	*mem_device = acpi_driver_data(device);
-	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
-	}
-
  	return_VALUE(0);
  }

@@ -282,9 +285,11 @@ static void acpi_memory_device_notify(ac
  {
  	struct acpi_memory_device *mem_device;
  	struct acpi_device *device;
+	acpi_status status;
+	int present;

  	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
-
+	present = is_memory_device_present(handle);
  	switch (event) {
  	case ACPI_NOTIFY_BUS_CHECK:
  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -294,12 +299,26 @@ static void acpi_memory_device_notify(ac
  		if (event == ACPI_NOTIFY_DEVICE_CHECK)
  			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
  					  "\nReceived DEVICE CHECK notification for device\n"));
-		if (acpi_memory_get_device(handle, &mem_device)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		status = acpi_bus_get_device(handle, &device);
+		if (ACPI_FAILURE(status) || !device) {
+			if (present) {
+				status = acpi_memory_get_device(handle, &device);
+				if (ACPI_FAILURE(status) || !device) {
+					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
  					  "Error in finding driver data\n"));
+					return_VOID;
+				}
+			} else {
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"notified handle seems not present"));
+				return_VOID;
+			}
+		}
+		mem_device = acpi_driver_data(device);
+		if (!mem_device) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "error acpi_memhotplug: device has no mem_device"));
  			return_VOID;
  		}
-
  		if (!acpi_memory_check_device(mem_device)) {
  			if (acpi_memory_enable_device(mem_device))
  				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,

--------------080800080309090300060804
Content-Type: text/x-patch;
 name="acpi_memhotplug_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_memhotplug_fix.patch"

Fix acpi_memory_get_device().
A case of "memory object is not onlined at boot time but hot-added" is managed.


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


Index: linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
@@ -77,6 +77,24 @@ struct acpi_memory_device {
 	u64 end_addr;		/* Memory Range end physical addr */
 };
 
+/* Maybe the same function in acpi_contaiener.c should be exported ..*/
+#define ACPI_STA_PRESENT                (0x00000001)
+static int is_memory_device_present(acpi_handle handle)
+{
+	acpi_status status;
+	unsigned long sta;
+	acpi_handle temp;
+	ACPI_FUNCTION_TRACE("is_memory_device_present");
+	status = acpi_get_handle(handle, "_STA", &temp);
+	if (ACPI_FAILURE(status))
+		return_VALUE(1);	/* _STA not found, assume present */
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return_VALUE(0);
+	return_VALUE((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
+}
+
+
 static int
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
 {
@@ -112,18 +130,14 @@ acpi_memory_get_device_resources(struct 
 
 static int
 acpi_memory_get_device(acpi_handle handle,
-		       struct acpi_memory_device **mem_device)
+		       struct acpi_device **device)
 {
 	acpi_status status;
 	acpi_handle phandle;
-	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
 
-	if (!acpi_bus_get_device(handle, &device) && device)
-		goto end;
-
 	status = acpi_get_parent(handle, &phandle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_get_parent\n"));
@@ -138,23 +152,12 @@ acpi_memory_get_device(acpi_handle handl
 		return_VALUE(-EINVAL);
 	}
 
-	/*
-	 * Now add the notified device.  This creates the acpi_device
-	 * and invokes .add function
-	 */
-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
+	status = acpi_bus_add(device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
 		return_VALUE(-EINVAL);
 	}
 
-      end:
-	*mem_device = acpi_driver_data(device);
-	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
-	}
-
 	return_VALUE(0);
 }
 
@@ -282,9 +285,11 @@ static void acpi_memory_device_notify(ac
 {
 	struct acpi_memory_device *mem_device;
 	struct acpi_device *device;
+	acpi_status status;
+	int present;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
-
+	present = is_memory_device_present(handle);
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -294,12 +299,26 @@ static void acpi_memory_device_notify(ac
 		if (event == ACPI_NOTIFY_DEVICE_CHECK)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "\nReceived DEVICE CHECK notification for device\n"));
-		if (acpi_memory_get_device(handle, &mem_device)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		status = acpi_bus_get_device(handle, &device);
+		if (ACPI_FAILURE(status) || !device) {
+			if (present) {
+				status = acpi_memory_get_device(handle, &device);
+				if (ACPI_FAILURE(status) || !device) {
+					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 					  "Error in finding driver data\n"));
+					return_VOID;
+				}
+			} else {
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"notified handle seems not present"));
+				return_VOID;
+			}
+		}
+		mem_device = acpi_driver_data(device);
+		if (!mem_device) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "error acpi_memhotplug: device has no mem_device"));
 			return_VOID;
 		}
-
 		if (!acpi_memory_check_device(mem_device)) {
 			if (acpi_memory_enable_device(mem_device))
 				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,

--------------080800080309090300060804--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
