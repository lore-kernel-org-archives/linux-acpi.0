From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PNP: don't check for conflicts with bridge windows
Date: Mon, 3 May 2010 16:03:11 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005031601450.5478@i5.linux-foundation.org>
References: <20100503164647.308.86063.stgit@bob.kio>  <20100503164721.308.11075.stgit@bob.kio>  <alpine.LFD.2.00.1005030950530.5478@i5.linux-foundation.org> <1272927008.28149.91.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41265 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759705Ab0ECXEs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 19:04:48 -0400
In-Reply-To: <1272927008.28149.91.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Pavel Kysilka <goldenfish@linuxsoft.cz>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>



On Mon, 3 May 2010, Bjorn Helgaas wrote:
> 
> My *plan* was to make pci_root.c a PNP driver, so it would use the
> pre-parsed PNP resources to find the host bridge windows rather than
> re-parsing the ACPI _CRS info by hand.  Those PNP resources are not in
> the resource tree when the driver first sees them (which might be a
> deficiency of our current PNP core), so I don't think there's currently
> a way for the driver to distinguish IO from MEM unless it's in the
> resource itself.
> 
> At this stage of the release, my preference would be to use the patch
> above (with the intention of coming back later for some more work), or
> to just revert fa35b4926 (PNPACPI window support) and maybe 9d7cca04
> (generic window support).  If we revert those patches, I'll have to
> figure out another way to clean up pci_root.c.

Oh, I'm fine with your patch, I just reacted to it wondering whether maybe 
there was some cleaner way of solving the problem. I guess annotating the 
resource itself is ok.

So don't take my comment as a NAK, more of a "hmm, how about.. "

		Linus
