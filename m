From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 13:33:27 +0000
Message-ID: <20090322133327.GB7932@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090321145502.GA28452@srcf.ucam.org> <20090321151037.GA28846@srcf.ucam.org> <200903212015.00581.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50424 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZCVNdb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 09:33:31 -0400
Content-Disposition: inline
In-Reply-To: <200903212015.00581.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 08:15:00PM +0100, Matthias Welwarsky wrote:
> On Saturday 21 March 2009 16:10:37 Matthew Garrett wrote:
> > The way that 0x113 moves around leaves me pretty sure that calling SN07
> > without checking what the function signature is is not a good idea. I'll
> > rewrite my patch.
> 
> If that's really a function signature, why are some of the slots empty? If 
> you're supposed to read the CFGI first via SN00, that would not make much 
> sense. However, it makes sense if the function is encoded by the slot and a 
> hole (i.e. Zero) means that the function is not supported or disabled.

I thought that at first, but 0x113 is the same code on the machines I 
checked even though it moves around. 0x100 appears to be "Get hotkey 
event" on the newer hardware even though it's not in slot 2.

> If you're right though, it means that "0x124" on all new-style models (those 
> with SN07 method) must always operate the killswitch. I might be able to find 
> that out from the decompiled DSDT. Right now I only checked the Z series DSDTs 
> (Z11 and Z21) and of course they are very similar. But I would be very 
> interested to see the code of  functions called for the other "slot 3" 
> methods, like 0x0104 and 0x0113. If you had some DSDTs to share...

The P, TT and Z all seem to have 0x124 as killswitch - the 0x113 and 
0x104 methods don't seem to be killswitch related, as far as I can tell. 
Mattia linked to a set of DSDTs earlier in the thread.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
