From: "Luming Yu" <luming.yu@gmail.com>
Subject: [RFC patch] add GPE count under firmware acpi sysfs
Date: Mon, 19 Mar 2007 17:00:33 +0800
Message-ID: <3877989d0703190200gbb3e850ne93a2f8574f79dc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_124705_25627590.1174294833661"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:37856 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbXCSJAf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2007 05:00:35 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1328256wry
        for <linux-acpi@vger.kernel.org>; Mon, 19 Mar 2007 02:00:34 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

------=_Part_124705_25627590.1174294833661
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add GPE count under /sys/firmware/acpi/gpe.

signed-off-by: Luming Yu <Luming.yu@intel.com>
--
 drivers/acpi/Makefile       |    1
 drivers/acpi/bus.c          |   44 ++++++++++++-
 drivers/acpi/events/evgpe.c |    1
 drivers/acpi/gpe_stats.c    |  104 +++++++++++++++++++++++++++++++
 drivers/acpi/osl.c          |  146 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/aclocal.h      |    1
 include/linux/acpi.h        |    7 ++
 7 files changed, 303 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5956e9f..066eeeb 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_ac
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= i2c_ec.o sbs.o
+obj-m				+= gpe_stats.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index dd49ea0..b1a8b24 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -735,6 +735,47 @@ #endif

 decl_subsys(acpi, NULL, NULL);

+struct acpi_subsys_attr {
+	struct attribute attr;
+	int type;
+	int value;
+	ssize_t(*show) (struct attribute *, char *);
+	ssize_t(*store) (struct attribute *, const char *, size_t count);
+};
+#define to_acpi_attr(k) container_of(k,struct acpi_subsys_attr,attr)
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct acpi_subsys_attr *aattr = to_acpi_attr(attr);
+	if (aattr->show)
+		return aattr->show(attr, buf);
+	else
+		return -EIO;
+}
+
+static ssize_t store(struct kobject *kobj, struct attribute *attr,
+			const char *buf, size_t count)
+{
+	struct acpi_subsys_attr *aattr = to_acpi_attr(attr);
+	if (aattr->store)
+		return aattr->store(attr, buf, count);
+	else
+		return -EIO;
+}
+static struct sysfs_ops sysfs_ops = {
+	.show = show,
+	.store = store,
+};
+
+static struct kobj_type ktype_acpi = {
+	.sysfs_ops = &sysfs_ops,
+};
+
+void acpi_subsys_set_sysfs_ops(void)
+{
+	acpi_subsys.kset.kobj.ktype = &ktype_acpi;
+	acpi_subsys.kset.ktype = &ktype_acpi;
+}
+
 static int __init acpi_init(void)
 {
 	int result = 0;
@@ -749,7 +790,7 @@ static int __init acpi_init(void)
 	if (result < 0)
 		printk(KERN_WARNING "%s: firmware_register error: %d\n",
 			__FUNCTION__, result);
-
+	acpi_subsys_set_sysfs_ops();
 	result = acpi_bus_init();

 	if (!result) {
@@ -769,4 +810,5 @@ #endif
 	return result;
 }

+EXPORT_SYMBOL(acpi_subsys);
 subsys_initcall(acpi_init);
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 635ba44..9b3face 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -621,6 +621,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve

 	acpi_gpe_count++;

+	gpe_event_info->count++;
 	/*
 	 * If edge-triggered, clear the GPE status bit now.  Note that
 	 * level-triggered events are cleared after the GPE is serviced.
diff --git a/drivers/acpi/gpe_stats.c b/drivers/acpi/gpe_stats.c
new file mode 100644
index 0000000..7be639d
--- /dev/null
+++ b/drivers/acpi/gpe_stats.c
@@ -0,0 +1,104 @@
+/*
+ *  gpe_stats.c
+ *
+ *  Copyright (C) 2007 Luming Yu <luming.yu@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sysdev.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/spinlock.h>
+#include <linux/acpi.h>
+
+typedef ssize_t(*show_func) (struct attribute * attr, char *buf);
+extern struct subsystem acpi_subsys;
+#define to_gpe_attr(k) container_of(k,struct gpe_attr, attr)
+#define GPE_STATS_ATTR(_name,_mode,_show)\
+static struct gpe_attr _attr_##_name = {\
+	.attr = {.name = __stringify(_name), .owner = THIS_MODULE, \
+		.mode = _mode,},\
+	.type = 0,\
+	.value = -1, \
+	.show = _show,\
+};
+extern int acpi_show_gpe_count(char *buf);
+extern int acpi_show_one_gpe_count(int gpe_number, char *buf);
+static ssize_t show_gpe_states(struct attribute *attr, char *buf)
+{
+	struct gpe_attr *gattr = to_gpe_attr(attr);
+	if (gattr->type == 0) {
+		if (gattr->value == -1)
+			return acpi_show_gpe_count(buf);
+		else
+			return acpi_show_one_gpe_count(gattr->value, buf);
+	} else
+		return 0;
+}
+
+GPE_STATS_ATTR(stats, 0444, show_gpe_states);
+
+static struct attribute **default_attrs;
+static struct attribute_group gpe_stats_attr_group = {
+	.name = "gpe",
+};
+static struct gpe_attr *gpe_attrs;
+extern int create_gpe_attr_array(struct module *module,
+				 struct attribute ***attrs,
+				 struct gpe_attr **gpe_attrs,
+				 struct gpe_attr *attr, show_func func);
+static int __init gpe_stats_init(void)
+{
+	int gpe_count;
+	int ret = 0;
+
+	gpe_count = create_gpe_attr_array(THIS_MODULE, &default_attrs,
+					  &gpe_attrs, &_attr_stats,
+					  &show_gpe_states);
+	default_attrs[gpe_count] = &_attr_stats.attr;
+	gpe_stats_attr_group.attrs = default_attrs;
+	ret = sysfs_create_group(&acpi_subsys.kset.kobj, &gpe_stats_attr_group);
+	return ret;
+}
+
+static void __exit gpe_stats_exit(void)
+{
+	struct attribute **p;
+	sysfs_remove_group(&acpi_subsys.kset.kobj, &gpe_stats_attr_group);
+
+	p = default_attrs;
+	while (*p) {
+		if (*p != &_attr_stats.attr)
+			kfree((*p++)->name);
+		else
+			p++;
+	}
+	kfree(default_attrs);
+	kfree(gpe_attrs);
+	return;
+}
+
+MODULE_AUTHOR("Yu Luming <luming.yu@intel.com>");
+MODULE_DESCRIPTION("gpe_stats");
+MODULE_LICENSE("GPL");
+
+module_init(gpe_stats_init);
+module_exit(gpe_stats_exit);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 971eca4..ab04591 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1019,6 +1019,152 @@ void acpi_os_release_lock(acpi_spinlock
 	spin_unlock_irqrestore(lockp, flags);
 }

+typedef ssize_t(*show_func) (struct attribute * attr, char *buf);
+int create_gpe_attr_array(struct module *module,
+			  struct attribute ***attrs,
+			  struct gpe_attr **gpe_attrs,
+			  struct gpe_attr *attr, show_func * func)
+{
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_register_info *gpe_register;
+	acpi_cpu_flags flags;
+	int i, j, gpe_count, count;
+
+	gpe_count = 0;
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			gpe_count += gpe_block->register_count *
+			    ACPI_GPE_REGISTER_WIDTH;
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	*attrs =
+	    kzalloc(sizeof(struct attribute *) * (gpe_count + 2), GFP_KERNEL);
+	*gpe_attrs =
+	    kzalloc(sizeof(struct gpe_attr) * (gpe_count + 1), GFP_KERNEL);
+	count = 0;
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			for (i = 0; i < gpe_block->register_count; i++) {
+				gpe_register = &gpe_block->register_info[i];
+				for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
+					char *name;
+					int base =
+					    gpe_register->base_gpe_number;
+					int gpe;
+					gpe = base + j;
+					name = kzalloc(10, GFP_KERNEL);
+					sprintf(name, "%x", gpe);
+					memcpy(&(*gpe_attrs)[count],
+					       attr, sizeof(struct gpe_attr));
+					(*gpe_attrs)[count].attr.name = name;
+					(*gpe_attrs)[count].value = gpe;
+					(*attrs)[count] = (struct attribute *)
+					    &(*gpe_attrs)[count].attr;
+					count++;
+				}
+			}
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	return gpe_count;
+}
+
+EXPORT_SYMBOL(create_gpe_attr_array);
+
+int acpi_show_gpe_count(char *buf)
+{
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_cpu_flags flags;
+	u32 i, j, count;
+
+	count = 0;
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			for (i = 0; i < gpe_block->register_count; i++) {
+				gpe_register_info =
+				    &gpe_block->register_info[i];
+				for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++)
+					count += sprintf(buf + count,
+							 "GPE[%d]: %d\n",
+							 gpe_register_info->
+							 base_gpe_number + j,
+							 gpe_block->
+							 event_info[(i *
+								     ACPI_GPE_REGISTER_WIDTH)
+								    + j].count);
+			}
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return count;
+}
+
+EXPORT_SYMBOL(acpi_show_gpe_count);
+
+int acpi_show_one_gpe_count(int gpe_number, char *buf)
+{
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_cpu_flags flags;
+	u32 i, j, count;
+
+	count = 0;
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			for (i = 0; i < gpe_block->register_count; i++) {
+				gpe_register_info =
+				    &gpe_block->register_info[i];
+				for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++)
+					if (gpe_number ==
+					    (gpe_register_info->
+					     base_gpe_number + j)) {
+						count +=
+						    sprintf(buf + count,
+							    "GPE[%d]: %d\n",
+							    gpe_register_info->
+							    base_gpe_number + j,
+							    gpe_block->
+							    event_info[(i *
+									ACPI_GPE_REGISTER_WIDTH)
+								       +
+								       j].
+							    count);
+						acpi_os_release_lock
+						    (acpi_gbl_gpe_lock, flags);
+						return count;
+					}
+			}
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return count;
+}
+
+EXPORT_SYMBOL(acpi_show_one_gpe_count);
 #ifndef ACPI_USE_LOCAL_CACHE

 /*******************************************************************************
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 6f83ddb..380a8a8 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -368,6 +368,7 @@ struct acpi_gpe_event_info {
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to
register info */
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
+	u32 count;
 };

 /* Information about a GPE register pair, one per each status/enable
pair in an array */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8bcfaa4..35fab01 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -158,6 +158,13 @@ struct acpi_prt_list {
 	struct list_head	entries;
 };

+struct gpe_attr {
+	struct attribute attr;
+	int type;
+	int value;
+	ssize_t(*show) (struct attribute *, char *);
+	ssize_t(*store) (struct attribute *, const char *, size_t count);
+};
 struct pci_dev;

 int acpi_pci_irq_enable (struct pci_dev *dev);

------=_Part_124705_25627590.1174294833661
Content-Type: application/octet-stream; name="gpe_count.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gpe_count.patch"
X-Attachment-Id: f_ezgotchc

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9NYWtlZmlsZSBiL2RyaXZlcnMvYWNwaS9NYWtlZmls
ZQppbmRleCA1OTU2ZTlmLi4wNjZlZWViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvTWFrZWZp
bGUKKysrIGIvZHJpdmVycy9hY3BpL01ha2VmaWxlCkBAIC02MCwzICs2MCw0IEBAIG9iai0kKENP
TkZJR19BQ1BJX1RPU0hJQkEpCSs9IHRvc2hpYmFfYWMKIG9iai0kKENPTkZJR19BQ1BJX0hPVFBM
VUdfTUVNT1JZKQkrPSBhY3BpX21lbWhvdHBsdWcubwogb2JqLXkJCQkJKz0gY21fc2JzLm8KIG9i
ai0kKENPTkZJR19BQ1BJX1NCUykJCSs9IGkyY19lYy5vIHNicy5vCitvYmotbQkJCQkrPSBncGVf
c3RhdHMubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2J1cy5jIGIvZHJpdmVycy9hY3BpL2J1
cy5jCmluZGV4IGRkNDllYTAuLmIxYThiMjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9idXMu
YworKysgYi9kcml2ZXJzL2FjcGkvYnVzLmMKQEAgLTczNSw2ICs3MzUsNDcgQEAgI2VuZGlmCiAK
IGRlY2xfc3Vic3lzKGFjcGksIE5VTEwsIE5VTEwpOwogCitzdHJ1Y3QgYWNwaV9zdWJzeXNfYXR0
ciB7CisJc3RydWN0IGF0dHJpYnV0ZSBhdHRyOworCWludCB0eXBlOworCWludCB2YWx1ZTsKKwlz
c2l6ZV90KCpzaG93KSAoc3RydWN0IGF0dHJpYnV0ZSAqLCBjaGFyICopOworCXNzaXplX3QoKnN0
b3JlKSAoc3RydWN0IGF0dHJpYnV0ZSAqLCBjb25zdCBjaGFyICosIHNpemVfdCBjb3VudCk7Cit9
OworI2RlZmluZSB0b19hY3BpX2F0dHIoaykgY29udGFpbmVyX29mKGssc3RydWN0IGFjcGlfc3Vi
c3lzX2F0dHIsYXR0cikKK3N0YXRpYyBzc2l6ZV90IHNob3coc3RydWN0IGtvYmplY3QgKmtvYmos
IHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKK3sKKwlzdHJ1Y3QgYWNwaV9zdWJz
eXNfYXR0ciAqYWF0dHIgPSB0b19hY3BpX2F0dHIoYXR0cik7CisJaWYgKGFhdHRyLT5zaG93KQor
CQlyZXR1cm4gYWF0dHItPnNob3coYXR0ciwgYnVmKTsKKwllbHNlCisJCXJldHVybiAtRUlPOwor
fQorCitzdGF0aWMgc3NpemVfdCBzdG9yZShzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGF0
dHJpYnV0ZSAqYXR0ciwKKwkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQoreworCXN0
cnVjdCBhY3BpX3N1YnN5c19hdHRyICphYXR0ciA9IHRvX2FjcGlfYXR0cihhdHRyKTsKKwlpZiAo
YWF0dHItPnN0b3JlKQorCQlyZXR1cm4gYWF0dHItPnN0b3JlKGF0dHIsIGJ1ZiwgY291bnQpOwor
CWVsc2UKKwkJcmV0dXJuIC1FSU87Cit9CitzdGF0aWMgc3RydWN0IHN5c2ZzX29wcyBzeXNmc19v
cHMgPSB7CisJLnNob3cgPSBzaG93LAorCS5zdG9yZSA9IHN0b3JlLAorfTsKKworc3RhdGljIHN0
cnVjdCBrb2JqX3R5cGUga3R5cGVfYWNwaSA9IHsKKwkuc3lzZnNfb3BzID0gJnN5c2ZzX29wcywK
K307CisKK3ZvaWQgYWNwaV9zdWJzeXNfc2V0X3N5c2ZzX29wcyh2b2lkKQoreworCWFjcGlfc3Vi
c3lzLmtzZXQua29iai5rdHlwZSA9ICZrdHlwZV9hY3BpOworCWFjcGlfc3Vic3lzLmtzZXQua3R5
cGUgPSAma3R5cGVfYWNwaTsKK30KKwogc3RhdGljIGludCBfX2luaXQgYWNwaV9pbml0KHZvaWQp
CiB7CiAJaW50IHJlc3VsdCA9IDA7CkBAIC03NDksNyArNzkwLDcgQEAgc3RhdGljIGludCBfX2lu
aXQgYWNwaV9pbml0KHZvaWQpCiAJaWYgKHJlc3VsdCA8IDApCiAJCXByaW50ayhLRVJOX1dBUk5J
TkcgIiVzOiBmaXJtd2FyZV9yZWdpc3RlciBlcnJvcjogJWRcbiIsCiAJCQlfX0ZVTkNUSU9OX18s
IHJlc3VsdCk7Ci0KKwlhY3BpX3N1YnN5c19zZXRfc3lzZnNfb3BzKCk7CiAJcmVzdWx0ID0gYWNw
aV9idXNfaW5pdCgpOwogCiAJaWYgKCFyZXN1bHQpIHsKQEAgLTc2OSw0ICs4MTAsNSBAQCAjZW5k
aWYKIAlyZXR1cm4gcmVzdWx0OwogfQogCitFWFBPUlRfU1lNQk9MKGFjcGlfc3Vic3lzKTsKIHN1
YnN5c19pbml0Y2FsbChhY3BpX2luaXQpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2V2ZW50
cy9ldmdwZS5jIGIvZHJpdmVycy9hY3BpL2V2ZW50cy9ldmdwZS5jCmluZGV4IDYzNWJhNDQuLjli
M2ZhY2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9ldmVudHMvZXZncGUuYworKysgYi9kcml2
ZXJzL2FjcGkvZXZlbnRzL2V2Z3BlLmMKQEAgLTYyMSw2ICs2MjEsNyBAQCBhY3BpX2V2X2dwZV9k
aXNwYXRjaChzdHJ1Y3QgYWNwaV9ncGVfZXZlCiAKIAlhY3BpX2dwZV9jb3VudCsrOwogCisJZ3Bl
X2V2ZW50X2luZm8tPmNvdW50Kys7CiAJLyoKIAkgKiBJZiBlZGdlLXRyaWdnZXJlZCwgY2xlYXIg
dGhlIEdQRSBzdGF0dXMgYml0IG5vdy4gIE5vdGUgdGhhdAogCSAqIGxldmVsLXRyaWdnZXJlZCBl
dmVudHMgYXJlIGNsZWFyZWQgYWZ0ZXIgdGhlIEdQRSBpcyBzZXJ2aWNlZC4KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYWNwaS9ncGVfc3RhdHMuYyBiL2RyaXZlcnMvYWNwaS9ncGVfc3RhdHMuYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi43YmU2MzlkCi0tLSAvZGV2L251bGwKKysr
IGIvZHJpdmVycy9hY3BpL2dwZV9zdGF0cy5jCkBAIC0wLDAgKzEsMTA0IEBACisvKgorICogIGdw
ZV9zdGF0cy5jCisgKgorICogIENvcHlyaWdodCAoQykgMjAwNyBMdW1pbmcgWXUgPGx1bWluZy55
dUBpbnRlbC5jb20+CisgKgorICogfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KKyAqCisgKiAgVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVp
dGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yIChhdAorICogIHlvdXIgb3B0aW9uKSBh
bnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dAorICogIFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdO
VQorICogIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAg
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYWxvbmcKKyAqICB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLAorICogIDU5IFRlbXBsZSBQbGFjZSwg
U3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEzMDcgVVNBLgorICoKKyAqIH5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+CisgKi8KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9zeXNkZXYuaD4KKyNpbmNsdWRlIDxsaW51eC9zeXNm
cy5oPgorI2luY2x1ZGUgPGxpbnV4L2tvYmplY3QuaD4KKyNpbmNsdWRlIDxsaW51eC9zcGlubG9j
ay5oPgorI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KKwordHlwZWRlZiBzc2l6ZV90KCpzaG93X2Z1
bmMpIChzdHJ1Y3QgYXR0cmlidXRlICogYXR0ciwgY2hhciAqYnVmKTsKK2V4dGVybiBzdHJ1Y3Qg
c3Vic3lzdGVtIGFjcGlfc3Vic3lzOworI2RlZmluZSB0b19ncGVfYXR0cihrKSBjb250YWluZXJf
b2YoayxzdHJ1Y3QgZ3BlX2F0dHIsIGF0dHIpCisjZGVmaW5lIEdQRV9TVEFUU19BVFRSKF9uYW1l
LF9tb2RlLF9zaG93KVwKK3N0YXRpYyBzdHJ1Y3QgZ3BlX2F0dHIgX2F0dHJfIyNfbmFtZSA9IHtc
CisJLmF0dHIgPSB7Lm5hbWUgPSBfX3N0cmluZ2lmeShfbmFtZSksIC5vd25lciA9IFRISVNfTU9E
VUxFLCBcCisJCS5tb2RlID0gX21vZGUsfSxcCisJLnR5cGUgPSAwLFwKKwkudmFsdWUgPSAtMSwg
XAorCS5zaG93ID0gX3Nob3csXAorfTsKK2V4dGVybiBpbnQgYWNwaV9zaG93X2dwZV9jb3VudChj
aGFyICpidWYpOworZXh0ZXJuIGludCBhY3BpX3Nob3dfb25lX2dwZV9jb3VudChpbnQgZ3BlX251
bWJlciwgY2hhciAqYnVmKTsKK3N0YXRpYyBzc2l6ZV90IHNob3dfZ3BlX3N0YXRlcyhzdHJ1Y3Qg
YXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCit7CisJc3RydWN0IGdwZV9hdHRyICpnYXR0ciA9
IHRvX2dwZV9hdHRyKGF0dHIpOworCWlmIChnYXR0ci0+dHlwZSA9PSAwKSB7CisJCWlmIChnYXR0
ci0+dmFsdWUgPT0gLTEpCisJCQlyZXR1cm4gYWNwaV9zaG93X2dwZV9jb3VudChidWYpOworCQll
bHNlCisJCQlyZXR1cm4gYWNwaV9zaG93X29uZV9ncGVfY291bnQoZ2F0dHItPnZhbHVlLCBidWYp
OworCX0gZWxzZQorCQlyZXR1cm4gMDsKK30KKworR1BFX1NUQVRTX0FUVFIoc3RhdHMsIDA0NDQs
IHNob3dfZ3BlX3N0YXRlcyk7CisKK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICoqZGVmYXVsdF9h
dHRyczsKK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGdwZV9zdGF0c19hdHRyX2dyb3Vw
ID0geworCS5uYW1lID0gImdwZSIsCit9Oworc3RhdGljIHN0cnVjdCBncGVfYXR0ciAqZ3BlX2F0
dHJzOworZXh0ZXJuIGludCBjcmVhdGVfZ3BlX2F0dHJfYXJyYXkoc3RydWN0IG1vZHVsZSAqbW9k
dWxlLAorCQkJCSBzdHJ1Y3QgYXR0cmlidXRlICoqKmF0dHJzLAorCQkJCSBzdHJ1Y3QgZ3BlX2F0
dHIgKipncGVfYXR0cnMsCisJCQkJIHN0cnVjdCBncGVfYXR0ciAqYXR0ciwgc2hvd19mdW5jIGZ1
bmMpOworc3RhdGljIGludCBfX2luaXQgZ3BlX3N0YXRzX2luaXQodm9pZCkKK3sKKwlpbnQgZ3Bl
X2NvdW50OworCWludCByZXQgPSAwOworCisJZ3BlX2NvdW50ID0gY3JlYXRlX2dwZV9hdHRyX2Fy
cmF5KFRISVNfTU9EVUxFLCAmZGVmYXVsdF9hdHRycywKKwkJCQkJICAmZ3BlX2F0dHJzLCAmX2F0
dHJfc3RhdHMsCisJCQkJCSAgJnNob3dfZ3BlX3N0YXRlcyk7CisJZGVmYXVsdF9hdHRyc1tncGVf
Y291bnRdID0gJl9hdHRyX3N0YXRzLmF0dHI7CisJZ3BlX3N0YXRzX2F0dHJfZ3JvdXAuYXR0cnMg
PSBkZWZhdWx0X2F0dHJzOworCXJldCA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmYWNwaV9zdWJzeXMu
a3NldC5rb2JqLCAmZ3BlX3N0YXRzX2F0dHJfZ3JvdXApOworCXJldHVybiByZXQ7Cit9CisKK3N0
YXRpYyB2b2lkIF9fZXhpdCBncGVfc3RhdHNfZXhpdCh2b2lkKQoreworCXN0cnVjdCBhdHRyaWJ1
dGUgKipwOworCXN5c2ZzX3JlbW92ZV9ncm91cCgmYWNwaV9zdWJzeXMua3NldC5rb2JqLCAmZ3Bl
X3N0YXRzX2F0dHJfZ3JvdXApOworCisJcCA9IGRlZmF1bHRfYXR0cnM7CisJd2hpbGUgKCpwKSB7
CisJCWlmICgqcCAhPSAmX2F0dHJfc3RhdHMuYXR0cikKKwkJCWtmcmVlKCgqcCsrKS0+bmFtZSk7
CisJCWVsc2UKKwkJCXArKzsKKwl9CisJa2ZyZWUoZGVmYXVsdF9hdHRycyk7CisJa2ZyZWUoZ3Bl
X2F0dHJzKTsKKwlyZXR1cm47Cit9CisKK01PRFVMRV9BVVRIT1IoIll1IEx1bWluZyA8bHVtaW5n
Lnl1QGludGVsLmNvbT4iKTsKK01PRFVMRV9ERVNDUklQVElPTigiZ3BlX3N0YXRzIik7CitNT0RV
TEVfTElDRU5TRSgiR1BMIik7CisKK21vZHVsZV9pbml0KGdwZV9zdGF0c19pbml0KTsKK21vZHVs
ZV9leGl0KGdwZV9zdGF0c19leGl0KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9vc2wuYyBi
L2RyaXZlcnMvYWNwaS9vc2wuYwppbmRleCA5NzFlY2E0Li5hYjA0NTkxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2FjcGkvb3NsLmMKKysrIGIvZHJpdmVycy9hY3BpL29zbC5jCkBAIC0xMDE5LDYgKzEw
MTksMTUyIEBAIHZvaWQgYWNwaV9vc19yZWxlYXNlX2xvY2soYWNwaV9zcGlubG9jayAKIAlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKGxvY2twLCBmbGFncyk7CiB9CiAKK3R5cGVkZWYgc3NpemVfdCgq
c2hvd19mdW5jKSAoc3RydWN0IGF0dHJpYnV0ZSAqIGF0dHIsIGNoYXIgKmJ1Zik7CitpbnQgY3Jl
YXRlX2dwZV9hdHRyX2FycmF5KHN0cnVjdCBtb2R1bGUgKm1vZHVsZSwKKwkJCSAgc3RydWN0IGF0
dHJpYnV0ZSAqKiphdHRycywKKwkJCSAgc3RydWN0IGdwZV9hdHRyICoqZ3BlX2F0dHJzLAorCQkJ
ICBzdHJ1Y3QgZ3BlX2F0dHIgKmF0dHIsIHNob3dfZnVuYyAqIGZ1bmMpCit7CisJc3RydWN0IGFj
cGlfZ3BlX2Jsb2NrX2luZm8gKmdwZV9ibG9jazsKKwlzdHJ1Y3QgYWNwaV9ncGVfeHJ1cHRfaW5m
byAqZ3BlX3hydXB0X2luZm87CisJc3RydWN0IGFjcGlfZ3BlX3JlZ2lzdGVyX2luZm8gKmdwZV9y
ZWdpc3RlcjsKKwlhY3BpX2NwdV9mbGFncyBmbGFnczsKKwlpbnQgaSwgaiwgZ3BlX2NvdW50LCBj
b3VudDsKKworCWdwZV9jb3VudCA9IDA7CisJZmxhZ3MgPSBhY3BpX29zX2FjcXVpcmVfbG9jayhh
Y3BpX2dibF9ncGVfbG9jayk7CisJZ3BlX3hydXB0X2luZm8gPSBhY3BpX2dibF9ncGVfeHJ1cHRf
bGlzdF9oZWFkOworCXdoaWxlIChncGVfeHJ1cHRfaW5mbykgeworCQlncGVfYmxvY2sgPSBncGVf
eHJ1cHRfaW5mby0+Z3BlX2Jsb2NrX2xpc3RfaGVhZDsKKwkJd2hpbGUgKGdwZV9ibG9jaykgewor
CQkJZ3BlX2NvdW50ICs9IGdwZV9ibG9jay0+cmVnaXN0ZXJfY291bnQgKgorCQkJICAgIEFDUElf
R1BFX1JFR0lTVEVSX1dJRFRIOworCQkJZ3BlX2Jsb2NrID0gZ3BlX2Jsb2NrLT5uZXh0OworCQl9
CisJCWdwZV94cnVwdF9pbmZvID0gZ3BlX3hydXB0X2luZm8tPm5leHQ7CisJfQorCSphdHRycyA9
CisJICAgIGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBhdHRyaWJ1dGUgKikgKiAoZ3BlX2NvdW50ICsg
MiksIEdGUF9LRVJORUwpOworCSpncGVfYXR0cnMgPQorCSAgICBremFsbG9jKHNpemVvZihzdHJ1
Y3QgZ3BlX2F0dHIpICogKGdwZV9jb3VudCArIDEpLCBHRlBfS0VSTkVMKTsKKwljb3VudCA9IDA7
CisJZ3BlX3hydXB0X2luZm8gPSBhY3BpX2dibF9ncGVfeHJ1cHRfbGlzdF9oZWFkOworCXdoaWxl
IChncGVfeHJ1cHRfaW5mbykgeworCQlncGVfYmxvY2sgPSBncGVfeHJ1cHRfaW5mby0+Z3BlX2Js
b2NrX2xpc3RfaGVhZDsKKwkJd2hpbGUgKGdwZV9ibG9jaykgeworCQkJZm9yIChpID0gMDsgaSA8
IGdwZV9ibG9jay0+cmVnaXN0ZXJfY291bnQ7IGkrKykgeworCQkJCWdwZV9yZWdpc3RlciA9ICZn
cGVfYmxvY2stPnJlZ2lzdGVyX2luZm9baV07CisJCQkJZm9yIChqID0gMDsgaiA8IEFDUElfR1BF
X1JFR0lTVEVSX1dJRFRIOyBqKyspIHsKKwkJCQkJY2hhciAqbmFtZTsKKwkJCQkJaW50IGJhc2Ug
PQorCQkJCQkgICAgZ3BlX3JlZ2lzdGVyLT5iYXNlX2dwZV9udW1iZXI7CisJCQkJCWludCBncGU7
CisJCQkJCWdwZSA9IGJhc2UgKyBqOworCQkJCQluYW1lID0ga3phbGxvYygxMCwgR0ZQX0tFUk5F
TCk7CisJCQkJCXNwcmludGYobmFtZSwgIiV4IiwgZ3BlKTsKKwkJCQkJbWVtY3B5KCYoKmdwZV9h
dHRycylbY291bnRdLAorCQkJCQkgICAgICAgYXR0ciwgc2l6ZW9mKHN0cnVjdCBncGVfYXR0cikp
OworCQkJCQkoKmdwZV9hdHRycylbY291bnRdLmF0dHIubmFtZSA9IG5hbWU7CisJCQkJCSgqZ3Bl
X2F0dHJzKVtjb3VudF0udmFsdWUgPSBncGU7CisJCQkJCSgqYXR0cnMpW2NvdW50XSA9IChzdHJ1
Y3QgYXR0cmlidXRlICopCisJCQkJCSAgICAmKCpncGVfYXR0cnMpW2NvdW50XS5hdHRyOworCQkJ
CQljb3VudCsrOworCQkJCX0KKwkJCX0KKwkJCWdwZV9ibG9jayA9IGdwZV9ibG9jay0+bmV4dDsK
KwkJfQorCQlncGVfeHJ1cHRfaW5mbyA9IGdwZV94cnVwdF9pbmZvLT5uZXh0OworCX0KKwlhY3Bp
X29zX3JlbGVhc2VfbG9jayhhY3BpX2dibF9ncGVfbG9jaywgZmxhZ3MpOworCisJcmV0dXJuIGdw
ZV9jb3VudDsKK30KKworRVhQT1JUX1NZTUJPTChjcmVhdGVfZ3BlX2F0dHJfYXJyYXkpOworCitp
bnQgYWNwaV9zaG93X2dwZV9jb3VudChjaGFyICpidWYpCit7CisJc3RydWN0IGFjcGlfZ3BlX2Js
b2NrX2luZm8gKmdwZV9ibG9jazsKKwlzdHJ1Y3QgYWNwaV9ncGVfeHJ1cHRfaW5mbyAqZ3BlX3hy
dXB0X2luZm87CisJc3RydWN0IGFjcGlfZ3BlX3JlZ2lzdGVyX2luZm8gKmdwZV9yZWdpc3Rlcl9p
bmZvOworCWFjcGlfY3B1X2ZsYWdzIGZsYWdzOworCXUzMiBpLCBqLCBjb3VudDsKKworCWNvdW50
ID0gMDsKKwlmbGFncyA9IGFjcGlfb3NfYWNxdWlyZV9sb2NrKGFjcGlfZ2JsX2dwZV9sb2NrKTsK
KwlncGVfeHJ1cHRfaW5mbyA9IGFjcGlfZ2JsX2dwZV94cnVwdF9saXN0X2hlYWQ7CisJd2hpbGUg
KGdwZV94cnVwdF9pbmZvKSB7CisJCWdwZV9ibG9jayA9IGdwZV94cnVwdF9pbmZvLT5ncGVfYmxv
Y2tfbGlzdF9oZWFkOworCQl3aGlsZSAoZ3BlX2Jsb2NrKSB7CisJCQlmb3IgKGkgPSAwOyBpIDwg
Z3BlX2Jsb2NrLT5yZWdpc3Rlcl9jb3VudDsgaSsrKSB7CisJCQkJZ3BlX3JlZ2lzdGVyX2luZm8g
PQorCQkJCSAgICAmZ3BlX2Jsb2NrLT5yZWdpc3Rlcl9pbmZvW2ldOworCQkJCWZvciAoaiA9IDA7
IGogPCBBQ1BJX0dQRV9SRUdJU1RFUl9XSURUSDsgaisrKQorCQkJCQljb3VudCArPSBzcHJpbnRm
KGJ1ZiArIGNvdW50LAorCQkJCQkJCSAiR1BFWyVkXTogJWRcbiIsCisJCQkJCQkJIGdwZV9yZWdp
c3Rlcl9pbmZvLT4KKwkJCQkJCQkgYmFzZV9ncGVfbnVtYmVyICsgaiwKKwkJCQkJCQkgZ3BlX2Js
b2NrLT4KKwkJCQkJCQkgZXZlbnRfaW5mb1soaSAqCisJCQkJCQkJCSAgICAgQUNQSV9HUEVfUkVH
SVNURVJfV0lEVEgpCisJCQkJCQkJCSAgICArIGpdLmNvdW50KTsKKwkJCX0KKwkJCWdwZV9ibG9j
ayA9IGdwZV9ibG9jay0+bmV4dDsKKwkJfQorCQlncGVfeHJ1cHRfaW5mbyA9IGdwZV94cnVwdF9p
bmZvLT5uZXh0OworCX0KKwlhY3BpX29zX3JlbGVhc2VfbG9jayhhY3BpX2dibF9ncGVfbG9jaywg
ZmxhZ3MpOworCXJldHVybiBjb3VudDsKK30KKworRVhQT1JUX1NZTUJPTChhY3BpX3Nob3dfZ3Bl
X2NvdW50KTsKKworaW50IGFjcGlfc2hvd19vbmVfZ3BlX2NvdW50KGludCBncGVfbnVtYmVyLCBj
aGFyICpidWYpCit7CisJc3RydWN0IGFjcGlfZ3BlX2Jsb2NrX2luZm8gKmdwZV9ibG9jazsKKwlz
dHJ1Y3QgYWNwaV9ncGVfeHJ1cHRfaW5mbyAqZ3BlX3hydXB0X2luZm87CisJc3RydWN0IGFjcGlf
Z3BlX3JlZ2lzdGVyX2luZm8gKmdwZV9yZWdpc3Rlcl9pbmZvOworCWFjcGlfY3B1X2ZsYWdzIGZs
YWdzOworCXUzMiBpLCBqLCBjb3VudDsKKworCWNvdW50ID0gMDsKKwlmbGFncyA9IGFjcGlfb3Nf
YWNxdWlyZV9sb2NrKGFjcGlfZ2JsX2dwZV9sb2NrKTsKKwlncGVfeHJ1cHRfaW5mbyA9IGFjcGlf
Z2JsX2dwZV94cnVwdF9saXN0X2hlYWQ7CisJd2hpbGUgKGdwZV94cnVwdF9pbmZvKSB7CisJCWdw
ZV9ibG9jayA9IGdwZV94cnVwdF9pbmZvLT5ncGVfYmxvY2tfbGlzdF9oZWFkOworCQl3aGlsZSAo
Z3BlX2Jsb2NrKSB7CisJCQlmb3IgKGkgPSAwOyBpIDwgZ3BlX2Jsb2NrLT5yZWdpc3Rlcl9jb3Vu
dDsgaSsrKSB7CisJCQkJZ3BlX3JlZ2lzdGVyX2luZm8gPQorCQkJCSAgICAmZ3BlX2Jsb2NrLT5y
ZWdpc3Rlcl9pbmZvW2ldOworCQkJCWZvciAoaiA9IDA7IGogPCBBQ1BJX0dQRV9SRUdJU1RFUl9X
SURUSDsgaisrKQorCQkJCQlpZiAoZ3BlX251bWJlciA9PQorCQkJCQkgICAgKGdwZV9yZWdpc3Rl
cl9pbmZvLT4KKwkJCQkJICAgICBiYXNlX2dwZV9udW1iZXIgKyBqKSkgeworCQkJCQkJY291bnQg
Kz0KKwkJCQkJCSAgICBzcHJpbnRmKGJ1ZiArIGNvdW50LAorCQkJCQkJCSAgICAiR1BFWyVkXTog
JWRcbiIsCisJCQkJCQkJICAgIGdwZV9yZWdpc3Rlcl9pbmZvLT4KKwkJCQkJCQkgICAgYmFzZV9n
cGVfbnVtYmVyICsgaiwKKwkJCQkJCQkgICAgZ3BlX2Jsb2NrLT4KKwkJCQkJCQkgICAgZXZlbnRf
aW5mb1soaSAqCisJCQkJCQkJCQlBQ1BJX0dQRV9SRUdJU1RFUl9XSURUSCkKKwkJCQkJCQkJICAg
ICAgICsKKwkJCQkJCQkJICAgICAgIGpdLgorCQkJCQkJCSAgICBjb3VudCk7CisJCQkJCQlhY3Bp
X29zX3JlbGVhc2VfbG9jaworCQkJCQkJICAgIChhY3BpX2dibF9ncGVfbG9jaywgZmxhZ3MpOwor
CQkJCQkJcmV0dXJuIGNvdW50OworCQkJCQl9CisJCQl9CisJCQlncGVfYmxvY2sgPSBncGVfYmxv
Y2stPm5leHQ7CisJCX0KKwkJZ3BlX3hydXB0X2luZm8gPSBncGVfeHJ1cHRfaW5mby0+bmV4dDsK
Kwl9CisJYWNwaV9vc19yZWxlYXNlX2xvY2soYWNwaV9nYmxfZ3BlX2xvY2ssIGZsYWdzKTsKKwly
ZXR1cm4gY291bnQ7Cit9CisKK0VYUE9SVF9TWU1CT0woYWNwaV9zaG93X29uZV9ncGVfY291bnQp
OwogI2lmbmRlZiBBQ1BJX1VTRV9MT0NBTF9DQUNIRQogCiAvKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2FjbG9jYWwuaCBiL2luY2x1ZGUvYWNwaS9hY2xv
Y2FsLmgKaW5kZXggNmY4M2RkYi4uMzgwYThhOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hY3BpL2Fj
bG9jYWwuaAorKysgYi9pbmNsdWRlL2FjcGkvYWNsb2NhbC5oCkBAIC0zNjgsNiArMzY4LDcgQEAg
c3RydWN0IGFjcGlfZ3BlX2V2ZW50X2luZm8gewogCXN0cnVjdCBhY3BpX2dwZV9yZWdpc3Rlcl9p
bmZvICpyZWdpc3Rlcl9pbmZvOwkvKiBCYWNrcG9pbnRlciB0byByZWdpc3RlciBpbmZvICovCiAJ
dTggZmxhZ3M7CQkvKiBNaXNjIGluZm8gYWJvdXQgdGhpcyBHUEUgKi8KIAl1OCBncGVfbnVtYmVy
OwkJLyogVGhpcyBHUEUgKi8KKwl1MzIgY291bnQ7CiB9OwogCiAvKiBJbmZvcm1hdGlvbiBhYm91
dCBhIEdQRSByZWdpc3RlciBwYWlyLCBvbmUgcGVyIGVhY2ggc3RhdHVzL2VuYWJsZSBwYWlyIGlu
IGFuIGFycmF5ICovCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGkuaCBiL2luY2x1ZGUv
bGludXgvYWNwaS5oCmluZGV4IDhiY2ZhYTQuLjM1ZmFiMDEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvYWNwaS5oCisrKyBiL2luY2x1ZGUvbGludXgvYWNwaS5oCkBAIC0xNTgsNiArMTU4LDEz
IEBAIHN0cnVjdCBhY3BpX3BydF9saXN0IHsKIAlzdHJ1Y3QgbGlzdF9oZWFkCWVudHJpZXM7CiB9
OwogCitzdHJ1Y3QgZ3BlX2F0dHIgeworCXN0cnVjdCBhdHRyaWJ1dGUgYXR0cjsKKwlpbnQgdHlw
ZTsKKwlpbnQgdmFsdWU7CisJc3NpemVfdCgqc2hvdykgKHN0cnVjdCBhdHRyaWJ1dGUgKiwgY2hh
ciAqKTsKKwlzc2l6ZV90KCpzdG9yZSkgKHN0cnVjdCBhdHRyaWJ1dGUgKiwgY29uc3QgY2hhciAq
LCBzaXplX3QgY291bnQpOworfTsKIHN0cnVjdCBwY2lfZGV2OwogCiBpbnQgYWNwaV9wY2lfaXJx
X2VuYWJsZSAoc3RydWN0IHBjaV9kZXYgKmRldik7Cg==
------=_Part_124705_25627590.1174294833661--
