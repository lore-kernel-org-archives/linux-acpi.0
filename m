From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: intel_cht_int33fe: Work around BIOS bug on
 some devices
Date: Thu, 31 Aug 2017 19:04:46 +0300
Message-ID: <CAHp75Vdz3S5a=Vqf=rnMV9Dy+829MGNUWPmzp+B08NadBM0wNg@mail.gmail.com>
References: <20170814201425.20991-1-hdegoede@redhat.com> <CAHp75Vdityzx+fzU_q0vULGpT3ww8C0_D0fYtEW77Hyh1yTX6A@mail.gmail.com>
 <06a1d48c-9f75-4aab-107d-f71ce8ebbb26@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06a1d48c-9f75-4aab-107d-f71ce8ebbb26@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 14, 2017 at 11:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 14-08-17 22:45, Andy Shevchenko wrote:
>> On Mon, Aug 14, 2017 at 11:14 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:

>>> +int cht_int33fe_check_for_max17047(struct device *dev, void *data)
>>> +{
>>> +       const char *name = dev_name(dev);
>>> +       struct i2c_client **max17047 = data;
>>> +
>>> +       if (name && strcmp(name, "i2c-MAX17047:00") == 0) {
>>
>>
>> Can we stop using bad practice of comparing against _instance_?
>> If device is suppose to be single in the system, wouldn't _HID be enough?

> Yes _HID would be enough, but that takes some extra code with little
> gain IMHO, we are effectively checking the HID here as that is where
> the device-name comes from.
>
> Anyways if you strongly prefer a HID check I can do a v2 doing that
> either way let me know.

Currently we have the following modules where ACPI instance is used in:

drivers/acpi/acpi_lpss.c
drivers/input/touchscreen/goodix.c
drivers/platform/x86/silead_dmi.c
drivers/power/supply/axp288_charger.c

and plenty under sound/soc/intel.

I do not care right now about sound/soc/intel stuff, while everywhere
else would be better to avoid this.

Mika, Rafael, what're yours opinions regarding to use ACPI instances
in the drivers?

For me it sounds fragile.

-- 
With Best Regards,
Andy Shevchenko
