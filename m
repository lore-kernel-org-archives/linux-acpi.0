Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CF3E51F5;
	Mon, 12 Oct 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816902; cv=none; b=PIHFJSc1TkCEVVYIgCaxmB2HT0wzG4RMqrfsg6i0ydzOZtphre7vAoBBx4d1Wxxp8rmlLrhd2ISvkW19WHGNdkl4W23LglGUqWcMk927CufIt7Z7axfURuCa2UidhtsZG5QQpsoj1y+jeRcHZWhkuuAMd1Qh4puxx/isxtpKIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816902; c=relaxed/simple;
	bh=OrVEu59gq2n54Nhmry3hSQCdx5t9FmndTbxVrh4n+O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTpJO3ir6OTiUXd71uiGCnGql6qe9jKTickDA/4muDAdynzteYNJuWuYfg5OX53iCr6Vsjpouh44lPGF8UiaG9fXlx37acIie06FlYoPkO3SvTsZVw4xun24cE6LNEpO1JWqf1/QXzhlNbgC8NxvhVAFi/G3ECcNJLA0TGNf3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JykU3ZWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JykU3ZWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D71F0089C;
	Mon, 12 Oct 2026 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816901;
	bh=HjF+dwN8jkIOmYUrrmNbDo0OkbvjjoMsq7uNZRAJ+PE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JykU3ZWXRY0rwTALJyGgXe4AGmqAVnSamo0Y0VhNMkc/GCU9qZFvaDUEBs2/cKC/p
	 dsbl6OV4fT0F49vsIbtpg9+ra+kkAmr9uyMQT/EUuWKgL6FqfLqrLPgqbYYHc4dnUN
	 kJUa6PsO0uC+bcM16SyQA/dozU9b5DKf30owY10v0kWvWmFjdAHOKMH8MMbUFeYSJV
	 htdsBAl1+wPY+s4xvC7AHkzLtwW8PjPEwqj+arJ4A6YJYdduYCgV7kfSenMjbWBict
	 kRD00j0YobueSZYk3+udbYH+3I86iUjdvLfkG39iRIrdfqwP/BxyHl9PgJWJhYpbP4
	 +Ge3UKzf9+Svw==
Message-ID: <96f4dc4d-eb5c-4af2-86e4-8d10f87b3d9d@kernel.org>
Date: Mon, 12 Oct 2026 16:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ACPI: video: force native backlight on Dell OptiPlex
 AIO 7410 35W
To: chitranshmandhaniya@gmail.com, ilpo.jarvinen@linux.intel.com,
 rafael@kernel.org
Cc: lenb@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chitransh_Mandhaniya@dell.com
References: <20261009072401.52509-1-chitranshmandhaniya@gmail.com>
 <20261010124830.116750-1-chitranshmandhaniya@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261010124830.116750-1-chitranshmandhaniya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Oct-26 14:48, chitranshmandhaniya@gmail.com wrote:
> From: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>
> 
> The Dell OptiPlex AIO 7410 35W (board 01KP8D) declares DELL0501 in its
> ACPI DSDT (status = 0x0F) even though no UART scalar board is physically
> present. This causes acpi_video_get_backlight_type() to return
> acpi_backlight_dell_uart, which makes i915 skip registering
> intel_backlight. The dell-uart-backlight driver then times out talking
> to the absent board and the probe fails, leaving the machine with zero
> backlight control.
> 
> A BIOS update fixes this on some models (e.g. OptiPlex 7420, board
> 0914RT) by setting DELL0501 _STA to 0, but Dell has not shipped a
> corrected BIOS for the 7410 even in the latest release (1.37.0,
> 2026-05-28).
> 
> Add a DMI quirk to force native backlight on this model so that i915
> registers intel_backlight and brightness control works out of the box.
> 
> Tested on:
>   - OptiPlex AIO 7410 35W (01KP8D, BIOS 1.37.0) -- confirmed
>     acpi_backlight=native produces working intel_backlight (raw,
>     max=96000), DMI quirk has the same effect.
>   - OptiPlex AIO 7420 35W (0914RT, BIOS 1.27.0) -- DELL0501 absent in
>     updated BIOS, intel_backlight works natively (no regression).
> 
> Signed-off-by: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index e3b69f876d24..1af14e04e597 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -883,6 +883,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Dell OptiPlex AIO 7410 35W */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
> +		},
> +	},
>  
>  	/*
>  	 * Models which have nvidia-ec-wmi support, but should not use it.

