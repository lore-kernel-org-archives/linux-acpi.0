From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Tue, 25 May 2010 11:40:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005251138560.4196@localhost.localdomain>
References: <20100126084740.GA5265@jgarrett.org>
 <87y6jkee1b.fsf@basil.nowhere.org> <20100205160900.GA2736@jgarrett.org>
 <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
 <20100426194002.586fbaa5@fido5> <20100427124703.GA16706@jgarrett.org>
 <alpine.LFD.2.00.1004301218280.2489@sony>
 <20100430174447.GA14889@srcf.ucam.org>
 <d7f2dd35a4361e5156079278543769a0@localhost>
 <alpine.LFD.2.00.1005250125590.20648@localhost.localdomain>
 <20100525123701.GA7876@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59799 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab0EYPkf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 May 2010 11:40:35 -0400
In-reply-to: <20100525123701.GA7876@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Philip Langdale <philipl@overt.org>, Jeff Garrett <jeff@jgarrett.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, luming.yu@intel.com, venki@google.com

> > I'm told by the hardware guys that BM_STS is _not_ always
> > a NOP, and so we're not supposed to simply ignore it on C3 --
> > though it should be extremely rare that we see it set.
> > If it is ever set, it should go on and off depending on 
> > activity on some latency sensitive device, like out on the LPC.
> > It may be possible for the BIOS writer to configure the chipset
> > so that BM_STS is enabled always, presumably to accomodate
> > some latency sensitve device -- or maybe by mistake.
> 
> On some hardware we've seen BM_STS be enabled approximately 50% of the 
> time without any obvious cause.

Assuming it is modern hardware, please get the acpidump and lspci -vv
output from that harware to this bug report:

https://bugzilla.kernel.org/show_bug.cgi?id=15886

thanks,
-Len Brown, Intel Open Source Technology Center

