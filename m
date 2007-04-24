From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/9] ACPI: thinkpad-acpi: add infrastructure for the sysfs device attributes
Date: Tue, 24 Apr 2007 11:48:14 -0300
Message-ID: <11774261002010-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35409 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754133AbXDXOs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:27 -0400
In-Reply-To: <11774261003184-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add infrastructure to deal with sysfs attributes and grouping, and helpers
for common sysfs parsing.  Switch driver attributes to use them.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   86 +++++++++++++++++++++++++++++++++++++++--
 drivers/misc/thinkpad_acpi.h |   21 ++++++++++
 2 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a31d00d..ca6d15c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -520,12 +520,8 @@ static ssize_t tpacpi_driver_debug_store(struct device_driver *drv,
 						const char *buf, size_t count)
 {
 	unsigned long t;
-	char *endp;
 
-	t = simple_strtoul(buf, &endp, 0);
-	while (*endp && isspace(*endp))
-		endp++;
-	if (*endp)
+	if (parse_strtoul(buf, 0xffff, &t))
 		return -EINVAL;
 
 	dbg_level = t;
@@ -575,6 +571,86 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 		driver_remove_file(drv, tpacpi_driver_attributes[i]);
 }
 
+/*************************************************************************
+ * sysfs support helpers
+ */
+
+struct attribute_set_obj {
+	struct attribute_set s;
+	struct attribute *a;
+} __attribute__((packed));
+
+static struct attribute_set *create_attr_set(unsigned int max_members,
+						const char* name)
+{
+	struct attribute_set_obj *sobj;
+
+	if (max_members == 0)
+		return NULL;
+
+	/* Allocates space for implicit NULL at the end too */
+	sobj = kzalloc(sizeof(struct attribute_set_obj) +
+		    max_members * sizeof(struct attribute *),
+		    GFP_KERNEL);
+	if (!sobj)
+		return NULL;
+	sobj->s.max_members = max_members;
+	sobj->s.group.attrs = &sobj->a;
+	sobj->s.group.name = name;
+
+	return &sobj->s;
+}
+
+/* not multi-threaded safe, use it in a single thread per set */
+static int add_to_attr_set(struct attribute_set* s, struct attribute *attr)
+{
+	if (!s || !attr)
+		return -EINVAL;
+
+	if (s->members >= s->max_members)
+		return -ENOMEM;
+
+	s->group.attrs[s->members] = attr;
+	s->members++;
+
+	return 0;
+}
+
+static int add_many_to_attr_set(struct attribute_set* s,
+			struct attribute **attr,
+			unsigned int count)
+{
+	int i, res;
+
+	for (i = 0; i < count; i++) {
+		res = add_to_attr_set(s, attr[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static void delete_attr_set(struct attribute_set* s, struct kobject *kobj)
+{
+	sysfs_remove_group(kobj, &s->group);
+	destroy_attr_set(s);
+}
+
+static int parse_strtoul(const char *buf,
+		unsigned long max, unsigned long *value)
+{
+	char *endp;
+
+	*value = simple_strtoul(buf, &endp, 0);
+	while (*endp && isspace(*endp))
+		endp++;
+	if (*endp || *value > max)
+		return -EINVAL;
+
+	return 0;
+}
+
 /****************************************************************************
  ****************************************************************************
  *
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 3786058..84fdefe 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -134,6 +134,27 @@ static int dispatch_procfs_write(struct file *file,
 		unsigned long count, void *data);
 static char *next_cmd(char **cmds);
 
+/* sysfs support */
+struct attribute_set {
+	unsigned int members, max_members;
+	struct attribute_group group;
+};
+
+static struct attribute_set *create_attr_set(unsigned int max_members,
+						const char* name);
+#define destroy_attr_set(_set) \
+	kfree(_set);
+static int add_to_attr_set(struct attribute_set* s, struct attribute *attr);
+static int add_many_to_attr_set(struct attribute_set* s,
+			struct attribute **attr,
+			unsigned int count);
+#define register_attr_set_with_sysfs(_attr_set, _kobj) \
+	sysfs_create_group(_kobj, &_attr_set->group)
+static void delete_attr_set(struct attribute_set* s, struct kobject *kobj);
+
+static int parse_strtoul(const char *buf, unsigned long max,
+			unsigned long *value);
+
 /* Device model */
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
-- 
1.5.1

