From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: implement UUID-labelled vendor-defined resources
Date: Tue, 11 Oct 2005 11:31:01 -0600
Message-ID: <200510111131.01813.bjorn.helgaas@hp.com>
References: <971FCB6690CD0E4898387DBF7552B90E02C0B5F2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E02C0B5F2-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 16 September 2005 3:56 pm, Moore, Robert wrote:
> And to make things even more interesting, the base ACPICA code looks
> nothing like the final Linux version of the code; it is converted on the
> fly before every release to Linux.

OK, here's the patch to the base ACPICA (prior to the Linux
conversion).

I tried to make it look ACPICA-ish.  When you integrate
this, there will be some breakage (name conflicts with the
old code that lives in arch/ia64/, probably a change required
to acpi_uuid.ByteData[], etc).  I hope it will be obvious
how to fix those up.  Applying the rest of my original
Linux-based patch should take care of most of it.

Let me know if I can help.

diff -u -ur acpica-unix-20050930/include/acpixf.h acpica-unix-20050930-new/include/acpixf.h
--- acpica-unix-20050930/include/acpixf.h	2005-09-30 16:50:25.000000000 -0600
+++ acpica-unix-20050930-new/include/acpixf.h	2005-10-11 11:08:32.000000000 -0600
@@ -498,6 +498,13 @@
     ACPI_RESOURCE           *Resource,
     ACPI_RESOURCE_ADDRESS64 *Out);
 
+ACPI_STATUS
+AcpiFindVendorResource (
+    ACPI_HANDLE		    DeviceHandle,
+    ACPI_VENDOR_DESCRIPTOR  *Id,
+    UINT8		    **Data,
+    UINT32		    *Length);
+
 /*
  * Hardware (ACPI device) interfaces
  */
diff -u -ur acpica-unix-20050930/include/actypes.h acpica-unix-20050930-new/include/actypes.h
--- acpica-unix-20050930/include/actypes.h	2005-09-30 16:50:25.000000000 -0600
+++ acpica-unix-20050930-new/include/actypes.h	2005-10-11 10:15:09.000000000 -0600
@@ -1145,6 +1145,17 @@
 #define ACPI_PRODUCER                   (UINT8) 0x00
 #define ACPI_CONSUMER                   (UINT8) 0x01
 
+typedef struct acpi_uuid
+{
+    UINT8			ByteData[16];
+} ACPI_UUID_STRUCT;
+
+#define ACPI_UUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
+    ((struct acpi_uuid) \
+    {{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
+      (b) & 0xff, ((b) >> 8) & 0xff, \
+      (c) & 0xff, ((c) >> 8) & 0xff, \
+      (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
 
 /*
  *  Structures used to describe device resources
@@ -1209,6 +1220,19 @@
 
 } ACPI_RESOURCE_VENDOR;
 
+typedef struct acpi_vendor_descriptor
+{
+    UINT8			UuidSubtype;
+    ACPI_UUID_STRUCT		Uuid;
+} ACPI_VENDOR_DESCRIPTOR;
+
+typedef struct acpi_vendor_info
+{
+    ACPI_VENDOR_DESCRIPTOR	*Descriptor;
+    UINT8			*Data;
+    UINT32			Length;
+} ACPI_VENDOR_INFO;
+
 typedef struct acpi_resource_end_tag
 {
     UINT8                       Checksum;
diff -u -ur acpica-unix-20050930/resources/rsxface.c acpica-unix-20050930-new/resources/rsxface.c
--- acpica-unix-20050930/resources/rsxface.c	2005-09-30 16:50:33.000000000 -0600
+++ acpica-unix-20050930-new/resources/rsxface.c	2005-10-11 11:10:26.000000000 -0600
@@ -514,3 +514,103 @@
 
     return (AE_OK);
 }
+
+static inline int
+AcpiUuidCmp (
+    ACPI_UUID_STRUCT		Left,
+    ACPI_UUID_STRUCT		Right)
+{
+    return memcmp(&Left, &Right, sizeof (Left));
+}
+
+static ACPI_STATUS
+AcpiVendorResourceMatch (
+    ACPI_RESOURCE		*Resource,
+    void			*Context)
+{
+    ACPI_VENDOR_INFO		*Info = (ACPI_VENDOR_INFO *) Context;
+    ACPI_RESOURCE_VENDOR	*Vendor;
+    ACPI_VENDOR_DESCRIPTOR	*Descriptor;
+    UINT32			Length;
+
+    if (Resource->Type != ACPI_RESOURCE_TYPE_VENDOR)
+    {
+	return AE_OK;
+    }
+
+    Vendor = (ACPI_RESOURCE_VENDOR *) &Resource->Data;
+    Descriptor = (ACPI_VENDOR_DESCRIPTOR *) Vendor->ByteData;
+    if (Vendor->ByteLength <= sizeof (*Info->Descriptor) ||
+	Descriptor->UuidSubtype != Info->Descriptor->UuidSubtype ||
+	AcpiUuidCmp(Descriptor->Uuid, Info->Descriptor->Uuid))
+    {
+	return AE_OK;
+    }
+
+    Length = Vendor->ByteLength - sizeof (ACPI_VENDOR_DESCRIPTOR);
+    Info->Data = AcpiOsAllocate(Length);
+    if (!Info->Data)
+    {
+	return AE_NO_MEMORY;
+    }
+
+    memcpy(Info->Data, Vendor->ByteData +
+	    sizeof (ACPI_VENDOR_DESCRIPTOR), Length);
+    Info->Length = Length;
+    return AE_CTRL_TERMINATE;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    AcpiFindVendorResource
+ *
+ * PARAMETERS:  DeviceHandle    - a handle to the device object for the
+ *                                device we are querying
+ *              Id              - a pointer to the acpi_vendor_descriptor
+ *                                for the UUID-identified vendor-defined
+ *                                resource we want
+ *              Data            - a pointer to a pointer where the address
+ *                                of the vendor data will be stored
+ *              Length          - a pointer to an integer where the length
+ *                                of the vendor data will be stored
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function walks the current resources for the specified
+ *              device and looks for a vendor-defined resource that matches
+ *              the supplied UUID and subtype.
+ *
+ *              If the desired resource is found, a buffer is allocated for
+ *              the vendor-defined data (excluding the UUID and other headers),
+ *              and the address and size of the buffer are returned in *Data
+ *              and *Length.  The caller is responsible for deallocating
+ *              the buffer with AcpiOsFree().
+ *
+ *              If the function fails, AE_NOT_FOUND will be returned and
+ *              the values of *Data and *Length are unchanged.
+ *
+ ******************************************************************************/
+
+ACPI_STATUS
+AcpiFindVendorResource (
+    ACPI_HANDLE				DeviceHandle,
+    ACPI_VENDOR_DESCRIPTOR		*Id,
+    UINT8				**Data,
+    UINT32				*Length)
+{
+    ACPI_VENDOR_INFO			Info;
+
+    Info.Descriptor = Id;
+    Info.Data = NULL;
+
+    AcpiWalkResources(DeviceHandle, METHOD_NAME__CRS,
+	    AcpiVendorResourceMatch, &Info);
+    if (!Info.Data)
+    {
+	return AE_NOT_FOUND;
+    }
+
+    *Data = Info.Data;
+    *Length = Info.Length;
+    return AE_OK;
+}



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
