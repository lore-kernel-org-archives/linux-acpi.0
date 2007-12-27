From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ACPI: WMI: Add ACPI-WMI mapping driver
Date: Thu, 27 Dec 2007 02:21:40 +0000
Message-ID: <20071227022140.GA2143@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235143.12838.33679.stgit@localhost> <20071226211718.GA31564@srcf.ucam.org> <200712270109.40121.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:35924 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXL0CVz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 21:21:55 -0500
Content-Disposition: inline
In-Reply-To: <200712270109.40121.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>

On Thu, Dec 27, 2007 at 01:09:39AM +0000, Carlos Corbacho wrote:
> On Wednesday 26 December 2007 21:17:18 Matthew Garrett wrote:
> > +       if (!wmi_external_handler)
> > +               return AE_ALREADY_ACQUIRED;
> 
> I'm not sure (mostly because I don't like dealing with typedefs around 
> pointers, and this bit is also untested).

At the moment, it's impossible to register a handler - I always get 
AE_ALREADY_ACQUIRED. Getting rid of the ! makes things work like I 
expected.

> > I'm also a bit 
> > unhappy about only being able to register one notification handler, if
> > we consider the case where vendors add and remove WMI interfaces over
> > time - it might make sense to have individual small drivers rather than
> > one big one, which would mean a notification handler per GUID. Any
> > thoughts?
> 
> Yes, a notification handler per GUID does make sense, so I'll add that to WMI.

Excellent, thanks!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
