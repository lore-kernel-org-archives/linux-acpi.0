From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21 - part II (resend)
Date: Tue, 6 Mar 2007 13:17:53 +0000
Message-ID: <20070306131753.GA15187@srcf.ucam.org>
References: <200702162223.59837.lenb@kernel.org> <20020101045751.GD4106@ucw.cz> <20070306122213.GF2919@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51273 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933277AbXCFNSa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 08:18:30 -0500
Content-Disposition: inline
In-Reply-To: <20070306122213.GF2919@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Mar 06, 2007 at 01:22:13PM +0100, Mattia Dongili wrote:

> the audiopower is basically a _PS3/_PS0 switch for the device, while the
> lanpower plays with the embedded controller to powerdown/powerup.
>
> Now, unfortunately those methods are attached to a fake device in the
> DSDT and afaict there's no way to tell which real device they are
> playing with (except by inspecting the method implementations).
> Well of course iff there's only _one_ sound card and _one_ nic you can
> easily guess it :)
> 
> Is there some way to hook into drivers for such kind of runtime power
> management?

Before worrying, I think it would make more sense to instrument the 
benefit gained against doing more "traditional" runtime management - 
that is, simply shutting down the ethernet chipset or doing ac97 power 
management. It's trivial to add those to the existing drivers, and if 
the additional benefit of using the Sony-specific methods is small then 
it's probably not really worth working out how to add it in.

Plus, implementing the generic support benefits more people :)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
