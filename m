From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Mon, 20 Oct 2008 17:25:20 -0200
Message-ID: <20081020192520.GM18277@khazad-dum.debian.net>
References: <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org> <200810201848.42759.trenn@suse.de> <20081020165425.GA11507@srcf.ucam.org> <20081020175124.GH18277@khazad-dum.debian.net> <20081020175814.GA13067@srcf.ucam.org> <20081020181622.GJ18277@khazad-dum.debian.net> <20081020182416.GA13676@srcf.ucam.org> <20081020184754.GL18277@khazad-dum.debian.net> <20081020185241.GA14155@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45179 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751937AbYJTTZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 15:25:26 -0400
Content-Disposition: inline
In-Reply-To: <20081020185241.GA14155@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, 20 Oct 2008, Matthew Garrett wrote:
> On Mon, Oct 20, 2008 at 04:47:54PM -0200, Henrique de Moraes Holschuh wrote:
> > On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > > C state transitions, not S state. Working properly here means not 
> > > hanging the moment ACPI processor power management starts.
> > 
> > I see, but my point remains.  Does a version of Windows that was tested to
> > do C-state transitions on the R50e and R40e even use the XSDT?
> 
> Vista is known to run on the R50e. See 
> http://forums.lenovo.com/lnv/board/message?board.id=R_Series_Thinkpads&thread.id=3467 
> , for instance.

Ok, now one has to wonder whether C-states work, but still the chances that
we are doing something differently than Windows XP/Vista here have gone up a
great deal in my book :-(

If you can describe how to test C-states in Windows, one could try to find
an R50e user to do that test, either in the linux-thinkpad ML, or in the
ThinkPad forums.

I still think a date cutoff line would explain a lot.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
