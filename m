From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI video extensions - ACPI vendor specific drivers vs. video
	module
Date: Sat, 25 Aug 2007 01:57:34 -0300
Message-ID: <20070825045734.GB7434@khazad-dum.debian.net>
References: <1187344606.8780.845.camel@queen.suse.de> <20070817131853.GA5027@khazad-dum.debian.net> <1187941725.3399.32.camel@prodigy.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45608 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384AbXHYE5m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 00:57:42 -0400
Content-Disposition: inline
In-Reply-To: <1187941725.3399.32.camel@prodigy.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Holger Macht <hmacht@suse.de>, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, linux-acpi@vger.kernel.org

On Fri, 24 Aug 2007, Thomas Renninger wrote:
> You want to encapsulate the new brightness add-ons into a .config
> Variable? I like that idea, then this could easily be removed as soon as
> video module is working with ThinkPads.

No, I want such stuff auto-detected, with an override to help with new
thinkpads from Lenovo doing weird things.  Note that 2.6.23-rc3-git1 fixes
ONE problem, but does NOT add support for 16 brightness levels, so it won't
work right on stuff with 16 brightness levels like a X61.

> Do you think it makes sense to backport the new brightness parts and
> ship it now or not?

The brightness parts? yes.  But they are not enough of a fix for the X61,
T61, and anything else with 16 brightness levels.

> To identify which laptop can safely use the video extensions and which
> one needs to be driven by the legacy (vendor specific) methods is a
> challenge though.

Since I am only dealing with thinkpads, it might be even easy. But I do not
have the time to play diff-cop with lots of DSDTs right now.  If anyone with
a x61/t61 wants to do it and sends me the info on how to detect the 16
brightness levels, I will cook up the patch to add such support right away.

> It would be great if someone can find out whether Vista requires the
> video extensions (maybe by checking BIOS update notes mentioning Vista

It does require them.

> called from BIOS and OS tells which OS are supported IIRC). Maybe if a
> Vista string is in the game, the video extensions are armed...

That could be it, there must be a reason why it is in a SSDT and not the
DSDT.  But it easily could be Lenovo letting users configure brightness
behaviour in BIOS config, and implementing that using SSDTs.

> very interesting if people can collect acpidumps before and after BIOS
> got updated with Vista and/or video functionality. Maybe someone should
> open a bug for collecting them and for giving developers a good

For thinkpads, get the *latest* BIOS.  The first ones trying to support
Vista are buggy crap.

> reference how we safely could identify machines (not only ThinkPads)
> that should work with the video module.

THAT won't be easy, at all.  How to tell if the stuff in the DSDT is good or
crap?  Sometimes the ACPI generic handles work better than the platform
specific ones.  Sometimes, they don't.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
