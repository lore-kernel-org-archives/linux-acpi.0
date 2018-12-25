From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Date: Tue, 25 Dec 2018 16:33:43 +0300
Message-ID: <CAK9iUCMUELeXMaqnXWxGKaEKX6OkfpWxvSxWiGjuNpvxneCk0g@mail.gmail.com>
References: <20181222001452.7474-1-okaya@kernel.org> <20181222001452.7474-7-okaya@kernel.org>
 <20181222080317.qicyihyauia6n63w@wunner.de> <CAHp75VfTmWN4bTNPaTL2KYYUWARvix67ynx2cKGzhO3o-0VY=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfTmWN4bTNPaTL2KYYUWARvix67ynx2cKGzhO3o-0VY=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 24, 2018 at 5:05 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, December 22, 2018, Lukas Wunner <lukas@wunner.de> wrote:
>>
>> On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
>> > Code is scanning PCI bus to find out if it is switchable or not. If
>> > CONFIG_PCI is not set, assume unswitchable.
>> >
>>
>> You can also drop the "platform/x86: " prefix from the subject if you
>> like, all previous commits to this driver just use "apple-gmux: ".
>>
>> If you are okay with these changes, feel free to add my Reviewed-by
>> when respinning.
>>
> I'm not okay with dropping prefix. You can but may not, please, remove the prefix.
>

You mean 'keep the prefix' above, right?

What is the consensus?

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
