From: Thomas Renninger <trenn@suse.de>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 13:36:14 +0200
Message-ID: <1210764974.29724.181.camel@queen.suse.de>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
	 <200805132048.00653.lenb@kernel.org> <20080514005636.GA21608@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:40418 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757339AbYENLgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 07:36:16 -0400
In-Reply-To: <20080514005636.GA21608@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, cpufreq@lists.linux.org.uk, Alex =?ISO-8859-1?Q?Villac=ED=ADs?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wed, 2008-05-14 at 01:56 +0100, Matthew Garrett wrote:
> On Tue, May 13, 2008 at 08:48:00PM -0400, Len Brown wrote:
> 
> > Assuming this is a laptop with a batter,
> > I'd certainly be interested if you could run BLTK
> > and measure any benefit to p4-clockmod (I've never
> > been able to)
> 
> The most plausible benefit to p4-clockmod is its utility in throttling 
> the CPU if it would otherwise cause the system to overheat. From that 
> point of view, I think it's worth keeping around - especially since not 
> all machines expose T states via ACPI.

If you think it's worth it..., but it needs a new implementation (at
another place). So just removing it for now should be best to avoid
further confusion.

Also there is another interface via mce:
arch/x86/kernel/cpu/mcheck/therm_throt.c

AFAIK this should be implemented in (all?) P4s, but Intel people should
know for sure.

This one should kick in for sure on high temperatures, are there any P4s
with a passive trip point defined?

I like the idea of reimplementing this via throttling interface. But
this is more for calming P4 users conscience (I saw my P4 running at 300
MHz on Windows) than for any real use.

   Thomas

