From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch_4/4] :Add MSR support for T-States
Date: Wed, 14 Nov 2007 22:22:15 -0500
Message-ID: <200711142222.15583.lenb@kernel.org>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com> <200710092343.40843.lenb@kernel.org> <1194483443.9610.7.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49053 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbXKODW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 22:22:29 -0500
In-Reply-To: <1194483443.9610.7.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 07 November 2007 19:57, Zhao Yakui wrote:
> Subject: ACPI : Add MSR support for T-States
> >From : Zhao Yakui <yakui.zhao@intel.com>
>  
> Add throttling control via MSR when T-states uses the FixHW Control/
> Status registers.
> 
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> 
> ---
>  arch/x86/kernel/acpi/processor.c    |    3 +
>  drivers/acpi/processor_throttling.c |   72 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
> ===================================================================
> --- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
> +++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
> @@ -391,6 +391,71 @@ static int acpi_processor_get_throttling
>  
>  	return 0;
>  }
> +#ifdef CONFIG_X86
> +static int acpi_throttling_rdmsr(struct acpi_processor *pr,
> +                                        acpi_integer * value)
> +{
> +        struct cpuinfo_x86 *c;
> +        u64 msr_high, msr_low;
> +        unsigned int cpu;
> +        u64 msr = 0;
> +        int ret = -1;
> +
> +	cpu = pr->id;
> +	c = &cpu_data(cpu);
> +
> +	if ((c->x86_vendor != X86_VENDOR_INTEL) ||
> +		!cpu_has(c, X86_FEATURE_ACPI)) {
> +		printk(KERN_ERR PREFIX
> +			"HARDWARE addr space,NOT supported yet\n");
> +	} else {
> +		msr_low = 0;
> +		msr_high = 0;
> +		rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL,
> +			(u32 *)&msr_low , (u32 *) &msr_high);
> +		msr = (msr_high << 32) | msr_low;
> +		*value = (acpi_integer) msr;
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
> +{
> +	struct cpuinfo_x86 *c;
> +	unsigned int cpu;
> +	int ret = -1;
> +	u64 msr;
> +
> +	cpu = pr->id;
> +	c = &cpu_data(cpu);
> +
> +	if ((c->x86_vendor != X86_VENDOR_INTEL) ||
> +		!cpu_has(c, X86_FEATURE_ACPI)) {
> +		printk(KERN_ERR PREFIX
> +			"HARDWARE addr space,NOT supported yet\n");
> +	} else {
> +		msr = value;
> +		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL,
> +			msr & 0xffffffff, msr >> 32);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +#else
> +static int acpi_throttling_rdmsr(struct acpi_processor *pr,
> +				acpi_integer * value)
> +{
> +	printk(KERN_ERR PREFIX
> +		"HARDWARE addr space,NOT supported yet\n");
> +	return -1;
> +}
> +static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
> +{
> +	printk(KERN_ERR PREFIX
> +		"HARDWARE addr space,NOT supported yet\n");
> +	return -1;
> +}
> +#endif
>  
>  static int acpi_read_throttling_status(struct acpi_processor *pr,
>  						acpi_integer *value)
> @@ -415,8 +480,7 @@ static int acpi_read_throttling_status(s
>  		ret = 0;
>  		break;
>  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> -		printk(KERN_ERR PREFIX
> -		       "HARDWARE addr space,NOT supported yet\n");
> +		ret = acpi_throttling_rdmsr(pr, value);
>  		break;
>  	default:
>  		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
> @@ -449,8 +513,7 @@ static int acpi_write_throttling_state(s
>  		ret = 0;
>  		break;
>  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> -		printk(KERN_ERR PREFIX
> -		       "HARDWARE addr space,NOT supported yet\n");
> +		ret = acpi_throttling_wrmsr(pr, value);
>  		break;
>  	default:
>  		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
> @@ -504,6 +567,7 @@ static int acpi_processor_get_throttling
>  
>  	pr->throttling.state = 0;
>  	local_irq_disable();
> +	value = 0;

but this patch doesn't _use_ value -- should it have been initialized
in a previous patch?

>  	ret = acpi_read_throttling_status(pr, &value);
>  	if (ret >= 0) {
>  		state = acpi_get_throttling_state(pr, value);
> Index: linux-2.6.24-rc1/arch/x86/kernel/acpi/processor.c
> ===================================================================
> --- linux-2.6.24-rc1.orig/arch/x86/kernel/acpi/processor.c
> +++ linux-2.6.24-rc1/arch/x86/kernel/acpi/processor.c
> @@ -49,6 +49,9 @@ static void init_intel_pdc(struct acpi_p
>  	if (cpu_has(c, X86_FEATURE_EST))
>  		buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
>  
> +	if (cpu_has(c, X86_FEATURE_ACPI))
> +		buf[2] |= ACPI_PDC_T_FFH;
> +
>  	obj->type = ACPI_TYPE_BUFFER;
>  	obj->buffer.length = 12;
>  	obj->buffer.pointer = (u8 *) buf;
> 
