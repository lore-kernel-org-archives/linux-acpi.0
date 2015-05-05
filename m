From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Tue, 05 May 2015 02:49:55 +0200
Message-ID: <12683914.6j7dxAgR6V@vostro.rjw.lan>
References: <3444888.xxxTREorHY@vostro.rjw.lan> <1816071.3jMa2RA6JD@vostro.rjw.lan> <20150422095718.GM1677@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57708 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751010AbbEEAYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 20:24:55 -0400
In-Reply-To: <20150422095718.GM1677@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wednesday, April 22, 2015 12:57:18 PM Mika Westerberg wrote:
> On Wed, Apr 22, 2015 at 03:54:16AM +0200, Rafael J. Wysocki wrote:
> > Any comments?
> > 
> > > ---
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Subject: ACPI / property: Refine consistency check for PRP0001
> > > 
> > > Refine the check for the presence of the "compatible" property
> > > if the PRP0001 device ID is present in the device's list of
> > > ACPI/PNP IDs to also print the message if _DSD is missing
> > > entirely or the format of it is incorrect.
> > > 
> > > While at it, reduce the log level of the message to "info"
> > > and reduce the log level of the "broken _DSD" message to
> > > "debug" (noise reduction).
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Looks good,
> 
> Reviewed-by: Mika Westerberg <mika.westerberb@linux.intel.com>

Thanks, I have an update, though.

In a recent discussion with Darren we've come to the conlusion that
having a parent with PRP0001 and "compatible" and a child with PRP0001 only
(without "compatible") is useful in cases when one complex device is
represented by a hierarchy of "device" objects (in analogy with device
nodes in a DT that have no struct device representations).  Thus it isn't
useful to complain that "compatible" is not present in such cases.

Updated patch:

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / property: Refine consistency check for PRP0001

Refine the check for the presence of the "compatible" property
if the PRP0001 device ID is present in the device's list of
ACPI/PNP IDs to also print the message if _DSD is missing
entirely or the format of it is incorrect.

One special case to take into accout is that the "compatible"
property need not be provided for devices having the PRP0001
device ID in their lists of ACPI/PNP IDs if they are ancestors
of PRP0001 devices with the "compatible" property present.
This is to cover heriarchies of device objects where the kernel
is only supposed to use a struct device representation for the
topmost one and the others represent, for example, functional
blocks of a composite device.

While at it, reduce the log level of the message to "info"
and reduce the log level of the "broken _DSD" message to
"debug" (noise reduction).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |   54 +++++++++++++++++++++++++++---------------------
 include/acpi/acpi_bus.h |    3 +-
 2 files changed, 33 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -79,50 +79,51 @@ static bool acpi_properties_format_valid
 static void acpi_init_of_compatible(struct acpi_device *adev)
 {
 	const union acpi_object *of_compatible;
-	struct acpi_hardware_id *hwid;
-	bool acpi_of = false;
 	int ret;
 
-	/*
-	 * Check if the special PRP0001 ACPI ID is present and in that
-	 * case we fill in Device Tree compatible properties for this
-	 * device.
-	 */
-	list_for_each_entry(hwid, &adev->pnp.ids, list) {
-		if (!strcmp(hwid->id, "PRP0001")) {
-			acpi_of = true;
-			break;
-		}
-	}
-
-	if (!acpi_of)
-		return;
-
 	ret = acpi_dev_get_property_array(adev, "compatible", ACPI_TYPE_STRING,
 					  &of_compatible);
 	if (ret) {
 		ret = acpi_dev_get_property(adev, "compatible",
 					    ACPI_TYPE_STRING, &of_compatible);
 		if (ret) {
-			acpi_handle_warn(adev->handle,
-					 "PRP0001 requires compatible property\n");
+			if (adev->parent
+			    && adev->parent->flags.of_compatible_ok)
+				goto out;
+
 			return;
 		}
 	}
 	adev->data.of_compatible = of_compatible;
+
+ out:
+	adev->flags.of_compatible_ok = 1;
 }
 
 void acpi_init_properties(struct acpi_device *adev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	bool acpi_of = false;
+	struct acpi_hardware_id *hwid;
 	const union acpi_object *desc;
 	acpi_status status;
 	int i;
 
+	/*
+	 * Check if the special PRP0001 ACPI ID is present and in that case we
+	 * fill in Device Tree compatible properties for this device.
+	 */
+	list_for_each_entry(hwid, &adev->pnp.ids, list) {
+		if (!strcmp(hwid->id, "PRP0001")) {
+			acpi_of = true;
+			break;
+		}
+	}
+
 	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL, &buf,
 					    ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status))
-		return;
+		goto out;
 
 	desc = buf.pointer;
 	if (desc->package.count % 2)
@@ -156,13 +157,20 @@ void acpi_init_properties(struct acpi_de
 		adev->data.pointer = buf.pointer;
 		adev->data.properties = properties;
 
-		acpi_init_of_compatible(adev);
-		return;
+		if (acpi_of)
+			acpi_init_of_compatible(adev);
+
+		goto out;
 	}
 
  fail:
-	dev_warn(&adev->dev, "Returned _DSD data is not valid, skipping\n");
+	dev_dbg(&adev->dev, "Returned _DSD data is not valid, skipping\n");
 	ACPI_FREE(buf.pointer);
+
+ out:
+	if (acpi_of && !adev->flags.of_compatible_ok)
+		acpi_handle_info(adev->handle,
+				 "PRP0001 requires 'compatible' property\n");
 }
 
 void acpi_free_properties(struct acpi_device *adev)
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -208,7 +208,8 @@ struct acpi_device_flags {
 	u32 visited:1;
 	u32 hotplug_notify:1;
 	u32 is_dock_station:1;
-	u32 reserved:23;
+	u32 of_compatible_ok:1;
+	u32 reserved:22;
 };
 
 /* File System */

