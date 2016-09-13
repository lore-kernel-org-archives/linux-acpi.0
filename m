From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/3] ACPI / sysfs: Fix an issue for LoadTable opcode
Date: Tue, 13 Sep 2016 17:48:27 +0800
Message-ID: <3db6943f4e70a5bb91e27f32f0391534735909c9.1473759814.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com> <cover.1473759814.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55273 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755541AbcIMJsd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 05:48:33 -0400
In-Reply-To: <cover.1473759814.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

OEM tables can be installed via RSDT/XSDT, in this case, they have already
been created under /sys/firmware/acpi/tables.

For this kind of tables, normally LoadTable opcode will be executed to load
them. If LoadTable opcode is executed after acpi_sysfs_init(),
acpi_sysfs_table_handler() will be invoked, thus a redundant table file
will be created under /sys/firmware/acpi/tables/dynamic. Then running
"acpidump" on such platform results in an error, complaining blank empty
table (see Link 1 below).

The bug can be reproduced by customizing an OEM1 table, allowing it to be
overridden via 'table_sigs' (drivers/acpi/tables.c), adding the following
code to the customized DSDT to load it:
  Name (OEMH, Zero)
  Name (OEMF, One)
  If (LEqual (OEMF, One)) {
      Store (LoadTable ("OEM1", "Intel", "Test"), OEMH)
      Store (Zero, OEMF)
  }
In order to make sure that the OEM1 table is installed after
acpi_sysfs_init(), acpi_sysfs_init() can be moved before invoking
acpi_load_tables(). Then the following command execution result can be
seen:
 # acpidump > acpidump.txt
 Could not read table header: /sysfs/firmware/acpi/tables/dynamic/OEM12
 Could not get ACPI table at index 17, AE_BAD_HEADER

Link: https://bugzilla.kernel.org/show_bug.cgi?id=150841 # [1]
Link: https://github.com/acpica/acpica/commit/ed6a5fbc
Reported-by: Jason Voelz <jason.voelz@intel.com>
Reported-by: Francisco Leoner <francisco.j.lenoer.soto@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 703c993..c88d4bd 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -383,7 +383,7 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 	struct acpi_table_attr *table_attr;
 
 	switch (event) {
-	case ACPI_TABLE_EVENT_LOAD:
+	case ACPI_TABLE_EVENT_INSTALL:
 		table_attr =
 		    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
 		if (!table_attr)
@@ -397,7 +397,9 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 		} else
 			list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		break;
+	case ACPI_TABLE_EVENT_LOAD:
 	case ACPI_TABLE_EVENT_UNLOAD:
+	case ACPI_TABLE_EVENT_UNINSTALL:
 		/*
 		 * we do not need to do anything right now
 		 * because the table is not deleted from the
-- 
1.7.10

