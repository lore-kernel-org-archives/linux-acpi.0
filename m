From: Len Brown <lenb@kernel.org>
Subject: [RFC] ACPI interrupt statistics
Date: Sat, 3 Nov 2007 00:40:53 -0400
Message-ID: <200711030040.53126.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46802 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbXKCElH (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Sat, 3 Nov 2007 00:41:07 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id lA34ewhX022582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <Linux-acpi@vger.kernel.org>; Sat, 3 Nov 2007 04:40:59 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org

For your review and testing...

The patch below exports interrupt counters from within ACPI
so that developers can better understand the cause of ACPI interrupts.

My intent is to have something like this built in by default
starting in 2.6.25.  The version below applies to 2.6.21
and is originally based on a patch by Luming Yu.

I'll probably move most of the code to system.c from osl.c,
and I'll port it to 2.6.24;
but otherwise, it seems to be doing what I wanted it to do...

One idea is that a user-space application could
select() an individual GPE file in order to notice
when a particular GPE fires.   This might be useful
for user-space platform specific code -- say allowing
it to recognize a GPE without requiring any platform-specific
kernel code...

$ cd /sys/firmware/acpi/interrupts/
$ ls
gpe0   gpe11  gpe14  gpe17  gpe2   gpe22  gpe25  gpe28  gpe30  gpe5  gpe8
gpe1   gpe12  gpe15  gpe18  gpe20  gpe23  gpe26  gpe29  gpe31  gpe6  gpe9
gpe10  gpe13  gpe16  gpe19  gpe21  gpe24  gpe27  gpe3   gpe4   gpe7  summary
$ cat summary
pm_timer     0
glbl_lock    0
power_btn    0
sleep_btn    0
rtc          0
gpe0      0
gpe1      0
gpe2      0
gpe3      0
gpe4      0
gpe5      0
gpe6      0
gpe7      0
gpe8      0
gpe9      2
gpe10     0
gpe11     0
gpe12     0
gpe13     0
gpe14     0
gpe15     0
gpe16     0
gpe17    60
gpe18     0
gpe19     0
gpe20     0
gpe21     0
gpe22     0
gpe23     0
gpe24     0
gpe25     0
gpe26     0
gpe27     0
gpe28     0
gpe29     0
gpe30     0
gpe31     0
gpe_hi    0
gpe_total   62
acpi_irq    62
$ cat gpe17
60
# echo 0 > summary
# cat summary
(all zeros)

Signed-off-by: Len Brown <len.brown@intel.com>

---
 drivers/acpi/bus.c                |   44 +++
 drivers/acpi/events/evevent.c     |    2
 drivers/acpi/events/evgpe.c       |    2
 drivers/acpi/osl.c                |  232 +++++++++++++++++-
 drivers/acpi/utilities/utglobal.c |    2
 include/acpi/acglobal.h           |    1
 include/acpi/aclocal.h            |    1
 include/acpi/acpiosxf.h           |    3
 include/linux/acpi.h              |    6
 9 files changed, 290 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index dd49ea0..b1a8b24 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -735,6 +735,47 @@ static int __init acpi_bus_init(void)
 
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
 	if (result < 0
 		printk(KERN_WARNING "%s: firmware_register error: %d\n",
 			__FUNCTION__, result);
-
+	acpi_subsys_set_sysfs_ops();
 	result = acpi_bus_init();
 
 	if (!result) {
@@ -769,4 +810,5 @@ static int __init acpi_init(void)
 	return result;
 }
 
+EXPORT_SYMBOL(acpi_subsys);
 subsys_initcall(acpi_init);
diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index a1f87b5..8bf4dbe 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -261,7 +261,7 @@ u32 acpi_ev_fixed_event_detect(void)
 			enable_bit_mask)) {
 
 			/* Found an active (signalled) event */
-
+			acpi_fixed_event_count[i]++;
 			int_status |= acpi_ev_fixed_event_dispatch((u32) i);
 		}
 	}
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 635ba44..76a91f4 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -621,6 +621,8 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 
 	acpi_gpe_count++;
 
+	acpi_os_gpe_count(gpe_number);
+
 	/*
 	 * If edge-triggered, clear the GPE status bit now.  Note that
 	 * level-triggered events are cleared after the GPE is serviced.
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 971eca4..21290c0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -71,7 +71,9 @@ extern char line_buf[80];
 static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
+static u32 acpi_irq_handled;
 static struct workqueue_struct *kacpid_wq;
+static void acpi_irq_stats_init(void);
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
@@ -276,15 +278,26 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
 
 static irqreturn_t acpi_irq(int irq, void *dev_id)
 {
-	return (*acpi_irq_handler) (acpi_irq_context) ? IRQ_HANDLED : IRQ_NONE;
+	u32 handled;
+
+	handled = (*acpi_irq_handler) (acpi_irq_context);
+
+	if (handled) {
+		acpi_irq_handled++;
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
 }
 
+
 acpi_status
 acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 				  void *context)
 {
 	unsigned int irq;
 
+	acpi_irq_stats_init();
+
 	/*
 	 * Ignore the GSI from the core, and use the value in our copy of the
 	 * FADT. It may not be the same if an interrupt source override exists
@@ -1019,6 +1032,223 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
 	spin_unlock_irqrestore(lockp, flags);
 }
 
+/*
+ * ACPI IRQ counters
+ *
+ * /sys/firmware/acpi/interrupts
+ * summary -- IRQ, Fixed Event, and GPE counters
+ * gpe* -- broken-out counters for up to 32 GPEs
+ */
+
+static u32 *gpe_counters;
+static u32 gpe_counter_high;			/* bucket for GPE's >= 32 */
+static u32 number_of_gpes;
+static struct attribute **all_attrs;
+
+static struct attribute_group gpe_stats_attr_group = {
+	.name = "interrupts",
+};
+static struct gpe_attr *gpe_attrs;
+
+static int count_num_gpes(void) {
+	int count = 0;
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_block_info *gpe_block;
+	acpi_cpu_flags flags;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			count += gpe_block->register_count *
+			    ACPI_GPE_REGISTER_WIDTH;
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	return count;
+}
+
+static void delete_gpe_attr_array(void) {
+
+	u32 *tmp = gpe_counters;
+
+	gpe_counters = NULL;
+	kfree (tmp);
+
+	if (gpe_attrs) {
+		int i;
+
+		for (i = 0; i < number_of_gpes; i++)
+			kfree(gpe_attrs[i].attr.name);
+
+		kfree(gpe_attrs);
+	}
+	kfree(all_attrs);
+
+	return;
+}
+
+static ssize_t interrupt_summary_show(struct attribute *not_used, char *buf)
+{
+	int i;
+	ssize_t count = 0;
+
+	/*
+	 * Fixed event counters
+	 */
+	count += sprintf(buf + count, "pm_timer  %4d\n",
+		acpi_fixed_event_count[ACPI_EVENT_PMTIMER]);
+
+	count += sprintf(buf + count, "glbl_lock %4d\n",
+		acpi_fixed_event_count[ACPI_EVENT_GLOBAL]);
+
+	count += sprintf(buf + count, "power_btn %4d\n",
+		acpi_fixed_event_count[ACPI_EVENT_POWER_BUTTON]);
+
+	count += sprintf(buf + count, "sleep_btn %4d\n",
+		acpi_fixed_event_count[ACPI_EVENT_SLEEP_BUTTON]);
+
+	count += sprintf(buf + count, "rtc       %4d\n",
+		acpi_fixed_event_count[ACPI_EVENT_RTC]);
+
+	/*
+	 * General Purpose Events
+	 */
+	for (i = 0; i < number_of_gpes; i++) {
+		count += sprintf(buf + count, "gpe%-3d %4d\n",
+			i, gpe_counters[i]);
+	}
+
+	count += sprintf(buf + count, "gpe_hi %4d\n",
+		gpe_counter_high);
+
+	count += sprintf(buf + count, "gpe_total %4d\n",
+		acpi_gpe_count);
+
+	count += sprintf(buf + count, "acpi_irq  %4d\n",
+		acpi_irq_handled);
+
+	return count;
+}
+
+/*
+ * write anything to summary file: resets all counters
+ */
+static ssize_t interrupt_summary_reset(struct attribute *not_used, const char *buf, size_t count)
+{
+	int i;
+
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; ++i)
+		acpi_fixed_event_count[i] = 0;
+
+	for (i = 0; i < number_of_gpes; ++i)
+		gpe_counters[i] = 0;
+
+	acpi_gpe_count = 0;
+	gpe_counter_high = 0;
+	acpi_irq_handled = 0;
+
+	return count;
+}
+
+extern struct subsystem acpi_subsys;
+
+static ssize_t gpe_count_show(struct attribute *attr, char *buf) {
+
+	int index = container_of(attr, struct gpe_attr, attr) - gpe_attrs;
+
+	return sprintf(buf, "%d\n", gpe_counters[index]);
+}
+
+static ssize_t gpe_count_reset(struct attribute *attr, const char *buf, size_t size) {
+
+	int index = container_of(attr, struct gpe_attr, attr) - gpe_attrs;
+
+	gpe_counters[index] = strtoul(buf, NULL, 0);
+
+	return size;
+}
+
+static struct gpe_attr summary_attr = {
+	.attr = {.name = "summary", .mode = 0644},
+	.show = interrupt_summary_show,
+	.store = interrupt_summary_reset
+};
+
+void acpi_irq_stats_init(void) {
+
+	int i;
+
+	number_of_gpes = count_num_gpes();
+
+	all_attrs = kzalloc(sizeof(struct attribute *) * (number_of_gpes + 2),
+			GFP_KERNEL);
+	if (all_attrs == NULL)
+		return;
+
+	gpe_counters = kzalloc(sizeof(u32) * (number_of_gpes), GFP_KERNEL);
+	if (gpe_counters == NULL)
+		goto fail;
+
+	gpe_attrs = kzalloc(sizeof(struct gpe_attr) * (number_of_gpes),
+			GFP_KERNEL);
+	if (gpe_attrs == NULL)
+		goto fail;
+
+	for (i = 0; i < number_of_gpes; ++i) {
+		char buffer[10];
+		char *name;
+
+		sprintf(buffer, "gpe%d", i);
+		name = kzalloc(strlen(buffer) + 1, GFP_KERNEL);
+		if (na)me == NULL)
+			goto fail;
+		strncpy(name, buffer, strlen(buffer) + 1);
+
+		gpe_attrs[i].attr.name = name;
+		gpe_attrs[i].attr.mode = 0644;
+		gpe_attrs[i].show = gpe_count_show;
+		gpe_attrs[i].store = gpe_count_reset;
+
+		all_attrs[i] = &gpe_attrs[i].attr;
+	}
+	all_attrs[number_of_gpes] = &summary_attr.attr;
+
+	gpe_stats_attr_group.attrs = all_attrs;
+	sysfs_create_group(&cpi_subsys.kset.kobj, &gpe_stats_attr_group);
+	return;
+
+    fail:
+	delete_gpe_attr_array();
+	return;
+}
+
+static void __exit gpe_stats_exit(void) {
+	sysfs_remove_group(&acpi_subsys.kset.kobj, &gpe_stats_attr_group);
+
+	delete_gpe_attr_array();
+
+	return;
+}
+
+void acpi_os_gpe_count (u32 gpe_number) {
+
+	if (!gpe_counters)
+		return;
+
+	if (gpe_number < number_of_gpes) {
+		gpe_counters[gpe_number]++;
+	} else {
+		gpe_counter_high++;
+	}
+	return;
+}
+
 #ifndef ACPI_USE_LOCAL_CACHE
 
 /*******************************************************************************
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index af33358..fbb9bec 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -673,6 +673,8 @@ void acpi_ut_init_globals(void)
 	/* GPE support */
 
 	acpi_gpe_count = 0;
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
+		acpi_fixed_event_count[i] = 0;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 24c3f05..a27ba06 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -120,6 +120,7 @@ extern u32 acpi_gbl_nesting_level;
 /* Event counters */
 
 ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
 
 /* Support for dynamic control method tracing mechanism */
 
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 6f83ddb..380a8a8 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -368,6 +368,7 @@ struct acpi_gpe_event_info {
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to register info */
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
+	u32 count;
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 2785058..0d82437 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -180,6 +180,9 @@ acpi_os_install_interrupt_handler(u32 gsi,
 acpi_status
 acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
 
+void
+acpi_os_gpe_count (u32 gpe_number);
+
 /*
  * Threads and Scheduling
  */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8bcfaa4..5bc7c84 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -158,6 +158,12 @@ struct acpi_prt_list {
 	struct list_head	entries;
 };
 
+struct gpe_attr {
+	struct attribute attr;
+	int value;
+	ssize_t(*show) (struct attribute *, char *);
+	ssize_t(*store) (struct attribute *, const char *, size_t count);
+};
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
