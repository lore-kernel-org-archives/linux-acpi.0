From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI / OSL: Fix a regression by returning acpi_table_header.length instead of 0 from acpi_get_table_with_size()
Date: Fri,  9 Dec 2016 15:15:25 +0800
Message-ID: <da13d99d5b7ea6a9435bbb82319ecc6b8d9be0c8.1481267531.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbcLIHPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Dec 2016 02:15:47 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

The following wrong commit triggers issues in acpi_get_table_with_size()
users:
    Subject: ACPICA: Tables: Back port acpi_get_table_with_size() and
             early_acpi_os_unmap_memory() from Linux kernel

The function is invented to be a replacement of acpi_get_table() during
early stage so that the early mapped pointer will not be stored in ACPICA
core and thus the late stage acpi_get_table() won't return a wrong pointer.
However the mapping size is returned just because it is required by
early_acpi_os_unmap_memory() to unmap the pointer during early stage.

As the mapping size equals to the acpi_table_header.length
(see acpi_tb_init_table_descriptor() and acpi_tb_validate_table()), when
such a convenient result is returned, driver code will start to use it
instead of accessing acpi_table_header to obtain the length.

So the commit can trigger problems in such drivers as it returns 0 now. And
it did bring a trouble to drivers/acpi/nfit/core.c. So before cleaning up
the drivers, we should keep the old semantics of the API.

This patch fixes the wrong commit by returning the acpi_table_header.length
from acpi_get_table_with_size().

Reported-by: Dan Williams <dan.j.williams@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5bef0f65..d0b273f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -445,8 +445,16 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 
 	status = acpi_get_table(signature, instance, out_table);
 	if (ACPI_SUCCESS(status)) {
-		/* No longer used by early_acpi_os_unmap_memory() */
-		*tbl_size = 0;
+		/*
+		 * "tbl_size" is no longer used by
+		 * early_acpi_os_unmap_memory(), but is still used by the
+		 * ACPI table drivers. So sets it to the length of the
+		 * table when the tbl_size is requested.
+		 * "out_table" is not sanity checked as AE_BAD_PARAMETER
+		 * is returned if it is NULL.
+		 */
+		if (tbl_size && *out_table)
+			*tbl_size = (*out_table)->length;
 	}
 
 	return (status);
-- 
1.7.10

