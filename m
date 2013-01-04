From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PNPACPI: Use _CRS buffer directly as _SRS template
Date: Fri, 04 Jan 2013 15:38:10 -0700
Message-ID: <20130104223810.4806.72475.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ye0-f202.google.com ([209.85.213.202]:48209 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab3ADWiM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2013 17:38:12 -0500
Received: by mail-ye0-f202.google.com with SMTP id r9so963380yen.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jan 2013 14:38:11 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Previously we went to a lot of trouble to count the supported descriptors
in _CRS, allocate a new buffer, copy the descriptor types to the new
buffer, and encode resources into the new buffer.  This will fail if _CRS
contains a descriptor type we don't support, even if we don't need to
change that descriptor.

I think it's simpler and more correct to just use the buffer returned from
_CRS directly, as suggested by the ACPI spec rev 5.0, sec 6.2.15.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pnp/pnpacpi/core.c     |   10 +++--
 drivers/pnp/pnpacpi/rsparser.c |   85 ----------------------------------------
 2 files changed, 6 insertions(+), 89 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 72e822e..701e00e 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -84,7 +84,8 @@ static int pnpacpi_set_resources(struct pnp_dev *dev)
 {
 	struct acpi_device *acpi_dev;
 	acpi_handle handle;
-	struct acpi_buffer buffer;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
 	int ret;
 
 	pnp_dbg(&dev->dev, "set resources\n");
@@ -98,9 +99,10 @@ static int pnpacpi_set_resources(struct pnp_dev *dev)
 	if (WARN_ON_ONCE(acpi_dev != dev->data))
 		dev->data = acpi_dev;
 
-	ret = pnpacpi_build_resource_template(dev, &buffer);
-	if (ret)
-		return ret;
+	status = acpi_evaluate_object(handle, METHOD_NAME__CRS, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
 	ret = pnpacpi_encode_resources(dev, &buffer);
 	if (ret) {
 		kfree(buffer.pointer);
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index b8f4ea7..629710a 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -553,91 +553,6 @@ int __init pnpacpi_parse_resource_option_data(struct pnp_dev *dev)
 	return 0;
 }
 
-static int pnpacpi_supported_resource(struct acpi_resource *res)
-{
-	switch (res->type) {
-	case ACPI_RESOURCE_TYPE_IRQ:
-	case ACPI_RESOURCE_TYPE_DMA:
-	case ACPI_RESOURCE_TYPE_IO:
-	case ACPI_RESOURCE_TYPE_FIXED_IO:
-	case ACPI_RESOURCE_TYPE_MEMORY24:
-	case ACPI_RESOURCE_TYPE_MEMORY32:
-	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-	case ACPI_RESOURCE_TYPE_ADDRESS16:
-	case ACPI_RESOURCE_TYPE_ADDRESS32:
-	case ACPI_RESOURCE_TYPE_ADDRESS64:
-	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * Set resource
- */
-static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
-					   void *data)
-{
-	int *res_cnt = data;
-
-	if (pnpacpi_supported_resource(res))
-		(*res_cnt)++;
-	return AE_OK;
-}
-
-static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
-{
-	struct acpi_resource **resource = data;
-
-	if (pnpacpi_supported_resource(res)) {
-		(*resource)->type = res->type;
-		(*resource)->length = sizeof(struct acpi_resource);
-		if (res->type == ACPI_RESOURCE_TYPE_IRQ)
-			(*resource)->data.irq.descriptor_length =
-					res->data.irq.descriptor_length;
-		(*resource)++;
-	}
-
-	return AE_OK;
-}
-
-int pnpacpi_build_resource_template(struct pnp_dev *dev,
-				    struct acpi_buffer *buffer)
-{
-	struct acpi_device *acpi_dev = dev->data;
-	acpi_handle handle = acpi_dev->handle;
-	struct acpi_resource *resource;
-	int res_cnt = 0;
-	acpi_status status;
-
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     pnpacpi_count_resources, &res_cnt);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
-		return -EINVAL;
-	}
-	if (!res_cnt)
-		return -EINVAL;
-	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
-	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
-	if (!buffer->pointer)
-		return -ENOMEM;
-
-	resource = (struct acpi_resource *)buffer->pointer;
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     pnpacpi_type_resources, &resource);
-	if (ACPI_FAILURE(status)) {
-		kfree(buffer->pointer);
-		dev_err(&dev->dev, "can't evaluate _CRS: %d\n", status);
-		return -EINVAL;
-	}
-	/* resource will pointer the end resource now */
-	resource->type = ACPI_RESOURCE_TYPE_END_TAG;
-
-	return 0;
-}
-
 static void pnpacpi_encode_irq(struct pnp_dev *dev,
 			       struct acpi_resource *resource,
 			       struct resource *p)

