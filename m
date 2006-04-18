From: mochel@linux.intel.com
Subject: [PATCH 12/24] Remove unneeded debugging macros in drivers/acpi/motherboard.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <114532331475-git-send-email-mochel@linux.intel.com>
References: <11453233132210-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:26246 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932113AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PP6X013973
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <11453233132210-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/motherboard.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

applies-to: 6643f7750035d5b7643f99e120f0a7d69da614af
e16d43106000085dfa970f8a94bdd0b6d0f61e4b
diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
index d51d68f..ac74e6c 100644
--- a/drivers/acpi/motherboard.c
+++ b/drivers/acpi/motherboard.c
@@ -52,13 +52,11 @@ static acpi_status acpi_reserve_io_range
 {
 	struct resource *requested_res = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_reserve_io_ranges");
-
 	if (res->type == ACPI_RESOURCE_TYPE_IO) {
 		struct acpi_resource_io *io_res = &res->data.io;
 
 		if (io_res->minimum != io_res->maximum)
-			return_VALUE(AE_OK);
+			return AE_OK;
 		if (IS_RESERVED_ADDR
 		    (io_res->minimum, io_res->address_length)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -92,7 +90,7 @@ static acpi_status acpi_reserve_io_range
 
 	if (requested_res)
 		requested_res->flags &= ~IORESOURCE_BUSY;
-	return_VALUE(AE_OK);
+	return AE_OK;
 }
 
 static int acpi_motherboard_add(struct acpi_device *device)
---
0.99.9.GIT


