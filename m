Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D112848A1;
	Tue, 17 Mar 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760751; cv=none; b=Z0x3sds+ca5pepjhk0bX5itGjvqB2Nm+z2ibA3Bar/RiHs+gJ/ZLCA106OgYoTLitq6L0IxLMv6iVp8rjNH1Fx53KV4zWQI6e4b4gg86tFrs2sJKJfbX0RUj2EkgSEMmLINwqQJaN6DybCStzAN3vXrFXyn8zPy4+xjtYY4fcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760751; c=relaxed/simple;
	bh=5Z4vSEE1bjGVPcx8vCfx3gMsrHsImpHM1Ahk1r1wHrc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i3Dajzoo9t6bYBVaTvE79ftRmxUE2qx682O5Ranz93Mj/cWRZhfibWn5eE5qsKtfTz2y+jsHgXmsnhaO4bUm6YPONMqr3m6PptZnX7OnTjP+vmrXldLUwyncXMkY/buh2jjgJpq3TnCMm07IFD/PN4O37jrl7/+2/SW6CZLGTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U12Jxo5z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U12Jxo5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773760750; x=1805296750;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5Z4vSEE1bjGVPcx8vCfx3gMsrHsImpHM1Ahk1r1wHrc=;
  b=U12Jxo5zuOCod5UbtsUuAjog6y0840SGP5MuqNcNcCFPNLa6I2XCPe34
   Jyhj4pfoahHQRO1d1SfTRdl3Tk5NFuD+8eQS7cRFYGo6RFq4kTmWgVibq
   h4O5zrFXLsvM3VYDwY8NkKZytyxbUMUCnJKfNjJ/VG8/iRscgpNnR3u6v
   OFZfJsYLPu/eLldqA9rnmPVkjLyjDi8Myy9iqc5nstJiB/k1H6iulaH34
   WzyaoUOYU+3PcCy6h2cHXvLCKSnuTMwQsN7UJLDCoH6bPNCUjESHNJQ07
   inj6/C7+hmPOygtYyQoPYfLaE+llvBPcdzi9bVfzTACkd0QNh+4GVfq1m
   Q==;
X-CSE-ConnectionGUID: XLy0AXq3RN6GsfFkBIApNA==
X-CSE-MsgGUID: u2AkfOgTR1GYeHEBCBC5ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="97404786"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="97404786"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:19:09 -0700
X-CSE-ConnectionGUID: 2Akn9hqRRzCna/tVGqHPsA==
X-CSE-MsgGUID: KGsugasGT0CLTtXXmZwGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226771278"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:19:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:19:03 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH v2 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
In-Reply-To: <1961003.tdWV9SEqCh@rafael.j.wysocki>
Message-ID: <6768d6a8-3ab5-f4c8-7e77-229fd8135f53@linux.intel.com>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki> <1961003.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Mar 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To facilitate subsequent conversion of the driver to using struct
> platform_driver instead of struct acpi_driver, make it install its ACPI
> notify handlers directly instead of using struct acpi_driver .notify()
> callbacks.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Call fujitsu_laptop_platform_remove() in acpi_fujitsu_laptop_add()
>    error code path if notify handler registration fails (Ilpo)

Hmm, did you forget to commit something as I don't see this addressed 
below?

> ---
>  drivers/platform/x86/fujitsu-laptop.c | 32 ++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 1adce90ae3e6..7816a867a60c 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi_device *device)
>  
>  /* Brightness notify */
>  
> -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
> +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *device = data;
>  	struct fujitsu_bl *priv = acpi_driver_data(device);
>  	int oldb, newb;
>  
> @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
>  	if (ret)
>  		return ret;
>  
> -	return fujitsu_backlight_register(device);
> +	ret = fujitsu_backlight_register(device);
> +	if (ret)
> +		return ret;
> +
> +	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +					       acpi_fujitsu_bl_notify, device);
> +}
> +
> +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> +{
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       acpi_fujitsu_bl_notify);
>  }
>  
>  /* ACPI device for hotkey handling */
> @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
>  	}
>  }
>  
> -static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
> +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *device = data;
>  	struct fujitsu_laptop *priv = acpi_driver_data(device);
>  	unsigned long flags;
>  	int scancode, i = 0;
> @@ -1056,6 +1069,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	if (ret)
>  		goto err_free_fifo;
>  
> +	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +					      acpi_fujitsu_laptop_notify, device);
> +	if (ret) {
> +		fujitsu_laptop_platform_remove(device);

Please add this into the rollback path instead and add another label 
there.

-- 
 i.


> +		goto err_free_fifo;
> +	}
> +
>  	ret = fujitsu_battery_charge_control_add(device);
>  	if (ret < 0)
>  		pr_warn("Unable to register battery charge control: %d\n", ret);
> @@ -1074,6 +1094,9 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
>  
>  	fujitsu_battery_charge_control_remove(device);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       acpi_fujitsu_laptop_notify);
> +
>  	fujitsu_laptop_platform_remove(device);
>  
>  	kfifo_free(&priv->fifo);
> @@ -1092,7 +1115,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
>  	.ids = fujitsu_bl_device_ids,
>  	.ops = {
>  		.add = acpi_fujitsu_bl_add,
> -		.notify = acpi_fujitsu_bl_notify,
> +		.remove = acpi_fujitsu_bl_remove,
>  		},
>  };
>  
> @@ -1108,7 +1131,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
>  	.ops = {
>  		.add = acpi_fujitsu_laptop_add,
>  		.remove = acpi_fujitsu_laptop_remove,
> -		.notify = acpi_fujitsu_laptop_notify,
>  		},
>  };
>  
> 
