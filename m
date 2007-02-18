From: Len Brown <lenb@kernel.org>
Subject: Re: breakage in current git-acpi
Date: Sat, 17 Feb 2007 21:59:02 -0500
Message-ID: <200702172159.03332.lenb@kernel.org>
References: <20070216223956.d04af327.akpm@linux-foundation.org> <200702170225.07774.lenb@kernel.org> <20070216234948.6bf2ed82.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46263 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993109AbXBRC5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Feb 2007 21:57:13 -0500
In-Reply-To: <20070216234948.6bf2ed82.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 17 February 2007 02:49, Andrew Morton wrote:
> On Sat, 17 Feb 2007 02:25:07 -0500 Len Brown <lenb@kernel.org> wrote:
> 
> > On Saturday 17 February 2007 01:39, Andrew Morton wrote:
> > > 
> > > Standard FC5 RH install, it is set up to suspend to disk when I close the
> > > lid.
> > > 
> > > With git-acpi.patch applied, this just stops working on the second or third
> > > attempt.  It's like acpid just didn't see the lid close at all.  Closing
> > > the lid causes no kernel messages at all.
> > > 
> > > Any suggestions as to how to debug this, apart from git-bisect, which will
> > > take rather a long time?
> > 
> > nuke kacpid
> 
> I hope you meant acpid - I can't kill a kernel thread ;)

right -- this is why I don't try to cut code at 3am;-)

> > and cat /proc/acpi/event
> 
> > click the lid a bunch of times
> 
> sony:/home/akpm# cat /proc/acpi/event
> button/lid LID0 00000080 00000005
> button/lid LID0 00000080 00000006
> button/lid LID0 00000080 00000007
> button/lid LID0 00000080 00000008
> 
> 
> > and also the power button
> 
> button/power PWRB 00000080 00000001
> button/power PWRB 00000080 00000002
> button/power PWRB 00000080 00000003
> button/power PWRB 00000080 00000004
> 
> > you should see the acpi line in /proc/interrupts tick each time,
> > and a message come out of /proc/acpi/event

Assuming there is exactly 1 event for each press,
then the kernel part of this is healthy.

Assuming the failure is that the lid event fails
to trigger the STD after a few iterations,
and you did this after the failure started;
then it seems the failure isn't the event
at all, but perhaps the inability to re-invoke STD.

What happens if you invoke STD manually with
# echo disk > /sys/power/state

> 9:       1344   IO-APIC-fasteoi   acpi
> 
> it's increasing even while the machine is just sitting there.

That's okay -- it is common -- particularly
laptops, which are likely to have a number of events ticking away.
thermal and fan control, and battery state, in particular.
 
> > Also, you should be able to see the state of the lid in a file under /proc/acpi/button/*/
> 
> sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
> state:      closed
> sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
> state:      open
> 
> all seems well.
> 
> Stopping and restarting acpid doesn't fix it.

Yeah, it must be suspend-to-disk itself refusing to suspend.
Probably when automatically invoked any errors or warnings
get sent to /dev/null.
Are there any dmesg associated with the failed suspend attempt?

How many suspend cycles can you survive before git-acpi is applied?

-Len
