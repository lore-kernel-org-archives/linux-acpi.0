From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 18:23:27 +0200
Message-ID: <200810201823.28314.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081020010142.GB32675@srcf.ucam.org> <20081020153153.GA18277@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:51013 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYJTQXb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 12:23:31 -0400
In-Reply-To: <20081020153153.GA18277@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 17:31:53 Henrique de Moraes Holschuh wrote:
> On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > On Sun, Oct 19, 2008 at 11:50:55PM +0200, Thomas Renninger wrote:
> > > Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
> > >
> > > References: http://bugzilla.kernel.org/show_bug.cgi?id=8246
> > >
> > > Blacklist R40e, R51e and T40, T40p, T41, T41p, T42, T42p, R50 and R50p
> > > ThinkPads to use the RSDT instead of the XSDT.
> >
> > I'm very sceptical about this. All of these machines were released years
> > before Vista, which makes me unsure about the diagnosis that this is
> > something to do with Vista readyness.
>
> I believe you will find stuff broken due to Vista Readyness badly
> retro-fitted only on the Z-series and also the T60.
>
> The R51e (BIOS TP-78) does NOT share a BIOS with the T40-T42 or any of the
> two R51 base models. The bugzilla bug report really cannot be used against
> them.  Thomas, do you have extra data not in the bug report that causes you
> to doubt the TP-1R BIOS?

Len, can you remove this part of the dmi entry then:
+       {
+           .ident = "ThinkPad ", /* T40, T40p, T41, T41p, T42, T42p
+                                    R50, R50p */
+           .matches = {
+               DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+               DMI_MATCH(DMI_BIOS_VERSION, "1RET")},
+       },

The others (these BIOSes seem to not be shared between that many machines) 
were tested that this patchset fixes sever bugs:
  - system freeze when using C-states on R40e
  - much faster booting on R50e

Thanks,

     Thomas
