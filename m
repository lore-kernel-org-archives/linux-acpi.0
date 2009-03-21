From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 20:15:00 +0100
Message-ID: <200903212015.00581.matze@welwarsky.de>
References: <20090319212123.GA24700@srcf.ucam.org> <20090321145502.GA28452@srcf.ucam.org> <20090321151037.GA28846@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:15682
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbZCUTPG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 15:15:06 -0400
Received: from wind.localnet (p54A7BA80.dip.t-dialin.net [84.167.186.128])
	by basyskom.de (Postfix) with ESMTP id BE2DA39BE3C
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2009 20:15:01 +0100 (CET)
In-Reply-To: <20090321151037.GA28846@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Saturday 21 March 2009 16:10:37 Matthew Garrett wrote:
> On Sat, Mar 21, 2009 at 02:55:02PM +0000, Matthew Garrett wrote:
> >    0x33:  0x34:  0x36:  0x37:
> > 0, 0x0101 0x0101 0x0101 0x0101
> > 1, 0x0102 0x0102 0x0102 0x0102
> > 2, 0x0100 0x0100 0x0100 0x0100
> > 3, 0x0104        0x0104
> > 4, 0x0107 0x010F 0x0107 0x010F
> > 5,               0x0106 0x0106
> > 6,               0x0000 0x0113
> > 7,        0x0111        0x010A
> > C,               0x010C
> > D,               0x010D 0x010D
> > E, 0x0105 0x0105 0x0105 0x0105
> > F, 0x0103 0x0103 0x0103
>
> Actually slightly more complicated than that - some are only stored on
> certain OS versions. Here's a more complete table.
>
>    0x33:  0x34:  0x36:  0x37:
>
> 0, 0x0101 0x0101 0x0101 0x0101
> 1, 0x0102 0x0102 0x0102 0x0102
> 2, 0x0100 0x0100 0x0100 0x0100
> 3, 0x0104 0x0113 0x0104
> 4, 0x0107 0x010F 0x0107 0x010F
> 5,               0x0106 0x0106
> 6,               0x0113 0x0113
> 7,        0x0111        0x010A
> C,               0x010C
> D,               0x010D 0x010D
> E, 0x0105 0x0105 0x0105 0x0105
> F, 0x0103 0x0103 0x0103
>
> The way that 0x113 moves around leaves me pretty sure that calling SN07
> without checking what the function signature is is not a good idea. I'll
> rewrite my patch.

If that's really a function signature, why are some of the slots empty? If 
you're supposed to read the CFGI first via SN00, that would not make much 
sense. However, it makes sense if the function is encoded by the slot and a 
hole (i.e. Zero) means that the function is not supported or disabled.

If you're right though, it means that "0x124" on all new-style models (those 
with SN07 method) must always operate the killswitch. I might be able to find 
that out from the decompiled DSDT. Right now I only checked the Z series DSDTs 
(Z11 and Z21) and of course they are very similar. But I would be very 
interested to see the code of  functions called for the other "slot 3" 
methods, like 0x0104 and 0x0113. If you had some DSDTs to share...

regards,
	matthias

