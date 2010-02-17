From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 17 Feb 2010 21:28:51 +0000
Message-ID: <20100217212851.GA27092@srcf.ucam.org>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org> <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain> <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain> <20100216154053.GA31195@srcf.ucam.org> <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain> <20100217143245.GA18411@srcf.ucam.org> <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain> <20100217183108.GA23189@srcf.ucam.org> <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42752 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab0BQV3A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2010 16:29:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Wed, Feb 17, 2010 at 04:23:12PM -0500, Len Brown wrote:
> On Wed, 17 Feb 2010, Matthew Garrett wrote:
> > The machines in question are falling back to apm, so probably losing 
> > some level of powersaving support. I'd say that's harmful :)
> 
> The system at hand is the Asus P2B-DS, a Dual Pentium III.
> APM is not SMP safe, and was not deployed on SMP motherboards.
> My expectation is that it is perfectly fine running in MPS
> mode rather than ACPI mode, as it has been running that way
> since 2003.  My expectation is that when running in ACPI mode,
> the only thing the user will notice is that the power button
> is software controlled.

So the APM idle loop won't have been used? I was under the impression 
that C1 was preferable to just calling hlt, but I'll admit to having no 
idea if that's true for the PIII. I'd also have expected there to be at 
least S1, so ACPI would be a functional improvement.

> > At least one of them covers a single submodel in a range, despite them 
> > all running the same BIOS. I'd really lean towards them being bogus at 
> > this stage of the game.
> 
> While I too vote for consistency and less cruft is better,
> I'd like to keep the acpi_ht issue at hand apart from the
> inconsistency in old thinkpad BIOS DMI list issue; as they
> are logically independent.

They're similar in that we have absolutely no idea why these entries are 
present, potentially resulting in us reducing the functionality of 
machines that would otherwise work happily.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
