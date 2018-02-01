From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI/PCI: pci_link: remove error messages when no _PRS methods
Date: Thu, 1 Feb 2018 08:30:25 +0100
Message-ID: <CAJZ5v0hNXpwvEDX4ddFdNVzKF8MrbCH=Dn7+z3bTMJ937_-J8w@mail.gmail.com>
References: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
 <1646413.6Bc7kdyLTf@aspire.rjw.lan> <CAJ=jquYAVi=CYmbrNuGzw+PuiphwzpVPHhZ06X6_PL5i-488Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:38396 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAHa0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 02:30:26 -0500
Received: by mail-ot0-f175.google.com with SMTP id v5so15998922oth.5
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2018 23:30:26 -0800 (PST)
In-Reply-To: <CAJ=jquYAVi=CYmbrNuGzw+PuiphwzpVPHhZ06X6_PL5i-488Tw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Thu, Feb 1, 2018 at 5:39 AM, Alex Hung <alex.hung@canonical.com> wrote:
> On Wed, Jan 31, 2018 at 1:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, January 31, 2018 6:52:19 AM CET Alex Hung wrote:
>>> In recent Intel hardware the IRQs become non-configurable after BIOS
>>> initializes them in PEI phase and _PRS objects are no longer included in
>>> ASL.
>>>
>>> This is the same as "static (non-configurable) devices do not
>>> specify a _PRS object" in ACPI spec. As a result, error messages
>>> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" are not
>>> needed.
>>
>> That's questionable at best.
>>
>> The errors basically indicate that _PRT entries corresponding to these
>> IRQs are messed up (because they should contain the value of 0 instead of
>> a NamePath in the Source column), so we are now going to paper over bugs
>> in ACPI tables as someone in the firmware land cannot be bothered with
>> putting correct values into them. :-/
>
> Rafael,
>
> Thanks for quick reply and sharing the information
>
> It seems static (non-configurable) devices on ACPI are discussed in
> both _PRS and _PRT as below:
>
> 6.2.12 _PRS (Possible Resource Settings)
> "... Static (non-configurable) devices do not specify a _PRS object... "
>
> 6.2.13 _PRT (PCI Routing Table)
> "In the second model, the PCI interrupts are hardwired to specific
> interrupt inputs on the interrupt controller and are not configurable.
> In this case, the Source field in _PRT does not reference a device,
> but instead contains the value zero, and the Source Index field
> contains the global system interrupt to which the PCI interrupt is
> hardwired."
>
> My interpretation is the both are true from ACPI's perspective, and
> both should be implemented by system firmware. On this particular
> system I am debugging remotely, it does the _PRS part but not _PRT,
> and I will follow up with firmware engineers.

OK

> On the other hand, it may not be unreasonable to remove AE_NOT_FOUND
> as defined in 6.2.12 in ACPI spec. I also did a code trace and it
> seems that the AE_NOT_FOUND in _PRS cannot be removed by a value of
> zero in Source field in _PRT.

I'm not sure what you mean here.

Do you mean that the code would mishandle 0 in the Source field of _PRT?
