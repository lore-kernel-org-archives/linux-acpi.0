From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Tue, 13 Feb 2018 10:18:01 +0100
Message-ID: <CAJZ5v0jCRXs9wCBb-kE-0HVJPCSMRZFgY8hF5Mn+kFLYhdp4=A@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion> <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws> <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com> <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de> <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com> <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:43874 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933866AbeBMJSC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2018 04:18:02 -0500
Received: by mail-ot0-f176.google.com with SMTP id q12so16683725otg.10
        for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2018 01:18:02 -0800 (PST)
In-Reply-To: <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Alex Hung <alex.hung@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, sayli karnik <karniksayli1995@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Feb 13, 2018 at 12:14 AM,  <Mario.Limonciello@dell.com> wrote:
>> >> request before making any decisions here.
>> >
>> > It's a lack of proper D3hot support and GC6 support in Nouveau.
>>
>> Thanks, but that is still a bit enigmatic.
>>
>> What exactly do you mean by "proper D3hot support", in particular?
>>
>
> I don't believe Nouveau or NVIDIA has support for D3hot at all from
> what I've heard.  I've not dug further into this.

But Lukas is saying that Nouveau actually supports runtime PM, so I'm
not sure what exactly the problem is with respect to this particular
driver.

> Maybe Canonical guys will have some more detail.

OK

>> Well, I have some reservations.
>>
>> While the idea of using _OSI to let the platform firmware find out
>> what the kernel can do is generally fine by me, the implementation
>> here isn't really.
>>
>> In the first place, the _OSI "feature" has to be defined clearly and
>> in such a way that the kernel can say right away whether or not it is
>> "supported".  That doesn't seem to be the case here.
>>
>> Second (and what follows from the above), the kernel should not need
>> any quirks on its side at all to give an answer.  It should be able to
>> say "yes" or "no" regardless of the platform it runs on if the
>> firmware asks the question.
>>
>> So something like "Do you support native PCI power management?" would
>> be fine, because native PCI power management is defined by the PCI
>> standard and it should be clear what supporting it means and it
>> doesn't depend on what platform the kernel runs on.
>>
>
> The problem is this is in conflict with the documentation.
> As quoted:
>
> ```
> _OSI("Linux-OEM-my_interface_name")
> where 'OEM' is needed if this is an OEM-specific hook,
> and 'my_interface_name' describes the hook, which could be a
> quirk, a bug, or a bug-fix.
> ```
>

I don't see the conflict, sorry.

The "OEM-specific hook" is the "feature" here.  It is OEM-specific,
but the kernel still should be able to say "Yes, do that" or "No,
don't do that" without looking at the platform it is running on.

> Quite literally from an OEM perspective this is a quirk.  The affected
> platforms as configured by default won't work properly with Linux.
>
> We apply a code deviation if the OSPM responds yes to that OSI string.

Right.

> It's entirely possible that the Linux kernel could not store a quirk table
> to match the affected platforms and instead give a blanket simple fast
> "Yes" answer to "Linux-Dell-Video", but I think that is no better than
> _OSI("Linux").

First of all, _OSI("Linux") is not well-defined, because it
potentially covers everything ever done or not done by Linux,
regardless of the kernel version.  This just plain doesn't work.

"Linux-Dell-Video" could be defined precisely enough to actually work,
but IMO "Video" is too generic for an _OSI "feature" name.

Something like "Linux-Dell-quirk-this-specific-video-issue" can be made work.

> This is at least an attestation from the OEM perspective
> that we have only changed one thing by this string.

I'm not sure what you mean.

The firmware should only do
_OSI("Linux-Dell-quirk-this-specific-video-issue") if the response to
that makes a difference to it.  It knows what the platform is and it
does the _OSI() thing if the platform may be affected by the quirk
(that is, when necessary).  If the kernel sees that, it has to assume
that the platform may be affected.  Double checking in DMI is
pointless unless there are platforms abusing the _OSI(), but then the
abuse is not the kernel's problem really.

The whole point is that at one point the kernel can stop saying "yes"
to "Linux-Dell-quirk-this-specific-video-issue" if the quirk is not
necessary any more in this particular kernel version.

> The alternative (and what has been done in the past) was the ACPI
> _OSI rev hack marking those platforms for quirks and other things
> before that and.  I really don't want to go down that road again.

Right, that doesn't work just like _OSI("Linux").
