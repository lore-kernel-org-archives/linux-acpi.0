From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 18:58:14 +0100
Message-ID: <20081020175814.GA13067@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org> <200810201848.42759.trenn@suse.de> <20081020165425.GA11507@srcf.ucam.org> <20081020175124.GH18277@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34873 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYJTR6T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2008 13:58:19 -0400
Content-Disposition: inline
In-Reply-To: <20081020175124.GH18277@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, Oct 20, 2008 at 03:51:24PM -0200, Henrique de Moraes Holschuh wrote:
> On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > But *why* is Vista not showing the symptoms?
> 
> I very much doubt anyone ever attempted to run Vista on a R40e or a R50e.
> It probably won't work well on the T4x/R51/R52 either, but I haven't tried.

I'd be surprised if nobody has done it. The hardware is above the 
minimum spec.

> > values in the table were never caught because, for some reason, Windows 
> > never used them. The bug is that we're not using the same heuristic as 
> > Windows. Applying a static list of hardware just results in it being 
> > likely that we'll never fix that bug.
> 
> I am a bit lost, now.  Are you talking about newer ThinkPads with
> Vista-capable BIOSes, or the older ones that can't handle it and thus are
> only subject to some ACPI access patterns when running Linux?

The R40e and R50e have differing values in the RSDT and XSDT tables. 
Linux uses the values from the XSDT, which apparently results in a 
system hang whenever you attempt to perform C-state manipulation. Using 
the RSDT values instead avoids this. Windows works fine, so is clearly 
using the RSDT values. However, we have no knowledge of what mechanism 
Windows uses to choose between the two sets of values.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
