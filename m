Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CD2D0610;
	Tue, 28 Apr 2026 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358112; cv=none; b=HTQlP9/lyABtNILNKAdRDdKad+BG/AaMgqdv+1LH9kNEwiR8uJuAopEnbILM2J4NB5qWPpNM2rNwc7w0019hzdtPoSkHi3bIgH0zcw+amm4dJLu8g1wOpEZqESDYvQAlBAI6C88k5w5x9LbExwiEGfrr6jTKjWGOP8cWm+Aozo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358112; c=relaxed/simple;
	bh=O9DcumiMFz/ScM9H8tmCN0A3C/VD+Dm/2Wyx5fawRQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHLxwKkfgFYL7pdlckBdQ/LuY2a0PS72SLnAHGUHoAiOOZcSPeiZ4IKHOQvrTM9fZYj/iK9U95SEAXDAXim3dKHl2/QVBt/wAC2RrYSHRu2yxM2i9f505uo91uYDKqonHXt6e/4NCxwQ66k3+BUUI4QAo8mB9WpBfRcsTDCRx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af76e.dynamic.kabel-deutschland.de [95.90.247.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 632A04C4430D9D;
	Tue, 28 Apr 2026 08:34:23 +0200 (CEST)
Message-ID: <c2dc681e-2291-4dc7-b0d4-8f8f6996cf48@molgen.mpg.de>
Date: Tue, 28 Apr 2026 08:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [systemd-devel] [RFC v2 04/10] platform/x86: asus-wmi: add s2idle
 begin delay for Ally devices
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
 bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
 kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org,
 richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-5-lkml@antheas.dev>
Content-Language: en-US
From: Paul Menzel <pmenzel+systemd-devel@molgen.mpg.de>
In-Reply-To: <20260425215734.14116-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Antheas,


Thank you for your patch.

Am 25.04.26 um 23:57 schrieb Antheas Kapenekakis:
> Asus ROG Ally devices have a small fade animation during their suspend
> sequence. This animation is triggered by the Display Off firmware
> notification. After it, they power off, disconnect, and save their

Does *they* mean the system firmware?

> state. Without a delay after that notification, if the device is placed
> into D3, it causes it to reboot during resume, or particularly for
> original Allies, also leave the xpad device connected, causing spurious
> wakeups when a gamepad button is pressed and higher standby drain.
> 
> Therefore, introduce a small delay quirk and bind it to an s2idle dev
> ops device. Place this quirk in the asus-wmi driver, as the USB gamepad
> disconnects, making it hard to place in hid-asus, and to allow for
> proper functionality when the hid-asus driver is blacklisted.

Reading the commit message, it’s not clear to me, if it’s a firmware bug 
or not. I’d say, it is. Could Asus fix *additionally* fix it?

Also please list the devices added to the quirk list to the commit message.

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/asus-nb-wmi.c | 40 ++++++++++++++++++++++++++++++
>   drivers/platform/x86/asus-wmi.c    | 12 +++++++++
>   drivers/platform/x86/asus-wmi.h    | 14 +++++++++++
>   3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index b4677c5bba5b..da963f3a17b1 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -155,6 +155,10 @@ static struct quirk_entry quirk_asus_z13 = {
>   	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
>   };
>   
> +static struct quirk_entry quirk_ally = {
> +	.lps0_begin_delay = 500,

I’d append the unit to the variable name. (But I also saw that 
`s2idle_dev_ops.begin_delay` does not follow this schema.)

> +};
> +
>   static int dmi_matched(const struct dmi_system_id *dmi)
>   {
>   	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -553,6 +557,42 @@ static const struct dmi_system_id asus_quirks[] = {
>   		},
>   		.driver_data = &quirk_asus_z13,
>   	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Ally",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +		},
> +		.driver_data = (void *)&quirk_ally,
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Ally X",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +		},
> +		.driver_data = (void *)&quirk_ally,
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Xbox Ally",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "RC73Y"),
> +		},
> +		.driver_data = (void *)&quirk_ally,
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Xbox Ally X",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "RC73X"),
> +		},
> +		.driver_data = (void *)&quirk_ally,
> +	},
>   	{},
>   };
>   
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 7c0915e097ba..3316415abbdf 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -337,6 +337,8 @@ struct asus_wmi {
>   	struct asus_wmi_debug debug;
>   
>   	struct asus_wmi_driver *driver;
> +
> +	struct acpi_s2idle_dev_ops s2idle_dev_ops;
>   };
>   
>   /* Global to allow setting externally without requiring driver data */
> @@ -5030,6 +5032,12 @@ static int asus_wmi_add(struct platform_device *pdev)
>   	if (err)
>   		goto fail_platform;
>   
> +	if (asus->driver->quirks->lps0_begin_delay) {
> +		asus->s2idle_dev_ops.begin_delay =
> +			asus->driver->quirks->lps0_begin_delay;
> +		acpi_register_lps0_dev(&asus->s2idle_dev_ops);
> +	}
> +
>   	if (use_ally_mcu_hack == ASUS_WMI_ALLY_MCU_HACK_INIT) {
>   		if (acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>   					&& dmi_check_system(asus_rog_ally_device))
> @@ -5184,6 +5192,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>   fail_custom_fan_curve:
>   fail_platform_profile_setup:
>   fail_fan_boost_mode:
> +	if (asus->driver->quirks->lps0_begin_delay)
> +		acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
>   fail_platform:
>   	kfree(asus);
>   	return err;
> @@ -5207,6 +5217,8 @@ static void asus_wmi_remove(struct platform_device *device)
>   	asus_fan_set_auto(asus);
>   	throttle_thermal_policy_set_default(asus);
>   	asus_wmi_battery_exit(asus);
> +	if (asus->driver->quirks->lps0_begin_delay)
> +		acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
>   
>   	kfree(asus);
>   }
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index 5cd4392b964e..2a8c51d39bf8 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -52,6 +52,20 @@ struct quirk_entry {
>   	 */
>   	int no_display_toggle;
>   	u32 xusb2pr;
> +	/*
> +	 * Ally devices uninitialize after the display off DSM of modern
> +	 * stanby, after a predetermined fade animation on their RGB.

standby

> +	 * If the USB subsystem puts the controller into D3 before that,
> +	 * it loses its state and (i) for original allies, it leaves the

Allies (or Allys) to make it easier to read for non-native speakers.

> +	 * xpad device connected, causing spurious wake-ups and higher
> +	 * power draw, (ii) for newer allies using the adaptive protocol

Ditto.

> +	 * causes the controller to reboot on resume if mcu_powersave is
> +	 * false. Therefore, allow adding a delay for the affected devices.
> +	 * (if MCU powersave is true the controller always reboots, but

Is MCU powersave a system firmware (UEFI) option?

> +	 * this also causes an unwelcome 5-7s delay on resume, this issue
> +	 * is present on all firmwares)
> +	 */
> +	int lps0_begin_delay;
>   };
>   
>   struct asus_wmi_driver {


Kind regards,

Paul
