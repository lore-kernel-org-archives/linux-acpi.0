From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3 2/7] Xen / ACPI / processor: use
 invalid_logical_cpuid()
Date: Mon, 11 May 2015 09:57:47 -0400
Message-ID: <20150511135747.GE18474@l.oracle.com>
References: <1431317839-4584-1-git-send-email-hanjun.guo@linaro.org>
 <1431317839-4584-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431317839-4584-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 11, 2015 at 12:17:14PM +0800, Hanjun Guo wrote:
> Use invalid_logical_cpuid(pr->id) instead of direct comparison.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/xen/xen-acpi-cpuhotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xen-acpi-cpuhotplug.c b/drivers/xen/xen-acpi-cpuhotplug.c
> index 3e62ee4..5a62aa0 100644
> --- a/drivers/xen/xen-acpi-cpuhotplug.c
> +++ b/drivers/xen/xen-acpi-cpuhotplug.c
> @@ -77,7 +77,7 @@ static int xen_acpi_processor_enable(struct acpi_device *device)
>  
>  	pr->id = xen_pcpu_id(pr->acpi_id);
>  
> -	if ((int)pr->id < 0)
> +	if (invalid_logical_cpuid(pr->id))
>  		/* This cpu is not presented at hypervisor, try to hotadd it */
>  		if (ACPI_FAILURE(xen_acpi_cpu_hotadd(pr))) {
>  			pr_err(PREFIX "Hotadd CPU (acpi_id = %d) failed.\n",
> @@ -226,7 +226,7 @@ static acpi_status xen_acpi_cpu_hotadd(struct acpi_processor *pr)
>  		return AE_ERROR;
>  
>  	pr->id = xen_hotadd_cpu(pr);
> -	if ((int)pr->id < 0)
> +	if (invalid_logical_cpuid(pr->id))
>  		return AE_ERROR;
>  
>  	/*
> -- 
> 1.9.1
> 
