From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
Date: Sun, 15 Jul 2007 19:31:51 +0100
Message-ID: <20070715183150.GA3235@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <118442233665-git-send-email-hmh@hmh.eng.br> <20070714223932.GD25782@srcf.ucam.org> <20070715175922.GD14134@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:56381 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbXGOSoo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 14:44:44 -0400
Content-Disposition: inline
In-Reply-To: <20070715175922.GD14134@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 02:59:22PM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 14 Jul 2007, Matthew Garrett wrote:
> 
> > On Sat, Jul 14, 2007 at 11:12:09AM -0300, Henrique de Moraes Holschuh wrote:
> > 
> > Ah, I see this one fixes some of my comments. However:
> > 
> > > +		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
> > > +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> > > +		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
> > 
> > > +		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
> > > +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> > > +		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
> > 
> > Why this difference?
> 
> Brightness events are handled in firmware (and no, you cannot make the
> firmware NOT handle it) in IBM thinkpads.  Lenovo thinkpads seem to be
> moving it to userspace, so you have to generate the events and actively
> handle them in the ACPI OSI or in userspace.

I believe that this is dependent on the BIOS version, not whether the 
distinction is Lenovo/IBM.

> Regardless, userspace *will* have to take some action to enable the hotkeys
> that are to only be used for passive monitoring.  Right now this means
> enabling them in the mask, and remapping the key map.  If this is that a big
> problem, I can add extra driver filtering, and make it only "enable it in
> the mask".

HAL already has a flag indicating whether applications should respond to 
brightness keys actively or passively. Life would be significantly 
easier if they're mapped by default, since the alternative is that 
everyone will just map them anyway.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
