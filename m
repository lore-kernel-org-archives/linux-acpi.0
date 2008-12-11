From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] PNPACPI: Enable Power Support
Date: Wed, 10 Dec 2008 23:28:38 -0200
Message-ID: <20081211012838.GA18065@khazad-dum.debian.net>
References: <493D8A1F.2090907@gmx.net> <20081210095315.GA20627@khazad-dum.debian.net> <494018E9.2060507@gmx.net> <20081210232137.GB7589@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34948 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208AbYLKB2n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 20:28:43 -0500
Content-Disposition: inline
In-Reply-To: <20081210232137.GB7589@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

Hi Witold!

On Wed, 10 Dec 2008, Henrique de Moraes Holschuh wrote:

> On Wed, 10 Dec 2008, Witold Szczeponik wrote:
> > Henrique de Moraes Holschuh wrote:
> >> On Mon, 08 Dec 2008, Witold Szczeponik wrote:
> >>> This patch sets the power of PnP ACPI devices to D0 when they
> >>> are activated and to D3 when they are disabled.  The latter is
> >>
> >> This will likely fix my T43 to power down USB during STR. THANKS!!
> >> Now, I just need to check if the ACPI BIOS is smart enough to not do
> >> it when they are configured as wake devices [in the BIOS].
> >>
> >
> > Most likely it won't. :-(  My patch takes only care of devices that are
> > properly registered as PnP by ACPI: attached USB devices don't fall
> > under that category.
> 
> I do mean the UHCI and EHCI bridges, not USB devices hanging off them :)
> 
> I will do an in-depth study of the AML in question, I just noticed it is
> coupled to some EC magic register, which might be doing stuff the USB
> subsystem just can't do normally.

Bah, never mind.  Major issue between the keyboard and the chair, on my
end...  Got PR# and PS# confused.  The ThinkPad ACPI DSDT in question has
the standard crap for wake device control, and PR# methods, but no PS#
methods.

The PR0..PR2 nodes for the UHCI and EHCI USB ports on the ThinkPad T43
mention a power resource object, and that power resource CAN power on/off
the USB ports (and that freaks out the UHCI and EHCI kernel drivers causing
over-current reports, but that was to be expected).  The AML code tells the
EC to do some magic that probably tells a MOSFET somewhere in the mainboard
to stop supplying power to the ports.

And Windows XP (this is not a Vista BIOS and I never tried running Vista in
it...) is noticing that power resource (even without PS3 or PR3 nodes) and
calling that power resource _OFF handler to power down USB ports when it
doesn't need these devices for wakeup reasons, before entering STR.

Anyone has any clue on what part of the ACPI spec could result on that
behaviour?  Because otherwise I will just bloody special-case it into
thinkpad-acpi's suspend and resume stuff.  It will piss the USB subsystem
off if I can't arrange to do it on early resume and late suspend, however.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
