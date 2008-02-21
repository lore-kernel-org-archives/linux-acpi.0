From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 12:50:35 -0300
Message-ID: <20080221155035.GA5859@khazad-dum.debian.net>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org> <20080221135132.GE14614@mit.edu> <20080221143052.GA8389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43550 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756782AbYBUPuk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 10:50:40 -0500
Content-Disposition: inline
In-Reply-To: <20080221143052.GA8389@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Theodore Tso <tytso@MIT.EDU>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, 21 Feb 2008, Matthew Garrett wrote:
> My concern with this is that until we know where we deviate from the 
> Windows behaviour, we don't know what strings we'd need to provide. And 
> once we *do* know where we deviate, we should fix that deviation rather 
> than provide an identifying string.

IMO we should "fix" deviations *only* when it makes sense to do so (I bet at
least one of the deviations we are going to find will be so hideously wrong
and ugly when compared to the Right Thing, that we will be at a very
unconfortable position if we need to implement it).

We better reserve judgment of what deviations we should be fixing or not for
when we find them in the first place.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
