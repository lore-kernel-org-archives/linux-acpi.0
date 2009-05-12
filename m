From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Tue, 12 May 2009 08:57:39 -0600
Message-ID: <200905120857.40058.bjorn.helgaas@hp.com>
References: <1242106060.3773.216.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:37169 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZELO5l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 10:57:41 -0400
In-Reply-To: <1242106060.3773.216.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday 11 May 2009 11:27:40 pm yakui_zhao wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Skip the power state check in course of power transition by changing the
> default value of acpi_power_nocheck to 1. If so, it is unnecessary to add the
> boot option of "acpi.power_nocheck=1" or add it into DMI power check table to
> skip the power state check.
> 
> Of course the power state check still can be enabled by adding the boot option
> of "acpi.power_nocheck=0".

What is the value of keeping the "acpi.power_nocheck" option at all?

If we can get along without it, it'd be nice to just remove the
whole thing.

Bjorn

> Index: linux-2.6/drivers/acpi/power.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/power.c	2009-04-16 16:10:24.000000000 +0800
> +++ linux-2.6/drivers/acpi/power.c	2009-05-12 13:12:27.000000000 +0800
> @@ -54,7 +54,7 @@
>  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
>  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
>  
> -int acpi_power_nocheck;
> +int acpi_power_nocheck = 1;
>  module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
>  
>  static int acpi_power_add(struct acpi_device *device);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


