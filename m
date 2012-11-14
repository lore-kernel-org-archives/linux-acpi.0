From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Wed, 14 Nov 2012 16:04:43 +0000
Message-ID: <20121114160443.GA9108@srcf.ucam.org>
References: <20121112050935.GA25110@scooby.iskra.name>
 <20121114074113.GA32091@srcf.ucam.org>
 <20121114095857.29582.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37038 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2KNQEs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2012 11:04:48 -0500
Content-Disposition: inline
In-Reply-To: <20121114095857.29582.qmail@stuge.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamil Iskra <kamil@iskra.name>, linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Wed, Nov 14, 2012 at 10:58:57AM +0100, Peter Stuge wrote:
> Matthew Garrett wrote:
> > > My guess is that this problem has been around ever since those machines
> > > have been released, but because the most common Thinkpad batteries are
> > > rated at 10.8V, the error (8%) is small enough that it simply hasn't been
> > > noticed or at least nobody could be bothered to look into it.
> > 
> > Yeah, the DSDT simply multiples the values by 10 when it's in this 
> > state. But the issue is purely cosmetic, right? I can't see any reason 
> > anything would be using the design voltage in calculations.
> 
> current energy percent = 100 * energy_now / energy_full_design

Right. That's not the voltage.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
