From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: DSDT/ASL compiler error
Date: Fri, 18 Aug 2006 13:25:17 +0200
Message-ID: <20060818112517.GB4945@poupinou.org>
References: <20060817170303.GA3592@cactii.net> <1155897211.4302.1318.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:15659 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S964861AbWHRL2r
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 07:28:47 -0400
Content-Disposition: inline
In-Reply-To: <1155897211.4302.1318.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ben B <kernel@bb.cactii.net>, linux-acpi@vger.kernel.org

On Fri, Aug 18, 2006 at 12:33:30PM +0200, Thomas Renninger wrote:
> On Thu, 2006-08-17 at 19:03 +0200, Ben B wrote:
> > Wondering if any ASL experts can help me here. I'm trying to recompile
> > the DSDT on my HP NC6400 laptop, to hopefully get some better acpi
> > functionality, and I'm seeing the following error:
> > 
> > $ iasl -tc dsdt.dsl            
> > 
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler version 20060608 [Jun 29 2006]
> > Copyright (C) 2000 - 2006 Intel Corporation
> > Supports ACPI Specification Revision 3.0a
> > 
> > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> > Warning  1104 -        Result is not used, operator has no effect ^ 
> > 
> > dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> > Warning  1086 -                                ^ Not all control paths return a value (_DSM)
> > 
> > dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> > Warning  1079 -                                ^ Reserved method must return a value (_DSM)
> > 
> > dsdt.dsl 12767:                 CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
> > Error    4062 -                                         Object does not exist ^  (\_SB.C002.C003._X0F._LEN)
> > 
> I expect this is an HP Bios...
> Try:
> CreateByteField (C1D3, \_SB.C002.C003.C334._X0F._LEN, C08F)
> instead of
> CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
> in line 12767. The rest should be harmless.
> 

I'm not sure if that's one is harmless:
> > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
It's as if the asl writter wanted to clear the upper bits of Local1, but forgot to
assign it back to Local1.  It might be something like this:
	And(Local1, 0xFFFF, Local1)

It's only a rough guess though, and wihtout knowing what was the
original intention, and without the source of the ASL, it's hard
to tell for sure.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
