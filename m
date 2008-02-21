From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 14:30:52 +0000
Message-ID: <20080221143052.GA8389@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org> <20080221135132.GE14614@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57988 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYBUObS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 09:31:18 -0500
Content-Disposition: inline
In-Reply-To: <20080221135132.GE14614@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, Feb 21, 2008 at 08:51:32AM -0500, Theodore Tso wrote:

> It would be much better if we define feature-specific OSI() strings
> that have well defined meanings for each place where Lenovo has to do
> something different than What Happens With Windows --- especially for
> stuff which is generic, since all laptop manufactuers need to
> interoperate with whatever cr*p Windows ship.  At the end of the day,
> since Intel was originally too lazy to ship an ACPI conformance test
> suite, like it or not, Windows *has* become the APCI conformance test
> suite, and all laptop manufacturers (at least for today) must bow to
> the might and power which is the market share of Microsoft.

My concern with this is that until we know where we deviate from the 
Windows behaviour, we don't know what strings we'd need to provide. And 
once we *do* know where we deviate, we should fix that deviation rather 
than provide an identifying string.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
