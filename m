Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389A2550CD;
	Tue, 17 Mar 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768944; cv=none; b=GalSfvp1TNdOQ5QZhTqgEfIp4qBdizPzYi5tOvriydKl089Zm8vXuuQjWkq+KbNGUqGG5bWYfJ/WWc9Bm+KKduL22k1d7WXnUnbxKlaRq/feLkDvku2KFeJ1dAURtKMpQohieMPxADhqaZbdDduUXU+PewXGxB8/dHa9MslSJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768944; c=relaxed/simple;
	bh=GrAifgFAjjiRiECOKbD98aquxGJudPKYTMqEW+F1G+I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DxTAxSDhCu/Co+xqX5tUZAC02/j3TWgG565LJBYJBAp1vrD5fPrWd1XrVrp+y4VqsHpfiRrwlQzuphpx41+O2n5jCuXkab1TXJgZKPN9dvYii5gGho7NbODzXgt82WgQEjrG3TJRllYMed23c/drgxZRWkGrwMRlq8MbTj7O+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaCqU3w8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaCqU3w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773768943; x=1805304943;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GrAifgFAjjiRiECOKbD98aquxGJudPKYTMqEW+F1G+I=;
  b=DaCqU3w896zOlBTungATXyZd9zsciObK42HLXHeBmioiF+YQZ/CDyvtE
   RGDYfqiWedKLyHIYHl/+tUJTFqJfmvwCgWZkkLeQZcNeP4ss3z+g4EGUB
   peghQto8k8dcjGP0fe2zsArH5hrvNFdGpcrgeij02Mt3omhMTcLY6x10i
   9khHbkw9FMjwDmPEZR5r5r/L7o06cnTD/ZGWGuO1Q3jEZGwbabofkOEbF
   k5mueYCcp7zY/mseQXONrdSmm4m92vA9p0bCAznlBrpuKeez6evLn/Mtt
   eXrnukVsYlAZzGl/V6P61/j/kGFgTptm04Lo/nj2130t8lunF97imWctp
   A==;
X-CSE-ConnectionGUID: AiapxmTSSGSLG7bBmLdhMA==
X-CSE-MsgGUID: tTiO9akrSBevPk2Ujd3rrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85438773"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85438773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:35:42 -0700
X-CSE-ConnectionGUID: efvndCEMRtqMfMiiVzvnkQ==
X-CSE-MsgGUID: 7BoC8YSMQFqmzYqAhwicIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="252815425"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:35:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 19:35:35 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [PATCH v1 2/3] platform/x86: panasonic-laptop: Register ACPI
 notify handler directly
In-Reply-To: <4508640.ejJDZkT8p0@rafael.j.wysocki>
Message-ID: <eb4ccb62-58fc-0d1b-7f74-2b1532448056@linux.intel.com>
References: <3616223.QJadu78ljV@rafael.j.wysocki> <4508640.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Mar 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index 64195ff0f40e..4bd83b987761 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -185,7 +185,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
>  
>  static int acpi_pcc_hotkey_add(struct acpi_device *device);
>  static void acpi_pcc_hotkey_remove(struct acpi_device *device);
> -static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
> +static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data);
>  
>  static const struct acpi_device_id pcc_device_ids[] = {
>  	{ "MAT0012", 0},
> @@ -208,7 +208,6 @@ static struct acpi_driver acpi_pcc_driver = {
>  	.ops =		{
>  				.add =		acpi_pcc_hotkey_add,
>  				.remove =	acpi_pcc_hotkey_remove,
> -				.notify =	acpi_pcc_hotkey_notify,
>  			},
>  	.drv.pm =	&acpi_pcc_hotkey_pm,
>  };
> @@ -869,9 +868,9 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
>  		pr_err("Unknown hotkey event: 0x%04llx\n", result);
>  }
>  
> -static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
> +static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct pcc_acpi *pcc = acpi_driver_data(device);
> +	struct pcc_acpi *pcc = data;
>  
>  	switch (event) {
>  	case HKEY_NOTIFY:
> @@ -1073,13 +1072,18 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	if (result)
>  		goto out_backlight;
>  
> +	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +						 acpi_pcc_hotkey_notify, pcc);
> +	if (result)
> +		goto out_sysfs;
> +
>  	/* optical drive initialization */
>  	if (ACPI_SUCCESS(check_optd_present())) {
>  		pcc->platform = platform_device_register_simple("panasonic",
>  			PLATFORM_DEVID_NONE, NULL, 0);
>  		if (IS_ERR(pcc->platform)) {
>  			result = PTR_ERR(pcc->platform);
> -			goto out_sysfs;
> +			goto out_notify_handler;
>  		}
>  		result = device_create_file(&pcc->platform->dev,
>  			&dev_attr_cdpower);
> @@ -1095,6 +1099,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  
>  out_platform:
>  	platform_device_unregister(pcc->platform);
> +out_notify_handler:
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       acpi_pcc_hotkey_notify);
>  out_sysfs:
>  	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
>  out_backlight:
> @@ -1123,6 +1130,9 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
>  
>  	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       acpi_pcc_hotkey_notify);
> +

This diverges from the setup order. Is that intentional? (I can see the 
current order is not exactly reverse of the setup order but it still 
looks it's possible to place the added remove call better than here.)

This driver also likely has pre-existing rollback problems related to 
pcc_register_optd_notifier/pcc_unregister_optd_notifier().

>  	backlight_device_unregister(pcc->backlight);
>  
>  	input_unregister_device(pcc->input_dev);
> 

-- 
 i.

