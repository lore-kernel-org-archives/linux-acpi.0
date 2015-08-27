From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/6] ACPI / property: Add routine for extraction of _DSD properties
Date: Thu, 27 Aug 2015 04:35:14 +0200
Message-ID: <1470381.fEBVUvjZY7@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53085 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752808AbbH0CPU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Aug 2015 22:15:20 -0400
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the extraction of _DSD properties from acpi_init_properties()
to a separate routine called acpi_extract_properties() to make the
subsequent changes more straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c |   69 +++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -100,34 +100,13 @@ static void acpi_init_of_compatible(stru
 	adev->flags.of_compatible_ok = 1;
 }
 
-void acpi_init_properties(struct acpi_device *adev)
+static bool acpi_extract_properties(const union acpi_object *desc,
+				    struct acpi_device_data *data)
 {
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-	bool acpi_of = false;
-	struct acpi_hardware_id *hwid;
-	const union acpi_object *desc;
-	acpi_status status;
 	int i;
 
-	/*
-	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fill in
-	 * Device Tree compatible properties for this device.
-	 */
-	list_for_each_entry(hwid, &adev->pnp.ids, list) {
-		if (!strcmp(hwid->id, ACPI_DT_NAMESPACE_HID)) {
-			acpi_of = true;
-			break;
-		}
-	}
-
-	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL, &buf,
-					    ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		goto out;
-
-	desc = buf.pointer;
 	if (desc->package.count % 2)
-		goto fail;
+		return false;
 
 	/* Look for the device properties UUID. */
 	for (i = 0; i < desc->package.count; i += 2) {
@@ -154,18 +133,44 @@ void acpi_init_properties(struct acpi_de
 		if (!acpi_properties_format_valid(properties))
 			break;
 
-		adev->data.pointer = buf.pointer;
-		adev->data.properties = properties;
+		data->properties = properties;
+		return true;
+	}
 
-		if (acpi_of)
-			acpi_init_of_compatible(adev);
+	return false;
+}
 
-		goto out;
+void acpi_init_properties(struct acpi_device *adev)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	struct acpi_hardware_id *hwid;
+	acpi_status status;
+	bool acpi_of = false;
+
+	/*
+	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fill in
+	 * Device Tree compatible properties for this device.
+	 */
+	list_for_each_entry(hwid, &adev->pnp.ids, list) {
+		if (!strcmp(hwid->id, ACPI_DT_NAMESPACE_HID)) {
+			acpi_of = true;
+			break;
+		}
 	}
 
- fail:
-	dev_dbg(&adev->dev, "Returned _DSD data is not valid, skipping\n");
-	ACPI_FREE(buf.pointer);
+	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+	if (acpi_extract_properties(buf.pointer, &adev->data)) {
+		adev->data.pointer = buf.pointer;
+		if (acpi_of)
+			acpi_init_of_compatible(adev);
+	} else {
+		acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
+		ACPI_FREE(buf.pointer);
+	}
 
  out:
 	if (acpi_of && !adev->flags.of_compatible_ok)

