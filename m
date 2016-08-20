From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 05/11] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Sat, 20 Aug 2016 02:46:06 +0200
Message-ID: <18399184.AAFNDR2hqb@vostro.rjw.lan>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1471559812-19967-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55723 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754617AbcHTAlX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Aug 2016 20:41:23 -0400
In-Reply-To: <1471559812-19967-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com

On Thursday, August 18, 2016 03:36:46 PM Srinivas Pandruvada wrote:
> Some newer x86 platforms have support for both _CPC and _PSS object. So
> kernel config can have both ACPI_CPU_FREQ_PSS and ACPI_CPPC_LIB. So remove
> restriction for ACPI_CPPC_LIB to build only when ACPI_CPU_FREQ_PSS is not
> defined.
> Also for legacy systems with only _PSS, we shouldn't bail out if
> acpi_cppc_processor_probe() fails, if ACPI_CPU_FREQ_PSS is also defined.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/Kconfig            | 1 -
>  drivers/acpi/processor_driver.c | 5 ++++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 445ce28..c6bb6aa 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -227,7 +227,6 @@ config ACPI_MCFG
>  config ACPI_CPPC_LIB
>  	bool
>  	depends on ACPI_PROCESSOR
> -	depends on !ACPI_CPU_FREQ_PSS
>  	select MAILBOX
>  	select PCC
>  	help
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 0553aee..0e0b629 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -245,8 +245,11 @@ static int __acpi_processor_start(struct acpi_device *device)
>  		return 0;
>  
>  	result = acpi_cppc_processor_probe(pr);
> -	if (result)
> +	if (result) {
> +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
>  		return -ENODEV;
> +#endif
> +	}

	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
		return -ENODEV;

would look better.

>  
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>  		acpi_processor_power_init(pr);
> 

Thanks,
Rafael

