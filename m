Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5A3BFE2D;
	Mon,  9 Mar 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061247; cv=none; b=TgJN1KgELTjVHnp4TXbwZlqAqa2zLDmQS0qrmsmeQ6pYLUs14NpdFqyaF5uGpiLPQUqI0Xa5WvMonOn1kpD+sHXZsdmjTBHQnt09ECuzQ/eaW8dqIP8d6jDVXN/9fcXZtT0IULO0OPB5+A8jU5KE9wX8udIzhIcl2aL8wp2i+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061247; c=relaxed/simple;
	bh=3TFIg0zT3ccHV8X+i3qqa/mt9RHjDBBEaeiJCi7h77I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NUtE0dFLqYUcrNr2n4e5DY80ardVA5SUjsrkbyRGxFz/o/GOziBujGx5Ny7tb3co52V5ztoOqsy9qcb9KUN83CJXDOQdMGsFNp4oVdnZ5vbLdTq5/ZUSEPWAM1MuOi6Q8hYrNzazG/Rkadsn4gL5gNz3HsavP10auu/Ft2dGY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW/thMRK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW/thMRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773061238; x=1804597238;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3TFIg0zT3ccHV8X+i3qqa/mt9RHjDBBEaeiJCi7h77I=;
  b=CW/thMRK44+/jXYUih3eL/6NMzICnoEHCSQxmksCDzob0Zu4QzoTUsbY
   /wtNfJ8VJTAMk+6L5AEOuBToD+NTdALYgEtq5wW2jMyC/nRIoTbIK58v1
   ddJuDxsJY1PgVKiIcX8HS8qCZpK/X+Ww7pseAEhVnX3vuv/omQ+MwQJtE
   FvDzuzVb1FtJqjH6TjJYahKZC19giGwuy/6xjSR46Yf+8IJEMStJAz4yv
   qvBblFEtXzXhXta990KyDxPVdeXzdtHEUJepvKfzfyLRuFA4eOGR0cvEs
   rVmT2/qGuha4sl02ggg1ACARvEdj5ml5Q3JlqqhWnN86yXtBI3QbOtHvt
   w==;
X-CSE-ConnectionGUID: R5HCWKTqRGOiV+5IATf9Eg==
X-CSE-MsgGUID: uUeGgaEcQse33qFurfYU7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="99553422"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="99553422"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 06:00:37 -0700
X-CSE-ConnectionGUID: BvK2j17KQn67v1X8CBGrOg==
X-CSE-MsgGUID: NFNbAvXQQ4WOkDRqyxN2aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219727916"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 06:00:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 15:00:31 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH v1 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
In-Reply-To: <10828467.nUPlyArG6x@rafael.j.wysocki>
Message-ID: <b645ebf3-6389-7255-db1c-a0322546b6dd@linux.intel.com>
References: <1968442.tdWV9SEqCh@rafael.j.wysocki> <10828467.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Feb 2026, Rafael J. Wysocki wrote:

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
>  drivers/platform/x86/fujitsu-laptop.c | 30 ++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 1adce90ae3e6..cb13c06b8f35 100644
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
> @@ -1056,6 +1069,11 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	if (ret)
>  		goto err_free_fifo;
>  
> +	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +					      acpi_fujitsu_laptop_notify, device);
> +	if (ret)
> +		goto err_free_fifo;

Hi Rafael,

Is the rollback path still correct after adding this here?

-- 
 i.

> +
>  	ret = fujitsu_battery_charge_control_add(device);
>  	if (ret < 0)
>  		pr_warn("Unable to register battery charge control: %d\n", ret);
> @@ -1074,6 +1092,9 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
>  
>  	fujitsu_battery_charge_control_remove(device);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       acpi_fujitsu_laptop_notify);
> +
>  	fujitsu_laptop_platform_remove(device);
>  
>  	kfifo_free(&priv->fifo);
> @@ -1092,7 +1113,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
>  	.ids = fujitsu_bl_device_ids,
>  	.ops = {
>  		.add = acpi_fujitsu_bl_add,
> -		.notify = acpi_fujitsu_bl_notify,
> +		.remove = acpi_fujitsu_bl_remove,
>  		},
>  };
>  
> @@ -1108,7 +1129,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
>  	.ops = {
>  		.add = acpi_fujitsu_laptop_add,
>  		.remove = acpi_fujitsu_laptop_remove,
> -		.notify = acpi_fujitsu_laptop_notify,
>  		},
>  };
>  
> 
