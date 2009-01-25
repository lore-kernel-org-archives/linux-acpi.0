From: Kay Sievers <kay.sievers@vrfy.org>
Subject: acpi: struct device - replace bus_id with dev_name(),
 dev_set_name()
Date: Sun, 25 Jan 2009 23:40:56 +0100
Message-ID: <1232923256.2924.3.camel@nga>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:37267 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZAYWlt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jan 2009 17:41:49 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3298169fgg.17
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jan 2009 14:41:47 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kay Sievers <kay.sievers@vrfy.org>
Subject: acpi: struct device - replace bus_id with dev_name(), dev_set_name()

Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---
 drivers/acpi/glue.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -255,12 +255,12 @@ static int acpi_platform_notify(struct d
 	}
 	type = acpi_get_bus_type(dev->bus);
 	if (!type) {
-		DBG("No ACPI bus support for %s\n", dev->bus_id);
+		DBG("No ACPI bus support for %s\n", dev_name(dev));
 		ret = -EINVAL;
 		goto end;
 	}
 	if ((ret = type->find_device(dev, &handle)) != 0)
-		DBG("Can't get handler for %s\n", dev->bus_id);
+		DBG("Can't get handler for %s\n", dev_name(dev));
       end:
 	if (!ret)
 		acpi_bind_one(dev, handle);
@@ -271,10 +271,10 @@ static int acpi_platform_notify(struct d
 
 		acpi_get_name(dev->archdata.acpi_handle,
 			      ACPI_FULL_PATHNAME, &buffer);
-		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
+		DBG("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
 		kfree(buffer.pointer);
 	} else
-		DBG("Device %s -> No ACPI support\n", dev->bus_id);
+		DBG("Device %s -> No ACPI support\n", dev_name(dev));
 #endif
 
 	return ret;

