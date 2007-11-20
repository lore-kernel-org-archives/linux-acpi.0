From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH]:Obtain FSB ratio from model string
Date: Tue, 20 Nov 2007 14:34:56 -0500
Message-ID: <200711201434.56358.lenb@kernel.org>
References: <1193377428.5254.19.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51954 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbXKTTfL (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 14:35:11 -0500
In-Reply-To: <1193377428.5254.19.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Linux-acpi@vger.kernel.org, cpufreq <cpufreq@www.linux.org.uk>

On Friday 26 October 2007 01:43, Zhao Yakui wrote:
> Hi, all
>         According to the document of 253369(intel), the ratio is
> undefined in MSR_FBC_REGSITER_ID. The following calculation is
> inappropriate.
> if (c->x86_model < 2)
>         mult = msr_lo >> 27;
> 
> There are two ways to fix this problem.
> a. use the following patch. the ratio is obtained from model string.
> b. revert the commit until the proper patch is available.
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=3e4159ab35c88aef5e063ba78796b277b762a30a

Okay, I've reverted that patch -- so model 0&1 are back to where they were in 2005
and random MHz is replaced by other random MHz.

> 
> Subject: ACPI :Obtain FSB ratio from model string when model is less than 2
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> The ratio is undefined in the register of MSR_FBC_REGSITER_ID 
> when the model for P4 is less than 2. The following calculation is 
> inappropriate.
> if (c->x86_model < 2)
> 	mult = msr_lo >> 27;
> In order to support the speedstep , the FSb ratio can be obtained from 
> the model_id string. 
> For example:
> The ratio is 13 for model string:"Intel(R) Pentium(R) 4 CPU 1300MHz"
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7186
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  arch/i386/kernel/cpu/cpufreq/speedstep-lib.c |   40 +++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.23-rc9/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
> ===================================================================
> --- linux-2.6.23-rc9.orig/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
> +++ linux-2.6.23-rc9/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
> @@ -17,6 +17,7 @@
>  
>  #include <asm/msr.h>
>  #include "speedstep-lib.h"
> +#include <linux/ctype.h>
>  
>  #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, "speedstep-lib", msg)
>  
> @@ -151,7 +152,40 @@ static unsigned int pentium_core_get_fre
>  
>  	return (msr_tmp * fsb);
>  }
> -
> +/* When Model_id is less than 2, the FSB ratio is
> +obtained from the string of model_id */
> +static unsigned int p4_01_get_fsb_ratio(void)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	unsigned int fsb_m;
> +	char model_id[64];
> +	unsigned int  freq_mhz;
> +	unsigned int max_ratio;
> +	char *ptr;
> +	int i = 0;
> +
> +	ptr = model_id;
> +	strncpy(ptr, c->x86_model_id, strlen(c->x86_model_id));
> +	for (i = 0; i < strlen(model_id); i++)
> +		model_id[i] = tolower(model_id[i]);
> +	if (strstr(model_id, "mhz"))
> +		fsb_m = 100;
> +	else
> +		fsb_m = 0;
> +	if (!fsb_m) {
> +		printk(KERN_DEBUG "CPU doesn't support speedstep\n");
> +		return 0;
> +	}
> +	ptr = strstr(model_id, "hz");
> +	if (ptr)
> +		*ptr = '\0';
> +	freq_mhz = 0;
> +	ptr = strrchr(model_id, ' ');
> +	if (ptr)
> +		sscanf(ptr, "%d", &freq_mhz);
> +	max_ratio = freq_mhz / fsb_m;
> +	return max_ratio;
> +}
>  
>  static unsigned int pentium4_get_frequency(void)
>  {
> @@ -189,8 +223,10 @@ static unsigned int pentium4_get_frequen
>  		printk(KERN_DEBUG "speedstep-lib: couldn't detect FSB speed. Please send an e-mail to <linux@brodo.de>\n");
>  
>  	/* Multiplier. */
> +	/* if Model is less than 2 , the ratio is obtained from the
> +	 * string of model_id */
>  	if (c->x86_model < 2)
> -		mult = msr_lo >> 27;
> +		mult = p4_01_get_fsb_ratio();
>  	else
>  		mult = msr_lo >> 24;
>  

I'm not excited about adding code to parse the model string,
particularly when the justification is an early P4 model that
doesn't even support P-states.

I'd prefer to see p4-clockmod deleted from the kernel.

-Len

