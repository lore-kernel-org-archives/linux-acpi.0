From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Mon, 20 Oct 2008 13:31:53 -0200
Message-ID: <20081020153153.GA18277@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de> <20081020010142.GB32675@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34005 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776AbYJTPcA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 11:32:00 -0400
Content-Disposition: inline
In-Reply-To: <20081020010142.GB32675@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, 20 Oct 2008, Matthew Garrett wrote:
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

I believe you will find stuff broken due to Vista Readyness badly
retro-fitted only on the Z-series and also the T60.

The R51e (BIOS TP-78) does NOT share a BIOS with the T40-T42 or any of the
two R51 base models. The bugzilla bug report really cannot be used against
them.  Thomas, do you have extra data not in the bug report that causes you
to doubt the TP-1R BIOS?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
