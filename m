From: Peter Stuge <peter@stuge.se>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Wed, 14 Nov 2012 10:58:57 +0100
Message-ID: <20121114095857.29582.qmail@stuge.se>
References: <20121112050935.GA25110@scooby.iskra.name> <20121114074113.GA32091@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:52643 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752187Ab2KNJ7A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2012 04:59:00 -0500
Content-Disposition: inline
In-Reply-To: <20121114074113.GA32091@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kamil Iskra <kamil@iskra.name>, linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

Matthew Garrett wrote:
> > My guess is that this problem has been around ever since those machines
> > have been released, but because the most common Thinkpad batteries are
> > rated at 10.8V, the error (8%) is small enough that it simply hasn't been
> > noticed or at least nobody could be bothered to look into it.
> 
> Yeah, the DSDT simply multiples the values by 10 when it's in this 
> state. But the issue is purely cosmetic, right? I can't see any reason 
> anything would be using the design voltage in calculations.

current energy percent = 100 * energy_now / energy_full_design


//Peter
