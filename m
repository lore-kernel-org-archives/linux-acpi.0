From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 12 Feb 2018 23:57:41 +0100
Message-ID: <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion> <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws> <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com> <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de> <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41875 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBLW5m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Feb 2018 17:57:42 -0500
Received: by mail-ot0-f195.google.com with SMTP id r23so15538558ote.8
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2018 14:57:42 -0800 (PST)
In-Reply-To: <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Alex Hung <alex.hung@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, sayli karnik <karniksayli1995@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Feb 12, 2018 at 9:29 PM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J.
>> Wysocki
>> Sent: Monday, February 12, 2018 3:50 AM
>> To: Lukas Wunner <lukas@wunner.de>; Alex Hung <alex.hung@canonical.com>
>> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Rafael J. Wysocki
>> <rafael@kernel.org>; Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
>> Dmitry Torokhov <dmitry.torokhov@gmail.com>; Jean Delvare
>> <jdelvare@suse.de>; Len Brown <lenb@kernel.org>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; David Miller <davem@davemloft.net>; Mika
>> Westerberg <mika.westerberg@linux.intel.com>; Florian Fainelli
>> <f.fainelli@gmail.com>; Kishon Vijay Abraham I <kishon@ti.com>;
>> karniksayli1995@gmail.com; ACPI Devel Maling List <linux-acpi@vger.kernel.org>
>> Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
>>
>> On Sun, Feb 11, 2018 at 2:45 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > On Tue, 2018-02-06 at 00:45 +0000, Mario.Limonciello@dell.com wrote:
>> >> Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
>> >> don't.  It leads to system hangs on the Linux side.
>> >
>> > So I'm on a Mac and thus indifferent to this issue, but I happen
>> > to know a thing or two about hybrid graphics and I'm wondering
>> > what the claim above is supposed to mean.
>> >
>> > RTD3, that's runtime D3, right?  Because nouveau does runtime suspend
>> > to D3cold and has been doing so since 2013.
>> >
>> > The commit message is extremely terse as to what exact problem
>> > the commit is trying to solve, and I haven't seen anything more
>> > specific in this thread other than handwaving. ("waiting on NVIDIA
>> > releasing something Nouveau needs" -- what exactly?)
>> >
>> > So please state clearly what the problem is and why solving it
>> > this way is the best or only solution.
>>
>> If that's not clear, I also would like to see a response to this
>> request before making any decisions here.
>
> It's a lack of proper D3hot support and GC6 support in Nouveau.

Thanks, but that is still a bit enigmatic.

What exactly do you mean by "proper D3hot support", in particular?

> As for why this is the best way to solve it?
> This has been a problem for many generations and Dell has had
> various different heuristics for detecting to turn off RTD3 on NV GPU
> to avoid exercising it.
>
> The patches submitted reflect a sustainable way to resolve the
> problem rather than the OEM and Linux kernel playing hide and seek
> to make the hardware work well in the general purpose scenario.

Well, I have some reservations.

While the idea of using _OSI to let the platform firmware find out
what the kernel can do is generally fine by me, the implementation
here isn't really.

In the first place, the _OSI "feature" has to be defined clearly and
in such a way that the kernel can say right away whether or not it is
"supported".  That doesn't seem to be the case here.

Second (and what follows from the above), the kernel should not need
any quirks on its side at all to give an answer.  It should be able to
say "yes" or "no" regardless of the platform it runs on if the
firmware asks the question.

So something like "Do you support native PCI power management?" would
be fine, because native PCI power management is defined by the PCI
standard and it should be clear what supporting it means and it
doesn't depend on what platform the kernel runs on.

Thanks,
Rafael
