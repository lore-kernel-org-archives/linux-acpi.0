From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 15:09:15 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200302211509.15641.bjorn_helgaas@hp.com>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> 2) I'm not convinced that this buys a whole lot -- it just hides the code
> behind a macro (something that's not generally liked in the Linux world.)
> Would this procedure be called from more than one place?

Or, since you mention a macro, maybe your question is not about
the usefulness of acpi_resource_to_address64() itself, but about
how I implemented it, namely, with the copy_field and copy_address
macros:

+#define copy_field(out, in, field)     out->field = in->field
+#define copy_address(out, in)                                  \
+       copy_field(out, in, resource_type);                     \
+       copy_field(out, in, producer_consumer);                 \
...

If you'd rather see it implemented without the macros, I have no
objection to that.  I just used the macros to reduce the chance of
making typographical errors along the way.  Attached is the
equivalent patch (untested) without the macros.  I also added a
note to the struct acpi_resource_addressXX definitions about the
need to make corresponding changes to acpi_resource_to_address64()
if the structures change.

Bjorn


diff -u -ur linux-2.5.59/drivers/acpi/resources/rsxface.c acpi-2/drivers/acpi/resources/rsxface.c
--- linux-2.5.59/drivers/acpi/resources/rsxface.c	2003-01-16 19:22:23.000000000 -0700
+++ acpi-2/drivers/acpi/resources/rsxface.c	2003-02-21 14:45:00.000000000 -0700
@@ -233,3 +233,83 @@
 	status = acpi_rs_set_srs_method_data (device_handle, in_buffer);
 	return_ACPI_STATUS (status);
 }
+
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_resource_to_address64
+ *
+ * PARAMETERS:  resource                - Pointer to a resource
+ *              out                     - Pointer to the users's return 
+ *                                        buffer (a struct
+ *                                        acpi_resource_address64)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: If the resource is an address16, address32, or address64,
+ *              copy it to the address64 return buffer.  This saves the
+ *              caller from having to duplicate code for different-sized
+ *              addresses.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_resource_to_address64 (
+	struct acpi_resource            *resource,
+	struct acpi_resource_address64  *out)
+{
+	struct acpi_resource_address16  *address16;
+	struct acpi_resource_address32  *address32;
+	struct acpi_resource_address64  *address64;
+
+	switch (resource->id) {
+		case ACPI_RSTYPE_ADDRESS16:
+			address16 = (struct acpi_resource_address16 *) &resource->data;
+			out->resource_type              = address16->resource_type;
+			out->producer_consumer          = address16->producer_consumer;
+			out->decode                     = address16->decode;
+			out->min_address_fixed          = address16->min_address_fixed;
+			out->max_address_fixed          = address16->max_address_fixed;
+			out->attribute                  = address16->attribute;
+			out->granularity                = address16->granularity;
+			out->min_address_range          = address16->min_address_range;
+			out->max_address_range          = address16->max_address_range;
+			out->address_translation_offset = address16->address_translation_offset;
+			out->address_length             = address16->address_length;
+			out->resource_source            = address16->resource_source;
+			break;
+		case ACPI_RSTYPE_ADDRESS32:
+			address32 = (struct acpi_resource_address32 *) &resource->data;
+			out->resource_type              = address32->resource_type;
+			out->producer_consumer          = address32->producer_consumer;
+			out->decode                     = address32->decode;
+			out->min_address_fixed          = address32->min_address_fixed;
+			out->max_address_fixed          = address32->max_address_fixed;
+			out->attribute                  = address32->attribute;
+			out->granularity                = address32->granularity;
+			out->min_address_range          = address32->min_address_range;
+			out->max_address_range          = address32->max_address_range;
+			out->address_translation_offset = address32->address_translation_offset;
+			out->address_length             = address32->address_length;
+			out->resource_source            = address32->resource_source;
+			break;
+		case ACPI_RSTYPE_ADDRESS64:
+			address64 = (struct acpi_resource_address64 *) &resource->data;
+			out->resource_type              = address64->resource_type;
+			out->producer_consumer          = address64->producer_consumer;
+			out->decode                     = address64->decode;
+			out->min_address_fixed          = address64->min_address_fixed;
+			out->max_address_fixed          = address64->max_address_fixed;
+			out->attribute                  = address64->attribute;
+			out->granularity                = address64->granularity;
+			out->min_address_range          = address64->min_address_range;
+			out->max_address_range          = address64->max_address_range;
+			out->address_translation_offset = address64->address_translation_offset;
+			out->address_length             = address64->address_length;
+			out->resource_source            = address64->resource_source;
+			break;
+		default:
+			return (AE_BAD_PARAMETER);
+	}
+	return (AE_OK);
+}
diff -u -ur linux-2.5.59/include/acpi/acpixf.h acpi-2/include/acpi/acpixf.h
--- linux-2.5.59/include/acpi/acpixf.h	2003-02-21 14:39:23.000000000 -0700
+++ acpi-2/include/acpi/acpixf.h	2003-02-21 14:40:16.000000000 -0700
@@ -340,6 +340,11 @@
 	acpi_handle                     bus_device_handle,
 	struct acpi_buffer              *ret_buffer);
 
+acpi_status
+acpi_resource_to_address64 (
+	struct acpi_resource            *resource,
+	struct acpi_resource_address64  *out);
+
 
 /*
  * Hardware (ACPI device) interfaces
diff -u -ur linux-2.5.59/include/acpi/actypes.h acpi-2/include/acpi/actypes.h
--- linux-2.5.59/include/acpi/actypes.h	2003-02-21 14:39:23.000000000 -0700
+++ acpi-2/include/acpi/actypes.h	2003-02-21 14:48:35.000000000 -0700
@@ -1049,6 +1049,11 @@
 	char                                *string_ptr;
 };
 
+/*
+ * Changes to the following address structures should
+ * also be reflected in acpi_resource_to_address64().
+ */
+
 struct acpi_resource_address16
 {
 	u32                                 resource_type;
