From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: remove error messages when no _PRS methods
Date: Thu, 1 Feb 2018 00:07:59 -0800
Message-ID: <CAJ=jquasNcZyVu3w+Xaz0g4DXtz-pAi8Bq61VkiRtLhm4mceMQ@mail.gmail.com>
References: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
 <1646413.6Bc7kdyLTf@aspire.rjw.lan> <CAJ=jquYAVi=CYmbrNuGzw+PuiphwzpVPHhZ06X6_PL5i-488Tw@mail.gmail.com>
 <CAJZ5v0hNXpwvEDX4ddFdNVzKF8MrbCH=Dn7+z3bTMJ937_-J8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34899 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeBAIIC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 03:08:02 -0500
Received: from mail-qk0-f199.google.com ([209.85.220.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1eh9ua-0003n3-VM
        for linux-acpi@vger.kernel.org; Thu, 01 Feb 2018 08:08:01 +0000
Received: by mail-qk0-f199.google.com with SMTP id b185so12276490qkc.7
        for <linux-acpi@vger.kernel.org>; Thu, 01 Feb 2018 00:08:00 -0800 (PST)
In-Reply-To: <CAJZ5v0hNXpwvEDX4ddFdNVzKF8MrbCH=Dn7+z3bTMJ937_-J8w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Wed, Jan 31, 2018 at 11:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Feb 1, 2018 at 5:39 AM, Alex Hung <alex.hung@canonical.com> wrote:
>> On Wed, Jan 31, 2018 at 1:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Wednesday, January 31, 2018 6:52:19 AM CET Alex Hung wrote:
>>>> In recent Intel hardware the IRQs become non-configurable after BIOS
>>>> initializes them in PEI phase and _PRS objects are no longer included in
>>>> ASL.
>>>>
>>>> This is the same as "static (non-configurable) devices do not
>>>> specify a _PRS object" in ACPI spec. As a result, error messages
>>>> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" are not
>>>> needed.
>>>
>>> That's questionable at best.
>>>
>>> The errors basically indicate that _PRT entries corresponding to these
>>> IRQs are messed up (because they should contain the value of 0 instead of
>>> a NamePath in the Source column), so we are now going to paper over bugs
>>> in ACPI tables as someone in the firmware land cannot be bothered with
>>> putting correct values into them. :-/
>>
>> Rafael,
>>
>> Thanks for quick reply and sharing the information
>>
>> It seems static (non-configurable) devices on ACPI are discussed in
>> both _PRS and _PRT as below:
>>
>> 6.2.12 _PRS (Possible Resource Settings)
>> "... Static (non-configurable) devices do not specify a _PRS object... "
>>
>> 6.2.13 _PRT (PCI Routing Table)
>> "In the second model, the PCI interrupts are hardwired to specific
>> interrupt inputs on the interrupt controller and are not configurable.
>> In this case, the Source field in _PRT does not reference a device,
>> but instead contains the value zero, and the Source Index field
>> contains the global system interrupt to which the PCI interrupt is
>> hardwired."
>>
>> My interpretation is the both are true from ACPI's perspective, and
>> both should be implemented by system firmware. On this particular
>> system I am debugging remotely, it does the _PRS part but not _PRT,
>> and I will follow up with firmware engineers.
>
> OK
>
>> On the other hand, it may not be unreasonable to remove AE_NOT_FOUND
>> as defined in 6.2.12 in ACPI spec. I also did a code trace and it
>> seems that the AE_NOT_FOUND in _PRS cannot be removed by a value of
>> zero in Source field in _PRT.
>
> I'm not sure what you mean here.
>
> Do you mean that the code would mishandle 0 in the Source field of _PRT?

I meant the AE_NOT_FOUND messages still pop up when SOURCE = 0.

-- 
Cheers,
Alex Hung
