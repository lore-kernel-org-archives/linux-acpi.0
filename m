From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: Do pinswitch magic when reading
 GPADC
Date: Sat, 08 Jul 2017 16:58:03 +0300
Message-ID: <1499522283.22624.309.camel@linux.intel.com>
References: <20170708134008.13930-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22607 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdGHODi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 8 Jul 2017 10:03:38 -0400
In-Reply-To: <20170708134008.13930-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 2017-07-08 at 15:40 +0200, Hans de Goede wrote:
> Testing has shown that the TS-pin's bias-current needs to be disabled
> when reading the GPIO0 pin in GPADC mode.
> 
> It seems that there is only 1 bias current source and to be able to
> use it
> for the GPIO0 pin in GPADC mode it must be temporarily turned off for
> the
> TS pin, but the datasheet does not mention this.
> 
> This commit adds the necessary writes to turn the TS pin BIAS current
> off before and back on after reading the GPADC. This fixes the GPADC
> always returning a reading of 0.
> 
> 

> +	/* After switching to the GPADC pin give things some time to
> settle */
> +	usleep_range(6000, 10000);

msleep(6); ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
