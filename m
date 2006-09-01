From: Andi Kleen <ak@suse.de>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: 01 Sep 2006 23:52:14 +0200
Message-ID: <p73d5af5k6p.fsf@verdi.suse.de>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	<200608311713.21618.bjorn.helgaas@hp.com>
	<1157070616.7974.232.camel@localhost.localdomain>
	<200608312353.05337.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:6579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751045AbWIAVwn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Sep 2006 17:52:43 -0400
In-Reply-To: <200608312353.05337.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org


Len Brown <len.brown@intel.com> writes:
> 
> Re: optimizing suspend/resume speed
> I expect suspend/resume speed has more to do with devices than with ACPI.
> But frankly, with gaping functionality holes in Linux suspend/resume support such as
> IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
> is somewhat "forward looking".

What are these gaping holes? SATA seems to work at least on many
drivers with an out of tree patch (that will hopefully be merged soon)
And IDE mostly works too except for HPA on thinkpads (which can be
disabled in the BIOS). While certainly not perfect it doesn't seem
that bad to me.

-Andi


-- 
VGER BF report: H 0
