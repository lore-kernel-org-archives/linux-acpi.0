From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: don't check power state after _ON/_OFF
Date: Fri, 22 May 2009 00:32:20 +0100
Message-ID: <20090521233220.GA1778@srcf.ucam.org>
References: <20090521232853.3282.8302.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39352 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbZEUXc2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 19:32:28 -0400
Content-Disposition: inline
In-Reply-To: <20090521232853.3282.8302.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>, Yakui Zhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Thu, May 21, 2009 at 05:28:53PM -0600, Bjorn Helgaas wrote:
> We used to evaluate _STA to check the power state of a device after
> running _ON or _OFF.  But as far as I can tell, there's no benefit
> to evaluating _STA, and sometimes we trip over bugs when BIOSes don't
> implement _STA correctly.
> 
> Yakui says Windows XP doesn't evaluate _STA during power transition.
> So let's skip it in Linux, too.  It's conceivable that we'll need to
> check _STA in the future for some reason, but until we do, I don't
> see a reason to clutter this code path.
> 
> References:
>     http://bugzilla.kernel.org/show_bug.cgi?id=13243
>     http://marc.info/?l=linux-acpi&m=124166053803753&w=2
>     http://marc.info/?l=linux-acpi&m=124175761408256&w=2
>     http://marc.info/?l=linux-acpi&m=124210593114061&w=2
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> CC: Yakui Zhao <yakui.zhao@intel.com>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> CC: Witold Szczeponik <Witold.Szczeponik@gmx.net>
> CC: Alexey Starikovskiy <astarikovskiy@suse.de>
> CC: Len Brown <lenb@kernel.org>

Acked-by: Matthew Garrett <mjg@redhat.com>

>  drivers/acpi/power.c |   28 ++--------------------------
>  1 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 56665a6..d74365d 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -194,7 +194,7 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
>  
>  static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0, state;
> +	int result = 0;
>  	int found = 0;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
> @@ -236,18 +236,6 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	if (!acpi_power_nocheck) {
> -		/*
> -		 * If acpi_power_nocheck is set, it is unnecessary to check
> -		 * the power state after power transition.
> -		 */
> -		result = acpi_power_get_state(resource->device->handle,
> -				&state);
> -		if (result)
> -			return result;
> -		if (state != ACPI_POWER_RESOURCE_STATE_ON)
> -			return -ENOEXEC;
> -	}
>  	/* Update the power resource's _device_ power state */
>  	resource->device->power.state = ACPI_STATE_D0;
>  
> @@ -258,7 +246,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  
>  static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0, state;
> +	int result = 0;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
>  	struct list_head *node, *next;
> @@ -293,18 +281,6 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	if (!acpi_power_nocheck) {
> -		/*
> -		 * If acpi_power_nocheck is set, it is unnecessary to check
> -		 * the power state after power transition.
> -		 */
> -		result = acpi_power_get_state(handle, &state);
> -		if (result)
> -			return result;
> -		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
> -			return -ENOEXEC;
> -	}
> -
>  	/* Update the power resource's _device_ power state */
>  	resource->device->power.state = ACPI_STATE_D3;
>  
> 
> 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
