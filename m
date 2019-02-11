From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to
 platform_get_irq()
Date: Mon, 11 Feb 2019 16:42:55 +0100
Message-ID: <daea3a4e-8cfb-8878-70ab-679da8432d12@redhat.com>
References: <20190207185917.167829-1-egranata@google.com>
 <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
 <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
 <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
 <20190211103024.GY7875@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211103024.GY7875@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Enrico Granata <egranata@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 11-02-19 11:30, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Feb 07, 2019 at 12:29:17PM -0800, Dmitry Torokhov wrote:
>>>
>>>> Do you have a suggestion as to how to write ACPI tables to avoid the issue?
>>>
>>> 1. Allocate new ID and use it (perhaps not the best path).
>>> 2. Use GPE(s).
>>>
>>
>> Or just solve the issue of intermixing Interrupt() with GpioInt(). We
>> have similar issue with i2c and spi, but we sidestep that there as we
>> only parse the first interrupt and do not give option of fetching 2nd,
>> 3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
>> in platform_get_irq() as well for the first iteration and then see if
>> we need to improve it if we see devices with multiple interrupts.
> 
> I think it should be fine to intermix them or do what you suggest and
> start supporting index 0 for now and then maybe extend it in the future
> to cover more.

I think only support fallback to GpioInt for index 0 for now is probably
the best solution. A device could have both Interrupt and GpioInt resources,
as soon as that is the case then the meaning of index becomes ambiguous.

We are already seeing something similar with mixed use of GpioInt + Gpio
resources on some devices, where we need the GpioInt for the IRQ and
the Gpio resource to toggle something else and the ACPI tables on
different devices have them in a different order, see:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=4d1f7a6eabd45639d9de22a8a004f3c208d13c1a

I suspect that on Windows device drivers specifically specify if they want a
Gpio or a GpioInt; or in this case if they want an Interrupt or a GpioInt.

Regards,

Hans
