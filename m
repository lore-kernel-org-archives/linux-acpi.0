From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Mon, 6 Nov 2017 14:49:29 -0700
Message-ID: <13ca1da1-f312-f2f0-020f-95acd8e1e5a7@codeaurora.org>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdKFVtd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2017 16:49:33 -0500
In-Reply-To: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, lenb@kernel.org, sudeep.holla@arm.com

Hi Rafael,

Any inputs on this patch?

Thanks!

On 10/19/2017 12:19 PM, Prashanth Prakash wrote:
> Add support to expose idle statistics maintained by platform to
> userspace via sysfs in addition to other data of interest from
> each LPI(Low Power Idle) state.
>
> LPI described in section 8.4.4 of ACPI spec 6.1 provides different
> methods to obtain idle statistics maintained by the platform. These
> show a granular view of how each of the LPI state is being used at
> different level of hierarchy. sysfs data is exposed at each level in
> the hierarchy by creating a directory named 'lpi' at each level and
> the LPI state information is presented under it. Below is the
> representation of LPI information at one such level in the hierarchy
>
> .../ACPI00XX: XX/lpi
> 	|-> state0
> 	|	|-> state_name
> 	|	|-> residency
> 	|	|-> usage
> 	|	|-> wakeup_latency
> 	|	|-> min_residency
> 	|	|-> state_index
> 	|	|-> enabled_parent_state
> 	|
> 	<<more states>>
>
> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
>
> stateX contains information related to a specific LPI state defined
> in the LPI ACPI tables.
>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
> v3
> * Changed sysfs names to follow spec names (Rafael)
> * Added enabled_parent_state(Rafael) and state_index to sysfs entries
>   state_index was added to make sense of enabled_parent_state
>
> Couldn't find a clean way to expose the hierarchical LPI information under
> cpuidle
>
> v2
> * Add Documentation/ABI/testing/sysfs-acpi-lpi
>
> v1
> * Drop flags, arch_flags and summary_stats field (Sudeep)
> * Create sysfs entries after we know that LPI will be used (Sudeep & Rafael)
>
>  Documentation/ABI/testing/sysfs-acpi-lpi |  57 +++++
>  drivers/acpi/processor_idle.c            | 363 ++++++++++++++++++++++++++++++-
>  include/acpi/processor.h                 |  14 ++
>  3 files changed, 432 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-acpi-lpi
>
> diff --git a/Documentation/ABI/testing/sysfs-acpi-lpi b/Documentation/ABI/testing/sysfs-acpi-lpi
> new file mode 100644
> index 0000000..5f1c90a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-acpi-lpi
> @@ -0,0 +1,57 @@
> +What:		LPI sysfs interface for processor devices and containers
> +Date:		19-October-2017
> +KernelVersion:	v4.15
> +Contact:	linux-acpi@vger.kernel.org
> +Description:	LPI(Low Power Idle) described in section 8.4.4 of ACPI spec 6.1
> +		provides different methods to obtain idle statistics maintained
> +		by the platform. These show a granular view of how each of the
> +		LPI state is being used at different level of processor hierarchy.
> +		sysfs data is exposed at each level in the hierarchy by creating
> +		a directory named 'lpi' at each level and the LPI state
> +		information is presented under it. Below is the representation
> +		of LPI information at one such level in the hierarchy.
> +
> +		.../ACPI00XX: YY/lpi
> +			|-> state0
> +			|	|-> state_name
> +			|	|-> wakeup_latency
> +			|	|-> min_residency
> +			|	|-> state_index
> +			|	|-> enabled_parent_state
> +			|	|-> residency
> +			|	|-> usage
> +			|
> +			|-> state1
> +			|	|-> state_name
> +			|	|-> wakeup_latency
> +			|	|-> min_residency
> +			|	|-> state_index
> +			|	|-> enabled_parent_state
> +			|	|-> residency
> +			|	|-> usage
> +			|
> +			<<more states>>
> +
> +		ACPI00XX can be ACPI0007(processor device) or ACPI0010(processor
> +		container) and the sysfs nodes for these ACPI devices can be
> +		found under /sys/devices/LNXSYSTM:00
> +
> +		stateX contains information related to a specific local LPI
> +		state defined in the LPI ACPI tables under a owning hierarchy
> +		node(ACPI0007 or ACPI0010).
> +
> +		state_name - Name of the local LPI state
> +		wakeup_latency - Worst case wake up latency(in micro seconds)
> +                                 for the owning hierarchy node to exit from this
> +                                 local LPI state
> +		min_residency - Time in microseconds after which a state becomes
> +				more energy effecient than a shallower state
> +		residency - Total time spent(in micro seconds) by the owning
> +			    hierarchy node in this local idle state
> +		usage - Number of times the owning hierarchy node entered
> +			this local power state
> +		state_index - Index 0 represents active state. The index(es) is
> +			      assigned starting from 1 as the states are
> +			      discovered  in ACPI tables.
> +		enabled_parent_state - Index of deepest local power state enabled
> +				       by this LPI state in parent processor node
> \ No newline at end of file
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 2736e25..ac6301a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -947,6 +947,10 @@ struct acpi_lpi_states_array {
>  	struct acpi_lpi_state *composite_states[ACPI_PROCESSOR_MAX_POWER];
>  };
>  
> +static int acpi_lpi_sysfs_init(acpi_handle h,
> +			struct acpi_lpi_states_array *info);
> +static int acpi_lpi_sysfs_exit(struct acpi_processor *pr);
> +
>  static int obj_get_integer(union acpi_object *obj, u32 *value)
>  {
>  	if (obj->type != ACPI_TYPE_INTEGER)
> @@ -956,6 +960,24 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
>  	return 0;
>  }
>  
> +static int obj_get_generic_addr(union acpi_object *obj,
> +				struct acpi_generic_address *addr)
> +{
> +	struct acpi_power_register *reg;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER)
> +		return -EINVAL;
> +
> +	reg = (struct acpi_power_register *)obj->buffer.pointer;
> +	addr->space_id = reg->space_id;
> +	addr->bit_width = reg->bit_width;
> +	addr->bit_offset = reg->bit_offset;
> +	addr->access_width = reg->access_size;
> +	addr->address = reg->address;
> +
> +	return 0;
> +}
> +
>  static int acpi_processor_evaluate_lpi(acpi_handle handle,
>  				       struct acpi_lpi_states_array *info)
>  {
> @@ -1030,8 +1052,6 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>  			continue;
>  		}
>  
> -		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
> -
>  		obj = pkg_elem + 9;
>  		if (obj->type == ACPI_TYPE_STRING)
>  			strlcpy(lpi_state->desc, obj->string.pointer,
> @@ -1059,9 +1079,16 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>  
>  		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
>  			lpi_state->enable_parent_state = 0;
> +
> +		obj_get_generic_addr(pkg_elem + 7, &lpi_state->res_cntr);
> +
> +		obj_get_generic_addr(pkg_elem + 8, &lpi_state->usage_cntr);
>  	}
>  
>  	acpi_handle_debug(handle, "Found %d power states\n", state_idx);
> +
> +	/* Set up LPI sysfs */
> +	acpi_lpi_sysfs_init(handle, info);
>  end:
>  	kfree(buffer.pointer);
>  	return ret;
> @@ -1173,6 +1200,10 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>  	if (!acpi_has_method(handle, "_LPI"))
>  		return -EINVAL;
>  
> +	/* If we have already initialized just return */
> +	if (pr->flags.has_lpi == 1)
> +		return 0;
> +
>  	flat_state_cnt = 0;
>  	prev = &info[0];
>  	curr = &info[1];
> @@ -1484,8 +1515,336 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
>  		acpi_processor_registered--;
>  		if (acpi_processor_registered == 0)
>  			cpuidle_unregister_driver(&acpi_idle_driver);
> +
> +		acpi_lpi_sysfs_exit(pr);
>  	}
>  
>  	pr->flags.power_setup_done = 0;
>  	return 0;
>  }
> +
> +
> +/*
> + * LPI sysfs support
> + */
> +
> +struct acpi_lpi_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
> +			char *buf);
> +	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
> +			const char *c, ssize_t count);
> +};
> +
> +#define define_lpi_ro(_name) static struct acpi_lpi_attr _name =	\
> +		__ATTR(_name, 0444, show_##_name, NULL)
> +
> +#define to_acpi_lpi_sysfs_state(k)				\
> +	container_of(k, struct acpi_lpi_sysfs_state, kobj)
> +
> +#define to_acpi_lpi_state(k)				\
> +	(&(to_acpi_lpi_sysfs_state(k)->lpi_state))
> +
> +static ssize_t show_state_name(struct kobject *kobj, struct attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", lpi->desc);
> +}
> +define_lpi_ro(state_name);
> +
> +static int acpi_lpi_get_residency(struct acpi_lpi_state *lpi, u64 *val)
> +{
> +	struct acpi_generic_address *reg;
> +
> +	if (!lpi)
> +		return -EFAULT;
> +
> +	reg = &lpi->res_cntr;
> +
> +	/* Supporting only system memory */
> +	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
> +		!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
> +		!reg->address || !lpi->res_cnt_freq)
> +		return -EINVAL;
> +
> +	if (ACPI_FAILURE(acpi_read(val, reg)))
> +		return -EFAULT;
> +
> +	*val = div_u64((*val * 1000000), lpi->res_cnt_freq);
> +	return 0;
> +
> +}
> +
> +/* shows residency in us */
> +static ssize_t show_residency(struct kobject *kobj, struct attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +	u64 val = 0;
> +	int ret;
> +
> +	ret = acpi_lpi_get_residency(lpi, &val);
> +
> +	if (ret == -EINVAL)
> +		return scnprintf(buf, PAGE_SIZE, "<unsupported>\n");
> +
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
> +}
> +define_lpi_ro(residency);
> +
> +static int acpi_lpi_get_usage(struct acpi_lpi_state *lpi, u64 *val)
> +{
> +	struct acpi_generic_address *reg;
> +
> +	if (!lpi)
> +		return -EFAULT;
> +
> +	reg = &lpi->usage_cntr;
> +
> +	/* Supporting only system memory now (FFH not supported) */
> +	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
> +		!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
> +		!reg->address)
> +		return -EINVAL;
> +
> +	if (ACPI_FAILURE(acpi_read(val, reg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static ssize_t show_usage(struct kobject *kobj, struct attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +	u64 val = 0;
> +	int ret;
> +
> +	ret = acpi_lpi_get_usage(lpi, &val);
> +
> +	if (ret == -EINVAL)
> +		return scnprintf(buf, PAGE_SIZE, "<unsupported>\n");
> +
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
> +}
> +define_lpi_ro(usage);
> +
> +static ssize_t show_min_residency(struct kobject *kobj, struct attribute *attr,
> +				char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->min_residency);
> +}
> +define_lpi_ro(min_residency);
> +
> +static ssize_t show_wakeup_latency(struct kobject *kobj, struct attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->wake_latency);
> +}
> +define_lpi_ro(wakeup_latency);
> +
> +static ssize_t show_state_index(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->index);
> +}
> +define_lpi_ro(state_index);
> +
> +static ssize_t show_enabled_parent_state(struct kobject *kobj,
> +					struct attribute *attr, char *buf)
> +{
> +	struct acpi_lpi_state *lpi = to_acpi_lpi_state(kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", lpi->enable_parent_state);
> +}
> +define_lpi_ro(enabled_parent_state);
> +
> +static struct attribute *acpi_lpi_state_attrs[] = {
> +	&state_name.attr,
> +	&min_residency.attr,
> +	&wakeup_latency.attr,
> +	&residency.attr,
> +	&usage.attr,
> +	&state_index.attr,
> +	&enabled_parent_state.attr,
> +	NULL
> +};
> +
> +static struct kobj_type lpi_state_ktype = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_attrs = acpi_lpi_state_attrs,
> +};
> +
> +static void acpi_lpi_sysfs_release(struct kobject *kobj)
> +{
> +	struct acpi_lpi_sysfs_data *sysfs_data =
> +		container_of(kobj, struct acpi_lpi_sysfs_data, kobj);
> +
> +	kfree(sysfs_data->sysfs_states);
> +	kfree(sysfs_data);
> +}
> +
> +static struct kobj_type lpi_device_ktype = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.release = acpi_lpi_sysfs_release,
> +};
> +
> +static int acpi_lpi_sysfs_get(struct acpi_lpi_sysfs_data *sysfs_data)
> +{
> +	int i;
> +
> +	if (!sysfs_data)
> +		return -EFAULT;
> +
> +	for (i = 0; i < sysfs_data->state_count; i++)
> +		kobject_get(&sysfs_data->sysfs_states[i].kobj);
> +
> +	kobject_get(&sysfs_data->kobj);
> +
> +	return 0;
> +}
> +
> +static int acpi_lpi_sysfs_put(struct acpi_lpi_sysfs_data *sysfs_data)
> +{
> +	int i;
> +
> +	if (!sysfs_data)
> +		return -EFAULT;
> +
> +	for (i = 0; i < sysfs_data->state_count; i++)
> +		kobject_put(&sysfs_data->sysfs_states[i].kobj);
> +
> +	kobject_put(&sysfs_data->kobj);
> +
> +	return 0;
> +}
> +
> +/*
> + * Given parsed LPI info creates sysfs entries to expose differnt LPI attributes
> + * stats for all the "enabled" states
> + */
> +static int acpi_lpi_sysfs_init(acpi_handle h,
> +			struct acpi_lpi_states_array *info)
> +{
> +	struct acpi_device *d;
> +	struct acpi_lpi_sysfs_state *sysfs_state = NULL;
> +	struct acpi_lpi_sysfs_data **lpi_sysfs_data;
> +	struct acpi_lpi_sysfs_data *data = NULL;
> +	int ret, i, j;
> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	ret = acpi_bus_get_device(h, &d);
> +	if (ret)
> +		return ret;
> +
> +	if (!strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> +		lpi_sysfs_data = (struct acpi_lpi_sysfs_data **)&d->driver_data;
> +	else {
> +		struct acpi_processor *pr = acpi_driver_data(d);
> +
> +		lpi_sysfs_data = &pr->power.lpi_sysfs_data;
> +	}
> +
> +	/* Already initialized, get a reference and return */
> +	if (*lpi_sysfs_data) {
> +		acpi_lpi_sysfs_get(*lpi_sysfs_data);
> +		return 0;
> +	}
> +
> +	data = kzalloc(sizeof(struct acpi_lpi_sysfs_data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto kfree_and_return;
> +	}
> +
> +	/* Count number of enabled states */
> +	for (i = 0; i < info->size; i++)
> +		if (info->entries[i].flags & ACPI_LPI_STATE_FLAGS_ENABLED)
> +			data->state_count++;
> +
> +	sysfs_state = kcalloc(data->state_count,
> +			sizeof(struct acpi_lpi_sysfs_state), GFP_KERNEL);
> +	if (!sysfs_state) {
> +		ret = -ENOMEM;
> +		goto kfree_and_return;
> +	}
> +
> +	ret = kobject_init_and_add(&data->kobj, &lpi_device_ktype, &d->dev.kobj,
> +				"lpi");
> +	if (ret)
> +		goto kfree_and_return;
> +
> +	*lpi_sysfs_data = data;
> +	data->sysfs_states = sysfs_state;
> +
> +	for (i = 0, j = 0; i < info->size; i++) {
> +		if (!(info->entries[i].flags & ACPI_LPI_STATE_FLAGS_ENABLED))
> +			continue;
> +		sysfs_state = data->sysfs_states + j;
> +		memcpy(&sysfs_state->lpi_state, info->entries + i,
> +			sizeof(struct acpi_lpi_state));
> +		ret = kobject_init_and_add(&sysfs_state->kobj, &lpi_state_ktype,
> +					&data->kobj, "state%d", j);
> +		if (ret)
> +			break;
> +		j++;
> +	}
> +
> +	if (ret) {
> +		while (j > 0) {
> +			j--;
> +			sysfs_state = data->sysfs_states + i;
> +			kobject_put(&sysfs_state->kobj);
> +		}
> +		kobject_put(&data->kobj);
> +	} else
> +		*lpi_sysfs_data = data;
> +
> +	return ret;
> +
> +kfree_and_return:
> +	kfree(data);
> +	kfree(sysfs_state);
> +	return ret;
> +}
> +
> +static int acpi_lpi_sysfs_exit(struct acpi_processor *pr)
> +{
> +	acpi_handle handle, p_handle;
> +	struct acpi_device *d = NULL;
> +	acpi_status status;
> +
> +	if (!pr)
> +		return -ENODEV;
> +
> +	handle = pr->handle;
> +	acpi_lpi_sysfs_put(pr->power.lpi_sysfs_data);
> +
> +	status = acpi_get_parent(handle, &p_handle);
> +	while (ACPI_SUCCESS(status)) {
> +		acpi_bus_get_device(p_handle, &d);
> +		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> +			break;
> +
> +		acpi_lpi_sysfs_put((struct acpi_lpi_sysfs_data *)d->driver_data);
> +		status = acpi_get_parent(handle, &p_handle);
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index c1ba00f..b99b84b 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -79,6 +79,19 @@ struct acpi_lpi_state {
>  	u8 index;
>  	u8 entry_method;
>  	char desc[ACPI_CX_DESC_LEN];
> +	struct acpi_generic_address res_cntr;
> +	struct acpi_generic_address usage_cntr;
> +};
> +
> +struct acpi_lpi_sysfs_state {
> +	struct acpi_lpi_state lpi_state;
> +	struct kobject kobj;
> +};
> +
> +struct acpi_lpi_sysfs_data {
> +	u8 state_count;
> +	struct kobject kobj;
> +	struct acpi_lpi_sysfs_state *sysfs_states;
>  };
>  
>  struct acpi_processor_power {
> @@ -88,6 +101,7 @@ struct acpi_processor_power {
>  		struct acpi_lpi_state lpi_states[ACPI_PROCESSOR_MAX_POWER];
>  	};
>  	int timer_broadcast_on_state;
> +	struct acpi_lpi_sysfs_data *lpi_sysfs_data;
>  };
>  
>  /* Performance Management */

