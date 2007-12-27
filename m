From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend code ordering (again)
Date: Thu, 27 Dec 2007 21:00:19 +0100
Message-ID: <200712272100.20282.rjw@sisk.pl>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no> <fa.XycBwhGuyvtVl/QW5HONqLwOags@ifi.uio.no> <4773E9EE.40107@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43811 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbXL0Tkm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 14:40:42 -0500
In-Reply-To: <4773E9EE.40107@shaw.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, "H. Peter Anvin" <hpa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, 27 of December 2007, Robert Hancock wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday, 26 of December 2007, Linus Torvalds wrote:
> >> On Tue, 25 Dec 2007, Rafael J. Wysocki wrote:
> >>> the ACPI specification between versions 1.0x and 2.0.  Namely, while ACPI
> >>> 2.0 and later wants us to put devices into low power states before calling
> >>> _PTS, ACPI 1.0x wants us to do that after calling _PTS.  Since we're following
> >>> the 2.0 and later specifications right now, we're not doing the right thing for
> >>> the (strictly) ACPI 1.0x-compliant systems.
> >>>
> >>> We ought to be able to fix things on the high level, by calling _PTS earlier on
> >>> systems that claim to be ACPI 1.0x-compliant.  That will require us to modify
> >>> the generic susped code quite a bit and will need to be tested for some time.
> >> That's insane. Are you really saying that ACPI wants totally different 
> >> orderings for different versions of the spec?
> > 
> > Yes, I am.
> > 
> >> And does Windows really do that?
> > 
> > I don't know.
> > 
> >> Please don't make lots of modifications to the generic suspend code. The 
> >> only thing that is worth doing is to just have a firmware callback before 
> >> the "device_suspend()" thing (and then on a ACPI-1.0 system, call _PTS 
> >> *there*), and on an ACPI-2.0 system, call _PTS *after* device_suspend().
> > 
> > Yes, that's what I'm going to do, but I need to untangle some ACPI code for
> > this purpose.
> > 
> >> Still, the fact is, some (most, I think) drivers *should* put themselves 
> >> into D3 only in "late_suspend()", so if ACPI-2.0 really expects _PTS to be 
> >> called after that, we're just screwed.
> > 
> > Well, section 9.1.6 of ACPI 2.0 specifies the suspend ordering directly and
> > says exactly that _PTS is to be executed after putting devices into respective
> > D states.
> 
> I would not take those sections as gospel, they're really an example 
> only. It's quite possible that Windows does not follow that ordering.
> 
> Also, as was pointed out, pre-Vista versions of Windows follow ACPI 1.0 
> and Vista follows 3.0, so 2.0 doesn't really matter since BIOS people 
> won't test against it. 1.0 specifies that _PTS is to be called before 
> suspending devices and 3.0 says that the AML must not depend on any 
> specific device power state, so in both cases it should be safe to call 
> _PTS before suspending, no?

Well, IMO, if we take one option only (whichever that is) and there are systems
that follow the other one, they will likely break.

Apart from this, there are BIOSes that openly claim ACPI 2.0 support (for
example, the one in my HP nx6325 does that) and they may actually prefer the
post-ACPI-1.0 ordering even if they work with the pre-ACPI-2.0 one.

Greetings,
Rafael
