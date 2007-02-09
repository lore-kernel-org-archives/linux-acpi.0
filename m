From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 02/13] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Fri, 9 Feb 2007 12:26:22 -0200
Message-ID: <20070209142622.GD26414@khazad-dum.debian.net>
References: <200702060010.l160AB6R003718@shell0.pdx.osdl.net> <200702090114.32041.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:58756 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946479AbXBIO0h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 09:26:37 -0500
Content-Disposition: inline
In-Reply-To: <200702090114.32041.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@elte.hu, ak@suse.de

On Fri, 09 Feb 2007, Len Brown wrote:
> resuming our previous discussion on this topic...
> 
> I'd rather see nmi watchdog disabled by default.
> 
> But if that battle isn't going to be concluded in my natural
> life-time, then I'm okay with a workaround for that bug
> in the interest of functioning systems.
> 
> > +	acpi_nmi_disable();
> >  	status = acpi_ns_evaluate(info);
> > +	acpi_nmi_enable();
> 
> My concern is that while this may make a T60 work, we have
> no assurance if it is sufficient for other systems which might
> suffer a similar fate.

What IS the point of even *allowing* the NMI watchdog to be turned on on any
ThinkPad?

According to a patch sent to LKML a while ago that blacklisted all ThinkPads
from nmi_watchdog, the ThinkPad SMBIOS does INT 0x10 or something else that
will cause double or triple-faults if an NMI happens while in SMBIOS mode.

I never tried to look at the ThinkPad SMBIOS, but given the stuff IBM does
in SMIs, I would actually *expect* them to do all sort of stuff that will
hose us.  The EC can trigger SMIs (and probably does, too. Ever seen the
ammount of "automatic" PM stuff the BIOS offers to do?).  The ACPI DSDT
*does* trigger SMIs for just about every bad reason, including to program
PCI config registers.  One really doesn't have a clue of what a ThinkPad is
doing behind his back.

> Maybe we should consider shutting off nmi_watchdog whenever we
> interpret AML, eg hook into acpi_ex_enter_interpreter/acpi_ex_exit_interpreter(),

On a ThinkPad?  Definately.  If the nmi_watchdog is to be allowed at all, we
should shut the watchdog at every call that could potentially:

	1. Call a DSDT/SSDT method (known to sometimes do SMI)

	2. Cause a smapi call (this means fixing the ACP Mwave driver and a
	at least the out-of-tree drivers in tpctl.sf.net) - known to use SMI

	3. Call in the BIOS or SMBIOS - potential user of SMIs.

Of course, this all assumes the reporter of the problem with NMIs while
processing a SMI in a ThinkPad is correct.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
