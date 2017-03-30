From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 29 Mar 2017 18:13:15 -0600
Message-ID: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932757AbdC3AN2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 20:13:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com, al.stone@linaro.org, Prashanth Prakash <pprakash@codeaurora.org>

Add support to expose idle statistics maintained by platform to
userspace via sysfs in addition to other data of interest from
each LPI(Low Power Idle) state.

LPI described in section 8.4.4 of ACPI spec 6.1 provides different
methods to obtain idle statistics maintained by the platform. These
show a granular view of how each of the LPI state is being used at
different level of hierarchy. sysfs data is exposed at each level in
the hierarchy by creating a directory named 'lpi' at each level and
the LPI state information is presented under it. Below is the
representation of LPI information at one such level in the hierarchy

.../ACPI00XX: XX/lpi
	|-> summary_stats
	|-> state0
	|	|-> desc
	|	|-> time
	|	|-> usage
	|	|-> latency
	|	|-> min_residency
	|	|-> flags
	|	|-> arch_flags
	|
	<<more states>>

ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)

stateX contains information related to a specific LPI state defined
in the LPI ACPI tables.

summary_stats shows the stats(usage and time) from all the LPI states
under a device. The summary_stats are provided to reduce the number'
of files to be accessed by the userspace to capture a snapshot of the'
idle statistics.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/acpi_processor.c |  11 ++
 drivers/acpi/processor_idle.c | 345 +++++++++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h      |  27 ++++
 3 files changed, 381 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 0143135..a01368d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -570,9 +570,19 @@ void __init acpi_early_processor_osc(void)
 static int acpi_processor_container_attach(struct acpi_device *dev,
 					   const struct acpi_device_id *id)
 {
+	if (dev->status.present && dev->status.functional &&
+		dev->status.enabled && dev->status.show_in_ui)
+		acpi_lpi_sysfs_init(dev->handle,
+				(struct acpi_lpi_sysfs_data **)&dev->driver_data);
 	return 1;
 }
 
+static void acpi_processor_container_detach(struct acpi_device *dev)
+{
+	if (dev->driver_data)
+		acpi_lpi_sysfs_exit((struct acpi_lpi_sysfs_data *)dev->driver_data);
+}
+
 static const struct acpi_device_id processor_container_ids[] = {
 	{ ACPI_PROCESSOR_CONTAINER_HID, },
 	{ }
@@ -581,6 +591,7 @@ static int acpi_processor_container_attach(struct acpi_device *dev,
 static struct acpi_scan_handler processor_container_handler = {
 	.ids = processor_container_ids,
 	.attach = acpi_processor_container_attach,
+	.detach = acpi_processor_container_detach,
 };
 
 /* The number of the unique processor IDs */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5c8aa9c..ae898c2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -949,6 +949,24 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
 	return 0;
 }
 
+static int obj_get_generic_addr(union acpi_object *obj,
+				struct acpi_generic_address *addr)
+{
+	struct acpi_power_register *reg;
+
+	if (obj->type != ACPI_TYPE_BUFFER)
+		return -EINVAL;
+
+	reg = (struct acpi_power_register *)obj->buffer.pointer;
+	addr->space_id = reg->space_id;
+	addr->bit_width = reg->bit_width;
+	addr->bit_offset = reg->bit_offset;
+	addr->access_width = reg->access_size;
+	addr->address = reg->address;
+
+	return 0;
+}
+
 static int acpi_processor_evaluate_lpi(acpi_handle handle,
 				       struct acpi_lpi_states_array *info)
 {
@@ -1023,8 +1041,6 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			continue;
 		}
 
-		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
-
 		obj = pkg_elem + 9;
 		if (obj->type == ACPI_TYPE_STRING)
 			strlcpy(lpi_state->desc, obj->string.pointer,
@@ -1052,6 +1068,10 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 
 		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
 			lpi_state->enable_parent_state = 0;
+
+		obj_get_generic_addr(pkg_elem + 7, &lpi_state->res_cntr);
+
+		obj_get_generic_addr(pkg_elem + 8, &lpi_state->usage_cntr);
 	}
 
 	acpi_handle_debug(handle, "Found %d power states\n", state_idx);
@@ -1208,6 +1228,14 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	pr->flags.has_lpi = 1;
 	pr->flags.power = 1;
 
+	/*
+	 * Set up LPI sysfs at the processor device level - acpi_lpi_sysfs_exit
+	 * will not be called on CPU offline path, so need to check if sysfs is
+	 * initialized before calling init
+	 */
+	if (!pr->power.lpi_sysfs_data)
+		acpi_lpi_sysfs_init(pr->handle, &pr->power.lpi_sysfs_data);
+
 	return 0;
 }
 
@@ -1477,8 +1505,321 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered == 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		if (pr->power.lpi_sysfs_data)
+			acpi_lpi_sysfs_exit(pr->power.lpi_sysfs_data);
 	}
 
 	pr->flags.power_setup_done = 0;
 	return 0;
 }
+
+
+/*
+ * LPI sysfs support
+ * Exports two APIs that can be called as part of init and exit to setup the LPI
+ * sysfs entries either from processor or processor_container driver
+ */
+
+struct acpi_lpi_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			const char *c, ssize_t count);
+};
+
+#define define_lpi_ro(_name) static struct acpi_lpi_attr _name =	\
+		__ATTR(_name, 0444, show_##_name, NULL)
+
+#define to_acpi_lpi_sysfs_state(k)				\
+	container_of(k, struct acpi_lpi_sysfs_state, kobj)
+
+#define to_acpi_lpi_state(k)			\
+	to_acpi_lpi_sysfs_state(k)->lpi_state
+
+static ssize_t show_desc(struct kobject *kobj, struct attribute *attr,
+			char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", lpi->desc);
+}
+define_lpi_ro(desc);
+
+static int acpi_lpi_get_time(struct acpi_lpi_state *lpi, u64 *val)
+{
+	struct acpi_generic_address *reg;
+
+	if (!lpi)
+		return -EFAULT;
+
+	reg = &lpi->res_cntr;
+
+	/* Supporting only system memory */
+	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+		!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
+		!reg->address || !lpi->res_cnt_freq)
+		return -EINVAL;
+
+	if (ACPI_FAILURE(acpi_read(val, reg)))
+		return -EFAULT;
+
+	*val = (*val * 1000000) / lpi->res_cnt_freq;
+	return 0;
+
+}
+
+/* shows residency in us */
+static ssize_t show_time(struct kobject *kobj, struct attribute *attr,
+			char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+	u64 val = 0;
+	int ret;
+
+	ret = acpi_lpi_get_time(lpi, &val);
+
+	if (ret == -EINVAL)
+		return scnprintf(buf, PAGE_SIZE, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+}
+define_lpi_ro(time);
+
+static int acpi_lpi_get_usage(struct acpi_lpi_state *lpi, u64 *val)
+{
+	struct acpi_generic_address *reg;
+
+	if (!lpi)
+		return -EFAULT;
+
+	reg = &lpi->usage_cntr;
+
+	/* Supporting only system memory now (FFH not supported) */
+	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+		!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
+		!reg->address)
+		return -EINVAL;
+
+	if (ACPI_FAILURE(acpi_read(val, reg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static ssize_t show_usage(struct kobject *kobj, struct attribute *attr,
+			char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+	u64 val = 0;
+	int ret;
+
+	ret = acpi_lpi_get_usage(lpi, &val);
+
+	if (ret == -EINVAL)
+		return scnprintf(buf, PAGE_SIZE, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+}
+define_lpi_ro(usage);
+
+static ssize_t show_flags(struct kobject *kobj, struct attribute *attr,
+			char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+	bool enabled =  lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			enabled ? "Enabled" : "Disabled");
+}
+define_lpi_ro(flags);
+
+static ssize_t show_arch_flags(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", lpi->arch_flags);
+}
+define_lpi_ro(arch_flags);
+
+static ssize_t show_min_residency(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->min_residency);
+}
+define_lpi_ro(min_residency);
+
+static ssize_t show_latency(struct kobject *kobj, struct attribute *attr,
+			char *buf)
+{
+	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->wake_latency);
+}
+define_lpi_ro(latency);
+
+static struct attribute *acpi_lpi_state_attrs[] = {
+	&desc.attr,
+	&flags.attr,
+	&arch_flags.attr,
+	&min_residency.attr,
+	&latency.attr,
+	&time.attr,
+	&usage.attr,
+	NULL
+};
+
+static struct kobj_type lpi_state_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_attrs = acpi_lpi_state_attrs,
+};
+
+static ssize_t show_summary_stats(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct acpi_lpi_sysfs_data *sysfs_data =
+		container_of(kobj, struct acpi_lpi_sysfs_data, kobj);
+	struct acpi_lpi_state *state;
+	u64 time, usage;
+	int i, ret_time, ret_usage, valid_states_found = 0;
+	ssize_t len;
+
+	len = scnprintf(buf, PAGE_SIZE, "%5s %20s %20s\n", "state",
+			"usage", "time(us)");
+
+	for (i = 0; i < sysfs_data->state_count; i++) {
+		state = sysfs_data->sysfs_states[i].lpi_state;
+
+		ret_time = acpi_lpi_get_time(state, &time);
+		ret_usage = acpi_lpi_get_usage(state, &usage);
+		if (ret_time || ret_usage)
+			continue;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				"%5d %20llu %20llu\n", i, usage, time);
+
+		valid_states_found = 1;
+	}
+
+	if (valid_states_found)
+		return len;
+
+	return scnprintf(buf, PAGE_SIZE, "<unsupported>\n");
+}
+define_lpi_ro(summary_stats);
+
+static void acpi_lpi_sysfs_release(struct kobject *kobj)
+{
+	struct acpi_lpi_sysfs_data *sysfs_data =
+		container_of(kobj, struct acpi_lpi_sysfs_data, kobj);
+
+	kfree(sysfs_data->sysfs_states->lpi_state);
+	kfree(sysfs_data->sysfs_states);
+	kfree(sysfs_data);
+}
+
+static struct attribute *acpi_lpi_device_attrs[] = {
+	&summary_stats.attr,
+	NULL
+};
+
+static struct kobj_type lpi_device_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_attrs = acpi_lpi_device_attrs,
+	.release = acpi_lpi_sysfs_release,
+};
+
+int acpi_lpi_sysfs_init(acpi_handle h,
+			struct acpi_lpi_sysfs_data **lpi_sysfs_data)
+{
+	struct acpi_device *d;
+	struct acpi_lpi_states_array info;
+	struct acpi_lpi_sysfs_state *sysfs_state = NULL;
+	struct acpi_lpi_sysfs_data *data = NULL;
+	int ret, i;
+
+	if (!lpi_sysfs_data)
+		return -EINVAL;
+
+	ret = acpi_bus_get_device(h, &d);
+	if (ret)
+		return ret;
+
+	ret = acpi_processor_evaluate_lpi(h, &info);
+	if (ret)
+		return ret;
+
+	data = kzalloc(sizeof(struct acpi_lpi_sysfs_data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto kfree_and_return;
+	}
+
+	sysfs_state = kcalloc(info.size, sizeof(struct acpi_lpi_sysfs_state),
+			GFP_KERNEL);
+	if (!sysfs_state) {
+		ret = -ENOMEM;
+		goto kfree_and_return;
+	}
+
+	ret = kobject_init_and_add(&data->kobj, &lpi_device_ktype, &d->dev.kobj,
+				"lpi");
+	if (ret)
+		goto kfree_and_return;
+
+	*lpi_sysfs_data = data;
+	data->state_count = info.size;
+	data->sysfs_states = sysfs_state;
+
+	for (i = 0; i < info.size; i++, sysfs_state++) {
+		sysfs_state->lpi_state = info.entries + i;
+		ret = kobject_init_and_add(&sysfs_state->kobj, &lpi_state_ktype,
+					&data->kobj, "state%d", i);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		while (i > 0) {
+			i--;
+			sysfs_state = data->sysfs_states + i;
+			kobject_put(&sysfs_state->kobj);
+		}
+
+		kobject_put(&data->kobj);
+	}
+	return ret;
+
+kfree_and_return:
+	kfree(data);
+	kfree(sysfs_state);
+	kfree(info.entries);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_lpi_sysfs_init);
+
+int acpi_lpi_sysfs_exit(struct acpi_lpi_sysfs_data *sysfs_data)
+{
+	int i;
+
+	if (!sysfs_data)
+		return -EFAULT;
+
+	for (i = 0; i < sysfs_data->state_count; i++)
+		kobject_put(&sysfs_data->sysfs_states[i].kobj);
+
+	kobject_put(&sysfs_data->kobj);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_lpi_sysfs_exit);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index c1ba00f..4baa14c 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -79,6 +79,19 @@ struct acpi_lpi_state {
 	u8 index;
 	u8 entry_method;
 	char desc[ACPI_CX_DESC_LEN];
+	struct acpi_generic_address res_cntr;
+	struct acpi_generic_address usage_cntr;
+};
+
+struct acpi_lpi_sysfs_state {
+	struct acpi_lpi_state *lpi_state;
+	struct kobject kobj;
+};
+
+struct acpi_lpi_sysfs_data {
+	u8 state_count;
+	struct kobject kobj;
+	struct acpi_lpi_sysfs_state *sysfs_states;
 };
 
 struct acpi_processor_power {
@@ -88,6 +101,7 @@ struct acpi_processor_power {
 		struct acpi_lpi_state lpi_states[ACPI_PROCESSOR_MAX_POWER];
 	};
 	int timer_broadcast_on_state;
+	struct acpi_lpi_sysfs_data *lpi_sysfs_data;
 };
 
 /* Performance Management */
@@ -393,6 +407,8 @@ static inline void acpi_processor_throttling_init(void) {}
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
+int acpi_lpi_sysfs_init(acpi_handle h, struct acpi_lpi_sysfs_data **sysfs_data);
+int acpi_lpi_sysfs_exit(struct acpi_lpi_sysfs_data *sysfs_data);
 #else
 static inline int acpi_processor_power_init(struct acpi_processor *pr)
 {
@@ -413,6 +429,17 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
+
+
+int acpi_lpi_sysfs_init(acpi_handle h, struct acpi_lpi_sysfs_data **sysfs_data)
+{
+	return -ENODEV;
+}
+
+int acpi_lpi_sysfs_exit(struct acpi_lpi_sysfs_data *sysfs_data)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

