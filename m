From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Wed, 7 Feb 2018 12:38:45 -0800
Message-ID: <CAJ=jquaWYk6Z9jn+107+1x2GZfk1hNGnOVcszKZ4OA+_7eXE2Q@mail.gmail.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion> <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws> <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com> <87fd656bb080495089cd21c66d559cea@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGUis (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 15:38:48 -0500
Received: from mail-qt0-f199.google.com ([209.85.216.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1ejWUR-0007VR-FL
        for linux-acpi@vger.kernel.org; Wed, 07 Feb 2018 20:38:47 +0000
Received: by mail-qt0-f199.google.com with SMTP id h6so1946959qtm.15
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2018 12:38:47 -0800 (PST)
In-Reply-To: <87fd656bb080495089cd21c66d559cea@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, Florian Fainelli <f.fainelli@gmail.com>, kishon@ti.com, sayli karnik <karniksayli1995@gmail.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Tue, Feb 6, 2018 at 8:24 AM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>> Sent: Tuesday, February 6, 2018 7:46 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>;
>> dmitry.torokhov@gmail.com
>> Cc: jdelvare@suse.de; alex.hung@canonical.com; rjw@rjwysocki.net;
>> lenb@kernel.org; gregkh@linuxfoundation.org; davem@davemloft.net;
>> mika.westerberg@linux.intel.com; f.fainelli@gmail.com; kishon@ti.com;
>> karniksayli1995@gmail.com; linux-acpi@vger.kernel.org
>> Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
>>
>> On Tue, 2018-02-06 at 00:45 +0000, Mario.Limonciello@dell.com wrote:
>>
>> > > > > Playing with OSI string is a bad idea. I wouldn't do anything
>> > > > > while
>> > > > > Rafael, or even Len can confirm that is the right thing to do.
>> > > > >
>> > > > > For me, AFAIK we need to be bug-to-bug compatible with Windows
>> > > > > (at least
>> > > > > on ACPICA side), so, what Windows exactly does on such laptops?
>> > > > >
>> > > >
>> > > > The issue that's being worked around isn't an ACPICA interpreter
>> > > > issue, but it's
>> > > > a graphics device configuration issue.
>>
>> Then clearly nothing to do with OSI strings here, right?
>
> The usage of OSI here is: do you support the feature "Linux-Dell-Video"
> to Linux kernel.  If Linux kernel responds yes then firmware will turn off
> RTD3 functionality for the discrete GPU.
>
>>
>> > > > Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
>> > > > don't.  It leads to system hangs on the Linux side.
>> > >
>> > > Can we adjust Linux drivers to do the right thing?
>>
>> +100
>>
>> > >  Or is it regarding
>> > > the binary NVIDIA blob?
>>
>> nVidia vs. Linux again? :-)
>>
>> >
>> > Neither Nouveau nor the NVIDIA blob have support for RTD3.
>> >
>> > Last I heard it's waiting on NVIDIA releasing something Nouveau
>> > needs.  So.. Eventually?  For now it's better to not hang though.
>>
>> Hmm... While you are talking sense, the patch itself looks like an ugly
>> hack.
>
> I don't disagree it's a workaround for a driver deficiency.
>
>>
>> > That's part of why we wanted to enable this via a transient OSI
>> > string,
>> > to let this be removed by Linux whenever the driver does grow support.
>>
>> So, means "never" then? (Assume a bit of irony here)
>>
>> I don't know how it feels for maintainers, for me it's quite unlikely to
>> go (at least in this shape).

Workarounds are never preferred, but they are needed from time to time.

There are other alternatives such as 1) _REV & acpi_rev_dmi_table, 2)
windows & linux osi strings & acpi_osi_dmi_table.

However, Linux-OEM-my_interface_name strings + OEM strings in DMI are
better choices for couple reasons:

1. Linux-OEM-my_interface_name are more informative than current
available mechanisms.

2. Linux-OEM-my_interface_name is defined in
Documentation/acpi/osi.txt as below:

_OSI("Linux-OEM-my_interface_name")
where 'OEM' is needed if this is an OEM-specific hook,
and 'my_interface_name' describes the hook, which could be a
quirk, a bug, or a bug-fix.

3. DMI OEM strings used in this patch are System IDs and they are
unlikely to repeat for years. System IDs are also more precise than
Product names.

4. The workaround is controlled and limited to specific systems as
Mario commented previously.

>
> I'm not going to be able to force NVIDIA to fix the blob or to give what's
> necessary to enable Nouvaeu for this function.  What we can do is prevent
> someone's system from hanging because of this situation.

and we never stopped poking NVIDIA to fix drivers and will never stop
trying. If NVIDIA fixes RTD3, a clean-up patch will be submit to
remove the quirks.

>
>>
>> I'm sorry I can't be much constructive here, I heard Len once about OSI
>> huge abuse by almost every party. I would rather let him speak on the
>> matter.
>
> I know that OSI has been abused in the past, but that's exactly why this
> has been implemented as seen in this patch series.
>
> It's done specifically to fit within exactly what the Linux kernel ideally
> looks for in a custom OSI feature string.
>
> * It has an OS Prefix (Linux-)
> * It's an OEM specific string (-Dell-)
> * It's a feature specific string (-Video)
> *It's specific to a single platform (not a blanket match to Dell Inc)
> *It only modifies one feature in ASL
>
>
