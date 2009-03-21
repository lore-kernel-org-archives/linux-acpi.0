From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 14:06:54 +0000
Message-ID: <20090321140654.GA28039@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org> <20090321043513.GA20519@srcf.ucam.org> <20090321063229.GE3834@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40831 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbZCUOG7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 10:06:59 -0400
Content-Disposition: inline
In-Reply-To: <20090321063229.GE3834@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 03:32:30PM +0900, Mattia Dongili wrote:

> sure, that DMI whitelist is already annoying in its current shape.
> Getting the ACPI tables to tell us what SNC version we are looking at
> would be so much better.
> I just grepped the DSDTs I have here and this is what I got:
> DSDT.c1s.dsl:                    Name (SNI4, 0x344A0001)
> DSDT.c71bw.dsl:                    Name (SNI4, 0x344A0001)

(snip)

The second byte seems to be the most consistent here - 0x4a for the 
models currently handled by the nc code, 0x4d for the tt and z, 0x55 for 
the p. I've no idea whether this is a monotonically increasing version 
string or a bitmask of supported functionality, but it ought to be 
enough to key off to begin with.

> want to try to push your patch to mainline or would you prefer to wait?
> IMO pushing it and eventually fixing support for 0x344a000[10] models is
> fine. After all your snc_setup code could be easily plugged into the DMI
> list for the time being and Z and TT users would be happy.

Might as well push it and see what happens?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
