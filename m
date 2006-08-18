From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT/ASL compiler error
Date: Fri, 18 Aug 2006 12:33:30 +0200
Message-ID: <1155897211.4302.1318.camel@queen.suse.de>
References: <20060817170303.GA3592@cactii.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:63657 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751345AbWHRK2e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 06:28:34 -0400
In-Reply-To: <20060817170303.GA3592@cactii.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben B <kernel@bb.cactii.net>
Cc: linux-acpi@vger.kernel.org

On Thu, 2006-08-17 at 19:03 +0200, Ben B wrote:
> Wondering if any ASL experts can help me here. I'm trying to recompile
> the DSDT on my HP NC6400 laptop, to hopefully get some better acpi
> functionality, and I'm seeing the following error:
> 
> $ iasl -tc dsdt.dsl            
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20060608 [Jun 29 2006]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
> 
> dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> Warning  1104 -        Result is not used, operator has no effect ^ 
> 
> dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> Warning  1086 -                                ^ Not all control paths return a value (_DSM)
> 
> dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
> Warning  1079 -                                ^ Reserved method must return a value (_DSM)
> 
> dsdt.dsl 12767:                 CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
> Error    4062 -                                         Object does not exist ^  (\_SB.C002.C003._X0F._LEN)
> 
I expect this is an HP Bios...
Try:
CreateByteField (C1D3, \_SB.C002.C003.C334._X0F._LEN, C08F)
instead of
CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
in line 12767. The rest should be harmless.

   Thomas

