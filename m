From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 11:49:05 -0600
Message-ID: <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <2457825.yjlrJCricN@vostro.rjw.lan>
 <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com>
 <1433753.0tcctuHSKe@vostro.rjw.lan> <51547D45.6030106@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64586 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab3C1Rt1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Mar 2013 13:49:27 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so8693221oag.40
        for <linux-acpi@vger.kernel.org>; Thu, 28 Mar 2013 10:49:26 -0700 (PDT)
In-Reply-To: <51547D45.6030106@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
>
>
> Rafael J. Wysocki wrote:
>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>> Hi Bjorn,
>>>>>>
>>>>>> I wonder what you think about the patch below?
>>>>>
>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
>>>>> I don't know much about it).  Why don't you resend it with Matthew's
>>>>> ack and the appropriate stable tags, and I'll put it in.
>>>>
>>>> I will, thanks!
>>>>
>>>>> If you have
>>>>> a URL for a bugzilla or mailing list report of the original problem,
>>>>> that would be good, too.  It'd be nice if users and distros could
>>>>> match problem reports with this solution, but I can't tell what the
>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>>>>> else reproduced the problem and tested the fix)?
>>>>
>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>>>> to publicly available mailing list archives etc.
>>>
>>> Do you at least have a description of how a user could determine
>>> whether he is seeing the problem fixed by this patch?
>>
>> Yeah.  For example, when the problem is visible on a USB controller and that
>> controller is runtime-suspended, then plugging a new USB device into one
>> of the controller's ports won't wake the controller up without the patch.
>
> Hi,
>  I am wondering for a week or two why nobody answered any of my bug reports,
> not even Sarah who asked for more details. I am think the fix is about my report
> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
> about my report. But I should better wait what Sarah says. ;-)

I haven't forgotten about your hotplug issues, but I've been on
vacation for a week and have been working on the similar issue
reported by Chris Clayton
(https://bugzilla.kernel.org/show_bug.cgi?id=54981) because it seemed
a bit more tractable.  But I'll get back to yours eventually :)
Unfortunately nobody else seems to be jumping in to help, and I can
only do so much by myself.

I haven't been following your XHCI issue at all, but one thing you
might consider is that it's easy for us on the receiving end to be
overwhelmed by the sheer volume of information.    For me personally,
it's more useful to get specific answers to a few questions than it is
for me to sort through a lot of speculation and other data.  In some
cases, "less is more" :)

>   I would have actually same comment for the proposed patches in:
> Yinghai Lu  "Re: [PATCH] PCI: Remove not needed check in disable aspm link"
> Who tested the bug, if anybody? What change(the fix) in lspci output should one
> observe?

Yeah, that's one of the things I'm trying to sort out right now.  It
*was* tested by Roman, according to the changelog, and I think I can
dig out the user-visible behavior from the bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=55211), but I definitely
agree -- that patch needs a lot of tender loving care before I apply
it.

>>>>>> On Saturday, March 23, 2013 03:33:03 PM Rafael J. Wysocki wrote:
>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>> It turns out that _Lxx control methods provided by some BIOSes clear
>>>>>>> the PME Status bit of PCI devices they handle, which means that
>>>>>>> pci_acpi_wake_dev() cannot really use that bit to check whether or
>>>>>>> not the device has signalled wakeup.
>>>>>>>
>>>>>>> For this reason, make pci_acpi_wake_dev() always attempt to resume
>>>>>>> the device it is called for regardless of the device's PME Status bit
>>>>>>> value (that bit still has to be cleared if set at this point,
>>>>>>> though).
>>>>>>>
>>>>>>> Reported-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
>>>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>> ---
>>>>>>>  drivers/pci/pci-acpi.c |   15 ++++++++-------
>>>>>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> Index: linux-pm/drivers/pci/pci-acpi.c
>>>>>>> ===================================================================
>>>>>>> --- linux-pm.orig/drivers/pci/pci-acpi.c
>>>>>>> +++ linux-pm/drivers/pci/pci-acpi.c
>>>>>>> @@ -53,14 +53,15 @@ static void pci_acpi_wake_dev(acpi_handl
>>>>>>>               return;
>>>>>>>       }
>>>>>>>
>>>>>>> -     if (!pci_dev->pm_cap || !pci_dev->pme_support
>>>>>>> -          || pci_check_pme_status(pci_dev)) {
>>>>>>> -             if (pci_dev->pme_poll)
>>>>>>> -                     pci_dev->pme_poll = false;
>>>>>>> +     /* Clear PME Status if set. */
>>>>>>> +     if (pci_dev->pme_support)
>>>>>>> +             pci_check_pme_status(pci_dev);
>>>>>>>
>>>>>>> -             pci_wakeup_event(pci_dev);
>>>>>>> -             pm_runtime_resume(&pci_dev->dev);
>>>>>>> -     }
>>>>>>> +     if (pci_dev->pme_poll)
>>>>>>> +             pci_dev->pme_poll = false;
>>>>>>> +
>>>>>>> +     pci_wakeup_event(pci_dev);
>>>>>>> +     pm_runtime_resume(&pci_dev->dev);
>>>>>>>
>>>>>>>       if (pci_dev->subordinate)
>>>>>>>               pci_pme_wakeup_bus(pci_dev->subordinate);
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> --
>>>>>> I speak only for myself.
>>>>>> Rafael J. Wysocki, Intel Open Source Technology Center.
>>>> --
>>>> I speak only for myself.
>>>> Rafael J. Wysocki, Intel Open Source Technology Center.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
