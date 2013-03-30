From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Sat, 30 Mar 2013 03:03:48 +0100
Message-ID: <51564804.9000700@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:48021 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757553Ab3C3CDw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Mar 2013 22:03:52 -0400
In-Reply-To: <2990024.LMTIBUbM3d@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Rafael J. Wysocki wrote:
> On Thursday, March 28, 2013 07:31:58 PM Martin Mokrejs wrote:
>> Hi Bjorn,
>>
>> Bjorn Helgaas wrote:
>>> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>>
>>>>
>>>> Rafael J. Wysocki wrote:
>>>>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>>>>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>>>>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>>>>> Hi Bjorn,
>>>>>>>>>
>>>>>>>>> I wonder what you think about the patch below?
>>>>>>>>
>>>>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
>>>>>>>> I don't know much about it).  Why don't you resend it with Matthew's
>>>>>>>> ack and the appropriate stable tags, and I'll put it in.
>>>>>>>
>>>>>>> I will, thanks!
>>>>>>>
>>>>>>>> If you have
>>>>>>>> a URL for a bugzilla or mailing list report of the original problem,
>>>>>>>> that would be good, too.  It'd be nice if users and distros could
>>>>>>>> match problem reports with this solution, but I can't tell what the
>>>>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>>>>>>>> else reproduced the problem and tested the fix)?
>>>>>>>
>>>>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>>>>>>> to publicly available mailing list archives etc.
>>>>>>
>>>>>> Do you at least have a description of how a user could determine
>>>>>> whether he is seeing the problem fixed by this patch?
>>>>>
>>>>> Yeah.  For example, when the problem is visible on a USB controller and that
>>>>> controller is runtime-suspended, then plugging a new USB device into one
>>>>> of the controller's ports won't wake the controller up without the patch.
>>>>
>>>> Hi,
>>>>  I am wondering for a week or two why nobody answered any of my bug reports,
>>>> not even Sarah who asked for more details. I am think the fix is about my report
>>>> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
>>>> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
>>>> about my report. But I should better wait what Sarah says. ;-)
>>>
>>> I haven't forgotten about your hotplug issues, but I've been on
>>> vacation for a week and have been working on the similar issue
>>> reported by Chris Clayton
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=54981) because it seemed
>>> a bit more tractable.  But I'll get back to yours eventually :)
>>> Unfortunately nobody else seems to be jumping in to help, and I can
>>> only do so much by myself.
>>>
>>> I haven't been following your XHCI issue at all, but one thing you
>>
>> But please do so now. If we are talking about an existing patch it should be
>> possible to say whether what I observed is likely to be fixed by the patch.
>> I will happily discuss then why I loose interrupts in a same way for my
>> rtl8169 network card and why this PME# stuff happens for me only with 3.8
>> and not 3.7 (unlike what Sarah claims). I am not arguing that something 
>> else makes 3.7 be able to wakeup the device and overcome the same bug
>> while "it" is gone from 3.8. I think this should be an easy task for you,
>> pci devs. ;-)
> 
> OK, let's try to establish facts.
> 
> Does the patch below causes the PCI PM issues you're seeing to go away?

Yes, the PME# enabled to disabled is gone, because only PME# disabled is allowed.
I don't think I really tested a scenario like before. Big thanks to Huang Ying
(https://patchwork.kernel.org/patch/2359611/):

# grep . /sys/bus/pci/devices/*/power/control
/sys/bus/pci/devices/0000:00:00.0/power/control:on
/sys/bus/pci/devices/0000:00:02.0/power/control:on
/sys/bus/pci/devices/0000:00:16.0/power/control:on
/sys/bus/pci/devices/0000:00:1a.0/power/control:on
/sys/bus/pci/devices/0000:00:1b.0/power/control:on
/sys/bus/pci/devices/0000:00:1c.0/power/control:on
/sys/bus/pci/devices/0000:00:1c.1/power/control:on
/sys/bus/pci/devices/0000:00:1c.3/power/control:on
/sys/bus/pci/devices/0000:00:1c.4/power/control:on
/sys/bus/pci/devices/0000:00:1c.7/power/control:on
/sys/bus/pci/devices/0000:00:1d.0/power/control:on
/sys/bus/pci/devices/0000:00:1f.0/power/control:on
/sys/bus/pci/devices/0000:00:1f.2/power/control:on
/sys/bus/pci/devices/0000:00:1f.3/power/control:on
/sys/bus/pci/devices/0000:05:00.0/power/control:on
/sys/bus/pci/devices/0000:09:00.0/power/control:on
/sys/bus/pci/devices/0000:0b:00.0/power/control:on
/sys/bus/pci/devices/0000:11:00.0/power/control:on
# grep . /sys/bus/pci/devices/*/power/runtime_status
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active
#

> 
> If it doesn't make all of them go away, does it make *some* of them go away?

Yes, repeated inserts and removals of devices into xHCI slot work fine, no need
to use "lsusb -vv" to wakeup devices.

Aside from some minor USB errors (won't mess them here) what is important is the fact
that the eSATA card hotplug works well or perfectly. I just sent to you and other pci devs
much more detailed report under the "Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI"
thread although this particular testing was done on 3.8.3.

I think I can stop replying to this thread which is about the patch from Sarah.
My dead XHCI port issue is a power management issue, incidentally also fixed by the
very same patch from Huang Ying. Cool! ;-)

> 
> If that is the case, which of the problems remain after applying it (on top
> of the Linus' current tree)?

Sorry, I used plain 3.8.3 so that we can compare with the patch from Sarah.
I tested meanwhile also plain 3.8.3 while I had already uninstalled the laptop-mode-tools
from my laptop, which cause power/control values to be set to "auto" instead of
"on". Sarah, I concluded that your pci-acpi.c patch (https://patchwork.kernel.org/patch/2359531/)
did not break anything on my setup and that the PME# issues associated with
the "dead" xHCI ports were just due to the powersaving issue, merely
laptop-mode-tools setting the "auto" state which allowed devices to be
suspended. After I enabled manually the "auto" for 1.c7 while NOT on 0b:00
(the XHCI controller), port could still detect exchanged USB device.

What I will have to redo is that with plain 3.8.3 I did not manage to
reproduce the PME#enabled message so that the port would appear "dead"
until I would do 'lsusb -vv'. I set the "auto" values instead of "on"
but that was still not enough, somehow. In the end I did set all devices
under /sys/ to "auto" but only some other PCI devices got suspended
while the xHCI port was still working. I will redo the test as I said
but in brief I don't have a problem with the patch from Sarah, posted
initially under thsi thread.


Thank you everybody,
Martin
