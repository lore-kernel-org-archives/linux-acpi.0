From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: bus: handle power manageable but no _PSC/_PRx case
Date: Thu, 6 Sep 2012 23:45:09 +0200
Message-ID: <201209062345.09840.rjw@sisk.pl>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40684 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933115Ab2IFViu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Sep 2012 17:38:50 -0400
In-Reply-To: <1346053126-7646-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Monday, August 27, 2012, Aaron Lu wrote:
> Currently, when we are trying to get the power state of an acpi device,
> we will do the following:
> If device is not power manageable, init its power state as its parent or
> if it does not have a parent, init as D0;
> If device is power manageable, evaluate _PSC and then refine with
> acpi_power_get_inferred_state.
> 
> But there exist some devices with _PSx defined, but no _PSC or _PRx.
> It is power manageable, but the above method to get power state does
> not cover this case and its power state will be UNKNOWN(255).
> 
> So change the check of power manageable to whether _PSC and _PRx
> defined.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Applied to the linux-next branch of the linux-pm.git tree.

I think it should go to -stable too and therefore it would be good to have
it in v3.6, so I'd like to push it to Linus for -rc5, if Len has no objections.

Thanks,
Rafael


> ---
>  drivers/acpi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9628652..b564e6d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -207,7 +207,8 @@ static int __acpi_bus_get_power(struct acpi_device *device, int *state)
>  	if (!device || !state)
>  		return -EINVAL;
>  
> -	if (!device->flags.power_manageable) {
> +	if (!device->power.flags.explicit_get &&
> +			!device->power.flags.power_resources) {
>  		/* TBD: Non-recursive algorithm for walking up hierarchy. */
>  		*state = device->parent ?
>  			device->parent->power.state : ACPI_STATE_D0;
> 

