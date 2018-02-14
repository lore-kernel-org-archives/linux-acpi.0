From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Wed, 14 Feb 2018 10:06:22 +0100
Message-ID: <CAJZ5v0h7YniZ_Xj8PHQ6GazccYPMNgi9r9Nn3Y3U5kKQsimJ7A@mail.gmail.com>
References: <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws> <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com> <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de> <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com>
 <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM> <20180213073258.GX27191@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38899 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeBNJGX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2018 04:06:23 -0500
Received: by mail-ot0-f193.google.com with SMTP id h14so19765099otj.5
        for <linux-acpi@vger.kernel.org>; Wed, 14 Feb 2018 01:06:23 -0800 (PST)
In-Reply-To: <20180213073258.GX27191@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Alex Hung <alex.hung@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, sayli karnik <karniksayli1995@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Feb 13, 2018 at 8:32 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Feb 12, 2018 at 11:14:42PM +0000, Mario.Limonciello@dell.com wrote:
>> > So something like "Do you support native PCI power management?" would
>> > be fine, because native PCI power management is defined by the PCI
>> > standard and it should be clear what supporting it means and it
>> > doesn't depend on what platform the kernel runs on.
>> >
>>
>> The problem is this is in conflict with the documentation.
>> As quoted:
>>
>> ```
>> _OSI("Linux-OEM-my_interface_name")
>> where 'OEM' is needed if this is an OEM-specific hook,
>> and 'my_interface_name' describes the hook, which could be a
>> quirk, a bug, or a bug-fix.
>> ```
>>
>> Quite literally from an OEM perspective this is a quirk.  The affected
>> platforms as configured by default won't work properly with Linux.
>>
>> We apply a code deviation if the OSPM responds yes to that OSI string.
>>
>> It's entirely possible that the Linux kernel could not store a quirk table
>> to match the affected platforms and instead give a blanket simple fast
>> "Yes" answer to "Linux-Dell-Video", but I think that is no better than
>> _OSI("Linux").  This is at least an attestation from the OEM perspective
>> that we have only changed one thing by this string.
>>
>> The alternative (and what has been done in the past) was the ACPI
>> _OSI rev hack marking those platforms for quirks and other things
>> before that and.  I really don't want to go down that road again.
>
> I have not followed this thread too closely so I might be missing
> something but why do we need to do this in the first place?

As a temporary (presumably) workaround, basically. :-)

> Does this work in Windows and if yes, why we can't do the the same in Linux
> without any sort of hacks and/or quirks?

Of course it works on Windows.

The underlying issue is that the platform firmware expects Linux to
behave like Windows, presumably because Linux says "yes" to
_OSI("Windows <something>"), and it fails to work, because Linux
doesn't behave as expected by it.

Theoretically, it should be possible to make Linux behave like Windows
in that particular respect, but (a) there may be missing pieces that
we have no access to (like some secret documentation or similar) and
(b) it is unclear how much time that would take even if everything was
known.

However, the platforms in question are (or shortly will be) shipping
and Linux quite promptly doesn't work with them.

So the idea is to make a the firmware ask the kernel for a hint on
whether or not it should adjust its behavior for a particular
difference in behavior between Linux and Windows.
