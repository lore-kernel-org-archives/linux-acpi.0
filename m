From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI processor: Remove unneeded variable passed by
 acpi_processor_hotadd_init
Date: Tue, 17 Jan 2012 06:10:33 -0500
Message-ID: <4F155729.2090707@kernel.org>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-6-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55596 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab2AQLKh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 06:10:37 -0500
Received: by qcsf13 with SMTP id f13so2003765qcs.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 03:10:36 -0800 (PST)
In-Reply-To: <1321569421-46220-6-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

On 11/17/2011 05:37 PM, Thomas Renninger wrote:

> This is a very small part taken from patches which afaik
> are coming from Yunhong Jiang for Xen.
> Xen CPU hotplug things not existing in Linus kernel yet were
> removed.
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
> index 3e5763f..66887a5 100644
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
> @@ -330,10 +330,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
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
> @@ -727,18 +725,19 @@ processor_walk_namespace_cb(acpi_handle handle,
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


eh?

>  		return AE_ERROR;
>  
> -	if (arch_register_cpu(*p_cpu)) {
> -		acpi_unmap_lsapic(*p_cpu);
> +	if (arch_register_cpu(pr->id)) {
> +		acpi_unmap_lsapic(pr->id);
>  		return AE_ERROR;
>  	}
>  
> @@ -755,7 +754,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr)
>  	return (0);
>  }
>  #else
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
>  {
>  	return AE_ERROR;
>  }


