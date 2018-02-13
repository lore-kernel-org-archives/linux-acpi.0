From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 12 Feb 2018 21:25:06 -0800
Message-ID: <CAJ=jquafOGOEMBzZF7nzkV4k1gYD0SzZcE-xAvccVVV8cT1TZA@mail.gmail.com>
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
Received: from youngberry.canonical.com ([91.189.89.112]:37206 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeBMFZJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2018 00:25:09 -0500
Received: from mail-qk0-f197.google.com ([209.85.220.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1elT5Y-0001Oe-Ap
        for linux-acpi@vger.kernel.org; Tue, 13 Feb 2018 05:25:08 +0000
Received: by mail-qk0-f197.google.com with SMTP id n11so7864244qkn.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2018 21:25:08 -0800 (PST)
In-Reply-To: <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lukas@wunner.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Len Brown <lenb@kernel.org>, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, Florian Fainelli <f.fainelli@gmail.com>, kishon@ti.com, sayli karnik <karniksayli1995@gmail.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Mon, Feb 12, 2018 at 3:14 PM,  <Mario.Limonciello@dell.com> wrote:
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
> Maybe Canonical guys will have some more detail.

I do not have more information than current NV GPU driver doesn't
support RTD3 now but NV would support RTD3 from next new GPU chip.

If this is true, we may not need this _OSI or any workaround in next generation.

>
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
> Quite literally from an OEM perspective this is a quirk.  The affected
> platforms as configured by default won't work properly with Linux.
>
> We apply a code deviation if the OSPM responds yes to that OSI string.
>
> It's entirely possible that the Linux kernel could not store a quirk table
> to match the affected platforms and instead give a blanket simple fast
> "Yes" answer to "Linux-Dell-Video", but I think that is no better than
> _OSI("Linux").  This is at least an attestation from the OEM perspective
> that we have only changed one thing by this string.
>
> The alternative (and what has been done in the past) was the ACPI
> _OSI rev hack marking those platforms for quirks and other things
> before that and.  I really don't want to go down that road again.



-- 
Cheers,
Alex Hung
