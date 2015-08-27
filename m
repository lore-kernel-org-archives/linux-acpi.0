From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/6] ACPI / property: Add support for data-only subnodes
Date: Thu, 27 Aug 2015 04:36:14 +0200
Message-ID: <2274344.yZpiXFaEmi@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases, the information expressed via device properties is
hierarchical by nature.  For example, the properties of a composite
device consisting of multiple semi-dependent components may need
to be represented in the form of a tree of property data sets
corresponding to specific components of the device.

Unfortunately, using ACPI device objects for this purpose turns out
to be problematic, mostly due to the assumption made by some operating
systems (that platform firmware generally needs to work with) that
each device object in the ACPI namespace represents a device requiring
a separate driver.  That assumption leads to complications which
reportedly are impractically difficult to overcome and a different
approach is needed for the sake of interoperability.

The approach implemented here is based on extending _DSD via pointers
(links) to additional ACPI objects returning data packages formatted
in accordance with the _DSD formatting rules defined by Section 6.2.5
of ACPI 6.  Those additional objects are referred to as data-only
subnodes of the device object containing the _DSD pointing to them.

The links to them need to be located in a separate section of the
_DSD data package following UUID dbb8e3e6-5886-4ba6-8795-1319f52a966b
referred to as the Hierarchical Data Extension UUID as defined in [1].
Each of them is represented by a package of two strings.  The first
string in that package (the key) is regarded as the name of the
data-only subnode pointed to by the link.  The second string in it
(the target) is expected to hold the ACPI namespace path (possibly
utilizing the usual ACPI namespace search rules) of an ACPI object
evaluating to a data package extending the _DSD.

The device properties initialization code follows those links,
creates a struct acpi_data_node object for each of them to store
the data returned by the ACPI object pointed to by it and processes
those data recursively (which may lead to the creation of more
struct acpi_data_node objects if the returned data package contains
the Hierarchical Data Extension UUID section with more links in it).

All of the struct acpi_data_node objects are present until the the
ACPI device object containing the _DSD with links to them is deleted
and they are deleted along with that object.

[1]: http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/acpi/acpi_bus.h |    9 +++
 include/linux/fwnode.h  |    1 
 3 files changed, 142 insertions(+), 1 deletion(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -343,6 +343,7 @@ struct acpi_device_data {
 	const union acpi_object *pointer;
 	const union acpi_object *properties;
 	const union acpi_object *of_compatible;
+	struct list_head subnodes;
 };
 
 struct acpi_gpio_mapping;
@@ -378,6 +379,14 @@ struct acpi_device {
 	void (*remove)(struct acpi_device *);
 };
 
+/* Non-device subnode */
+struct acpi_data_node {
+	const char *name;
+	struct fwnode_handle fwnode;
+	struct acpi_device_data data;
+	struct list_head sibling;
+};
+
 static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 {
 	bool ret = false;
Index: linux-pm/include/linux/fwnode.h
===================================================================
--- linux-pm.orig/include/linux/fwnode.h
+++ linux-pm/include/linux/fwnode.h
@@ -16,6 +16,7 @@ enum fwnode_type {
 	FWNODE_INVALID = 0,
 	FWNODE_OF,
 	FWNODE_ACPI,
+	FWNODE_ACPI_DATA,
 	FWNODE_PDATA,
 };
 
Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -24,6 +24,115 @@ static const u8 prp_uuid[16] = {
 	0x14, 0xd8, 0xff, 0xda, 0xba, 0x6e, 0x8c, 0x4d,
 	0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01
 };
+/* ACPI _DSD data subnodes UUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
+static const u8 ads_uuid[16] = {
+	0xe6, 0xe3, 0xb8, 0xdb, 0x86, 0x58, 0xa6, 0x4b,
+	0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b
+};
+
+static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
+					   const union acpi_object *desc,
+					   struct acpi_device_data *data);
+static bool acpi_extract_properties(const union acpi_object *desc,
+				    struct acpi_device_data *data);
+
+static bool acpi_nondev_subnode_ok(acpi_handle scope,
+				   const union acpi_object *link,
+				   struct list_head *list)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	struct acpi_data_node *dn;
+	acpi_handle handle;
+	acpi_status status;
+
+	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
+	if (!dn)
+		return false;
+
+	dn->name = link->package.elements[0].string.pointer;
+	dn->fwnode.type = FWNODE_ACPI_DATA;
+	INIT_LIST_HEAD(&dn->data.subnodes);
+
+	status = acpi_get_handle(scope, link->package.elements[1].string.pointer,
+				 &handle);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
+	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
+	if (acpi_extract_properties(buf.pointer, &dn->data))
+		dn->data.pointer = buf.pointer;
+
+	if (acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
+		dn->data.pointer = buf.pointer;
+
+	if (dn->data.pointer) {
+		list_add_tail(&dn->sibling, list);
+		return true;
+	}
+
+	acpi_handle_debug(handle, "Invalid properties/subnodes data, skipping\n");
+
+ fail:
+	ACPI_FREE(buf.pointer);
+	kfree(dn);
+	return false;
+}
+
+static int acpi_add_nondev_subnodes(acpi_handle scope,
+				    const union acpi_object *links,
+				    struct list_head *list)
+{
+	bool ret = false;
+	int i;
+
+	for (i = 0; i < links->package.count; i++) {
+		const union acpi_object *link;
+
+		link = &links->package.elements[i];
+		/* Only two elements allowed, both must be strings. */
+		if (link->package.count == 2
+		    && link->package.elements[0].type == ACPI_TYPE_STRING
+		    && link->package.elements[1].type == ACPI_TYPE_STRING
+		    && acpi_nondev_subnode_ok(scope, link, list))
+			ret = true;
+	}
+
+	return ret;
+}
+
+static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
+					   const union acpi_object *desc,
+					   struct acpi_device_data *data)
+{
+	int i;
+
+	/* Look for the ACPI data subnodes UUID. */
+	for (i = 0; i < desc->package.count; i += 2) {
+		const union acpi_object *uuid, *links;
+
+		uuid = &desc->package.elements[i];
+		links = &desc->package.elements[i + 1];
+
+		/*
+		 * The first element must be a UUID and the second one must be
+		 * a package.
+		 */
+		if (uuid->type != ACPI_TYPE_BUFFER || uuid->buffer.length != 16
+		    || links->type != ACPI_TYPE_PACKAGE)
+			break;
+
+		if (memcmp(uuid->buffer.pointer, ads_uuid, sizeof(ads_uuid)))
+			continue;
+
+		return acpi_add_nondev_subnodes(scope, links, &data->subnodes);
+	}
+
+	return false;
+}
 
 static bool acpi_property_value_ok(const union acpi_object *value)
 {
@@ -147,6 +256,8 @@ void acpi_init_properties(struct acpi_de
 	acpi_status status;
 	bool acpi_of = false;
 
+	INIT_LIST_HEAD(&adev->data.subnodes);
+
 	/*
 	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fill in
 	 * Device Tree compatible properties for this device.
@@ -167,7 +278,11 @@ void acpi_init_properties(struct acpi_de
 		adev->data.pointer = buf.pointer;
 		if (acpi_of)
 			acpi_init_of_compatible(adev);
-	} else {
+	}
+	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer, &adev->data))
+		adev->data.pointer = buf.pointer;
+
+	if (!adev->data.pointer) {
 		acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
 		ACPI_FREE(buf.pointer);
 	}
@@ -178,8 +293,24 @@ void acpi_init_properties(struct acpi_de
 			 ACPI_DT_NAMESPACE_HID " requires 'compatible' property\n");
 }
 
+static void acpi_destroy_nondev_subnodes(struct list_head *list)
+{
+	struct acpi_data_node *dn, *next;
+
+	if (list_empty(list))
+		return;
+
+	list_for_each_entry_safe_reverse(dn, next, list, sibling) {
+		acpi_destroy_nondev_subnodes(&dn->data.subnodes);
+		list_del(&dn->sibling);
+		ACPI_FREE((void *)dn->data.pointer);
+		kfree(dn);
+	}
+}
+
 void acpi_free_properties(struct acpi_device *adev)
 {
+	acpi_destroy_nondev_subnodes(&adev->data.subnodes);
 	ACPI_FREE((void *)adev->data.pointer);
 	adev->data.of_compatible = NULL;
 	adev->data.pointer = NULL;
