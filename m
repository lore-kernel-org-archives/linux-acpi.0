From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Fri, 4 Jul 2008 10:13:07 +0100
Message-ID: <20080704091307.GB8905@srcf.ucam.org>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <20080704030948.GB31908@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41889 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYGDJNP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 05:13:15 -0400
Content-Disposition: inline
In-Reply-To: <20080704030948.GB31908@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

On Fri, Jul 04, 2008 at 12:09:49AM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 03 Jul 2008, Matthew Garrett wrote:
> > Not until the opregion code is merged, no. If you'd like that to happen 
> > faster, then figuring out why it triggers a 750ms delay on brightness 
> > changes on the T61 would be a great help, because I haven't a clue why 
> > it's broken...
> 
> I have never really tried finding out WTF in the firmware causes this, but:
> 
> 1. The backlight-change firmware runs in SMM.
> 2. The calls happen in ACPI DSDT
> 3. The SMM code DOES take care of the CMOS NVRAM

As far as I can tell, it's sleeping in the DSDT. But all the ready flags 
are set appropriately according to the opregion spec, so I'm confused as 
to why. Hardware failure has meant I've got to use the T61 this week, so 
I'll try to fix it while I'm stuck in an airport tomorrow...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
