From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 18:49:54 +0000
Message-ID: <20080220184954.GB23679@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43557 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637AbYBTSuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 13:50:08 -0500
Content-Disposition: inline
In-Reply-To: <20080220182339.GC17648@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, Feb 20, 2008 at 03:23:40PM -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 20 Feb 2008, Matthew Garrett wrote:
> > Let's look at this differently. Most hardware is produced by vendors who 
> > don't care about Linux. We need to make that hardware work anyway. The 
> > only way we can achieve that is to be bug-compatible with Windows. 
> > Therefore, any way in which Linux behaviour varies from Windows 
> > behaviour is a bug. The only reason to export any indication that the 
> > kernel is Linux is because our behaviour is not identical to Windows. 
> > But, given that that's a bug, the solution should be to fix Linux and 
> > not to encourage vendors to put workarounds in their firmware.
> 
> That punishes vendors which actually care about Linux.  These are quite
> rare in the laptop and desktop market, but they do exist.

It doesn't punish them. They're the ones who are going to work with us 
to ensure that Linux works on their hardware, and their needs are going 
to be prioritised over those of vendors who don't care about Linux. The 
other choice (encourage vendors to put workarounds in their firmware 
instead) *does* punish users who've ended up with laptops that aren't 
actively supported - like, say, pretty much anything on the market.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
