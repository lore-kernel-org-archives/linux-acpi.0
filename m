From: Len Brown <len.brown@intel.com>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Thu, 31 Aug 2006 23:53:04 -0400
Message-ID: <200608312353.05337.len.brown@intel.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:10689 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750967AbWIADwF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Aug 2006 23:52:05 -0400
In-Reply-To: <1157070616.7974.232.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jg@laptop.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org

On Thursday 31 August 2006 20:30, Jim Gettys wrote:
> On Thu, 2006-08-31 at 17:13 -0600, Bjorn Helgaas wrote:
> > On Wednesday 30 August 2006 13:43, Matthew Garrett wrote:
> > > That would be helpful. For the One Laptop Per Child project (or whatever 
> > > it's called today), it would be advantageous to run without acpi.
> > 
> > Out of curiosity, what is the motivation for running without acpi?
> > It costs a lot to diverge from the mainstream in areas like that,
> > so there must be a big payoff.  But maybe if OLPC depends on acpi
> > being smarter about power or code size or whatever, those improvements
> > could be made and everybody would benefit.
> 
> Good question; I see Matthew beat me to part of the explanation, but
> here is more detail:

I recommended that the OLPC guys not use ACPI.

I do not think it would benefit their system.  Although it is an i386
instruction set, their system is more like an embedded device than
like a traditional laptop.

The Geode doesn't suport any C-states -- so ACPI wouldn't help them there anyway.

As Jim wrote, OLPC plans to suspend-to-ram from idle, and to keep video running,
so ACPI wouldn't help them on that either.

Re: optimizing suspend/resume speed
I expect suspend/resume speed has more to do with devices than with ACPI.
But frankly, with gaping functionality holes in Linux suspend/resume support such as
IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
is somewhat "forward looking".

-Len
