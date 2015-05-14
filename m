From: Adam Goode <agoode@google.com>
Subject: Re: Registering a device driver before _INI?
Date: Thu, 14 May 2015 13:36:12 +0100
Message-ID: <CAOf41N=BW4ChU=27zhW_AUPqhkK=m5iXUcYCwNx6kmSaDD-bOw@mail.gmail.com>
References: <CAOf41NnAjRG-2H=h8pUDBPQs2pePH4GNY0+XNnC+iXiRf30srA@mail.gmail.com>
 <5553A0F8.8000505@redhat.com> <3348174.NCS7iW2FVj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:34808 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbbENMgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 08:36:35 -0400
Received: by vnbf190 with SMTP id f190so5010136vnb.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2015 05:36:34 -0700 (PDT)
In-Reply-To: <3348174.NCS7iW2FVj@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Al Stone <ahs3@redhat.com>, linux-acpi@vger.kernel.org

On Wed, May 13, 2015 at 11:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 13, 2015 01:07:36 PM Al Stone wrote:
>> On 05/13/2015 10:25 AM, Adam Goode wrote:
>> > The Macmini7,1 addresses SystemCMOS memory in _INI methods. Currently,
>> > this fails since _INI is called before the acpi_cmos_rtc_space_handler
>> > is registered.
>> >
>> > I proposed registering a default handler on the ACPICA list, but was
>> > told that because the device has a _HID it should require a device
>> > driver.
>> >
>> > So, is it possible to register a device driver before _INI is called?
>> > Otherwise, Thunderbolt doesn't get initialized properly on this
>> > hardware.
>>
>> I take it from the question that the _INI methods are using the predefined
>> SystemCMOS OperationRegion, correct?  Are the _INI methods invoking _REG
>> before trying to access that region?  Looking at the spec, the _INI methods
>> must first call _REG to see if SystemCMOS is available for use (see section
>> 6.5.1), and there is no requirement that SystemCMOS must be available for
>> use by _INI (see 6.5.4).  So, if I think about this from the spec point of
>> view, it sounds like the _INI methods are non-compliant.  From the kernel
>> perspective, the SystemCMOS region is created at a reasonable time and is
>> available when it is required to be.

My reading of the ACPI spec is that the OS calls _REG when it updates
region availability. It's not the AML that calls _REG at all. There
are no _REG methods defined for this, so nothing to do. Further
reading of the spec seems to indicate that the OS should be doing a
kind of dependency analysis and registering region handlers before
failing here. I'm not seeing anything really out of spec with the AML
code in this case.

I'm guessing that some kind of refactoring of _HID driver attachment
would be a way forward here. But I haven't looked deeply into this
yet.

>>
>> It seems to me that the correct answer is that there should indeed be a device
>> driver connected to the _HID, but that it gets invoked just like any other
>> driver, and has as part of its probe an invocation of some method to access
>> the necessary items in the SystemCMOS (maybe add the method in an SSDT loaded
>> at run-time?).  One could also hack around this by moving where in the kernel
>> the SystemCMOS region gets created to some place before the _INI functions are
>> invoked, but that feels klunky to me to handle firmware that may not be correct.
>
> There may be another way: Add a DMI quirk for the affected Apple system to
> acpi_cmos_rtc.c that would install the address space handler early (ie. before
> _INI is executed) and make acpi_install_cmos_rtc_space_handler() return
> immediately if the address space handler is already installed.
>

I'm really wary of adding a DMI quirk. For one, I don't know the list
of Apple devices that need the quirk, and it is likely to grow in the
future. Secondly, Windows 8.1 works correctly here, without any
additional drivers, and I would be quite surprised if they have a
built-in hardcoding of this machine.


Thanks,

Adam
