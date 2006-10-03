From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Date: Mon, 2 Oct 2006 22:27:09 -0400
Message-ID: <200610022227.10087.dtor@insightbb.com>
References: <20061003011056.GA28731@ecstasy.ring2.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:12417 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1030239AbWJCC1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Oct 2006 22:27:13 -0400
In-Reply-To: <20061003011056.GA28731@ecstasy.ring2.lan>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, s270-linux@mail.0pointer.de

Hi Lennart,

On Monday 02 October 2006 21:10, Lennart Poettering wrote:
> +        
> +        msipf_device = platform_device_register_simple("msi-laptop-pf", -1, NULL, 0);
> +	if (IS_ERR(msipf_device)) {
> +		ret = PTR_ERR(msipf_device);
> +		goto fail_platform_driver;
> +	}
> +

Please do not use platform_device_register_simple, use platform_device_alloc
and platform_device_add instead (_simple will go away some day).

> +        ret = sysfs_create_group(&msipf_device->dev.kobj, &msipf_attribute_group);
> +        if (ret)
> +                goto fail_platform_device;
> +
> +
> +        /* Enable automatic brightness control again */
> +        if (auto_brightness != 2)
> +                set_auto_brightness(1);     
> +

What happens if auto_brightness is 2 but userspace messed up with it
through device's sysfs attribute? Overall brightness controll interface
(module vs. per-device) needs to be tightened up.

-- 
Dmitry
