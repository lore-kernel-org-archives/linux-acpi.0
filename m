From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 23:37:18 +0900
Message-ID: <20090321143717.GA21091@kamineko.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org> <20090321043513.GA20519@srcf.ucam.org> <20090321063229.GE3834@kamineko.org> <20090321140654.GA28039@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:46626
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZCUOhV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 10:37:21 -0400
Content-Disposition: inline
In-Reply-To: <20090321140654.GA28039@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 02:06:54PM +0000, Matthew Garrett wrote:
> On Sat, Mar 21, 2009 at 03:32:30PM +0900, Mattia Dongili wrote:
> 
> > sure, that DMI whitelist is already annoying in its current shape.
> > Getting the ACPI tables to tell us what SNC version we are looking at
> > would be so much better.
> > I just grepped the DSDTs I have here and this is what I got:
> > DSDT.c1s.dsl:                    Name (SNI4, 0x344A0001)
> > DSDT.c71bw.dsl:                    Name (SNI4, 0x344A0001)
> 
> (snip)
> 
> The second byte seems to be the most consistent here - 0x4a for the 
> models currently handled by the nc code, 0x4d for the tt and z, 0x55 for 
> the p. I've no idea whether this is a monotonically increasing version 
> string or a bitmask of supported functionality, but it ought to be 
> enough to key off to begin with.

Oh, do you have a vaio type P DSDT to share?

> > want to try to push your patch to mainline or would you prefer to wait?
> > IMO pushing it and eventually fixing support for 0x344a000[10] models is
> > fine. After all your snc_setup code could be easily plugged into the DMI
> > list for the time being and Z and TT users would be happy.
> 
> Might as well push it and see what happens?

Sure, if you're ok I'll apply the patch you sent just changing the
rfkill_free and send the whole patch-set to Len tomorrow morning (JST).

cheers
-- 
mattia
:wq!
