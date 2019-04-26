From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Fri, 26 Apr 2019 19:39:56 +0200
Message-ID: <534a4812-e6d3-9b16-5142-ab214da3d661@siemens.com>
References: <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426173329.GA31161@Mani-XPS-13-9360>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 26.04.19 19:33, Manivannan Sadhasivam wrote:
> On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
>> On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
>>>> On 26.04.19 15:36, Jan Kiszka wrote:
>>>>
>>>>> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
>>>> switch> the engine.
>>>> Which value exactly does that collection of crude wrappers and broken
>>>> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
>>>> provide ?
>>>
>>> Leaving that blunt hack aside:
>>>
>>> import mraa
>>>
>>> pin = mraa.Gpio(13)
>>> pin.dir(mraa.DIR_OUT)
>>> pin.write(1)
>>>
>>> And the same goes for nodejs, java and c++.
>>>
>>> Moreover, this allows you to abstract away where "Pin 13" actually came from on
>>> that board if the kernel changes (BSP -> upstream...) or the extension board or
>>> ...
>>
>> The problem here is opaque number. This has to be chip + *relative* pin number/
>> See this:
>> https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
>>
> 
> But for platform like 96Boards we don't need controller specific lookup, these
> are all handled by the platform code [1] so that the users can use the standard
> pinout number to access GPIOs. For instance, pin 23 on the Low Speed expansion
> header is the GPIO for all 96Boards platform, so the user can access that pin
> using 23 itself in the application and it will run across all supported
> 96Boards.

Can you ensure stable numbering when probing order changes, e.g. due to adding 
an extension board?

Jan

> 
> That's one of the reason why we prefer MRAA.
> 
> Thanks,
> Mani
> 
> [1] https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L75
> 
>> -- 
>> With Best Regards,
>> Andy Shevchenko

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
