From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86: Add reboot quirk for Dell Precision M4600
Date: Sat, 06 Aug 2011 11:31:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108061120150.3197@x980>
References: <20110727125651.GH3010@suse.de> <20110806065635.GE13220@elte.hu>
 <24c471f7-80f5-4102-a12b-d6245c8d0921@email.android.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:33404 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab1HFPca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Aug 2011 11:32:30 -0400
In-reply-to: <24c471f7-80f5-4102-a12b-d6245c8d0921@email.android.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>, bruno@ioda-net.ch, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 6 Aug 2011, H. Peter Anvin wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> 
> >* Mel Gorman <mgorman@suse.de> wrote:
> >
> >> ACPI reboot does not work for Dell Precision M4600. Detect this
> >> machine via DMI and force the use of the PCI reboot method.
> >>     
> >> Reported-and-tested-by: Bruno Friedmann <bruno@ioda-net.ch>
> >> Signed-off-by: Mel Gorman <mgorman@suse.de>
> >> ---
> >>  arch/x86/kernel/reboot.c |    9 +++++++++
> >>  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> >Weird - ACPI is the default Windows method of reboot - how come it 
> >does not work on that box? Does Windows work around this specific 
> >machine (unlikely), or is our ACPI boot sequence not 100% compatible 
> >with the Windows method (more likely IMO)?
> 
> It seems almost all the affected machines are Dell, too... very odd, no?

Dell website says that the M4600 is current,
and ships with Windows 7.  It is a "mobile workstation",
so it is more likely to have a windows "feature" driver,
say, than Dell's servers.

Matthew,
Did you do your reboot comopatibility test using Win7,
or something older?

BTW, it would be nice if ACPI incompatibilities and workarounds
somehow got stuck in the ACPI code rather than the arch code.
Unfortunately this kind sets a working reboot method instead
of disabling a non-working one -- so what it overrides has
changed when the default changed.

thanks,
-Len Brown, Intel Open Source Technolgy Center

