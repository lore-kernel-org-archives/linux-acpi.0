From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
Date: Tue, 1 Aug 2017 15:37:21 +0300
Message-ID: <CAHp75Vd-LcCR3k3-LTNYNzh-aomGcqgszFWw7HFb-u1+UJLX3A@mail.gmail.com>
References: <7313224.XbtxUoJtXM@aspire.rjw.lan> <3172146.dPhkKZoKtx@aspire.rjw.lan>
 <CAHp75VfouHVbj0X3PJfRHy2uSziq-P__N5ezbmsuUNYDwDxYKg@mail.gmail.com> <CAJZ5v0jimcsL3+BfyfjSxjZRjWVFXunPRDquCp-V1SHi32f+=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jimcsL3+BfyfjSxjZRjWVFXunPRDquCp-V1SHi32f+=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 1, 2017 at 2:56 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Aug 1, 2017 at 1:21 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Aug 1, 2017 at 12:46 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Friday, July 28, 2017 02:06:36 AM Rafael J. Wysocki wrote:

>>> Please note that this change is requisite for
>>>
>>> https://patchwork.kernel.org/patch/9873159/
>>>
>>> so are there any objections or concerns?
>>
>> Not from my side,
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> OK, thanks!
>
> I'm going to route it through the PM tree then if that's not a problem.

Mario, are you okay with this change?

-- 
With Best Regards,
Andy Shevchenko
