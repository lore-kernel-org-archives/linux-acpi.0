From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_cht_int33fe: Work around BIOS bug on
 some devices
Date: Fri, 1 Sep 2017 09:25:27 +0300
Message-ID: <3a1c95bb-f8a2-f31b-3e45-14718e530dd0@linux.intel.com>
References: <20170814201425.20991-1-hdegoede@redhat.com>
 <CAHp75Vdityzx+fzU_q0vULGpT3ww8C0_D0fYtEW77Hyh1yTX6A@mail.gmail.com>
 <06a1d48c-9f75-4aab-107d-f71ce8ebbb26@redhat.com>
 <CAHp75Vdz3S5a=Vqf=rnMV9Dy+829MGNUWPmzp+B08NadBM0wNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:48535 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdIAGZd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Sep 2017 02:25:33 -0400
In-Reply-To: <CAHp75Vdz3S5a=Vqf=rnMV9Dy+829MGNUWPmzp+B08NadBM0wNg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 08/31/2017 07:04 PM, Andy Shevchenko wrote:
> On Mon, Aug 14, 2017 at 11:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 14-08-17 22:45, Andy Shevchenko wrote:
>>> On Mon, Aug 14, 2017 at 11:14 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
> 
>>>> +int cht_int33fe_check_for_max17047(struct device *dev, void *data)
>>>> +{
>>>> +       const char *name = dev_name(dev);
>>>> +       struct i2c_client **max17047 = data;
>>>> +
>>>> +       if (name && strcmp(name, "i2c-MAX17047:00") == 0) {
>>>
>>>
>>> Can we stop using bad practice of comparing against _instance_?
>>> If device is suppose to be single in the system, wouldn't _HID be enough?
> 
>> Yes _HID would be enough, but that takes some extra code with little
>> gain IMHO, we are effectively checking the HID here as that is where
>> the device-name comes from.
>>
>> Anyways if you strongly prefer a HID check I can do a v2 doing that
>> either way let me know.
> 
> Currently we have the following modules where ACPI instance is used in:
> 
> drivers/acpi/acpi_lpss.c
> drivers/input/touchscreen/goodix.c
> drivers/platform/x86/silead_dmi.c
> drivers/power/supply/axp288_charger.c
> 
> and plenty under sound/soc/intel.
> 
> I do not care right now about sound/soc/intel stuff, while everywhere
> else would be better to avoid this.
> 
My 2 cents: sound subsystem needs to match exactly against instance 
since we (must) know how each component are wired in HW. For instance 
nothing prevents to have multiple audio codec chips with the same HID.

There are couple examples under sound/soc/intel where system have 
multiple codecs with the same HID.

(I don't know do we have yet a better way in ACPI to describe audio HW 
than matching know instances and tying them together with a code).

-- 
Jarkko
