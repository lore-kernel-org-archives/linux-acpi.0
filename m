From: Len Brown <len.brown@intel.com>
Subject: [PATCH 070/105] ACPI: thinkpad-acpi: add infrastructure for the sysfs device attributes
Date: Sun, 29 Apr 2007 00:51:10 -0400
Message-ID: <11778223692377-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42357 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155AbXD2Ewv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:51 -0400
In-Reply-To: <1177822368793-git-send-email-len.brown@intel.com>
Message-Id: <7252374a39d794879f5e47bcfa0a16e7599b27b5.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add infrastructure to deal with sysfs attributes and grouping, and helpers
for common sysfs parsing.  Switch driver attributes to use them.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
