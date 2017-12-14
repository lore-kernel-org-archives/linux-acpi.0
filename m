From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Thu, 14 Dec 2017 16:16:51 +0200
Message-ID: <1513261011.7000.75.camel@linux.intel.com>
References: <1512637396-17000-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512637396-17000-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2017-12-07 at 11:03 +0200, Adrian Hunter wrote:
> Some Cherry Trail boards have a dependency between the SDHCI host
> controller used for SD cards and an external PMIC accessed via I2C.
> Add a
> device link between the SDHCI host controller (consumer) and the I2C
> adapter (supplier).
> 
> This patch depends on a fix to devices links, namely commit
> 0ff26c662d5f
> ("driver core: Fix device link deferred probe"). And also either,
> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling
> in
> probe"), or patch "PM / runtime: Fix handling of suppliers with
> disabled
> runtime PM".
> 

Fine with me, though I think below comment worth to address.

>  
> +static const struct x86_cpu_id cht_cpu[] = {
> +	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry
> Trail */
> +	{}
> +};

I would rather to modify ICPU() macro to accept driver data where we
just pass an unsigned long value to be assigned as lpss_quirks and
introduce another quirk.

> +
> +		if (link->cpus && !x86_match_cpu(link->cpus))
> +			continue;

...thus, 

if (!(lpss_quirks & LPSS_QUIRK_NEED_DEVICE_LINKS))
 continue;


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
