From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / property: Hierarchical properties support update
Date: Tue, 22 Nov 2016 00:02:19 +0100
Message-ID: <3837037.oamKiZqo1g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57016 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755096AbcKUWyg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Nov 2016 17:54:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The definition document of the Hierarchical Properties Extension UUID
for _DSD has been changed recently to allow local references to be
used as sub-node link targets (previously, it only allowed strings to
be used for that purpose).

Update the code in drivers/acpi/property.c to reflect that change.

Link: http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_sysfs.c |    8 +-
 drivers/acpi/property.c     |  127 +++++++++++++++++++++++++++++++-------------
 2 files changed, 94 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -41,14 +41,13 @@ static bool acpi_enumerate_nondev_subnod
 static bool acpi_extract_properties(const union acpi_object *desc,
 				    struct acpi_device_data *data);
 
-static bool acpi_nondev_subnode_ok(acpi_handle scope,
-				   const union acpi_object *link,
-				   struct list_head *list)
+static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
+					acpi_handle handle,
+					const union acpi_object *link,
+					struct list_head *list)
 {
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	struct acpi_data_node *dn;
-	acpi_handle handle;
-	acpi_status status;
+	bool result;
 
 	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
 	if (!dn)
@@ -58,43 +57,75 @@ static bool acpi_nondev_subnode_ok(acpi_
 	dn->fwnode.type = FWNODE_ACPI_DATA;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	status = acpi_get_handle(scope, link->package.elements[1].string.pointer,
-				 &handle);
-	if (ACPI_FAILURE(status))
-		goto fail;
-
-	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
-					    ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		goto fail;
+	result = acpi_extract_properties(desc, &dn->data);
 
-	if (acpi_extract_properties(buf.pointer, &dn->data))
-		dn->handle = handle;
+	if (handle) {
+		acpi_handle scope;
+		acpi_status status;
+
+		/*
+		 * The scope for the subnode object lookup is the one of the
+		 * namespace node (device) containing the object that has
+		 * returned the package.  That is, it's the scope of that
+		 * object's parent.
+		 */
+		status = acpi_get_parent(handle, &scope);
+		if (ACPI_SUCCESS(status)
+		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data))
+			result = true;
+	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data)) {
+		result = true;
+	}
 
-	/*
-	 * The scope for the subnode object lookup is the one of the namespace
-	 * node (device) containing the object that has returned the package.
-	 * That is, it's the scope of that object's parent.
-	 */
-	status = acpi_get_parent(handle, &scope);
-	if (ACPI_SUCCESS(status)
-	    && acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
+	if (result) {
 		dn->handle = handle;
-
-	if (dn->handle) {
-		dn->data.pointer = buf.pointer;
+		dn->data.pointer = desc;
 		list_add_tail(&dn->sibling, list);
 		return true;
 	}
 
+	kfree(dn);
 	acpi_handle_debug(handle, "Invalid properties/subnodes data, skipping\n");
+	return false;
+}
+
+static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
+					const union acpi_object *link,
+					struct list_head *list)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	acpi_status status;
+
+	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list))
+		return true;
 
- fail:
 	ACPI_FREE(buf.pointer);
-	kfree(dn);
 	return false;
 }
 
+static bool acpi_nondev_subnode_ok(acpi_handle scope,
+				   const union acpi_object *link,
+				   struct list_head *list)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	if (!scope)
+		return false;
+
+	status = acpi_get_handle(scope, link->package.elements[1].string.pointer,
+				 &handle);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	return acpi_nondev_subnode_data_ok(handle, link, list);
+}
+
 static int acpi_add_nondev_subnodes(acpi_handle scope,
 				    const union acpi_object *links,
 				    struct list_head *list)
@@ -103,15 +134,37 @@ static int acpi_add_nondev_subnodes(acpi
 	int i;
 
 	for (i = 0; i < links->package.count; i++) {
-		const union acpi_object *link;
+		const union acpi_object *link, *desc;
+		acpi_handle handle;
+		bool result;
 
 		link = &links->package.elements[i];
-		/* Only two elements allowed, both must be strings. */
-		if (link->package.count == 2
-		    && link->package.elements[0].type == ACPI_TYPE_STRING
-		    && link->package.elements[1].type == ACPI_TYPE_STRING
-		    && acpi_nondev_subnode_ok(scope, link, list))
-			ret = true;
+		/* Only two elements allowed. */
+		if (link->package.count != 2)
+			continue;
+
+		/* The first one must be a string. */
+		if (link->package.elements[0].type != ACPI_TYPE_STRING)
+			continue;
+
+		/* The second one may be a string, a reference or a package. */
+		switch (link->package.elements[1].type) {
+		case ACPI_TYPE_STRING:
+			result = acpi_nondev_subnode_ok(scope, link, list);
+			break;
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			handle = link->package.elements[1].reference.handle;
+			result = acpi_nondev_subnode_data_ok(handle, link, list);
+			break;
+		case ACPI_TYPE_PACKAGE:
+			desc = &link->package.elements[1];
+			result = acpi_nondev_subnode_extract(desc, NULL, link, list);
+			break;
+		default:
+			result = false;
+			break;
+		}
+		ret = ret || result;
 	}
 
 	return ret;
Index: linux-pm/drivers/acpi/device_sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_sysfs.c
+++ linux-pm/drivers/acpi/device_sysfs.c
@@ -52,7 +52,7 @@ struct acpi_data_node_attr {
 
 static ssize_t data_node_show_path(struct acpi_data_node *dn, char *buf)
 {
-	return acpi_object_path(dn->handle, buf);
+	return dn->handle ? acpi_object_path(dn->handle, buf) : 0;
 }
 
 DATA_NODE_ATTR(path);
@@ -105,10 +105,10 @@ static void acpi_expose_nondev_subnodes(
 		init_completion(&dn->kobj_done);
 		ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
 					   kobj, "%s", dn->name);
-		if (ret)
-			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
-		else
+		if (!ret)
 			acpi_expose_nondev_subnodes(&dn->kobj, &dn->data);
+		else if (dn->handle)
+			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
 	}
 }
 

