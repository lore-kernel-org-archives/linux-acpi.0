From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
Date: Wed, 2 Aug 2017 11:07:36 +0200
Message-ID: <CA+kEDGGe+0HgujKh0766XDVe0vmBKE-vTNep8r6_T7EcATBGmw@mail.gmail.com>
References: <7313224.XbtxUoJtXM@aspire.rjw.lan> <3172146.dPhkKZoKtx@aspire.rjw.lan>
 <CAHp75VfouHVbj0X3PJfRHy2uSziq-P__N5ezbmsuUNYDwDxYKg@mail.gmail.com>
 <CAJZ5v0jimcsL3+BfyfjSxjZRjWVFXunPRDquCp-V1SHi32f+=w@mail.gmail.com>
 <CAHp75Vd-LcCR3k3-LTNYNzh-aomGcqgszFWw7HFb-u1+UJLX3A@mail.gmail.com> <739eedabac12425e8e59f8391da4b607@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <739eedabac12425e8e59f8391da4b607@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: andy.shevchenko@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alex.hung@canonical.com
List-Id: linux-acpi@vger.kernel.org

2017-08-01 19:04 GMT+02:00  <Mario.Limonciello@dell.com>:
>> -----Original Message-----
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Sent: Tuesday, August 1, 2017 7:37 AM
>> To: Rafael J. Wysocki <rafael@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Platform Driver <platform-dri=
ver-
>> x86@vger.kernel.org>; Darren Hart <dvhart@infradead.org>; LKML <linux-
>> kernel@vger.kernel.org>; Linux ACPI <linux-acpi@vger.kernel.org>; Andy
>> Shevchenko <andriy.shevchenko@linux.intel.com>; J=C3=A9r=C3=B4me de Bret=
agne
>> <jerome.debretagne@gmail.com>; Limonciello, Mario
>> <Mario_Limonciello@Dell.com>; Alex Hung <alex.hung@canonical.com>
>> Subject: Re: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275=
 from
>> suspend-to-idle
>>
>> On Tue, Aug 1, 2017 at 2:56 PM, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
>> > On Tue, Aug 1, 2017 at 1:21 AM, Andy Shevchenko
>> > <andy.shevchenko@gmail.com> wrote:
>> >> On Tue, Aug 1, 2017 at 12:46 AM, Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>> >>> On Friday, July 28, 2017 02:06:36 AM Rafael J. Wysocki wrote:
>>
>> >>> Please note that this change is requisite for
>> >>>
>> >>> https://patchwork.kernel.org/patch/9873159/
>> >>>
>> >>> so are there any objections or concerns?
>> >>
>> >> Not from my side,
>> >>
>> >> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >
>> > OK, thanks!
>> >
>> > I'm going to route it through the PM tree then if that's not a problem=
.
>>
>> Mario, are you okay with this change?
>>
>
> Thanks for checking.  I spent a little time this morning trying to walk t=
hrough
> the ASL as attached to the Bugzilla entry and I think this is the correct=
 approach.
>
> Acked-By: Mario Limonciello <mario.limonciello@dell.com>
>
> J=C3=A9r=C3=B4me,
> I have one question though.  These events should be happening as a pair.
> Press: 0xCE, Release: 0xCF.
> What happens with the event on power button release?
> Is that showing a message in the log during wakeup from S2I?
>
> Something like "unknown event 0xCF"?

Mario, I confirm that I can see such release events in the logs:

   intel-hid INT33D5:00: unknown event 0xcf

during wakeup from suspend-to-idle.

> If so, it would be good to also catch and ignore that too.
>
> Thanks,
