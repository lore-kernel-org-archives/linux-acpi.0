From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Fri, 15 Dec 2017 01:58:28 +0100
Message-ID: <CAJZ5v0hLBODV4Tfh-TMa6Psh16Bbs_d9x51xjrweGGHAPpqqqQ@mail.gmail.com>
References: <1512637396-17000-1-git-send-email-adrian.hunter@intel.com> <1513261011.7000.75.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36433 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbdLOA63 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Dec 2017 19:58:29 -0500
In-Reply-To: <1513261011.7000.75.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>

On Thu, Dec 14, 2017 at 3:16 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
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
>> +     ICPU(INTEL_FAM6_ATOM_AIRMONT),  /* Braswell, Cherry
>> Trail */
>> +     {}
>> +};
>
> I would rather to modify ICPU() macro to accept driver data where we
> just pass an unsigned long value to be assigned as lpss_quirks and
> introduce another quirk.

Not really.

There are many instances of ICPU() already in the tree and updating
all of them is just not worth it.

If you can make the code cleaner without modifying that macro, go for it.

Thanks,
Rafael
