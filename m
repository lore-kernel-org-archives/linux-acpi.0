From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Mon, 20 Oct 2008 15:51:24 -0200
Message-ID: <20081020175124.GH18277@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de> <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org> <200810201848.42759.trenn@suse.de> <20081020165425.GA11507@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50311 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbYJTRvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 13:51:32 -0400
Content-Disposition: inline
In-Reply-To: <20081020165425.GA11507@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, 20 Oct 2008, Matthew Garrett wrote:
> On Mon, Oct 20, 2008 at 06:48:41PM +0200, Thomas Renninger wrote:
> > As said, probably because Vista is not supported at all or not showing the 
> > symptoms.
> 
> But *why* is Vista not showing the symptoms?

I very much doubt anyone ever attempted to run Vista on a R40e or a R50e.
It probably won't work well on the T4x/R51/R52 either, but I haven't tried.

> values in the table were never caught because, for some reason, Windows 
> never used them. The bug is that we're not using the same heuristic as 
> Windows. Applying a static list of hardware just results in it being 
> likely that we'll never fix that bug.

I am a bit lost, now.  Are you talking about newer ThinkPads with
Vista-capable BIOSes, or the older ones that can't handle it and thus are
only subject to some ACPI access patterns when running Linux?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
