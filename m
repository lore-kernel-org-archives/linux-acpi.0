From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Tue, 11 Nov 2008 18:14:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
 <200811080930.21462.arvidjaar@mail.ru>
 <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
 <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org>
 <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:43614 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYKKXOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 18:14:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA600MRAZ8CYPW7@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 17:14:37 -0600 (CST)
In-reply-to: <20081110130029.GC30894@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>



On Mon, 10 Nov 2008, Matthew Garrett wrote:

> On Mon, Nov 10, 2008 at 01:56:30PM +0100, Ingo Molnar wrote:
> > * Matthew Garrett <mjg@redhat.com> wrote:
> > > or something. Microsoft appear to have moved away from using date 
> > > cutoffs for anything other than whether or not to enable ACPI in the 
> > > first place, and we ought to attempt compatibility with them.
> > 
> > okay, that's fine to me too. My main point is that we need something 
> > nuanced this time around (be it a string check or a cutoff) - not the 
> > "enable again" patch that i saw in the ACPI tree and which i had to 
> > NAK.
> 
> All we need now is confirmation as to which versions of Windows use this 
> behaviour.

We knows XP and Vista do it.

But upstream doesn't currently check the FADT.flags.reset-reg-supported bit
due to a recent bad guess on my part on how to be bug compatible with 
windows.

The (revert) patch to add that check is in my tree, along with
the trivial patch to flip the default to acpi-reset.

Technically, that is the only "unanced" thing we should need
to check.  However, it will not fix Avi's box, where it appears
that flag is present, the reset works, but for some reason the
keyboard fails after reset.  More likely that is a device driver
issue specific to Linux interacting with "unexpected" BIOS behavior.

Ingo,
If you don't mind, I'd like to continue to keep a version
of the acpi-reset-default patch in my test tree so that
it is seen by linux-next.  Once I have something that
I think merits upstream inclusion, I'll send a request
to you.  Will that work?

thanks,
-Len

