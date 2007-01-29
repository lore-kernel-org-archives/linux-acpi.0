From: Andrew Morton <akpm@osdl.org>
Subject: Re: x86_64-mm-always-use-physical-delivery-mode-on-8-cpus vs
 git-acpi
Date: Sun, 28 Jan 2007 22:38:16 -0800
Message-ID: <20070128223816.3ee4574a.akpm@osdl.org>
References: <20070126172402.77a3edbc.akpm@osdl.org>
	<200701270429.57170.lenb@kernel.org>
	<20070127142031.041d3239.akpm@osdl.org>
	<200701282158.12540.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:51412 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241AbXA2Gjh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jan 2007 01:39:37 -0500
In-Reply-To: <200701282158.12540.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@muc.de>, linux-acpi@vger.kernel.org

On Sun, 28 Jan 2007 21:58:12 -0500
Len Brown <lenb@kernel.org> wrote:

> > OK, so I took another look.  This ACPI update does extensive damage to
> > Andi's pending queue.  I fixed four patches, dropped four or five more, hit
> > more problems then gave up again.  I'll go back to Thursday's git-acpi
> > again.
> > 
> > Longer-term, I expect Andi will merge before acpi does, and you're looking
> > at a fairly large amount of fixing after that happens.
> 
> Exactly what patches from Andi do I need to merge on top of to get the ACPI tree into -mm?

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/ is everything.

In rc6-mm1 that's everything between #X86_64-START and #X86_64-END in the
series file.  I have another 35-odd x86 patches on top of that lot.

Note that I normally stage the x86_64 tree _after_ the ACPI tree, but I can
change that.

I don't think that making the acpi tree dependent upon the x86_64 tree
would be a smart idea, frankly.  It'll cause you heaps of pain.

Perhaps Andi could stick his tree into git for you to base off, dunno.  But
he doesn't seem to be around at present.

