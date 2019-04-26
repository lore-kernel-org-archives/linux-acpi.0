From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Fri, 26 Apr 2019 19:37:35 +0200
Message-ID: <bbc81e4d-7a3c-ef1e-e89b-739bc262f6db@siemens.com>
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
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 26.04.19 19:20, Andy Shevchenko wrote:
> On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
>>> On 26.04.19 15:36, Jan Kiszka wrote:
>>>
>>>> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
>>> switch> the engine.
>>> Which value exactly does that collection of crude wrappers and broken
>>> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
>>> provide ?
>>
>> Leaving that blunt hack aside:
>>
>> import mraa
>>
>> pin = mraa.Gpio(13)
>> pin.dir(mraa.DIR_OUT)
>> pin.write(1)
>>
>> And the same goes for nodejs, java and c++.
>>
>> Moreover, this allows you to abstract away where "Pin 13" actually came from on
>> that board if the kernel changes (BSP -> upstream...) or the extension board or
>> ...
> 
> The problem here is opaque number. This has to be chip + *relative* pin number/
> See this:
> https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> 

...and device path based discovery of the base:

https://github.com/siemens/mraa/commits/jan/queue

And I think that makes good use cases for application-level abstractions like in 
mraa. You don't want all user having to learn those nasty details, for 
devicetree, ACPI, and even worse stuff.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
