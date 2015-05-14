From: Al Stone <ahs3@redhat.com>
Subject: Re: Registering a device driver before _INI?
Date: Thu, 14 May 2015 11:47:51 -0600
Message-ID: <5554DFC7.4070303@redhat.com>
References: <CAOf41NnAjRG-2H=h8pUDBPQs2pePH4GNY0+XNnC+iXiRf30srA@mail.gmail.com> <5553A0F8.8000505@redhat.com> <3348174.NCS7iW2FVj@vostro.rjw.lan> <CAOf41N=BW4ChU=27zhW_AUPqhkK=m5iXUcYCwNx6kmSaDD-bOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbbENRr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 May 2015 13:47:56 -0400
In-Reply-To: <CAOf41N=BW4ChU=27zhW_AUPqhkK=m5iXUcYCwNx6kmSaDD-bOw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Goode <agoode@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

On 05/14/2015 06:36 AM, Adam Goode wrote:
> On Wed, May 13, 2015 at 11:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, May 13, 2015 01:07:36 PM Al Stone wrote:
>>> On 05/13/2015 10:25 AM, Adam Goode wrote:
>>>> The Macmini7,1 addresses SystemCMOS memory in _INI methods. Currently,
>>>> this fails since _INI is called before the acpi_cmos_rtc_space_handler
>>>> is registered.
>>>>
>>>> I proposed registering a default handler on the ACPICA list, but was
>>>> told that because the device has a _HID it should require a device
>>>> driver.
>>>>
>>>> So, is it possible to register a device driver before _INI is called?
>>>> Otherwise, Thunderbolt doesn't get initialized properly on this
>>>> hardware.
>>>
>>> I take it from the question that the _INI methods are using the predefined
>>> SystemCMOS OperationRegion, correct?  Are the _INI methods invoking _REG
>>> before trying to access that region?  Looking at the spec, the _INI methods
>>> must first call _REG to see if SystemCMOS is available for use (see section
>>> 6.5.1), and there is no requirement that SystemCMOS must be available for
>>> use by _INI (see 6.5.4).  So, if I think about this from the spec point of
>>> view, it sounds like the _INI methods are non-compliant.  From the kernel
>>> perspective, the SystemCMOS region is created at a reasonable time and is
>>> available when it is required to be.
> 
> My reading of the ACPI spec is that the OS calls _REG when it updates
> region availability. It's not the AML that calls _REG at all. There
> are no _REG methods defined for this, so nothing to do. Further
> reading of the spec seems to indicate that the OS should be doing a
> kind of dependency analysis and registering region handlers before
> failing here. I'm not seeing anything really out of spec with the AML
> code in this case.

Ah, my bad.  I misread the _REG part.  The OS does call _REG, not the AML.
Just the same, that section does say that "control methods must assume all
operation regions inaccessible until the _REG(RegionSpace, 1) method is
executed."  I would take that to mean that _INI cannot assume SystemCMOS
is ready to use, unless _REG has been defined in an enclosing scope so the
OS knows it is to be executed.

Could you point out where the dependency analysis is indicated?  I am
not seeing that at all; that would seem to require a priori knowledge
of all of the regions all of the devices could ever possibly use, and
it's not clear to me that can even be conveyed to the OS using the
current version of the spec.  As someone involved in writing the spec,
I want to make sure we're being unambiguous in what is required.

> I'm guessing that some kind of refactoring of _HID driver attachment
> would be a way forward here. But I haven't looked deeply into this
> yet.

Perhaps; as long as _INI is executed before _HID as required (6.5.1, again).

>>>
>>> It seems to me that the correct answer is that there should indeed be a device
>>> driver connected to the _HID, but that it gets invoked just like any other
>>> driver, and has as part of its probe an invocation of some method to access
>>> the necessary items in the SystemCMOS (maybe add the method in an SSDT loaded
>>> at run-time?).  One could also hack around this by moving where in the kernel
>>> the SystemCMOS region gets created to some place before the _INI functions are
>>> invoked, but that feels klunky to me to handle firmware that may not be correct.
>>
>> There may be another way: Add a DMI quirk for the affected Apple system to
>> acpi_cmos_rtc.c that would install the address space handler early (ie. before
>> _INI is executed) and make acpi_install_cmos_rtc_space_handler() return
>> immediately if the address space handler is already installed.
>>
> 
> I'm really wary of adding a DMI quirk. For one, I don't know the list
> of Apple devices that need the quirk, and it is likely to grow in the
> future. Secondly, Windows 8.1 works correctly here, without any
> additional drivers, and I would be quite surprised if they have a
> built-in hardcoding of this machine.

I don't think they would have to; from the sounds of it, if all they do is set
up the SystemCMOS region earlier than Linux does, I suspect it would work just
fine.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
