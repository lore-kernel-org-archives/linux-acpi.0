Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E229E11D;
	Tue, 28 Apr 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341414; cv=none; b=PSReNzDHHSbWMpYXf9I41WgbFplsLzjx7ooDL6dRHNQVzPLi8WLJ0uP4ygm0eD9yTGNBWyw8YQktWZys+fRz0zPDFsgzg2RUmuzLrfvZtq8HQixEglPcEnqTTYw9Rony/EJ4gm0PhY6V2nIld9NijtgeZsf7JJU8OuiiaFtEOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341414; c=relaxed/simple;
	bh=aQuhWlNvPYX+NkLPdd+qNBPd3TvJl1bgP7uJAQNuPrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQYaTNHFY8Epd5OhncZuizrzemI+OEHlUKI+fZt+9axS7c+Cg2v2zgIM8XVVo5Y+gHQiCC9YSYQFpoDvm93PaHj055WP7xpDi16+h/HgtSl5YnYQePJO4Z/q3wtqWi6ZZDaLOuN3SabxKuJKggD54qO076FkKPupnBsL4LvLIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJyKCI5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJyKCI5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75806C19425;
	Tue, 28 Apr 2026 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341414;
	bh=aQuhWlNvPYX+NkLPdd+qNBPd3TvJl1bgP7uJAQNuPrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VJyKCI5wb+1ENaz+1oKjaJYo6QKwTDJTtJ/y5qnGYDN9XW28+9IPlAn5pS67K92ne
	 VEDp8txI3Bu0G0nC/IsL8A16DDzTpNRSngkQuNchjO6U/Uqv3lTRolsawsrLXWtfzl
	 Rh5xwNv+kuxhf73265/glE4QUcfpO9KK88GcrW2r1uvbHfC8aqX1FVkjWrpOmii/+/
	 Q/dUjSVWG5Lwb3uT75J6Uz+99OTVTV16EB590iE4g6kDCqfUJ8ITomwYEjRkpWRHel
	 zHDat5PHBZTR15C8Ot+r7ovgPow2w9O+8P/GTm64UCyyBdOa8GJuf1ffVmDPCi4DQB
	 pMk/e1p0b3y2Q==
Message-ID: <93d15dd4-d084-4f9b-9e02-a5417ecb168e@kernel.org>
Date: Mon, 27 Apr 2026 20:56:51 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/10] platform/x86: asus-wmi: add s2idle begin delay for
 Ally devices
Content-Language: en-US
To: Antheas Kapenekakis <lkml@antheas.dev>, dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-5-lkml@antheas.dev>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260425215734.14116-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/26 16:57, Antheas Kapenekakis wrote:
> Asus ROG Ally devices have a small fade animation during their suspend
> sequence. This animation is triggered by the Display Off firmware
> notification. After it, they power off, disconnect, and save their
> state. Without a delay after that notification, if the device is placed
> into D3, it causes it to reboot during resume, or particularly for
> original Allies, also leave the xpad device connected, causing spurious
> wakeups when a gamepad button is pressed and higher standby drain.
> 
> Therefore, introduce a small delay quirk and bind it to an s2idle dev
> ops device. Place this quirk in the asus-wmi driver, as the USB gamepad
> disconnects, making it hard to place in hid-asus, and to allow for
> proper functionality when the hid-asus driver is blacklisted.
> 
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
> +	 * xpad device connected, causing spurious wake-ups and higher
> +	 * power draw, (ii) for newer allies using the adaptive protocol
> +	 * causes the controller to reboot on resume if mcu_powersave is
> +	 * false. Therefore, allow adding a delay for the affected devices.
> +	 * (if MCU powersave is true the controller always reboots, but
> +	 * this also causes an unwelcome 5-7s delay on resume, this issue
> +	 * is present on all firmwares)
> +	 */
> +	int lps0_begin_delay;
>   };
>   
>   struct asus_wmi_driver {

