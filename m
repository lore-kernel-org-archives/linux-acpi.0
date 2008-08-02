From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] patch acpi_lenovo_thinkpad_only_return_vista.patch
Date: Sat, 2 Aug 2008 18:28:46 +0200
Message-ID: <200808021828.47888.trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo> <1217696279-23848-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60648 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673AbYHBREO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Aug 2008 13:04:14 -0400
In-Reply-To: <1217696279-23848-3-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corsac@debian.org
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

On Saturday 02 August 2008 06:57:59 pm Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/acpi/osl.c                     |   11 +++++++++++
>  drivers/net/wireless/iwlwifi/iwl-led.c |    2 --
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index bf42ef1..0d9e174 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -201,6 +201,17 @@ acpi_status __init acpi_os_initialize(void)
>
>  acpi_status acpi_os_initialize1(void)
>  {
> +	/* Only return Vista 2006 for Lenovo ThinkPads */
> +	if (dmi_name_in_vendors("LENOVO")) {
> +		acpi_osi_invalidate("Windows 2000");
> +		acpi_osi_invalidate("Windows 2001");
> +		acpi_osi_invalidate("Windows 2001 SP1");
> +		acpi_osi_invalidate("Windows 2001 SP2");
> +		acpi_osi_invalidate("Windows 2001.1");
> +		acpi_osi_invalidate("Windows 2001.1 SP1");
> +		/* acpi_osi_invalidate("Windows 2006"); */
> +	}
> +
>  	kacpid_wq = create_singlethread_workqueue("kacpid");
>  	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
>  	BUG_ON(!kacpid_wq);

Ops, the stuff below is unrelated.

> diff --git a/drivers/net/wireless/iwlwifi/iwl-led.c
> b/drivers/net/wireless/iwlwifi/iwl-led.c index 899d7a2..34de711 100644
> --- a/drivers/net/wireless/iwlwifi/iwl-led.c
> +++ b/drivers/net/wireless/iwlwifi/iwl-led.c
> @@ -195,8 +195,6 @@ static void iwl_led_brightness_set(struct led_classdev
> *led_cdev, return;
>
>
> -	IWL_DEBUG_LED("Led type = %s brightness = %d\n",
> -			led_type_str[led->type], brightness);
>  	switch (brightness) {
>  	case LED_FULL:
>  		if (led->type == IWL_LED_TRG_ASSOC)

Also the first patch probably disables video.ko brightness switching and 
thinkpad_acpi has to be used then. The way it worked before Vista...

But only returning true to Windows 2006, is worth a try IMO.

       Thomas
