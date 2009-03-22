From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 11:38:46 +0900
Message-ID: <20090322023845.GB17905@kamineko.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org> <20090321043513.GA20519@srcf.ucam.org> <20090321063229.GE3834@kamineko.org> <20090321140654.GA28039@srcf.ucam.org> <20090321143717.GA21091@kamineko.org> <20090321145502.GA28452@srcf.ucam.org> <20090321151037.GA28846@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:35343
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZCVCis (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 22:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20090321151037.GA28846@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 03:10:37PM +0000, Matthew Garrett wrote:
> On Sat, Mar 21, 2009 at 02:55:02PM +0000, Matthew Garrett wrote:
> 
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

Ok no rush, I'll wait until you're done before submitting the batch for
.30.

PS: you forgot the type P DSDT attachment. ;)
-- 
mattia
:wq!
