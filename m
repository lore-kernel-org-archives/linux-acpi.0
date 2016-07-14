From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH 5/5] ACPI/CPPC: add sysfs support to compute delivered
 performance
Date: Thu, 14 Jul 2016 14:25:35 +0100
Message-ID: <20160714132535.GA5796@arm.com>
References: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
 <1467309758-26536-6-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42883 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbcGNNZp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jul 2016 09:25:45 -0400
Content-Disposition: inline
In-Reply-To: <1467309758-26536-6-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, hotran@apm.com, cov@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Prashanth and Ashwin,

On Thu, Jun 30, 2016 at 12:02:38PM -0600, Prashanth Prakash wrote:
> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> 
> The CPPC tables contain entries for per CPU feedback counters which
> allows us to compute the delivered performance over a given interval
> of time.
> 
> The math for delivered performance per the CPPCv5.0+ spec is:
>   reference perf * delta(delivered perf ctr)/delta(ref perf ctr)
> 
> Maintaining deltas of the counters in the kernel is messy, as it
> depends on when the reads are triggered. (e.g. via the cpufreq
> ->get() interface). Also the ->get() interace only returns one
> value, so cant return raw values. So instead, leave it to userspace
> to keep track of raw values and do its math for CPUs it cares about.
> 
> delivered and reference perf counters are exposed via the same
> sysfs file to avoid the potential "skid", if these values are read
> individually from userspace.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/acpi/cppc_acpi.c | 94 +++++++++++++++++++++++++++++++++++++++++++-----
>  include/acpi/cppc_acpi.h |  3 +-
>  2 files changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7844e4c..8bd501f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -95,6 +95,17 @@ static unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
>  				(cpc)->cpc_entry.reg.space_id ==	\
>  				ACPI_ADR_SPACE_PLATFORM_COMM)
>  
> +/* Evalutes to True if reg is a NULL register descriptor */
> +#define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
> +				(reg)->address == 0 &&			\
> +				(reg)->bit_width == 0 &&		\
> +				(reg)->bit_offset == 0 &&		\
> +				(reg)->access_width == 0)
> +
> +/* Evalutes to True if an optional cpc field is supported */
> +#define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
> +				!!(cpc)->cpc_entry.int_value :			\
> +				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
>  /*
>   * Arbitrary Retries in case the remote processor is slow to respond
>   * to PCC commands. Keeping it high enough to cover emulators where
> @@ -102,6 +113,61 @@ static unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
>   */
>  #define NUM_RETRIES 500
>  
> +struct cppc_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct kobject *kobj,
> +			struct attribute *attr, char *buf);
> +	ssize_t (*store)(struct kobject *kobj,
> +			struct attribute *attr, const char *c, ssize_t count);
> +};
> +
> +#define define_one_cppc_ro(_name)		\
> +static struct cppc_attr _name =			\
> +__ATTR(_name, 0444, show_##_name, NULL)
> +
> +#define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
> +
> +static ssize_t show_feedback_ctrs(struct kobject *kobj,
> +		struct attribute *attr, char *buf)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +
> +	cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
> +
> +	return scnprintf(buf, PAGE_SIZE, "ref:%lld del:%lld\n",
> +			fb_ctrs.reference, fb_ctrs.delivered);
> +}
> +define_one_cppc_ro(feedback_ctrs);
> +
> +static ssize_t show_reference_perf(struct kobject *kobj,
> +		struct attribute *attr, char *buf)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	struct cppc_perf_caps perf_caps;
> +
> +	cppc_get_perf_caps(cpc_ptr->cpu_id, &perf_caps);
> +
> +	if (perf_caps.reference_perf)
> +		return scnprintf(buf, PAGE_SIZE, "%u\n",
> +				perf_caps.reference_perf);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			perf_caps.nominal_perf);
> +}

What do you think about exporting Counter Wraparound Time register
as well if it's present?

Best regards,
Alexey Klimov


> +define_one_cppc_ro(reference_perf);
> +
> +static struct attribute *cppc_attrs[] = {
> +	&feedback_ctrs.attr,
> +	&reference_perf.attr,
> +	NULL
> +};
> +
> +static struct kobj_type cppc_ktype = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_attrs = cppc_attrs,
> +};
> +
>  static int check_pcc_chan(void)
>  {
>  	int ret = -EIO;
> @@ -544,6 +610,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	union acpi_object *out_obj, *cpc_obj;
>  	struct cpc_desc *cpc_ptr;
>  	struct cpc_reg *gas_t;
> +	struct device *cpu_dev;
>  	acpi_handle handle = pr->handle;
>  	unsigned int num_ent, i, cpc_rev;
>  	acpi_status status;
> @@ -666,6 +733,16 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	/* Everything looks okay */
>  	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
>  
> +	/* Add per logical CPU nodes for reading its feedback counters. */
> +	cpu_dev = get_cpu_device(pr->id);
> +	if (!cpu_dev)
> +		goto out_free;
> +
> +	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
> +			"acpi_cppc");
> +	if (ret)
> +		goto out_free;
> +
>  	kfree(output.pointer);
>  	return 0;
>  
> @@ -695,6 +772,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  	struct cpc_desc *cpc_ptr;
>  	unsigned int i;
>  	void __iomem *addr;
> +
>  	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
>  
>  	/* Free all the mapped sys mem areas for this CPU */
> @@ -704,6 +782,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  			iounmap(addr);
>  	}
>  
> +	kobject_put(&cpc_ptr->kobj);
>  	kfree(cpc_ptr);
>  }
>  EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
> @@ -721,7 +800,7 @@ static int cpc_read(struct cpc_register_resource *reg_res, u64 *val)
>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>  
>  	if (reg_res->type == ACPI_TYPE_INTEGER) {
> -		*val = reg_res->int_value;
> +		*val = reg_res->cpc_entry.int_value;
>  		return ret_val;
>  	}
>  
> @@ -836,8 +915,11 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	cpc_read(lowest_reg, &low);
>  	perf_caps->lowest_perf = low;
>  
> -	cpc_read(ref_perf, &ref);
> -	perf_caps->reference_perf = ref;
> +	perf_caps->reference_perf = 0;
> +	if (CPC_SUPPORTED(ref_perf)) {
> +		cpc_read(ref_perf, &ref);
> +		perf_caps->reference_perf = ref;
> +	}
>  
>  	cpc_read(nom_perf, &nom);
>  	perf_caps->nominal_perf = nom;
> @@ -899,12 +981,6 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  	perf_fb_ctrs->delivered = delivered;
>  	perf_fb_ctrs->reference = reference;
>  
> -	perf_fb_ctrs->delivered -= perf_fb_ctrs->prev_delivered;
> -	perf_fb_ctrs->reference -= perf_fb_ctrs->prev_reference;
> -
> -	perf_fb_ctrs->prev_delivered = delivered;
> -	perf_fb_ctrs->prev_reference = reference;
> -
>  out_err:
>  	if (regs_in_pcc)
>  		up_write(&pcc_lock);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 7b7e2e1..2bf9db1 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -63,6 +63,7 @@ struct cpc_desc {
>  	int cpu_id;
>  	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>  	struct acpi_psd_package domain_info;
> +	struct kobject kobj;
>  };
>  
>  /* These are indexes into the per-cpu cpc_regs[]. Order is important. */
> @@ -109,9 +110,7 @@ struct cppc_perf_ctrls {
>  
>  struct cppc_perf_fb_ctrs {
>  	u64 reference;
> -	u64 prev_reference;
>  	u64 delivered;
> -	u64 prev_delivered;
>  };
>  
>  /* Per CPU container for runtime CPPC management. */
> -- 
> Qualcomm Technologies, Inc. on behalf
> of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
> is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
