From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 16:26:33 +0100
Message-ID: <20130118152633.GA4062@pd.tnic>
References: <20130116131725.4e590c34@bluemoon>
 <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
 <1448223.sdUJnNSRz4@vostro.rjw.lan>
 <20130116231728.GA10204@x1.alien8.de>
 <20130116181600.4c48ee3b@bluemoon>
 <20130117094648.GD30700@pd.tnic>
 <20130117194044.7a18a29d@bluemoon>
 <20130118113717.GA6808@pd.tnic>
 <20130118133233.4521ddb6@hydra>
 <E99CBA9F97C3D149AA6B19ED2E277C9B0193997E@BY2PRD0510MB365.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E99CBA9F97C3D149AA6B19ED2E277C9B0193997E@BY2PRD0510MB365.namprd05.prod.outlook.com>
Sender: cpufreq-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 18, 2013 at 03:17:04PM +0000, Matthew Garrett wrote:
> Can you try this (entirely untested) patch?
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c
> b/drivers/cpufreq/acpi-cpufreq.c
> index 0d048f6..7b0d49d 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1030,4 +1030,11 @@ MODULE_PARM_DESC(acpi_pstate_strict,
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
>  
> +static const struct x86_cpu_id acpi_cpufreq_ids[] = {
> +	X86_FEATURE_MATCH(X86_FEATURE_ACPI),
> +	X86_FEATURE_MATCH(X86_FEATURE_HW_PSTATE),
> +	{}

Yep, that should be one way to fix it.

One other fix IMHO would be if udev is looking at CPUID bits, to teach
it to check the proper P-States feature bits on Intel and AMD:

On Intel: CPUID_0x00000001[ECX] bit 7
On AMD  : CPUID_0x80000007[EDX] bit 7

AFAICT.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
