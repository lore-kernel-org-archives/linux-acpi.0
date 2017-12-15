From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Fri, 15 Dec 2017 11:10:39 +0200
Message-ID: <6618157d-6866-8926-fa6a-40dc4b217ba4@intel.com>
References: <1512637396-17000-1-git-send-email-adrian.hunter@intel.com>
 <1513261011.7000.75.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36435 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754719AbdLOJLE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 04:11:04 -0500
In-Reply-To: <1513261011.7000.75.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>

On 14/12/17 16:16, Andy Shevchenko wrote:
> On Thu, 2017-12-07 at 11:03 +0200, Adrian Hunter wrote:
>> Some Cherry Trail boards have a dependency between the SDHCI host
>> controller used for SD cards and an external PMIC accessed via I2C.
>> Add a
>> device link between the SDHCI host controller (consumer) and the I2C
>> adapter (supplier).
>>
>> This patch depends on a fix to devices links, namely commit
>> 0ff26c662d5f
>> ("driver core: Fix device link deferred probe"). And also either,
>> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling
>> in
>> probe"), or patch "PM / runtime: Fix handling of suppliers with
>> disabled
>> runtime PM".
>>
> 
> Fine with me, though I think below comment worth to address.
> 
>>  
>> +static const struct x86_cpu_id cht_cpu[] = {
>> +	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry
>> Trail */
>> +	{}
>> +};
> 
> I would rather to modify ICPU() macro to accept driver data where we
> just pass an unsigned long value to be assigned as lpss_quirks and
> introduce another quirk.
> 
>> +
>> +		if (link->cpus && !x86_match_cpu(link->cpus))
>> +			continue;
> 
> ...thus, 
> 
> if (!(lpss_quirks & LPSS_QUIRK_NEED_DEVICE_LINKS))
>  continue;

The intention is to associate the cpu with the link information i.e. that
link is needed on that cpu.  What you are proposing is slightly different.
