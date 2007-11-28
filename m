From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Wed, 28 Nov 2007 17:28:24 +0100
Message-ID: <1196267304.23251.165.camel@queen.suse.de>
References: <200711131724.31868.carlos@strangeworlds.co.uk>
	 <200711131849.56964.carlos@strangeworlds.co.uk> <4739F2FB.9080800@suse.de>
	 <200711131903.03018.carlos@strangeworlds.co.uk>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:54497 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758016AbXK1Q20 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2007 11:28:26 -0500
In-Reply-To: <200711131903.03018.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>

On Tue, 2007-11-13 at 19:03 +0000, Carlos Corbacho wrote:
> Alexey,
> 
> > How about character /dev/ec0?
> 
> Yes, that would be fine.
> 
> On Tuesday 13 November 2007 18:54:51 Alexey Starikovskiy wrote:
> > What is the benefit of having acer_acpi in userspace, rather than one more
> > *-laptop in /devices/misc?
> 
> A debate of "would it be easier for me to maintain an in kernel driver (if/ 
> when I can get it upstream) or a userspace application". At the moment, the 
> idea of a full blown userspace application is just something I'm toying with 
> in my head whilst working on WMI userspace.

I very much like the idea of a general EC debug/devel interface to
userspace.
It should be a separate CONFIG, marked "DEBUG", "EXPERIMENTAL" or
whatever and be per default off.
It is stupid that everybody who wants to debug a bit on EC registers
needs to duplicate the IBM EC implementation, this should IMO be moved
where it belongs to:
drivers/acpi/ec.c

The question is whether Len will accept/like it, Len?

   Thomas

