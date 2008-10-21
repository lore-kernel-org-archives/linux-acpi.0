From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 13:07:04 +0200
Message-ID: <200810211307.05601.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081020154628.GB18277@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34522 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbYJULHJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 07:07:09 -0400
In-Reply-To: <20081020154628.GB18277@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 17:46:28 Henrique de Moraes Holschuh wrote:
> On Sun, 19 Oct 2008, Thomas Renninger wrote:
> > The rest share one BIOS and have been added in hope that this bug gets
> > solved, but this is not proven:
> >   T41p shutting down due to "temperature critical"
> >   https://bugzilla.novell.com/show_bug.cgi?id=378327
> > I saw a kind of fixed temperature offset with the exact same machine
> > models and exact same BIOS. Short after cold boot the one machine showed
> > about 15 degree C more than the other. This looked like wrong, too high
> > temperature values read from EC on the one machine. I never found out
> > why, this could explain and fix it, but I did not double check.
>
> How is using the RSDT instead of XSDT going to help with that?

RSDT -> FADT (early rev)
XSDT -> other FADT (later rev)

Broken IO addresses are taken, this can theoretically cause everything.
E.g. the slow boot of the R50e caused by wrong IO FADT adresses
is related to the EC:
http://bugzilla.kernel.org/show_bug.cgi?id=8246#c26
Ok I tested 2.6.20.3 with ec_intr=0 and it works fine.

But as said, this is not proven for the temperature problem for the non R40e 
and non R50e. I added them, because I know that the 32 bit address for those 
is used on XP and it's safe.
As soon as these patchseries is in, people can easily try things out using the 
boot param.

   Thomas
