From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / PMIC: xpower: Add support for the GPI1
 regulator to the OpRegion handler
Date: Fri, 21 Apr 2017 12:30:46 +0300
Message-ID: <1492767046.24567.113.camel@linux.intel.com>
References: <20170421073433.10897-1-hdegoede@redhat.com>
         <20170421073433.10897-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28619 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037294AbdDUJcU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 05:32:20 -0400
In-Reply-To: <20170421073433.10897-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org

On Fri, 2017-04-21 at 09:34 +0200, Hans de Goede wrote:
> Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
> their 0x8d power OpRegion, add support for this.
> 
> This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
> fixes these errors causing these devices to not suspend.

>  	int data;
>  
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == 0x92) {
> +		if (on)
> +			data = 0x03;
> +		else
> +			data = 0x04;
> +
> +		return regmap_update_bits(regmap, reg, 0x07, data);
> +	}

I would go with

if (reg == 0x92)
 return regmap_update_bits(regmap, reg, 0x07, on ? 0x03 : 0x04);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
