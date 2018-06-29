From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: small dmesg regression in kernel 4.17.3
Date: Fri, 29 Jun 2018 13:43:13 +0300
Message-ID: <CAHp75Vcp=uNrQDxGFgPjji4HxEQDR+DGeK5UgtG46ZYiV0Ag5Q@mail.gmail.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de> <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 29, 2018 at 1:13 AM, Schmauss, Erik <erik.schmauss@intel.com> w=
rote:
>> On Tue, Jun 26, 2018 at 8:57 PM, Toralf F=C3=B6rster <toralf.foerster@gm=
x.de>
>> wrote:
>> > The attached dmesg contains non printable chars 0x01 33 around "ACPI
>> > BIOS Error (bug): Could not resolve" which is a new issue compared to
>> > the dmesg of 4.17.2
>> >
>> > System is a stable hardened Gentoo Linux at a ThinkPad T440s.
>>
>> I bet the below commit makes this.
>>
>> commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
>> Author: Erik Schmauss <erik.schmauss@intel.com>
>> Date:   Fri Jun 1 12:06:43 2018 -0700
>>
>>    ACPICA: AML parser: attempt to continue loading table after error
>>
>>
> Hi Andy,
>
>> So, it does add leading '\n' which flushes buffers followed by printing =
the
>> message you see. But, I'm guessing now, kernel adds a default level sinc=
e it's
>> going to dmesg which you can see as unprintable symbols.
>
> What do you mean by a default level?

I can't find fast the better example, though if you look at  printk_get_lev=
el()
https://elixir.bootlin.com/linux/latest/source/include/linux/printk.h#L16

it will shed a light on a format. Thus, 0x01 0x33 means start of the
kernel error message (error is a level).

Kernel messaging protocol is defined in
https://elixir.bootlin.com/linux/latest/source/include/linux/kern_levels.h

This is my understanding on what's going on (I might be mistaken).

--=20
With Best Regards,
Andy Shevchenko
