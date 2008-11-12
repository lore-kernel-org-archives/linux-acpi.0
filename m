From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 12:58:06 +0100
Message-ID: <20081112115806.GD11352@elte.hu>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org> <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org> <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45608 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYKLL6n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 06:58:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


* Len Brown <lenb@kernel.org> wrote:

> 
> 
> On Mon, 10 Nov 2008, Matthew Garrett wrote:
> 
> > On Mon, Nov 10, 2008 at 01:56:30PM +0100, Ingo Molnar wrote:
> > > * Matthew Garrett <mjg@redhat.com> wrote:
> > > > or something. Microsoft appear to have moved away from using date 
> > > > cutoffs for anything other than whether or not to enable ACPI in the 
> > > > first place, and we ought to attempt compatibility with them.
> > > 
> > > okay, that's fine to me too. My main point is that we need something 
> > > nuanced this time around (be it a string check or a cutoff) - not the 
> > > "enable again" patch that i saw in the ACPI tree and which i had to 
> > > NAK.
> > 
> > All we need now is confirmation as to which versions of Windows use this 
> > behaviour.
> 
> We knows XP and Vista do it.
> 
> But upstream doesn't currently check the FADT.flags.reset-reg-supported bit
> due to a recent bad guess on my part on how to be bug compatible with 
> windows.
> 
> The (revert) patch to add that check is in my tree, along with
> the trivial patch to flip the default to acpi-reset.
> 
> Technically, that is the only "unanced" thing we should need
> to check.  However, it will not fix Avi's box, where it appears
> that flag is present, the reset works, but for some reason the
> keyboard fails after reset.  More likely that is a device driver
> issue specific to Linux interacting with "unexpected" BIOS behavior.

hm, will that also fix Andrey's box?

> Ingo,
> If you don't mind, I'd like to continue to keep a version
> of the acpi-reset-default patch in my test tree so that
> it is seen by linux-next.  Once I have something that
> I think merits upstream inclusion, I'll send a request
> to you.  Will that work?

It's fine to me - although i'm a bit uncomfortable about keeping a 
known breakage in linux-next.

linux-next is not really there to experiment around, it's there to 
push the known stable stuff to. linux-next has enough trouble with 
_unintended_ breakages.

At least that's how i push patches to linux-next - i've Cc:-ed Stephen 
and Andrew if there's a clarification needed.

But i _think_ we should be fine even with the KVM related reboot 
problems if we insert the CF9 sequence right before the triple fault.

	Ingo
