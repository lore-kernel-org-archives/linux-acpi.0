From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Tue, 11 May 2010 19:22:53 +0100
Message-ID: <20100511182253.GB19264@srcf.ucam.org>
References: <alpine.LFD.2.00.1005061926460.901@i5.linux-foundation.org> <20100507061203.GA8779@srcf.ucam.org> <alpine.LFD.2.00.1005071402080.901@i5.linux-foundation.org> <20100507211331.GA28906@srcf.ucam.org> <alpine.LFD.2.00.1005071418200.901@i5.linux-foundation.org> <20100507213600.GC28906@srcf.ucam.org> <20100511172543.GA17868@srcf.ucam.org> <alpine.LFD.2.00.1005111031260.3711@i5.linux-foundation.org> <20100511175904.GA18797@srcf.ucam.org> <alpine.LFD.2.00.1005111107020.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33394 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416Ab0EKSXB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2010 14:23:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005111107020.3711@i5.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, May 11, 2010 at 11:17:34AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 11 May 2010, Matthew Garrett wrote:
> > 
> > I see Windows write the SCI_EN bit without reading it first and without 
> > calling the ACPI enable SMM function.
> 
> Hmm. So presumably Windows doesn't even do them bit-by-bit, but simply 
> does a "restore PM1 Control register value" on resume.

Yup.

> And I guess it probably does the same for the PM1_ENABLE register and the 
> PM2 control registers too?

Haven't checked those, but could do so easily enough.

(I say easily enough. Turns out that getting Windows to do S3 under qemu 
is a fair amount of work)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
