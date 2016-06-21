From: Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Tue, 21 Jun 2016 11:18:55 -0400
Message-ID: <20160621151853.GE28967@redhat.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com>
 <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
 <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>
List-Id: linux-acpi@vger.kernel.org

(Sorry for the slow response - it's deadline time over here.)

On Thu, Jun 16, 2016 at 04:56:57PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 16, 2016 at 2:12 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Jun 16, 2016 at 12:15 AM, Peter Jones <pjones@redhat.com> wrote:
> >> Right now when booting, on many laptops the firmware manages the PCIe
> >> bus.  As a result, when we call the _OSC ACPI method, it returns an
> >> error code.  Unfortunately the errors are not very articulate.
> >
> > What exactly do you mean here?
> >
> >>  As a result, we show:
> >>
> >> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> >> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> >> \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid UUID
> >> _OSC request data: 1 1f 0
> >
> > So _OSC told us that the UUID was invalid, didn't it?
> 
> BTW, the above messages are KERN_DEBUG, so at least in theory they
> shouldn't be visible in production runs.
> 
> Maybe the bug to fix is that they show up when they aren't supposed to?

No - the workflow that I am really trying to remedy is this:

 1) S3 resume sometimes isn't working on some laptop you've got.
 2) start looking at debug messages
 3) this shows an error, so it looks like it's probably the problem
 4) go fishing for red herring
 5) if you happen to know who maintains the DSDT for the platform in
    question, eventually work out that this is working as intended and
    the bug is someplace else.
5b) if you don't know that person, eventually work out that it /might/
     be someplace else...

So the idea was to make it look more like an indication of status, and
less like an error that's causing unrelated problems.

When I talked to Mario at Dell (Cc'd), it wasn't clear to us that
there's a way to distinguish the between the UUID being
invalid/malformed, being merely unsupported, or being supported in some
configurations but not the current one.  In this particular DSDT, the
machine doesn't support the OS controlling any of this if USB-C /
thunderbolt are enabled.  The DSDT is clearly written with the belief
that you have to completely disable the handling for that UUID in this
case, and googling for this looks like it's not the only one written
with that belief.

Reading the spec (v6.1, sections 6.2.11.3 and 6.2.11.4), it seems
plausible that you can express this instead by handling the UUID but
choosing each individual query/status bit in the way that accomplishes
the OS doing nothing with the response.  So it may well be that that's
just more code that vendors have thought wasn't necessary (or wasn't
correct for some reason.)

Mario, want to jump in on your thinking here?

-- 
  Peter
