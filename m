From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v4] ACPI / sysfs: Extend ACPI sysfs to provide access to boot error region
Date: Fri, 18 Aug 2017 16:19:00 -0700
Message-ID: <20170818231900.3020-1-tony.luck@intel.com>
References: <878tigojy2.fsf@e105922-lin.cambridge.arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:56180 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdHRXTC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Aug 2017 19:19:02 -0400
In-Reply-To: <878tigojy2.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

From: Tony Luck <tony.luck@intel.com>

The ACPI sysfs interface provides a way to read each ACPI table from
userspace via entries in /sys/firmware/acpi/tables/

The BERT table simply provides the size and address of the error
record in BIOS reserved memory and users may want access to this
record.

In an earlier age we might have used /dev/mem to retrieve this error
record, but many systems disable /dev/mem for security reasons.

Extend this driver to provide read-only access to the data via a
file in a new directory /sys/firmware/acpi/tables/data/BERT

Cc: Len Brown <lenb@kernel.org>
Cc: Boris Petkov <bp@suse.de>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

v4: fix typo reported by Punit
---
 drivers/acpi/sysfs.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index e414fabf7315..faa1aa3ed0e1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -306,11 +306,13 @@ module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
 /*
  * ACPI table sysfs I/F:
  * /sys/firmware/acpi/tables/
+ * /sys/firmware/acpi/tables/data/
  * /sys/firmware/acpi/tables/dynamic/
  */
 
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
+static struct kobject *tables_data_kobj;
 static struct kobject *dynamic_tables_kobj;
 static struct kobject *hotplug_kobj;
 
@@ -325,6 +327,11 @@ struct acpi_table_attr {
 	struct list_head node;
 };
 
+struct acpi_data_attr {
+	struct bin_attribute attr;
+	u64	addr;
+};
+
 static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr, char *buf,
 			       loff_t offset, size_t count)
@@ -420,6 +427,70 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 	return AE_OK;
 }
 
+static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
+			      struct bin_attribute *bin_attr, char *buf,
+			      loff_t offset, size_t count)
+{
+	struct acpi_data_attr *data_attr;
+	void __iomem *base;
+	ssize_t rc;
+
+	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
+
+	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
+	if (!base)
+		return -ENOMEM;
+	rc = memory_read_from_buffer(buf, count, &offset, base,
+				     data_attr->attr.size);
+	acpi_os_unmap_memory(base, data_attr->attr.size);
+
+	return rc;
+}
+
+static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
+{
+	struct acpi_table_bert *bert = th;
+
+	if (bert->header.length < sizeof(struct acpi_table_bert) ||
+	    bert->region_length < sizeof(struct acpi_hest_generic_status)) {
+		kfree(data_attr);
+		return -EINVAL;
+	}
+	data_attr->addr = bert->address;
+	data_attr->attr.size = bert->region_length;
+	data_attr->attr.attr.name = "BERT";
+
+	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
+}
+
+static struct acpi_data_obj {
+	char *name;
+	int (*fn)(void *, struct acpi_data_attr *);
+} acpi_data_objs[] = {
+	{ ACPI_SIG_BERT, acpi_bert_data_init },
+};
+
+#define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
+
+static int acpi_table_data_init(struct acpi_table_header *th)
+{
+	struct acpi_data_attr *data_attr;
+	int i;
+
+	for (i = 0; i < NUM_ACPI_DATA_OBJS; i++) {
+		if (ACPI_COMPARE_NAME(th->signature, acpi_data_objs[i].name)) {
+			data_attr = kzalloc(sizeof(*data_attr), GFP_KERNEL);
+			if (!data_attr)
+				return -ENOMEM;
+			sysfs_attr_init(&data_attr->attr.attr);
+			data_attr->attr.read = acpi_data_show;
+			data_attr->attr.attr.mode = 0400;
+			return acpi_data_objs[i].fn(th, data_attr);
+		}
+	}
+	return 0;
+}
+
 static int acpi_tables_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
@@ -432,6 +503,10 @@ static int acpi_tables_sysfs_init(void)
 	if (!tables_kobj)
 		goto err;
 
+	tables_data_kobj = kobject_create_and_add("data", tables_kobj);
+	if (!tables_data_kobj)
+		goto err_tables_data;
+
 	dynamic_tables_kobj = kobject_create_and_add("dynamic", tables_kobj);
 	if (!dynamic_tables_kobj)
 		goto err_dynamic_tables;
@@ -456,13 +531,17 @@ static int acpi_tables_sysfs_init(void)
 			return ret;
 		}
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
+		acpi_table_data_init(table_header);
 	}
 
 	kobject_uevent(tables_kobj, KOBJ_ADD);
+	kobject_uevent(tables_data_kobj, KOBJ_ADD);
 	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
 
 	return 0;
 err_dynamic_tables:
+	kobject_put(tables_data_kobj);
+err_tables_data:
 	kobject_put(tables_kobj);
 err:
 	return -ENOMEM;
-- 
2.11.0

