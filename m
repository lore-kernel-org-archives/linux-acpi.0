From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] acpi: pnp: add ACPI_RESOURCE_TYPE_SERIAL_BUS as a valid type
Date: Tue,  1 Mar 2016 13:31:45 -0600
Message-ID: <1456860705-24935-1-git-send-email-timur@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52079 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbcCATbx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 14:31:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, harba@codeaurora.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

From: Harb Abdulhamid <harba@codeaurora.org>

An error message is printed for resources of type 19, which is a valid
supported resource type.  The Firmware Test Suite tool (fwts) reports
this as a test failure.  This change fixes the false test failures
for ASL that use type 19 (ACPI_RESOURCE_TYPE_SERIAL_BUS) resources.

Signed-off-by: Harb Abdulhamid <harba@codeaurora.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pnp/pnpacpi/rsparser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 0579649..4b717c6 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -252,6 +252,10 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 		break;
 
+	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
+		/* serial bus connections (I2C/SPI/UART) are not pnp */
+		break;
+
 	default:
 		dev_warn(&dev->dev, "unknown resource type %d in _CRS\n",
 			 res->type);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

