From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 18:43:09 +0200
Message-ID: <200810201843.10507.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081020010142.GB32675@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:52413 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbYJTQnN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 12:43:13 -0400
In-Reply-To: <20081020010142.GB32675@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 03:01:42 Matthew Garrett wrote:
> On Sun, Oct 19, 2008 at 11:50:55PM +0200, Thomas Renninger wrote:
> > Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
> >
> > References: http://bugzilla.kernel.org/show_bug.cgi?id=8246
> >
> > Blacklist R40e, R51e and T40, T40p, T41, T41p, T42, T42p, R50 and R50p
> > ThinkPads to use the RSDT instead of the XSDT.
>
> I'm very sceptical about this. All of these machines were released years
> before Vista, which makes me unsure about the diagnosis that this is
> something to do with Vista readyness.

I sent you a link to BIOS updates where the last changelog entry stated VISTA 
support. Hmm, I double checked R40e and R50e and there is nothing about VISTA 
support.
Nevertheless, this would mean the addresses used by Linux are not supported.

> I'm very sceptical about this
Could you please explain why? Or better suggest another solution if you have a 
better one.
XP uses the 32 bit adresses. Vista the 64 bit adresses.
For some reason, the 64 bit addresses are not 0 as demanded by the spec if 
they should get ignored, therefore Linux takes them. There is no way of 
automated detection, because all this happens before the DSDT is parsed.

Could you please point to a specific problem you have with the patches, these 
are safe, tested and verified fixes.

     Thomas
