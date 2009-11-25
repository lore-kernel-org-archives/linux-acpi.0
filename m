From: Len Brown <lenb@kernel.org>
Subject: Re: No c2-c7 states on core i7
Date: Wed, 25 Nov 2009 01:59:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911250154350.8459@localhost.localdomain>
References: <4B06A7A8.109@slagter.name>
 <1258945512.3773.33.camel@localhost.localdomain>
 <4B0A4D62.2040001@slagter.name>
 <alpine.LFD.2.00.0911231101150.858@localhost.localdomain>
 <4B0AE1FD.4030108@slagter.name>
 <20091124143459.385a0bc9@starbug.prg01.itonis.net>
 <4B0BE5B8.7060402@slagter.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:56369 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZKYG7u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:59:50 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN006DUKRWLBD5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:59:56 -0600 (CST)
In-reply-to: <4B0BE5B8.7060402@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Jindrich Makovicka <makovick@gmail.com>, linux-acpi@vger.kernel.org

> Yesterday I raised the clock to 3.4 Ghz and I set all voltages to "normal" and
> it seems to run fine. I will have to check under really heavy load yet, I will
> do that tonight. My motherboard has an option "power line load calibration", I
> guess that has something to do with it :-)
> 
> Interesting: I pulled out a "modern" (but cheapo, no fans) pcie vga card and
> replaced it with a very old pci card (I guess from 1996) and that saves me 20
> watts! That's more power than I problably ever could save using C states!

Yep, beware graphics card power.

> BTW on my ancient athlon-mp board, I could enable c2/c3 (although not
> supported by the bios) and that would save about ~40 watts of power. But it
> looks I won't see such a difference on modern CPU's, maybe because of the
> dynamic frequency scaling and enhanced c1? Is there anyone who can give me an
> indication of what to expect in powersavings by c2-c7 on modern cpu's?

On the mobile parts they used to publish the power limits for C-states,
but I don't see these numbers in the core i7 datasheet...

However, many have done comparisons of what you might expect for
idle vs loaded power.  eg.
http://www.anandtech.com/cpuchipsets/showdoc.aspx?i=3634&p=17

In general, I don't view it as a Linux bug that the MB's BIOS
disables c-states when it is over-clocked.  Indeed, it is
quite possibly a BIOS feature.

Len Brown, Intel Open Source Technology Center



