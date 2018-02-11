From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Sun, 11 Feb 2018 10:29:18 +0100
Message-ID: <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion> <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws> <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37718 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJ3U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Feb 2018 04:29:20 -0500
Received: by mail-ot0-f196.google.com with SMTP id e64so11542706ote.4
        for <linux-acpi@vger.kernel.org>; Sun, 11 Feb 2018 01:29:19 -0800 (PST)
In-Reply-To: <1517924731.22495.51.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Jean Delvare <jdelvare@suse.de>, Alex Hung <alex.hung@canonical.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, karniksayli1995@gmail.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Feb 6, 2018 at 2:45 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2018-02-06 at 00:45 +0000, Mario.Limonciello@dell.com wrote:
>
>> > > > Playing with OSI string is a bad idea. I wouldn't do anything
>> > > > while
>> > > > Rafael, or even Len can confirm that is the right thing to do.
>> > > >
>> > > > For me, AFAIK we need to be bug-to-bug compatible with Windows
>> > > > (at least
>> > > > on ACPICA side), so, what Windows exactly does on such laptops?
>> > > >
>> > >
>> > > The issue that's being worked around isn't an ACPICA interpreter
>> > > issue, but it's
>> > > a graphics device configuration issue.
>
> Then clearly nothing to do with OSI strings here, right?
>
>> > > Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
>> > > don't.  It leads to system hangs on the Linux side.
>> >
>> > Can we adjust Linux drivers to do the right thing?
>
> +100

IMO you should only say so if *you* are willing to do the work and
have all of the requisite means for that.

>> >  Or is it regarding
>> > the binary NVIDIA blob?
>
> nVidia vs. Linux again? :-)
>
>>
>> Neither Nouveau nor the NVIDIA blob have support for RTD3.
>>
>> Last I heard it's waiting on NVIDIA releasing something Nouveau
>> needs.  So.. Eventually?  For now it's better to not hang though.
>
> Hmm... While you are talking sense, the patch itself looks like an ugly
> hack.
>
>> That's part of why we wanted to enable this via a transient OSI
>> string,
>> to let this be removed by Linux whenever the driver does grow support.
>
> So, means "never" then? (Assume a bit of irony here)
>
> I don't know how it feels for maintainers, for me it's quite unlikely to
> go (at least in this shape).
>
> I'm sorry I can't be much constructive here, I heard Len once about OSI
> huge abuse by almost every party. I would rather let him speak on the
> matter.

One thing is the merit and another thing is the patch itself.

On the merit side, with all due respect, this isn't about fixing the
drivers in question.  They aren't broken.

RTD3 (or generally runtime PM) support in Linux has been regarded as
optional so far and it is not even realistic to change this policy
ATM.  The lack of it is a matter of energy-efficiency, but not a
matter of basic correctness, as far as Linux is concerned.

If some platform firmware doesn't work correctly with an OS that
doesn't do RTD3 all over and crashes when Linux runs on it for this
reason, than that platform is simply not compatible with Linux as it
stands.

Granted, we can say "Too bad, Linux is not going to run on this
platform any time soon" (but frankly I don't see how that would
benefit anyone) or we can make the kernel give a little hint to the
platform firmware to make it behave in a Linux-compatible way.

So if we can agree that this has merit (and I personally think that it
does), let's try to make the implementation cleaner, if possible.

Thanks,
Rafael
