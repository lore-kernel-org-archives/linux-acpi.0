From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 19:33:44 -0300
Message-ID: <20080620223344.GC3417@khazad-dum.debian.net>
References: <20080620152227.GA11828@srcf.ucam.org> <20080620193941.GC20498@khazad-dum.debian.net> <20080620195840.GA16284@srcf.ucam.org> <20080620220120.GB3417@khazad-dum.debian.net> <20080620221308.GB18980@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34748 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752305AbYFTWdr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 18:33:47 -0400
Content-Disposition: inline
In-Reply-To: <20080620221308.GB18980@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, 20 Jun 2008, Matthew Garrett wrote:
> On Fri, Jun 20, 2008 at 07:01:20PM -0300, Henrique de Moraes Holschuh wrote:
> > Sounds like a good idea, but in order to do that, we just need to let
> > kernel drivers hook to GPE handlers somehow.  I'd be quite happy to add
> > support for it to thinkpad-acpi.
> 
> I expected that the method name would probably be more consistent, 
> whereas the GPE number might change in a way that was difficult to hook. 
> There's only three CMOS update methods in the range of Thinkpad BIOSes, 
> IIRC?

True.  Well, both would work, and I'd have to add this as a whitelist
anyway (which is NOT a problem, as we are talking about old thinkpads
anyway, and there is a finite, non-extremely-huge number of those).

It works marginally better if one traps the GPE, as that looks a lot
more like what one gets in a modern thinkpad instead of what one gets
from the NVRAM (look at the nvram polling code in thinkpad-acpi to
understand what I mean.  Some not so pretty crap was required in there
due to deal with loss of information in the VOLUME/MUTE handling...)

Hotfixing the AML would also allow one to do all of this and more (maybe
hell will freeze over and Len will let us do it :-) ).

Anyway, if we add notifications for normal nodes, please add them for
GPEs too.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
