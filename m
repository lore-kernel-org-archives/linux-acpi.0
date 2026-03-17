Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921837CD49;
	Tue, 17 Mar 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769722; cv=none; b=At50P3KhomKlfgfRDuuZgoru9RkEiaA+PvRBlZ+eimk3B9q9UDLoiIbThO16v3WOmrhGqPFYUMZD3VJoTOT1nXkQet6JPIWPDzjMAce4AJ8gxmvkKRtJDIH+k2hBpO/j5wxyrs3s9P0Ybx1vr+a/sfpH/+eFMW8eDKnPuq/ktbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769722; c=relaxed/simple;
	bh=bWhpstERNSmZdHWN0B03khElzRfyJt72GD8Wo2EgV4o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pSzvndHNa1R+qMBzG2/+ibxjoZee7Qs4Z7e470T4EPA3lZdGFFB3fc+KkXbc5Yfny5X4qDPMOE24h2fsBnoM3HkOQ8IWiBKIiFcnVTbOkFolZSOfQzpSG+h/0cTaw7DLhIiNi4z6pLii4ITsnkDcnwXDpaYj9AcZV3ehfcC4DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm85+QZ7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm85+QZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773769719; x=1805305719;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bWhpstERNSmZdHWN0B03khElzRfyJt72GD8Wo2EgV4o=;
  b=Xm85+QZ7VKRrP26pbAMk/A93kskj5qeFe6Uyv5wb78gF677qkJEXtzS6
   WUVgtWDFgrASq1BTz+luRR60oawaZYdK+ZcaaMHqhIEAneSBQOE91IyVm
   H6KXPsGmNDC0uRkGrmUAOhahFqtm8ay1DDSJmsw8XpfrCzU6koXSbjqN1
   Fl+2/vdYkN6Yps8CrJLR9/ziHkRXjHxMrHDobs+GJLsYLoAxjGEcSPmec
   UJtxFEgeenxhUzE420OT6GdmKMmoo4tmL4nr/xfXUXDBonk6gJmQx3OMh
   H+utTyQ6xSlFThTB/VfclmMrZnYPhdcQQ3CIrtrWeDtCwGNXPzNTja5X4
   g==;
X-CSE-ConnectionGUID: wtNL6EuWTxmvIF1B/3Swdg==
X-CSE-MsgGUID: zux6smyXSiKwwt54imZ1EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85441055"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85441055"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:48:38 -0700
X-CSE-ConnectionGUID: Vyq1c9R0TYCAfzev6RHYvA==
X-CSE-MsgGUID: Iyu8dnD3Qb+9mMvOzkoTRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221580685"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:48:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 19:48:31 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jeremy Soller <jeremy@system76.com>, 
    System76 Product Development <productdev@system76.com>
Subject: Re: [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to
 a platform one
In-Reply-To: <1968431.tdWV9SEqCh@rafael.j.wysocki>
Message-ID: <e8b58f60-2741-c259-9882-78a9d3c8f50b@linux.intel.com>
References: <2841136.mvXUDI8C0e@rafael.j.wysocki> <1968431.tdWV9SEqCh@rafael.j.wysocki>
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
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the System76 ACPI driver to a platform one.
> 
> After this change, the subordinate hwmon, input and LED class devices
> will be registered under the platform device used for driver binding
> instead of its ACPI companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/system76_acpi.c | 52 +++++++++++++++-------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index 35e294a55fa3..b3a4254156ae 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/pci_ids.h>
> +#include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> @@ -670,16 +671,19 @@ static void system76_notify(acpi_handle handle, u32 event, void *context)
>  	}
>  }
>  
> -// Add a System76 ACPI device
> -static int system76_add(struct acpi_device *acpi_dev)
> +// Probe a System76 platform device
> +static int system76_probe(struct platform_device *pdev)
>  {
> +	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
>  	struct system76_data *data;
>  	int err;
>  
> -	data = devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> -	acpi_dev->driver_data = data;
> +
> +	platform_set_drvdata(pdev, data);
> +
>  	data->acpi_dev = acpi_dev;
>  
>  	// Some models do not run open EC firmware. Check for an ACPI method
> @@ -695,7 +699,7 @@ static int system76_add(struct acpi_device *acpi_dev)
>  	data->ap_led.brightness_set_blocking = ap_led_set;
>  	data->ap_led.max_brightness = 1;
>  	data->ap_led.default_trigger = "rfkill-none";
> -	err = devm_led_classdev_register(&acpi_dev->dev, &data->ap_led);
> +	err = devm_led_classdev_register(&pdev->dev, &data->ap_led);
>  	if (err)
>  		return err;
>  
> @@ -739,19 +743,19 @@ static int system76_add(struct acpi_device *acpi_dev)
>  	}
>  
>  	if (data->kbled_type != KBLED_NONE) {
> -		err = devm_led_classdev_register(&acpi_dev->dev, &data->kb_led);
> +		err = devm_led_classdev_register(&pdev->dev, &data->kb_led);
>  		if (err)
>  			return err;
>  	}
>  
> -	data->input = devm_input_allocate_device(&acpi_dev->dev);
> +	data->input = devm_input_allocate_device(&pdev->dev);
>  	if (!data->input)
>  		return -ENOMEM;
>  
>  	data->input->name = "System76 ACPI Hotkeys";
>  	data->input->phys = "system76_acpi/input0";
>  	data->input->id.bustype = BUS_HOST;
> -	data->input->dev.parent = &acpi_dev->dev;
> +	data->input->dev.parent = &pdev->dev;
>  	input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
>  
>  	err = input_register_device(data->input);
> @@ -767,7 +771,7 @@ static int system76_add(struct acpi_device *acpi_dev)
>  		if (err)
>  			goto error;
>  
> -		data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
> +		data->therm = devm_hwmon_device_register_with_info(&pdev->dev,
>  			"system76_acpi", data, &thermal_chip_info, NULL);
>  		err = PTR_ERR_OR_ZERO(data->therm);
>  		if (err)
> @@ -795,14 +799,13 @@ static int system76_add(struct acpi_device *acpi_dev)
>  	return err;
>  }
>  
> -// Remove a System76 ACPI device
> -static void system76_remove(struct acpi_device *acpi_dev)
> +// Remove a System76 platform device
> +static void system76_remove(struct platform_device *pdev)
>  {
> -	struct system76_data *data;
> -
> -	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
> +	struct system76_data *data = platform_get_drvdata(pdev);
>  
> -	data = acpi_driver_data(acpi_dev);
> +	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
> +				       ACPI_DEVICE_NOTIFY, system76_notify);
>  
>  	if (data->has_open_ec) {
>  		system76_battery_exit();
> @@ -810,22 +813,21 @@ static void system76_remove(struct acpi_device *acpi_dev)
>  		kfree(data->ntmp);
>  	}
>  
> -	devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
> -	devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
> +	devm_led_classdev_unregister(&pdev->dev, &data->ap_led);
> +	devm_led_classdev_unregister(&pdev->dev, &data->kb_led);

With devm_* being used, why are these needed?

>  	system76_get(data, "FINI");
>  }
>  
> -static struct acpi_driver system76_driver = {
> -	.name = "System76 ACPI Driver",
> -	.class = "hotkey",
> -	.ids = device_ids,
> -	.ops = {
> -		.add = system76_add,
> -		.remove = system76_remove,
> +static struct platform_driver system76_driver = {
> +	.probe = system76_probe,
> +	.remove = system76_remove,
> +	.driver = {
> +		.name = "System76 ACPI Driver",
> +		.acpi_match_table = device_ids,
>  	},
>  };
> -module_acpi_driver(system76_driver);
> +module_platform_driver(system76_driver);
>  
>  MODULE_DESCRIPTION("System76 ACPI Driver");
>  MODULE_AUTHOR("Jeremy Soller <jeremy@system76.com>");
> 

-- 
 i.

