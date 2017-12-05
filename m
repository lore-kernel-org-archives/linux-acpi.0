From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Add device link for CHT SD card dependency
 on I2C
Date: Tue, 5 Dec 2017 16:05:55 +0100
Message-ID: <CAJZ5v0iGdZZRnkESWRiVAV6abSGpidMGyaiq3=1ZdpMBP-hSUQ@mail.gmail.com>
References: <1512390731-11171-1-git-send-email-adrian.hunter@intel.com>
 <626a88b4-cf71-fd94-d78f-3947bfc5f024@redhat.com> <ea27da62-aa15-24ed-d35f-73ca9a5f40b8@intel.com>
 <2244973.KDCVUlUVYl@aspire.rjw.lan> <e6be8f82-c471-8b18-7011-7da71f9ddb11@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:41846 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdLEPF5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 10:05:57 -0500
In-Reply-To: <e6be8f82-c471-8b18-7011-7da71f9ddb11@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>

On Tue, Dec 5, 2017 at 3:25 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/12/17 17:00, Rafael J. Wysocki wrote:
>> On Monday, December 4, 2017 3:41:45 PM CET Adrian Hunter wrote:
>>> On 04/12/17 16:33, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 04-12-17 15:30, Adrian Hunter wrote:
>>>>> On 04/12/17 15:48, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Wouldn't it be easier to use the ACPI _DEP tracking for this, e.g.
>>>>>
>>>>> It is using _DEP, see acpi_lpss_dep()
>>>>>
>>>>>> add something like this to the the probe function:
>>>>>>
>>>>>>      struct acpi_device = ACPI_COMPANION(device);
>>>>>>
>>>>>>      if (acpi_device->dep_unmet)
>>>>>>          return -EPROBE_DEFER;
>>>>>>
>>>>>> No idea if this will work, but if it does work, using the deps described
>>>>>> in the ACPI tables seems like a better solution then hardcoding this.
>>>>>
>>>>> That would not work because there are other devices listed in the _DEP
>>>>> method so dep_unmet is always true.  So we are left checking _DEP but only
>>>>> for specific device dependencies.
>>>>
>>>> Ugh, understood thank you for explaining this. Perhaps it is a good idea
>>>> to mention in the commit message why acpi_dev->dep_unmet cannot be used
>>>> here?
>>>
>>> dep_unmet predates device links, but now we have device links, they are
>>> better anyway.
>>
>> Right (they cover PM too, for example), but it would be good to note why
>> it is necessary to hardcode the links information in the code.
>
> It isn't entirely necessary to hardcode the links information.  For example,
> another possibility is to create device links for all LPSS devices with _DEP
> methods that point to other LPSS devices i.e. match against
> acpi_lpss_device_ids.  The assumptions would be that all LPSS devices have
> drivers so it would be safe to create links between them, and that the
> nature of the dependency is correctly represented by a device link.
>
> An advantage of that approach would be that it might work for future
> dependencies between LPSS devices without having to add entries to a table.
> The disadvantage would be the possibility that creating a device link
> somehow turns out not to be the right thing to do.

OK

To me, hardcoding is fine for the time being, but I would just add the
above information as a comment to explain the choice made.

Thanks,
Rafael
