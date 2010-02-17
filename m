From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 17 Feb 2010 18:31:08 +0000
Message-ID: <20100217183108.GA23189@srcf.ucam.org>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org> <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain> <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain> <20100216154053.GA31195@srcf.ucam.org> <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain> <20100217143245.GA18411@srcf.ucam.org> <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38257 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0BQSbR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2010 13:31:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Wed, Feb 17, 2010 at 01:24:58PM -0500, Len Brown wrote:
> On Wed, 17 Feb 2010, Matthew Garrett wrote:
> > We seem to have no good history of where these blacklist entries came 
> > from, and we know that at least one of them is actively harmful. Perhaps 
> > replace them with a debug statement on affected machines telling people 
> > what they need to pass to restore the blacklist behaviour, and to let us 
> > know if it's necessary?
> 
> Actually, it wasn't actively harmful until we broke "acpi=ht".
> Indeed, it was actively helpful in pointing out that regression:-)

The machines in question are falling back to apm, so probably losing 
some level of powersaving support. I'd say that's harmful :)

> The other entries in today's acpi_dmi_table[] are less clear
> and should probably be modified only with some care...

At least one of them covers a single submodel in a range, despite them 
all running the same BIOS. I'd really lean towards them being bogus at 
this stage of the game.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
