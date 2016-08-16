From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/5] ACPI / sysfs: Fix an issue for LoadTable opcode
Date: Tue, 16 Aug 2016 16:53:08 +0800
Message-ID: <95ab759477b67ba43862d686ff410efd8471fd33.1471337441.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

OEM tables can be installed via RSDT/XSDT, in this case, they have already
been created under /sys/firmware/acpi/tables.

For this kind of tables, normally LoadTable opcode will be executed to load
them. If LoadTable opcode is executed after acpi_sysfs_init(),
acpi_sysfs_table_handler() will be invoked, thus a redundant table file
will be created under /sys/firmware/acpi/tables/dynamic. Then running
"acpidump" on such platform results in an error.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=150841
Reported-by: Jason Voelz <jason.voelz@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 358165e..f2fa363 100644
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
