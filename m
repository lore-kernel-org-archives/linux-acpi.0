From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT/ASL compiler error
Date: Fri, 18 Aug 2006 15:09:56 +0200
Message-ID: <1155906597.4302.1339.camel@queen.suse.de>
References: <20060817170303.GA3592@cactii.net>
	 <1155897211.4302.1318.camel@queen.suse.de>
	 <20060818112517.GB4945@poupinou.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:3740 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbWHRNE7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 09:04:59 -0400
In-Reply-To: <20060818112517.GB4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Ben B <kernel@bb.cactii.net>, linux-acpi@vger.kernel.org

On Fri, 2006-08-18 at 13:25 +0200, Bruno Ducrot wrote:
> On Fri, Aug 18, 2006 at 12:33:30PM +0200, Thomas Renninger wrote:
> > On Thu, 2006-08-17 at 19:03 +0200, Ben B wrote:
> > > Wondering if any ASL experts can help me here. I'm trying to recompile
> > > the DSDT on my HP NC6400 laptop, to hopefully get some better acpi
> > > functionality, and I'm seeing the following error:
> > > 
> > > $ iasl -tc dsdt.dsl            
> > > 
> > > Intel ACPI Component Architecture
> > > ASL Optimizing Compiler version 20060608 [Jun 29 2006]
> > > Copyright (C) 2000 - 2006 Intel Corporation
> > > Supports ACPI Specification Revision 3.0a
> > > 
> > > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> > > Warning  1104 -        Result is not used, operator has no effect ^ 
> > > 
> > > dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> > > Warning  1086 -                                ^ Not all control paths return a value (_DSM)
> > > 
> > > dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> > > Warning  1079 -                                ^ Reserved method must return a value (_DSM)
> > > 
> > > dsdt.dsl 12767:                 CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
> > > Error    4062 -                                         Object does not exist ^  (\_SB.C002.C003._X0F._LEN)
> > > 
> > I expect this is an HP Bios...
> > Try:
> > CreateByteField (C1D3, \_SB.C002.C003.C334._X0F._LEN, C08F)
> > instead of
> > CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
> > in line 12767. The rest should be harmless.
> > 
> 
> I'm not sure if that's one is harmless:
> > > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> It's as if the asl writter wanted to clear the upper bits of Local1, but forgot to
> assign it back to Local1.  It might be something like this:
> 	And(Local1, 0xFFFF, Local1)
> 
> It's only a rough guess though, and wihtout knowing what was the
> original intention, and without the source of the ASL, it's hard
> to tell for sure.

Thanks.

I checked on a very similar DSDT table:
This line seems only to be used for the WMAA method:
Method (WMAA, 3, NotSerialized)
{
    Return (C23E (Arg1, Arg2))
}
C23E->C24B->C1AB(in this function is the line), the functions are only
used once in DSDT.
I expect this method is part of the Windows Management Instrumentation
(WMI -> [1]).
The functions might have other names in your dsl output file.
As the WMAA function shouldn't get used on a current linux system it
should be harmless in the end.

(unfortunately, I hoped that was the missing hint to fix some things on
this system).

Sorry Ben, I can't help you with the HPQ0004 device, I don't know
anything about this one and don't have such a machine myself.

Thanks again,

     Thomas

[1]: http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

