Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459402BF3D7;
	Tue, 28 Apr 2026 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341474; cv=none; b=fqWtjFpi7A9EH2BYh7nK8Kc7LHnBD1sGJ4P+/2ubB1BR08D18QurMrJ0bKQt5fY5BR7ZFzOT7X963N9pjzuIOBJmcTl4s5w3aWoz9/WGBV4TQ3Eyn8xVZAiwCY0eCm8YWNQ99ljgapHXnGdVzwnEtXOGtcmxTQrnW/8QvfWGOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341474; c=relaxed/simple;
	bh=rOonBp+piUpdPA+hE946zkT1f5kVqnqsMbM4XRaZLI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPbZpERH7sZ/SJYQ2C8EAbkAfH4/00vQyYUSpoYGEXtMF4e4zbwZVKZcdTRGQeZcj2BLVTdkI2l2Sz3K6mLldp3+4GNPBvAucAnbycniXiaHJoNZ01MtB6ekHsm2dg1/pc/a8vPuZ8JPcPy5V0+KpVtz8DOwHAmFjVebcIL9MgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw8RGdxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw8RGdxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD90EC19425;
	Tue, 28 Apr 2026 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341474;
	bh=rOonBp+piUpdPA+hE946zkT1f5kVqnqsMbM4XRaZLI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iw8RGdxaZbrsCiPlepUU3oswecINl5kKbUBkd8ltilHL1wXaiNHyZ1qhMK6UnTEf6
	 Lo/Lfx+fbbIRXIdBWPYwpRpjoVX5z0x+kWHMrAsaweGk3obpKtN+Y3vfXaVDohSs33
	 U3caI1705ePstmD1x0mQySiNk6+9TsohcLtUW+c08t46DCN/v/7H5lXlbppDdVuGWq
	 Jtd0gUd7RrszVP7vwQxjf4tYW/xYmXuFPuztmIkdyR2E3M9JeskK96YwL6zkvds4il
	 3cDOKXOGi3OQxNQehAKxmrQ15Jze1qt8NcJrR2+eg45e/DuMhZMxRBnqbGvoou1YcJ
	 kttdXHlzPZrNg==
Message-ID: <3841aded-9b40-4899-9b64-3fb42e077ac7@kernel.org>
Date: Mon, 27 Apr 2026 20:57:51 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/10] acpi/x86: s2idle: Add support for adding a delay
 after begin MS calls
Content-Language: en-US
To: Antheas Kapenekakis <lkml@antheas.dev>, dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-4-lkml@antheas.dev>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260425215734.14116-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/26 16:57, Antheas Kapenekakis wrote:
> Certain platform/USB devices interact with Modern Standby firmware
> notifications. This is particularly true with Asus, where the keyboards
> are wired up to turn off their backlight during the Display Off
> notification using a predetermined delay. While for Asus Keyboards this
> does not cause an issue, it does manifest in ROG Ally devices, where the
> controller waits for the animation to complete before saving its state.
> 
> In Windows, this is not a problem, because there is an ample delay after
> these calls and before LPS0, typically seconds to minutes.
> 
> Therefore, introduce a delay quirk after these calls, to ensure affected
> devices have time to uninitialize, and attach it to acpi_s2idle_dev_ops
> so it can be consumed by device drivers.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/acpi/x86/s2idle.c | 11 +++++++++++
>   include/linux/acpi.h      |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index f5aefba8b191..8b48f999e0e9 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/dmi.h>
>   #include <linux/suspend.h>
> @@ -517,6 +518,9 @@ static struct acpi_scan_handler lps0_handler = {
>   
>   static int acpi_s2idle_begin_lps0(void)
>   {
> +	struct acpi_s2idle_dev_ops *handler;
> +	int delay = 0;
> +
>   	if (!lps0_device_handle || sleep_no_lps0)
>   		return acpi_s2idle_begin();
>   
> @@ -552,6 +556,13 @@ static int acpi_s2idle_begin_lps0(void)
>   					lps0_dsm_func_mask_microsoft,
>   					lps0_dsm_guid_microsoft);
>   
> +	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> +		if (handler->begin_delay && handler->begin_delay > delay)
> +			delay = handler->begin_delay;
> +	}
> +	if (delay > 0)
> +		msleep(delay);

Is this the correct location?  You wouldn't want it at the check callback?

> +
>   	return acpi_s2idle_begin();
>   }
>   
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4d2f0bed7a06..a416e5c5798a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1154,6 +1154,7 @@ struct acpi_s2idle_dev_ops {
>   	void (*prepare)(void);
>   	void (*check)(void);
>   	void (*restore)(void);
> +	int begin_delay;
>   };
>   #if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);

