From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 7/8] acpi: avoid using internal acpica structures
Date: Wed, 26 Nov 2008 10:56:17 +0800
Message-ID: <1227668177.7702.99.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40090 "EHLO mga02.intel.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbYKZDBj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 22:01:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

=EF=BB=BFAvoid using internal acpica structures acpi_namespace_node and=
 =EF=BB=BFacpi_operand_object
Call acpi_get_name or acpi_get_object_info to get node name and method =
arg count

=EF=BB=BFSigned-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/ec.c          |   13 +++++++++++--
 drivers/misc/sony-laptop.c |   15 +++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 591b4f6..2f4828f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -754,10 +754,19 @@ static acpi_status
 acpi_ec_register_query_methods(acpi_handle handle, u32 level,
 			       void *context, void **return_value)
 {
-	struct acpi_namespace_node *node =3D handle;
+	char node_name[5];
+	struct acpi_buffer buffer =3D { sizeof(node_name), node_name };
 	struct acpi_ec *ec =3D context;
 	int value =3D 0;
-	if (sscanf(node->name.ascii, "_Q%x", &value) =3D=3D 1) {
+	acpi_status status;
+
+	status =3D acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+      =20
+	if (sscanf(node_name, "_Q%x", &value) =3D=3D 1) {
 		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
 	}
 	return AE_OK;
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7bcb810..dd9c16f 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -935,14 +935,17 @@ static void sony_acpi_notify(acpi_handle handle, =
u32 event, void *data)
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 				      void *context, void **return_value)
 {
-	struct acpi_namespace_node *node;
-	union acpi_operand_object *operand;
+	struct acpi_device_info *info;
+	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
=20
-	node =3D (struct acpi_namespace_node *)handle;
-	operand =3D (union acpi_operand_object *)node->object;
+	if (ACPI_SUCCESS(acpi_get_object_info(handle, &buffer))) {
+		info =3D buffer.pointer;
=20
-	printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n", node->n=
ame.ascii,
-	       (u32) operand->method.param_count);
+		printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n",
+			(char *)info->name, info->param_count);
+
+		kfree(buffer.pointer);
+	}
=20
 	return AE_OK;
 }


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
