From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [RFC PATCH] ACPI: sysfs expose root tables RSDP/RSDT/XSDT
Date: Tue, 21 Jul 2015 14:31:08 +0100
Message-ID: <1437485468-17107-2-git-send-email-graeme.gregory@linaro.org>
References: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On some architectures /dev/mem is being removed. For debug/analysis
tools like FWTS/acpidump we therefore need to expose the ACPI root
tables in sysfs like the other tables.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/sysfs.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0876d77b..c998ea1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -348,6 +348,127 @@ acpi_sysfs_table_handler(u32 event, void *table, void *context)
 	return AE_OK;
 }
 
+/*
+ * On some architectures /dev/mem interface is not available so for debug
+ * tools like FWTS, acpidump etc we will also need to export the three
+ * root tables RSDP, RSDT, XSDT where they exist.
+ */
+
+struct acpi_root_table_attr {
+	struct bin_attribute attr;
+	acpi_physical_address table_addr;
+};
+
+static ssize_t acpi_table_show_root(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *bin_attr, char *buf,
+				    loff_t offset, size_t count)
+{
+	struct acpi_root_table_attr *table_attr =
+			container_of(bin_attr,
+				     struct acpi_root_table_attr, attr);
+	void *table;
+	int ret;
+
+	table = acpi_os_map_memory(table_attr->table_addr, bin_attr->size);
+
+	if (!table)
+		return -EIO;
+
+	ret = memory_read_from_buffer(buf, count, &offset, table,
+				      bin_attr->size);
+	acpi_os_unmap_memory(table, bin_attr->size);
+
+	return ret;
+}
+
+static int acpi_root_tables_sysfs_init(struct kobject *tables_kobj)
+{
+	struct acpi_root_table_attr *root_tables_attr;
+	struct acpi_table_rsdp *rsdp;
+	struct acpi_table_header *table_header = NULL;
+	acpi_physical_address rsdp_ptr, rsdt_ptr, xsdt_ptr;
+	int ret;
+
+	rsdp_ptr = acpi_os_get_root_pointer();
+
+	if (!rsdp_ptr)
+		return -EIO;
+
+	rsdp = acpi_os_map_memory(rsdp_ptr, sizeof(*rsdp));
+	if (!rsdp) {
+		ret = -EIO;
+		goto err;
+	}
+
+	root_tables_attr = kzalloc(sizeof(*root_tables_attr) * 3, GFP_KERNEL);
+	if (!root_tables_attr) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	root_tables_attr[0].table_addr = rsdp_ptr;
+	root_tables_attr[0].attr.size = sizeof(*rsdp);
+	root_tables_attr[0].attr.read = acpi_table_show_root;
+	root_tables_attr[0].attr.attr.name = "RSDP";
+	root_tables_attr[0].attr.attr.mode = 0400;
+
+	ret = sysfs_create_bin_file(tables_kobj, &root_tables_attr[0].attr);
+	if (ret)
+		goto err;
+
+	rsdt_ptr = rsdp->rsdt_physical_address;
+	if (rsdt_ptr) {
+		table_header = acpi_os_map_memory(rsdt_ptr,
+						  sizeof(*table_header));
+		if (!table_header) {
+			ret = -EIO;
+			goto err;
+		}
+
+		root_tables_attr[1].table_addr = rsdt_ptr;
+		root_tables_attr[1].attr.size = table_header->length;
+		root_tables_attr[1].attr.read = acpi_table_show_root;
+		root_tables_attr[1].attr.attr.name = "RSDT";
+		root_tables_attr[1].attr.attr.mode = 0400;
+
+		ret = sysfs_create_bin_file(tables_kobj,
+					    &root_tables_attr[1].attr);
+		if (ret)
+			goto err;
+		acpi_os_unmap_memory(table_header, sizeof(*table_header));
+	}
+
+	xsdt_ptr = rsdp->xsdt_physical_address;
+	if (xsdt_ptr) {
+		table_header = acpi_os_map_memory(xsdt_ptr,
+						  sizeof(*table_header));
+		if (!table_header) {
+			ret = -EIO;
+			goto err;
+		}
+
+		root_tables_attr[2].table_addr = xsdt_ptr;
+		root_tables_attr[2].attr.size = table_header->length;
+		root_tables_attr[2].attr.read = acpi_table_show_root;
+		root_tables_attr[2].attr.attr.name = "XSDT";
+		root_tables_attr[2].attr.attr.mode = 0400;
+
+		ret = sysfs_create_bin_file(tables_kobj,
+					    &root_tables_attr[2].attr);
+		if (ret)
+			goto err;
+		acpi_os_unmap_memory(table_header, sizeof(*table_header));
+	}
+	return ret;
+
+err:
+	if (rsdp)
+		acpi_os_map_memory(rsdp_ptr, sizeof(*rsdp));
+	if (table_header)
+		acpi_os_unmap_memory(table_header, sizeof(*table_header));
+	return ret;
+}
+
 static int acpi_tables_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
@@ -387,6 +508,8 @@ static int acpi_tables_sysfs_init(void)
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 	}
 
+	acpi_root_tables_sysfs_init(tables_kobj);
+
 	kobject_uevent(tables_kobj, KOBJ_ADD);
 	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
 	status = acpi_install_table_handler(acpi_sysfs_table_handler, NULL);
-- 
2.1.4
