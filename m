From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] drivers/platform/x86: Add driver for INT0002 ACPI device
Date: Fri, 21 Apr 2017 12:02:20 +0300
Message-ID: <CAHp75Vd0SCJuFtPPV1KPu5+r8UtY2hXS=HTVF6QT6ZAr4EgZBw@mail.gmail.com>
References: <20170421074157.19159-1-hdegoede@redhat.com> <s5hfuh2mayi.wl-tiwai@suse.de>
 <CAHp75Vd=ZgXe9rWHC8U5HANtDso7kqv-WN7R2L5Bt5c7r==dSw@mail.gmail.com> <s5hd1c6m9z4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <s5hd1c6m9z4.wl-tiwai@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 21, 2017 at 11:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 21 Apr 2017 10:27:32 +0200,
> Andy Shevchenko wrote:
>> On Fri, Apr 21, 2017 at 11:17 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Fri, 21 Apr 2017 09:41:57 +0200,
>> > Hans de Goede wrote:

>> >> +     char ev_name[5];
>> >
>> > Are 5 bytes enough?  I see the code below:
>> >
>> >> +             snprintf(data->ev_name, sizeof(data->ev_name), "_%c%02X",
>> >> +                     res->data.gpio.triggering ? 'E' : 'L',
>> >> +                     res->data.gpio.pin_table[0]);
>> >
>> > So it counts 6 including NUL.
>>
>> How? 4 + NUL = 5.
>
> Well, "_E00X" is 5 letters, IIUC.

Well, today is Friday, yes.
But %02X means two capitalized hex characters.

>> >> +static int int0002_runtime_resume(struct device *dev)
>> >> +{
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static const struct dev_pm_ops int0002_pm_ops = {
>> >> +     .runtime_suspend = int0002_runtime_suspend,
>> >> +     .runtime_resume = int0002_runtime_resume,
>> >> +};
>> >
>> > Do we need these runtime PM?  If not, we can remove the header
>> > inclusion, too.
>>
>> Yeah, and it needs attention when built with !CONFIG_PM.
>
> Practically seen, we may build this only with CONFIG_PM, too.
> The virtual GPIO thing happens only when the machine gets resumed.

Perhaps depend on PM then?


-- 
With Best Regards,
Andy Shevchenko
