From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] 4.17 failed to probe ACPI PnP
Date: Wed, 20 Jun 2018 09:28:40 +0200
Message-ID: <CAJZ5v0gWRfbtKG0w1UiM=KbtZYkhL2kj-W_9Q+PUP293sX35_Q@mail.gmail.com>
References: <s5h8t7bfgnq.wl-tiwai@suse.de> <CAJZ5v0hidPav5kvTW05e0k5mouFyiUiyUW50=fDqVphbEBjQaA@mail.gmail.com>
 <s5hpo0ndvc5.wl-tiwai@suse.de> <s5hy3fac6ao.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy3fac6ao.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Noah Davis <noahadvs@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 20, 2018 at 8:37 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 19 Jun 2018 10:38:50 +0200,
> Takashi Iwai wrote:
>>
>> On Tue, 19 Jun 2018 10:28:42 +0200,
>> Rafael J. Wysocki wrote:
>> >
>> > On Tue, Jun 19, 2018 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > Hi,
>> > >
>> > > there seems a regression regarding the probe of ACPI PnP devices.
>> > > The detailed logs are found in openSUSE bugzilla:
>> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1098074
>> >
>> > But that's on this particular machine, not in general, right?
>> >
>> > At least I don't see this on any of the systems in my office.
>>
>> Yes, it looks so.  4.17 and later works on my several machines, too.
>>
>> >
>> > > In short, since 4.17, the laptop keyboard is lost on ASUS K501UW.
>> > > Comparing the kernel messages and other logs indicates that the
>> > > complete lost of ACPI PnP devices:
>> > >
>> > > On 4.16:
>> > > [    0.390244] pnp: PnP ACPI: found 9 devices
>> > >
>> > > On 4.17:
>> > > [    0.263266] pnp: PnP ACPI: found 0 devices
>> > >
>> > > ... and this leads to the failure of PS/2 keyboard detection due to
>> > > the missing PNP030b entry as a result.
>> > >
>> > > Any hints for debugging this are appreciated.
>> >
>> > It looks like this may be related to the ACPICA changes that went in
>> > during the 4.17 cycle.
>> >
>> > I would try 4.18-rc1 as there is an ACPICA fix in it that may be
>> > related to this in theory.  If that doesn't help, I'd focus on the
>> > ACPICA changes.
>>
>> OK, Noah, could you test later the kernel in OBS Kernel:HEAD repo?
>> Now 4.18-rc1 kernel is being built there, and hopefully will finish
>> soon later.
>
> 4.18-rc1 was confirmed to work, so something had fixed it.

Please check this commit

5088814a6e93 ACPICA: AML parser: attempt to continue loading table after error

None of the other ACPICA commits that have gone in since 4.17 should
affect the behavior at hand.

> Also, the symptom appears not only on a single machine but on another
> (ASUS?) machine, according to the bug report.

OK

Thanks,
Rafael
