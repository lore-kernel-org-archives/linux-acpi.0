From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Fri, 26 Apr 2019 17:44:10 +0200
Message-ID: <63b179c9-242d-ae90-9c33-49ed256bde28@siemens.com>
References: <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <CACRpkdY=m1QJVqvERiAY+7taUgjPXn=9U2Eajx7d7NPo-iNhiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY=m1QJVqvERiAY+7taUgjPXn=9U2Eajx7d7NPo-iNhiA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 26.04.19 16:41, Linus Walleij wrote:
> On Fri, Apr 26, 2019 at 3:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Wed, Apr 24, 2019 at 12:39:35PM +0200, Jan Kiszka wrote:
>>> On 24.04.19 12:33, Mika Westerberg wrote:
>>>> On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
>>
>>>>> And even if that were possible, we would be back to the square of existing
>>>>> devices without those definitions. If this were a recent chipset, I would
>>>>> say, "go, fix future firmware versions". But this one is legacy.
>>>>
>>>> Is it fixing some real issue with these legacy platforms? I mean without
>>>> the patch some GPE event is not handled properly? It was not clear to me
>>>> from the commit message.
>>>>
>>>
>>> Without that patch, you are forced to poll for event changes in your
>>> application, timer-driven. There are application that cannot process these
>>> GPIOs because they lack such logic (mraa with node-red-node-intel-gpio is a
>>> public example).
>>
>> Just a side note: MRAA is a hack itself. It abuses almost all interfaces Linux
>> kernel provides.
> 
> I think it's pretty clean for GPIOs these days. My colleague Manivannan
> was part of cleaning it up a while back and since then it is doing
> what userspace should be doing if userspace absolutely cannot
> abstain from using GPIOs directly (i.e. uses the character device).
> https://github.com/intel-iot-devkit/mraa/blob/master/src/gpio/gpio_chardev.c
> 
> I don't know about other resources than GPIOs though.

That's valuable progress!

OTOH, there still seem to be the broken pattern to address pins via hard-coded 
GPIO numbers. This broke our neck, e.g., when trying to replace the hacky BSP 
kernel with upstream. I started to create better infrastructure but never fished 
that.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
