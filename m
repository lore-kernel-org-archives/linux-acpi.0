From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / OSL: Fix a regression by returning table size via acpi_get_table_with_size()
Date: Fri,  9 Dec 2016 10:21:04 +0800
Message-ID: <b8107fa792de9cb442c342433043604080699fc6.1481249993.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932672AbcLICVL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Dec 2016 21:21:11 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

The returned size is still used by the drivers.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5bef0f65..adf1ec4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -445,8 +445,12 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 
 	status = acpi_get_table(signature, instance, out_table);
 	if (ACPI_SUCCESS(status)) {
-		/* No longer used by early_acpi_os_unmap_memory() */
-		*tbl_size = 0;
+		/*
+		 * No longer used by early_acpi_os_unmap_memory(), but still
+		 * used by the ACPI table drivers.
+		 */
+		if (*out_table)
+			*tbl_size = (*out_table)->length;
 	}
 
 	return (status);
-- 
1.7.10

