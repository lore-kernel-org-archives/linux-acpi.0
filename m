From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Thu, 8 Apr 2004 18:25:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040408172548.GH18329@parcelfarce.linux.theplanet.co.uk>
References: <1081373781.23176.30.camel@t40> <1081376023.2748.15.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1081376023.2748.15.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 07, 2004 at 04:13:43PM -0600, Alex Williamson wrote:
>    Here you go, a second iteration.  I haven't looked at the _Qxx
> methods yet, but we're up to over 30 methods exported now.  I've added
> several writable methods so you can do more than query status.  I've
> been able to undock my omnibook 500 laptop (electromechanical eject) and
> switch between a CRT and LCD using only the sysfs interface.  I thought
> about parsing some of the more complicated data structures, but that
> turned into way too much code too quickly.  So you'll find there are
> several entries that return a binary dump of the data structures.  these
> include _CRS, _PRS, _PRT, and _MAT.  Some of the methods look like they
> should work, but I don't have a box w/ firmware that exports them, so
> let me know if the output is broken.  Thanks,

Ii'm not a big fan of overloading acpi_device_read_file ... how about
splitting it up like this?

diff -u edited/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- edited/drivers/acpi/scan.c	Wed Apr  7 15:55:17 2004
+++ b/drivers/acpi/scan.c	8 Apr 2004 15:49:40 -0000
@@ -146,61 +146,86 @@
 	ssize_t retval = 0;
 	unsigned int flags = 0;
 
-	if (!strcmp(method, METHOD_NAME__CRS)) {
-		status = acpi_get_current_resources(device->handle, &buffer);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-
-		memcpy(buf, buffer.pointer, buffer.length);
-		retval = buffer.length;
-		acpi_os_free(buffer.pointer);
-	} else if (!strcmp(method, METHOD_NAME__PRS)) {
-		status = acpi_get_possible_resources(device->handle, &buffer);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-
-		memcpy(buf, buffer.pointer, buffer.length);
-		retval = buffer.length;
-		acpi_os_free(buffer.pointer);
-	} else if (!strcmp(method, METHOD_NAME__PRT)) {
-		status = acpi_get_irq_routing_table(device->handle, &buffer);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-
-		memcpy(buf, buffer.pointer, buffer.length);
-		retval = buffer.length;
-		acpi_os_free(buffer.pointer);
-	} else if (!strcmp(method, METHOD_NAME__MAT)) {
-		status = acpi_evaluate_object(device->handle, method,
-		                              NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-
-		memcpy(buf, buffer.pointer, buffer.length);
-		retval = buffer.length;
-		acpi_os_free(buffer.pointer);
-	} else {
-		status = acpi_evaluate_object(device->handle, method,
-		                              NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	
-		if (!strcmp(method, METHOD_NAME__HID)
-		    || !strcmp(method, METHOD_NAME__CID)
-		    || !strcmp(method, METHOD_NAME__FIX))
-			flags |= EISA_ID_TYPE;
-
-		if (!strcmp(method, METHOD_NAME__STR))
-			flags |= UNICODE_TYPE;
-
-		element = (union acpi_object *) buffer.pointer;
-		retval = parse_element(buf, element, flags);
-		acpi_os_free(buffer.pointer);
-	}
+	status = acpi_evaluate_object(device->handle, method, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (!strcmp(method, METHOD_NAME__HID)
+	    || !strcmp(method, METHOD_NAME__CID)
+	    || !strcmp(method, METHOD_NAME__FIX))
+		flags = EISA_ID_TYPE;
+
+	if (!strcmp(method, METHOD_NAME__STR))
+		flags = UNICODE_TYPE;
+
+	element = (union acpi_object *) buffer.pointer;
+	retval = parse_element(buf, element, flags);
+	acpi_os_free(buffer.pointer);
+
 	return retval;
 }
 
 static ssize_t
+acpi_device_read_raw(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_evaluate_object(device->handle, method, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_read_crs(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_current_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_read_prs(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_possible_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_read_prt(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_irq_routing_table(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
 acpi_device_write_integer (
 	struct acpi_device	*device,
 	char			*method,
@@ -237,7 +262,7 @@
 acpi_handle_attr(_BCL, acpi_device_read_file, NULL)
 acpi_handle_attr(_BCM, NULL, acpi_device_write_integer)
 acpi_handle_attr(_CID, acpi_device_read_file, NULL)
-acpi_handle_attr(_CRS, acpi_device_read_file, NULL)
+acpi_handle_attr(_CRS, acpi_device_read_crs, NULL)
 acpi_handle_attr(_DCK, NULL, acpi_device_write_integer)
 acpi_handle_attr(_DCS, acpi_device_read_file, NULL)
 acpi_handle_attr(_DGS, acpi_device_read_file, NULL)
@@ -253,9 +278,9 @@
 acpi_handle_attr(_HPP, acpi_device_read_file, NULL)
 acpi_handle_attr(_LCK, NULL, acpi_device_write_integer)
 acpi_handle_attr(_LID, acpi_device_read_file, NULL)
-acpi_handle_attr(_MAT, acpi_device_read_file, NULL)
-acpi_handle_attr(_PRS, acpi_device_read_file, NULL)
-acpi_handle_attr(_PRT, acpi_device_read_file, NULL)
+acpi_handle_attr(_MAT, acpi_device_read_raw, NULL)
+acpi_handle_attr(_PRS, acpi_device_read_prs, NULL)
+acpi_handle_attr(_PRT, acpi_device_read_prt, NULL)
 acpi_handle_attr(_PXM, acpi_device_read_file, NULL)
 acpi_handle_attr(_RMV, acpi_device_read_file, NULL)
 acpi_handle_attr(_SEG, acpi_device_read_file, NULL)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
