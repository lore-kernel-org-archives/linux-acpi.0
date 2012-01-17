From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/3] ACPI processor: Remove unneeded variable passed by
 acpi_processor_hotadd_init
Date: Tue, 17 Jan 2012 11:29:51 -0500
Message-ID: <20120117162951.GB21545@phenom.dumpdata.com>
References: <1326817230-79711-1-git-send-email-trenn@suse.de>
 <1326817230-79711-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:22599 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab2AQQcD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 11:32:03 -0500
Content-Disposition: inline
In-Reply-To: <1326817230-79711-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, deepthi@linux.vnet.ibm.com, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

On Tue, Jan 17, 2012 at 05:20:29PM +0100, Thomas Renninger wrote:
> This is a very small part taken from patches which afaik
> are coming from Yunhong Jiang for Xen.
> Xen CPU hotplug things not existing in Linus kernel yet were
> removed.

Could you point out the git commit please?
I did this:
 git log --grep=Yunhong drivers/acpi/processor_driver.c

And could not find it?
> 
> Cleanup only: no functional change.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Jiang, Yunhong <yunhong.jiang@intel.com>
> ---
>  drivers/acpi/processor_driver.c |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 90719d1..2291aa4 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -82,7 +82,7 @@ MODULE_LICENSE("GPL");
>  static int acpi_processor_add(struct acpi_device *device);
>  static int acpi_processor_remove(struct acpi_device *device, int type);
>  static void acpi_processor_notify(struct acpi_device *device, u32 event);
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
>  static int acpi_processor_handle_eject(struct acpi_processor *pr);
>  
>  
> @@ -324,10 +324,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 *  they are physically not present.
>  	 */
>  	if (pr->id == -1) {
> -		if (ACPI_FAILURE
> -		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
> +		if (ACPI_FAILURE (acpi_processor_hotadd_init(pr->handle)))
>  			return -ENODEV;
> -		}
>  	}
>  	/*
>  	 * On some boxes several processors use the same processor bus id.
> @@ -721,18 +719,19 @@ processor_walk_namespace_cb(acpi_handle handle,
>  	return (AE_OK);
>  }
>  
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
>  {
> +	acpi_handle handle = pr->handle;
>  
>  	if (!is_processor_present(handle)) {
>  		return AE_ERROR;
>  	}
>  
> -	if (acpi_map_lsapic(handle, p_cpu))
> +	if (acpi_map_lsapic(handle, &pr-id))
>  		return AE_ERROR;
>  
> -	if (arch_register_cpu(*p_cpu)) {
> -		acpi_unmap_lsapic(*p_cpu);
> +	if (arch_register_cpu(pr->id)) {
> +		acpi_unmap_lsapic(pr->id);
>  		return AE_ERROR;
>  	}
>  
> @@ -749,7 +748,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr)
>  	return (0);
>  }
>  #else
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
>  {
>  	return AE_ERROR;
>  }
> -- 
> 1.7.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
