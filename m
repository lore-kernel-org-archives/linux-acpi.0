From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: iasl and SSDT disassembling limitations
Date: Tue, 18 Nov 2008 16:00:53 +0800
Message-ID: <1226995253.32759.11.camel@minggr.sh.intel.com>
References: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com>
	 <200811121817.22589.trenn@suse.de>
	 <1226559749.30025.171.camel@minggr.sh.intel.com>
	 <200811141728.40581.trenn@suse.de>
	 <1226994826.32759.4.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48938 "EHLO mga02.intel.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751127AbYKRIEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Nov 2008 03:04:10 -0500
In-Reply-To: <1226994826.32759.4.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "elendil@planet.nl" <elendil@planet.nl>, "devel@lists.acpica.org" <devel@lists.acpica.org>

On Tue, 2008-11-18 at 15:53 +0800, Lin Ming wrote:
> On Sat, 2008-11-15 at 00:28 +0800, Thomas Renninger wrote:
> > On Thursday 13 November 2008 08:02:29 Lin Ming wrote:
> > > On Thu, 2008-11-13 at 08:17 +0800, Thomas Renninger wrote:
> > > > On Friday 24 October 2008 05:50:30 am Lin Ming wrote:
> > > > > We have added a "-e" option to iasl that include tables for external
> > > > > symbol resolution. See
> > > > > http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=2f705a1b06109e
> > > > >12bd 2659d0e12215710a5622b7
> > > > >
> > > > >
> > > > > Example: To disassemble an SSDT with external symbols defined in DSDT:
> > > > >
> > > > > iasl -e dsdt.aml -d ssdt.aml
> > > >
> > > > I thought this option already existed for quite a while?
> > > > Did it get re-implemented?
> > >
> > > No, the original one is a NULL implementation.
> > It did not work, but it already remembered unresolved objects/functions and 
> > tried to resolve them correctly from the -e passed table.
> > Either this or I did mess up something completely when I played with that 
> > maybe a year ago.
> > 
> > >
> > > > IIRC I already saw references in both directions. SSDT is making use of
> > > > variables declared in the DSDT and vice versa (rare, but it can happen).
> > > >
> > > > IMO a proper long-term solution would be to be able to do:
> > > > iasl -d [DS]SDT*.dsl
> > > > iasl then parses every table, remembers unresolved objects and then goes
> > > > through these, once the last table got parsed.
> > > >
> > > > Probably one step harder to implement, do you think this is possible to
> > > > do or should such things be considered as BIOS implementation bugs?
> > >
> > > It's possible, but harder. External symbol is not a BIOS bug.
> > Do you plan to extend the functionality that external symbols can be
> > resolved in both directions, e.g. by passing all DSDT and SSDT tables:
> > iasl -d DSDT.dsl SSDT1.dsl SSDT2.dsl
> 
> Yes, both directions.

Sorry for my misunderstanding here.
No, currently I don't have this plan.
But it's a good idea, I'll put it in the to-do list.

Thanks,
Lin Ming

> 
> > I tried that unsuccessfully quite some time ago.
> 
> I have some patches here.
> You can try it again when next version of iasl is released.
> 
> Lin Ming
> 
> > Now one still has an overview how this could be done :)
> > iasl -e DSDT.dsl SSDTx.dsl
> > should now work in much more cases, but I fear there will be some which
> > are still not covered (if DSDT references variables declared in SSDTs).
> > 
> > > iasl tries to guess the arguments of external methods, and it success at
> > > most time (-e option is not needed).
> > >
> > > But sometimes it fails, and then you can use -e option to include the
> > > external tables to resolve the external symbols.
> > Yes, and having this working makes it possible to more reliably check
> > BIOSes against ASL syntax errors.
> > 
> > Thanks a lot for your efforts,
> > 
> >      Thomas
> > 
> > > Lin Ming
> > >
> > > > Thanks,
> > > >
> > > >       Thomas
> > > >
> > > > > Lin Ming
> > > > >
> > > > > > From: linux-acpi-owner@vger.kernel.org
> > > > > > [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore, Robert
> > > > > > Sent: Saturday, September 27, 2008 12:49 AM
> > > > > > To: Henrique de Moraes Holschuh
> > > > > > Cc: linux-acpi@vger.kernel.org
> > > > > > Subject: RE: iasl and SSDT disassembling limitations
> > > > > >
> > > > > > Yes, it should be possible, and it is on our list of things to look
> > > > > > at.
> > > > > >
> > > > > > A little more info on the problem: Without the definition of the
> > > > > > control method, the disassembler has no way of knowing how many
> > > > > > arguments should be passed to the method. Without this information,
> > > > > > it does not know how many expressions to parse after the control
> > > > > > method invocation in order to create the arguments. The information
> > > > > > is simply not available. So it tries to guess.
> > > > > >
> > > > > > Bob
> > > > > >
> > > > > > >-----Original Message-----
> > > > > > >From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
> > > > > > >Sent: Friday, September 26, 2008 9:09 AM
> > > > > > >To: Moore, Robert
> > > > > > >Cc: linux-acpi@vger.kernel.org
> > > > > > >Subject: iasl and SSDT disassembling limitations
> > > > > > >
> > > > > > >On Fri, 26 Sep 2008, Moore, Robert wrote:
> > > > > > >> Most of the problems seen in the SSDT are related to the fact that
> > > > > > >> the disassembler cannot always correctly disassemble code that
> > > > > > >> contains calls to control methods that are external to the table.
> > > > > > >> There is not enough information to disassemble correctly, and the
> > > > > > >> table often needs to be repaired by hand.
> > > > > > >
> > > > > > >Can iasl be improved to properly disassemble such tables if we give
> > > > > > > it ALL tables to work with?
> > > > > > >
> > > > > > >--
> > > > > > >  "One disk to rule them all, One disk to find them. One disk to
> > > > > > > bring them all and in the darkness grind them. In the Land of
> > > > > > > Redmond where the shadows lie." -- The Silicon Valley Tarot
> > > > > > >  Henrique Holschuh
> > > > > >
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > > > > > in the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > > > > in the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 

