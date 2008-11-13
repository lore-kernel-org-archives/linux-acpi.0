From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: iasl and SSDT disassembling limitations
Date: Thu, 13 Nov 2008 15:02:29 +0800
Message-ID: <1226559749.30025.171.camel@minggr.sh.intel.com>
References: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com>
	 <1224845430.14280.58.camel@minggr.sh.intel.com>
	 <200811121817.22589.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7140 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbYKMHEL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 02:04:11 -0500
In-Reply-To: <200811121817.22589.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "elendil@planet.nl" <elendil@planet.nl>, "devel@lists.acpica.org" <devel@lists.acpica.org>

On Thu, 2008-11-13 at 08:17 +0800, Thomas Renninger wrote:
> On Friday 24 October 2008 05:50:30 am Lin Ming wrote:
> > We have added a "-e" option to iasl that include tables for external
> > symbol resolution. See
> > http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=2f705a1b06109e12bd
> >2659d0e12215710a5622b7
> >
> >
> > Example: To disassemble an SSDT with external symbols defined in DSDT:
> >
> > iasl -e dsdt.aml -d ssdt.aml
> 
> I thought this option already existed for quite a while?
> Did it get re-implemented?

No, the original one is a NULL implementation.

> 
> IIRC I already saw references in both directions. SSDT is making use of 
> variables declared in the DSDT and vice versa (rare, but it can happen).
> 
> IMO a proper long-term solution would be to be able to do:
> iasl -d [DS]SDT*.dsl
> iasl then parses every table, remembers unresolved objects and then goes 
> through these, once the last table got parsed.
> 
> Probably one step harder to implement, do you think this is possible to do or 
> should such things be considered as BIOS implementation bugs?

It's possible, but harder. External symbol is not a BIOS bug.

iasl tries to guess the arguments of external methods, and it success at
most time (-e option is not needed).

But sometimes it fails, and then you can use -e option to include the
external tables to resolve the external symbols.

Lin Ming

> 
> Thanks,
> 
>       Thomas
> 
> >
> > Lin Ming
> >
> > > From: linux-acpi-owner@vger.kernel.org
> > > [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore, Robert
> > > Sent: Saturday, September 27, 2008 12:49 AM
> > > To: Henrique de Moraes Holschuh
> > > Cc: linux-acpi@vger.kernel.org
> > > Subject: RE: iasl and SSDT disassembling limitations
> > >
> > > Yes, it should be possible, and it is on our list of things to look at.
> > >
> > > A little more info on the problem: Without the definition of the control
> > > method, the disassembler has no way of knowing how many arguments should
> > > be passed to the method. Without this information, it does not know how
> > > many expressions to parse after the control method invocation in order to
> > > create the arguments. The information is simply not available. So it
> > > tries to guess.
> > >
> > > Bob
> > >
> > > >-----Original Message-----
> > > >From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
> > > >Sent: Friday, September 26, 2008 9:09 AM
> > > >To: Moore, Robert
> > > >Cc: linux-acpi@vger.kernel.org
> > > >Subject: iasl and SSDT disassembling limitations
> > > >
> > > >On Fri, 26 Sep 2008, Moore, Robert wrote:
> > > >> Most of the problems seen in the SSDT are related to the fact that the
> > > >> disassembler cannot always correctly disassemble code that contains
> > > >> calls to control methods that are external to the table. There is not
> > > >> enough information to disassemble correctly, and the table often needs
> > > >> to be repaired by hand.
> > > >
> > > >Can iasl be improved to properly disassemble such tables if we give it
> > > > ALL tables to work with?
> > > >
> > > >--
> > > >  "One disk to rule them all, One disk to find them. One disk to bring
> > > >  them all and in the darkness grind them. In the Land of Redmond
> > > >  where the shadows lie." -- The Silicon Valley Tarot
> > > >  Henrique Holschuh
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

