From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
Date: Fri, 01 Sep 2006 23:57:25 +0100
Message-ID: <1157151445.6271.336.camel@localhost.localdomain>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <200608312353.05337.len.brown@intel.com>  <p73d5af5k6p.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750740AbWIAWgm@vger.kernel.org>
In-Reply-To: <p73d5af5k6p.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
List-Id: linux-acpi@vger.kernel.org

Ar Gwe, 2006-09-01 am 23:52 +0200, ysgrifennodd Andi Kleen:
> What are these gaping holes? SATA seems to work at least on many
> drivers with an out of tree patch (that will hopefully be merged soon)

SATA ought to be pretty good now. 

> And IDE mostly works too except for HPA on thinkpads (which can be
> disabled in the BIOS). While certainly not perfect it doesn't seem
> that bad to me.

IDE also fails for various chipsets where PLLs need a recalibration or
setup needs redoing, and some users report things like floating IRQ 14
hangs on suspend or resume.

HPA now has a -mm proposed patch.

Alan


-- 
VGER BF report: H 0
