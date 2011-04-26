From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI EC: remove redundant code
Date: Tue, 26 Apr 2011 16:29:55 +0800
Message-ID: <1303806595.28018.10.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab1DZIcq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2011 04:32:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

ec->handle is set in ec_parse_device(), so don't bother to set it again.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ec.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -808,8 +808,6 @@ static int acpi_ec_add(struct acpi_devic
 			return -EINVAL;
 	}
 
-	ec->handle = device->handle;
-
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 			    acpi_ec_register_query_methods, NULL, ec, NULL);


