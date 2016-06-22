From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Wed, 22 Jun 2016 13:53:19 -0700
Message-ID: <CALCETrVy5nKGEyGD9XCR8ZJaa+9WaM_x77ipG8sLjTWm=8VoOw@mail.gmail.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com>
 <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
 <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
 <20160621151853.GE28967@redhat.com> <cf3d90a8598241ff9b6e28b8fb037633@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0ji0DpVsNbnKQpWTdJS-d9y+dh-BVGGfJ_o5fHGe8qeiA@mail.gmail.com> <c6d927d71f544432a48a38047c8bfb14@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36842 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcFVUxk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2016 16:53:40 -0400
Received: by mail-vk0-f53.google.com with SMTP id u64so78720401vkf.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2016 13:53:40 -0700 (PDT)
In-Reply-To: <c6d927d71f544432a48a38047c8bfb14@ausx13mpc124.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario_Limonciello@dell.com>
Cc: Rafael Wysocki <rafael@kernel.org>, Peter Jones <pjones@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, Jun 22, 2016 at 12:43 PM,  <Mario_Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Tuesday, June 21, 2016 5:51 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: Peter Jones <pjones@redhat.com>; Rafael J. Wysocki
>> <rafael@kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
>> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Len Brown
>> <lenb@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Andy Lutomirski
>> <luto@amacapital.net>
>> Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
>> PCIe hotplug.
>>
>> On Tue, Jun 21, 2016 at 8:01 PM,  <Mario_Limonciello@dell.com> wrote:
>> >> -----Original Message-----
>> >> From: Peter Jones [mailto:pjones@redhat.com]
>> >> Sent: Tuesday, June 21, 2016 10:19 AM
>> >> To: Rafael J. Wysocki <rafael@kernel.org>
>> >> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Limonciello,
>> Mario
>> >> <Mario_Limonciello@Dell.com>; Linux Kernel Mailing List <linux-
>> >> kernel@vger.kernel.org>; Len Brown <lenb@kernel.org>; Rafael J .
>> Wysocki
>> >> <rjw@rjwysocki.net>; Andy Lutomirski <luto@amacapital.net>
>> >> Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge
>> of
>> >> PCIe hotplug.
>> >>
>> >> (Sorry for the slow response - it's deadline time over here.)
>> >>
>> >> On Thu, Jun 16, 2016 at 04:56:57PM +0200, Rafael J. Wysocki wrote:
>> >> > On Thu, Jun 16, 2016 at 2:12 AM, Rafael J. Wysocki <rafael@kernel.org>
>> >> wrote:
>> >> > > On Thu, Jun 16, 2016 at 12:15 AM, Peter Jones <pjones@redhat.com>
>> >> wrote:
>> >> > >> Right now when booting, on many laptops the firmware manages
>> the
>> >> PCIe
>> >> > >> bus.  As a result, when we call the _OSC ACPI method, it returns an
>> >> > >> error code.  Unfortunately the errors are not very articulate.
>> >> > >
>> >> > > What exactly do you mean here?
>> >> > >
>> >> > >>  As a result, we show:
>> >> > >>
>> >> > >> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
>> >> > >> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
>> ClockPM
>> >> Segments MSI]
>> >> > >> \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid
>> >> UUID
>> >> > >> _OSC request data: 1 1f 0
>> >> > >
>> >> > > So _OSC told us that the UUID was invalid, didn't it?
>> >> >
>> >> > BTW, the above messages are KERN_DEBUG, so at least in theory they
>> >> > shouldn't be visible in production runs.
>> >> >
>> >> > Maybe the bug to fix is that they show up when they aren't supposed
>> to?
>> >>
>> >> No - the workflow that I am really trying to remedy is this:
>> >>
>> >>  1) S3 resume sometimes isn't working on some laptop you've got.
>> >>  2) start looking at debug messages
>> >>  3) this shows an error, so it looks like it's probably the problem
>> >>  4) go fishing for red herring
>> >>  5) if you happen to know who maintains the DSDT for the platform in
>> >>     question, eventually work out that this is working as intended and
>> >>     the bug is someplace else.
>> >> 5b) if you don't know that person, eventually work out that it /might/
>> >>      be someplace else...
>> >>
>> >> So the idea was to make it look more like an indication of status, and
>> >> less like an error that's causing unrelated problems.
>> >>
>> >> When I talked to Mario at Dell (Cc'd), it wasn't clear to us that
>> >> there's a way to distinguish the between the UUID being
>> >> invalid/malformed, being merely unsupported, or being supported in
>> some
>> >> configurations but not the current one.  In this particular DSDT, the
>> >> machine doesn't support the OS controlling any of this if USB-C /
>> >> thunderbolt are enabled.  The DSDT is clearly written with the belief
>> >> that you have to completely disable the handling for that UUID in this
>> >> case, and googling for this looks like it's not the only one written
>> >> with that belief.
>> >>
>> >> Reading the spec (v6.1, sections 6.2.11.3 and 6.2.11.4), it seems
>> >> plausible that you can express this instead by handling the UUID but
>> >> choosing each individual query/status bit in the way that accomplishes
>> >> the OS doing nothing with the response.  So it may well be that that's
>> >> just more code that vendors have thought wasn't necessary (or wasn't
>> >> correct for some reason.)
>> >>
>> >> Mario, want to jump in on your thinking here?
>> >>
>> >> --
>> >>   Peter
>> >
>> > After talking to the team, I was told this particular implementation to not
>> let
>> > OS take control when acting on that specific UUID based upon a variable
>> > (NEXP in this case) came from Intel RC code.
>> >
>> > That's probably why this is all across a lot of platforms, including non-Dell.
>> >
>> > At least in the context of the laptop Peter noticed this on (Dell XPS 13 9350)
>> > NEXP is set in GNVS based upon Thunderbolt capability.
>> >
>> > As for why they return unrecognized UUID instead of just masking all the
>> > capabilities bits?  It's the same net functional result.  If the vendor provided
>> > RC code doesn't caused WCHK problems or functional problems it's hard to
>> > make a case for why it needs to be changed by the OEM.
>> >
>> > I think that Peter's patch is appropriate to message this is specifically
>> > what's going on.
>>
>> No, it may hide real (ie. non-intentional) bugs in _OSC, so it is not
>> appropriate.
>>
>> Debug-level messages really should not hurt anyone (and should never
>> show up in production anyway).
>>
>> We can slightly tone down the "_OSC failed (%s); disabling ASPM\n"
>> message in negotiate_os_control() in drivers/acpi/pci_root.c if you
>> think it's too strong and that's it.
>>
>> Thanks,
>> Rafael
>
> I think changing that would help communicate what's going on here and at
> least let the user know the result will be that the firmware is still controlling
> ASPM due to the _OSC failure.
>
> Something else that I think Andy recommended a while back was at that
> time try to evaluate NEXP and display its value and an associated message
> in debug logs when _OSC fails.  Would you be amenable to a change like that?

That seems dangerous if NEXP is anything other than a SystemMemory
variable.  I don't know if there's a clean way to check that before
evaluating it.  (i.e. we don't want to hit some other thing called
NEXP that has side effects.)

-- 
Andy Lutomirski
AMA Capital Management, LLC
