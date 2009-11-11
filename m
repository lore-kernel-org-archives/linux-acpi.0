From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] acpi_check_resource_conflict doesn't change the resource
Date: Wed, 11 Nov 2009 15:22:15 +0100
Message-ID: <20091111152215.66617c8f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:56905 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695AbZKKOWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 09:22:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

The acpi_check_resource_conflict function doesn't change the resource
it operates on, so the res parameter can be marked const.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/osl.c   |    2 +-
 include/linux/acpi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.32-rc6.orig/drivers/acpi/osl.c	2009-09-28 10:28:34.000000000 +0200
+++ linux-2.6.32-rc6/drivers/acpi/osl.c	2009-11-11 15:13:30.000000000 +0100
@@ -1118,7 +1118,7 @@ __setup("acpi_enforce_resources=", acpi_
 
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
-int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(const struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
--- linux-2.6.32-rc6.orig/include/linux/acpi.h	2009-09-28 10:29:17.000000000 +0200
+++ linux-2.6.32-rc6/include/linux/acpi.h	2009-11-11 15:13:09.000000000 +0100
@@ -240,7 +240,7 @@ extern int pnpacpi_disabled;
 #define PXM_INVAL	(-1)
 #define NID_INVAL	(-1)
 
-int acpi_check_resource_conflict(struct resource *res);
+int acpi_check_resource_conflict(const struct resource *res);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);


-- 
Jean Delvare
