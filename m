From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 19:31:58 +0100
Message-ID: <51548C9E.9090703@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <2457825.yjlrJCricN@vostro.rjw.lan> <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com> <1433753.0tcctuHSKe@vostro.rjw.lan> <51547D45.6030106@fold.natur.cuni.cz> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:51824 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754526Ab3C1ScE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Mar 2013 14:32:04 -0400
In-Reply-To: <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Hi Bjorn,

Bjorn Helgaas wrote:
> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>>
>>
>> Rafael J. Wysocki wrote:
>>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>>> Hi Bjorn,
>>>>>>>
>>>>>>> I wonder what you think about the patch below?
>>>>>>
>>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
>>>>>> I don't know much about it).  Why don't you resend it with Matthew's
>>>>>> ack and the appropriate stable tags, and I'll put it in.
>>>>>
>>>>> I will, thanks!
>>>>>
>>>>>> If you have
>>>>>> a URL for a bugzilla or mailing list report of the original problem,
>>>>>> that would be good, too.  It'd be nice if users and distros could
>>>>>> match problem reports with this solution, but I can't tell what the
>>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>>>>>> else reproduced the problem and tested the fix)?
>>>>>
>>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>>>>> to publicly available mailing list archives etc.
>>>>
>>>> Do you at least have a description of how a user could determine
>>>> whether he is seeing the problem fixed by this patch?
>>>
>>> Yeah.  For example, when the problem is visible on a USB controller and that
>>> controller is runtime-suspended, then plugging a new USB device into one
>>> of the controller's ports won't wake the controller up without the patch.
>>
>> Hi,
>>  I am wondering for a week or two why nobody answered any of my bug reports,
>> not even Sarah who asked for more details. I am think the fix is about my report
>> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
>> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
>> about my report. But I should better wait what Sarah says. ;-)
> 
> I haven't forgotten about your hotplug issues, but I've been on
> vacation for a week and have been working on the similar issue
> reported by Chris Clayton
> (https://bugzilla.kernel.org/show_bug.cgi?id=54981) because it seemed
> a bit more tractable.  But I'll get back to yours eventually :)
> Unfortunately nobody else seems to be jumping in to help, and I can
> only do so much by myself.
> 
> I haven't been following your XHCI issue at all, but one thing you

But please do so now. If we are talking about an existing patch it should be
possible to say whether what I observed is likely to be fixed by the patch.
I will happily discuss then why I loose interrupts in a same way for my
rtl8169 network card and why this PME# stuff happens for me only with 3.8
and not 3.7 (unlike what Sarah claims). I am not arguing that something 
else makes 3.7 be able to wakeup the device and overcome the same bug
while "it" is gone from 3.8. I think this should be an easy task for you,
pci devs. ;-)


> might consider is that it's easy for us on the receiving end to be
> overwhelmed by the sheer volume of information.    For me personally,
> it's more useful to get specific answers to a few questions than it is
> for me to sort through a lot of speculation and other data.  In some
> cases, "less is more" :)

Although in theory I agree in real, I can only collect data for you and test a
patch. Even when I extracted bits which I found important into emails there was
still not much answer. And if there is nobody to go through the data then it
is a waste of time.

But still, each thread was a different bug and I just thought you will pick
any which looks edible. Why Sarah had to fix PCI/ACPI stuff I don't know
but yes, that one seemed quite clear.


> 
>>   I would have actually same comment for the proposed patches in:
>> Yinghai Lu  "Re: [PATCH] PCI: Remove not needed check in disable aspm link"
>> Who tested the bug, if anybody? What change(the fix) in lspci output should one
>> observe?
> 
> Yeah, that's one of the things I'm trying to sort out right now.  It
> *was* tested by Roman, according to the changelog, and I think I can
> dig out the user-visible behavior from the bugzilla
> (https://bugzilla.kernel.org/show_bug.cgi?id=55211), but I definitely
> agree -- that patch needs a lot of tender loving care before I apply
> it.

Good. I think all of these relate to the issues I saw, and I don't believe
one cannot find the *now described* broken behavior in my test outputs
and verbosely explain what went on.

Best,
Martin
