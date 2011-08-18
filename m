From: Anisse Astier <anisse@astier.eu>
Subject: Re: ACPI LID wakeup device prevents shutdown on Toshiba laptop and
 other computers
Date: Thu, 18 Aug 2011 18:11:26 +0200
Message-ID: <20110818181126.3a70efdb@destiny.ordissimo>
References: <20110728174759.292311cc@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48774 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1HRQLx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2011 12:11:53 -0400
Received: by wwe5 with SMTP id 5so4251967wwe.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2011 09:11:52 -0700 (PDT)
In-Reply-To: <20110728174759.292311cc@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>


On Thu, 28 Jul 2011 17:47:59 +0200, Anisse Astier <anisse@astier.eu> wrote :

> Hi,
> 
> (See reference: https://bugzilla.kernel.org/show_bug.cgi?id=35262 )
> 
> On Toshiba C670D-10C, and as reported on a desktop asus mainboard
> computer, we cannot shutdown without the computer rebooting.
> 
> The fix for this is simple, just run:
> echo " LID" > /proc/acpi/wakeup
> before shutdown. Please see below for quick and dirty in-kernel
> implementation.
> 
> Now I don't know why is that. Perhaps Windows disables (some) wakeup
> devices at shutdown, therefore the OEM/BIOS vendor expected any OS to
> behave this way in order to halt properly.
> Or maybe there's another reason.
> 
> I'd like comments on the idea implemented on the patch below, and maybe
> suggestions to do this in a better way. 

No one has any objection ? Should I resend the patch as-is ? Make it a
quirk?

> 
> Thanks,
> 
> Anisse
> 
> --
> 
> From: Anisse Astier <anisse@astier.eu>
> Subject: [PATCH] ACPI / PM : Disable ACPI LID wakeup device at shutdown
> 
> This device might cause shutdown to be a reboot on some computers:
> Toshiba C670D-10C laptop, Asus desktop mainboard.
> Device will shutdown, then wakeup immediately afterwards, regardless of
> the status of the LID.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=35262
> ---
>  drivers/acpi/sleep.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 6c94960..3859628 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -58,6 +58,30 @@ static struct notifier_block tts_notifier = {
>  	.priority	= 0,
>  };
>  
> +static void acpi_disable_obnoxious_wakeup_device(u32 sleep_state)
> +{
> +	struct list_head *node, *next;
> +
> +	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> +		struct acpi_device *dev =
> +			container_of(node, struct acpi_device, wakeup_list);
> +
> +		if (!dev->wakeup.flags.valid
> +		    || sleep_state > (u32) dev->wakeup.sleep_state
> +		    || !(device_may_wakeup(&dev->dev)
> +		        || dev->wakeup.prepare_count))
> +			continue;
> +		if (!strcmp(dev->pnp.bus_id, "LID")) {
> +			acpi_set_gpe_wake_mask(dev->wakeup.gpe_device,
> +					       dev->wakeup.gpe_number,
> +					       ACPI_GPE_DISABLE);
> +
> +			if (device_may_wakeup(&dev->dev))
> +				acpi_disable_wakeup_device_power(dev);
> +			}
> +	}
> +}
> +
>  static int acpi_sleep_prepare(u32 acpi_state)
>  {
>  #ifdef CONFIG_ACPI_SLEEP
> @@ -75,6 +99,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
>  		acpi_state);
>  	acpi_enable_wakeup_devices(acpi_state);
> +	acpi_disable_obnoxious_wakeup_device(acpi_state);
>  	acpi_enter_sleep_state_prep(acpi_state);
>  	return 0;
>  }
