From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: [PATCH] GUID-identified vendor data resources
Date: Fri, 19 Sep 2003 15:55:19 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF20@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Looks like CA is going to hold off for now - although if Len wants to
apply it to the Linux version that's his call. -- Andy

-----Original Message-----
From: Therien, Guy=20
Sent: Tuesday, September 16, 2003 11:35 AM
To: Moore, Robert; Grover, Andrew
Subject: RE: [PATCH] GUID-identified vendor data resources


Agree - we cannot do this until spec is public

-----Original Message-----
From: Moore, Robert=20
Sent: Tuesday, September 16, 2003 11:32 AM
To: Grover, Andrew
Cc: Therien, Guy
Subject: RE: [PATCH] GUID-identified vendor data resources



I don't think we will add this until it is part of the spec. Bob


-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]=20
Sent: Thursday, August 14, 2003 2:43 PM
To: Grover, Andrew
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-ia64@vger.kernel.org
Subject: [PATCH] GUID-identified vendor data resources

Here's a patch to add support for vendor data resources identified by
GUIDs.

The idea is to add a GUID and a subtype to the data in a vendor- defined
resource, so we can tell what sort of data the resource contains.

HP ships firmware that uses this and is working to formally incorporate
this into the spec.  Unfortunately I don't think there's a public
document describing it yet, but it's pretty trivial.  It just adds a
header:

+struct acpi_vendor_descriptor {
+	u8				guid_id;
+	efi_guid_t			guid;
+};

at the beginning of the vendor-defined data area, and the payload data
starts after the header.

This applies to the current ACPI in both 2.4 and 2.5.  There don't seem
to be any prior references to GUIDs in ACPI, and I'm not sure how to
cleanly integrate it.  For now I just added the "#include <linux/efi.h>"
in aclinux.h, but I'm open to suggestions.

Bjorn


--- 1.16/drivers/acpi/resources/rsxface.c	Thu Apr 24 12:22:45 2003
+++ edited/drivers/acpi/resources/rsxface.c	Thu Aug 14 16:12:49 2003
@@ -410,3 +410,100 @@
=20
 	return (AE_OK);
 }
+
+struct acpi_vendor_info {
+	struct acpi_vendor_descriptor	*descriptor;
+	int				found;
+	u8				*data;
+	u32				length;
+};
+
+static acpi_status
+acpi_vendor_resource_match (
+	struct acpi_resource		*resource,
+	void				*context)
+{
+	struct acpi_vendor_info		*info =3D (struct acpi_vendor_info
*) context;
+	struct acpi_resource_vendor	*vendor;
+	struct acpi_vendor_descriptor	*descriptor;
+
+	if (resource->id !=3D ACPI_RSTYPE_VENDOR)
+		return AE_OK;
+
+	vendor =3D (struct acpi_resource_vendor *) &resource->data;
+	descriptor =3D (struct acpi_vendor_descriptor *) vendor->reserved;
+	if (vendor->length < sizeof(struct acpi_vendor_descriptor) ||
+	    descriptor->guid_id !=3D info->descriptor->guid_id ||
+	    efi_guidcmp(descriptor->guid, info->descriptor->guid))
+		return AE_OK;
+
+	info->found =3D 1;
+	info->length =3D vendor->length - sizeof(struct
acpi_vendor_descriptor);
+	if (!info->length)
+		return AE_CTRL_TERMINATE;	/* descriptor, but no
payload */
+
+	info->data =3D acpi_os_allocate(info->length);
+	if (!info->data)
+		return AE_NO_MEMORY;
+
+	memcpy(info->data, vendor->reserved + sizeof(struct
acpi_vendor_descriptor), info->length);
+	return AE_CTRL_TERMINATE;
+}
+
+
+/**********************************************************************
+*********
+ *
+ * FUNCTION:    acpi_find_vendor_resource
+ *
+ * PARAMETERS:  device_handle   - a handle to the device object for the
+ *                                device we are querying
+ *              id		- a pointer to descriptor for desired
+ *				  vendor resource
+ *              data		- (out) a pointer to a pointer where
payload
+ *                                data is returned
+ *              length		- (out) a pointer to the length of
payload
+ *				  data
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function evaluates the object's _CRS method and
+ *		searches the result for a large vendor-defined resource
+ *		identified by the supplied GUID and subtype.  If such
+ *		a resource is found, a pointer to the payload data is
+ *		returned, along with the length of the payload data.
+ *
+ *		The caller is responsible for deallocating the buffer
+ *		returned in "data" with acpi_os_free().
+ *
+ *		If the function fails, "data" and "length" are
+ *		unchanged.
+ * =20
+***********************************************************************
+*******/
+
+acpi_status
+acpi_find_vendor_resource (
+	acpi_handle			device_handle,
+	struct acpi_vendor_descriptor	*id,
+	u8				**data,
+	u32				*length)
+{
+	struct acpi_vendor_info		info;
+	acpi_status			status;
+
+
+	ACPI_FUNCTION_TRACE ("acpi_find_vendor_resource");
+
+
+	info.descriptor =3D id;
+	info.found =3D 0;
+	info.data =3D 0;
+
+	status =3D acpi_walk_resources(device_handle, METHOD_NAME__CRS,
+		acpi_vendor_resource_match, &info);
+	if (ACPI_FAILURE(status) || !info.found)
+		return_ACPI_STATUS (AE_NOT_FOUND);
+
+	*data =3D info.data;
+	*length =3D info.length;
+	return_ACPI_STATUS (AE_OK);
+}
--- 1.23/include/acpi/acpixf.h	Fri May 23 17:01:52 2003
+++ edited/include/acpi/acpixf.h	Thu Aug 14 16:12:49 2003
@@ -412,6 +412,18 @@
 	struct acpi_resource            *resource,
 	struct acpi_resource_address64 *out);
=20
+struct acpi_vendor_descriptor {
+	u8				guid_id;
+	efi_guid_t			guid;
+};
+
+acpi_status
+acpi_find_vendor_resource (
+	acpi_handle			obj,
+	struct acpi_vendor_descriptor	*id,
+	u8				**data,
+	u32				*length);
+
 /*
  * Hardware (ACPI device) interfaces
  */
--- 1.20/include/acpi/platform/aclinux.h	Tue Feb 18 16:32:35 2003
+++ edited/include/acpi/platform/aclinux.h	Thu Aug 14 16:12:49 2003
@@ -52,6 +52,7 @@
 #ifdef __KERNEL__
=20
 #include <linux/config.h>
+#include <linux/efi.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
