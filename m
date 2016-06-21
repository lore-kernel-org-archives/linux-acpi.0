From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Wed, 22 Jun 2016 00:54:03 +0200
Message-ID: <CAJZ5v0ipcnC2zP_rGSmvovGVeHWf=xc6N57SnPKHrwCKpynXOw@mail.gmail.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com>
 <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
 <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
 <20160621151853.GE28967@redhat.com> <cf3d90a8598241ff9b6e28b8fb037633@ausx13mpc120.AMER.DELL.COM>
 <CALCETrWYqR22WJDX_CTBFom7Ti_Jc++BRvu3VKJ22QpGe6+6Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWYqR22WJDX_CTBFom7Ti_Jc++BRvu3VKJ22QpGe6+6Xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <Mario_Limonciello@dell.com>, Peter Jones <pjones@redhat.com>, Rafael Wysocki <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 21, 2016 at 8:07 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Jun 21, 2016 at 11:01 AM,  <Mario_Limonciello@dell.com> wrote:
>>> -----Original Message-----
>>> From: Peter Jones [mailto:pjones@redhat.com]
>>> Sent: Tuesday, June 21, 2016 10:19 AM
>>> To: Rafael J. Wysocki <rafael@kernel.org>
>>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Limonciello, Mario
>>> <Mario_Limonciello@Dell.com>; Linux Kernel Mailing List <linux-
>>> kernel@vger.kernel.org>; Len Brown <lenb@kernel.org>; Rafael J . Wysocki
>>> <rjw@rjwysocki.net>; Andy Lutomirski <luto@amacapital.net>
>>> Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
>>> PCIe hotplug.
>>>
>>> (Sorry for the slow response - it's deadline time over here.)
>>>
>>> On Thu, Jun 16, 2016 at 04:56:57PM +0200, Rafael J. Wysocki wrote:
>>> > On Thu, Jun 16, 2016 at 2:12 AM, Rafael J. Wysocki <rafael@kernel.org>
>>> wrote:
>>> > > On Thu, Jun 16, 2016 at 12:15 AM, Peter Jones <pjones@redhat.com>
>>> wrote:
>>> > >> Right now when booting, on many laptops the firmware manages the
>>> PCIe
>>> > >> bus.  As a result, when we call the _OSC ACPI method, it returns an
>>> > >> error code.  Unfortunately the errors are not very articulate.
>>> > >
>>> > > What exactly do you mean here?
>>> > >
>>> > >>  As a result, we show:
>>> > >>
>>> > >> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
>>> > >> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
>>> Segments MSI]
>>> > >> \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid
>>> UUID
>>> > >> _OSC request data: 1 1f 0
>>> > >
>>> > > So _OSC told us that the UUID was invalid, didn't it?
>>> >
>>> > BTW, the above messages are KERN_DEBUG, so at least in theory they
>>> > shouldn't be visible in production runs.
>>> >
>>> > Maybe the bug to fix is that they show up when they aren't supposed to?
>>>
>>> No - the workflow that I am really trying to remedy is this:
>>>
>>>  1) S3 resume sometimes isn't working on some laptop you've got.
>>>  2) start looking at debug messages
>>>  3) this shows an error, so it looks like it's probably the problem
>>>  4) go fishing for red herring
>>>  5) if you happen to know who maintains the DSDT for the platform in
>>>     question, eventually work out that this is working as intended and
>>>     the bug is someplace else.
>>> 5b) if you don't know that person, eventually work out that it /might/
>>>      be someplace else...
>>>
>>> So the idea was to make it look more like an indication of status, and
>>> less like an error that's causing unrelated problems.
>>>
>>> When I talked to Mario at Dell (Cc'd), it wasn't clear to us that
>>> there's a way to distinguish the between the UUID being
>>> invalid/malformed, being merely unsupported, or being supported in some
>>> configurations but not the current one.  In this particular DSDT, the
>>> machine doesn't support the OS controlling any of this if USB-C /
>>> thunderbolt are enabled.  The DSDT is clearly written with the belief
>>> that you have to completely disable the handling for that UUID in this
>>> case, and googling for this looks like it's not the only one written
>>> with that belief.
>>>
>>> Reading the spec (v6.1, sections 6.2.11.3 and 6.2.11.4), it seems
>>> plausible that you can express this instead by handling the UUID but
>>> choosing each individual query/status bit in the way that accomplishes
>>> the OS doing nothing with the response.  So it may well be that that's
>>> just more code that vendors have thought wasn't necessary (or wasn't
>>> correct for some reason.)
>>>
>>> Mario, want to jump in on your thinking here?
>>>
>>> --
>>>   Peter
>>
>> After talking to the team, I was told this particular implementation to not let
>> OS take control when acting on that specific UUID based upon a variable
>> (NEXP in this case) came from Intel RC code.
>>
>> That's probably why this is all across a lot of platforms, including non-Dell.
>>
>> At least in the context of the laptop Peter noticed this on (Dell XPS 13 9350)
>> NEXP is set in GNVS based upon Thunderbolt capability.
>>
>> As for why they return unrecognized UUID instead of just masking all the
>> capabilities bits?  It's the same net functional result.  If the vendor provided
>> RC code doesn't caused WCHK problems or functional problems it's hard to
>> make a case for why it needs to be changed by the OEM.
>>
>> I think that Peter's patch is appropriate to message this is specifically
>> what's going on.
>>
>
> In general, it seems that Windows is considerably less inclined to
> throw out errors when the DSDT contains spec violations.  It would be
> great if Microsoft were to tighten up their requirements :)

Agreed (but I speak for myself only as usual).

> I wonder if Intel could be persuaded to add an ACPI mechanism to grant
> PCIe native control per device or per bus instead of more-or-less
> globally as it is now.

I guess at least in some cases it just has to be done that way.

Thanks,
Rafael
