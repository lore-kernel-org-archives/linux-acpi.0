From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: remove error messages when no _PRS methods
Date: Wed, 31 Jan 2018 21:01:29 -0800
Message-ID: <CAJ=jquZGvQSqv0Dm54o22nBnCozFhv4W1tFXNx5dWffiTDNeQA@mail.gmail.com>
References: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
 <1646413.6Bc7kdyLTf@aspire.rjw.lan> <CAJ=jquYAVi=CYmbrNuGzw+PuiphwzpVPHhZ06X6_PL5i-488Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBAFBc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 00:01:32 -0500
Received: from mail-qk0-f198.google.com ([209.85.220.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1eh707-0000dM-RS
        for linux-acpi@vger.kernel.org; Thu, 01 Feb 2018 05:01:31 +0000
Received: by mail-qk0-f198.google.com with SMTP id n72so12051327qke.9
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2018 21:01:31 -0800 (PST)
In-Reply-To: <CAJ=jquYAVi=CYmbrNuGzw+PuiphwzpVPHhZ06X6_PL5i-488Tw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Wed, Jan 31, 2018 at 8:39 PM, Alex Hung <alex.hung@canonical.com> wrote:
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

I made a mistake saying firmware's _PRT part is not done. In the DSDT,
the _PRT is as below:


            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR00) /* \_SB_.AR00 */
                }

                Return (PK00) /* \_SB_.PK00 */
            }

When I used acpiexec to load *.dat from acpidump, it returns _SB.PK00;
however, actual system should return _SB.AR00 which is defined as
below:

        Name (AR00, Package (0x2E)
        {
            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x001EFFFF,
                Zero,
                Zero,
                0x14
            },

            Package (0x04)
            {
                0x001EFFFF,
                One,
                Zero,
                0x15
            },
            ... // skips more

The third elements, Source, are zero and it meets ACPI's requirement.

>
> On the other hand, it may not be unreasonable to remove AE_NOT_FOUND
> as defined in 6.2.12 in ACPI spec. I also did a code trace and it
> seems that the AE_NOT_FOUND in _PRS cannot be removed by a value of
> zero in Source field in _PRT.
>
> Finally, this seems to be a confusing topic in ACPI spec (to the
> firmware engineers and I at least). If we can figure this out, we may
> want to clarify the wording with ASWG.
>
>>
>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>> ---
>>>  drivers/acpi/pci_link.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>>> index 85ad679390e3..f98215971f30 100644
>>> --- a/drivers/acpi/pci_link.c
>>> +++ b/drivers/acpi/pci_link.c
>>> @@ -172,10 +172,8 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
>>>
>>>       status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
>>>                                    acpi_pci_link_check_possible, link);
>>> -     if (ACPI_FAILURE(status)) {
>>> -             ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
>>> +     if (ACPI_FAILURE(status))
>>>               return -ENODEV;
>>> -     }
>>>
>>>       ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>>>                         "Found %d possible IRQs\n",
>>>
>>
>>
>
>
>
> --
> Cheers,
> Alex Hung



-- 
Cheers,
Alex Hung
