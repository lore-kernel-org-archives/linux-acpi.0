From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: breakage in current git-acpi
Date: Sun, 25 Feb 2007 00:54:17 -0800
Message-ID: <20070225005417.a9e2245a.akpm@linux-foundation.org>
References: <20070216223956.d04af327.akpm@linux-foundation.org>
	<200702170225.07774.lenb@kernel.org>
	<20070216234948.6bf2ed82.akpm@linux-foundation.org>
	<200702172159.03332.lenb@kernel.org>
	<20070217190755.e708effd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56589 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875AbXBYIzh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Feb 2007 03:55:37 -0500
In-Reply-To: <20070217190755.e708effd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org

> On Sat, 17 Feb 2007 19:07:55 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 17 Feb 2007 21:59:02 -0500 Len Brown <lenb@kernel.org> wrote:
> 
> > 
> > Assuming there is exactly 1 event for each press,
> > then the kernel part of this is healthy.
> > 
> > Assuming the failure is that the lid event fails
> > to trigger the STD after a few iterations,
> > and you did this after the failure started;
> > then it seems the failure isn't the event
> > at all, but perhaps the inability to re-invoke STD.
> > 
> > What happens if you invoke STD manually with
> > # echo disk > /sys/power/state
> 
> That works OK.
> 
> > > 9:       1344   IO-APIC-fasteoi   acpi
> > > 
> > > it's increasing even while the machine is just sitting there.
> > 
> > That's okay -- it is common -- particularly
> > laptops, which are likely to have a number of events ticking away.
> > thermal and fan control, and battery state, in particular.
> >  
> > > > Also, you should be able to see the state of the lid in a file under /proc/acpi/button/*/
> > > 
> > > sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
> > > state:      closed
> > > sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
> > > state:      open
> > > 
> > > all seems well.
> > > 
> > > Stopping and restarting acpid doesn't fix it.
> > 
> > Yeah, it must be suspend-to-disk itself refusing to suspend.
> > Probably when automatically invoked any errors or warnings
> > get sent to /dev/null.
> > Are there any dmesg associated with the failed suspend attempt?
> 
> No messages come out when I shut the lid.
> 
> Manually suspending works normally.
> 
> > How many suspend cycles can you survive before git-acpi is applied?
> 
> I tested up to five or six times once.

So..  I went from 2.6.20-mm1 back to 2.6.21-rc1 the other day and have
since been happily suspending via lid closure maybe ten times a day.

Any more suggestions about how to debug this?

How does the suspend happen, anyway?  Is it acpid's job to read the
LID0/state file and to then poke /sys/power/state?  Or is that linkage
in-kernel?
