From: Thomas Renninger <trenn@suse.de>
Subject: Re: Hardlock during boot on Supermicro C2SBA BIOS v1.1
Date: Mon, 07 Apr 2008 17:57:02 +0200
Message-ID: <1207583822.4700.99.camel@queen.suse.de>
References: <47F9DE3F.1050702@bigpizza.co.uk>
	 <1207578108.4700.82.camel@queen.suse.de>  <47FA3CA0.4080400@bigpizza.co.uk>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44559 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690AbYDGP5F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 11:57:05 -0400
In-Reply-To: <47FA3CA0.4080400@bigpizza.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lists_acpi <lists_acpi@bigpizza.co.uk>
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-04-07 at 16:24 +0100, lists_acpi wrote:
> Thomas Renninger wrote:
> > On Mon, 2008-04-07 at 09:41 +0100, lists_acpi wrote:
> >   
> >> Hello all,
> >>
> >> I recently upgraded the BIOS to v1.1 on my Supermicro C2SBA and found 
> >> that the system would hardlock on boot.  The last message printed on the 
> >> screen was:
> >>
> >>     tbxface-0587 [00] tb_load_namespace : ACPI Tables successfully acquired
> >>     
> > >From another machine with 2.6.22 kernel:
> >  tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acquired
> > evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
> > If your machine really freezes when switching to ACPI mode, I expect
> > something goes wrong in the depth of SMM BIOS operations?
> > Not much one can do from OS then..., still maybe something below helps.
> >
> >   
> >> which lead me to think the problem was caused by some changes to the 
> >> ACPI tables in the new version of the BIOS.  Booting the system with 
> >> "acpi=off irqpoll" then allowed me to boot the system but the system 
> >> would randomly drop off the network. 
> >>     
> > AFAIK it should still be possible to dump ACPI tables with acpidump?
> >
> > If yes, best is you do this with the working and the not working BIOS,
> > open a bug on bugzilla.kernel.org and attach both.
> >
> >   
> What format should I use to create the acpi dumps?  I know nothing of 
> acpi tables so I don't know what information is useful to a developer.  
> I tried "acpidump -o acpidump --binary" but was unable to disassemble it 
> using iasl.  I then tried "acpidump --t DSDT -o acpidump_dsdt --binary" 
> and was able to disassemble it using iasl. 
Just providing the output of acpidump as text/plain mime type attachment
in bugzilla is perfect.
Assign it to the ACPI component and you can add my email to CC.

To have a look at the tables yourself you can (acpidump comes from Len
Brown's pmtools package, acpixtract from Intel's acpica project, the
latter should not be older than say a year or the syntax is another):
acpidump > acpidump
acpixtract -a acpidump

iasl -d DSDT.dat   (to disassemble)
iasl -sa DSDT.dsl  (to recompile)

You might want to do a diff between DSDT.dsl of the two BIOSes, but also
other tables, also static ones can be "disassembled" and compared...,
maybe you find something interesting.

Also comparing default BIOS configuration, might reveal a change (maybe
somewhere in the ACPI area?)?

   Thomas

> > Maybe pci=noacpi or noapic also helps instead of switching off whole
> > acpi?
> > Can you switch off Cstate/C1E/processor deeper sleep states in the new
> > BIOS? Just a guess, maybe it's that?
> >
> >    Thomas
> >
> >   
> When I get a free window with the machine I'll get the ACPI dumps for as 
> many BIOS versions as I can and see if I can change the sleep state with 
> the newest BIOS.


