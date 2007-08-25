From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI video extensions - ACPI vendor specific drivers vs. video
	module
Date: Sat, 25 Aug 2007 01:28:05 -0300
Message-ID: <20070825042805.GA7434@khazad-dum.debian.net>
References: <1187344606.8780.845.camel@queen.suse.de> <20070817131853.GA5027@khazad-dum.debian.net> <1187941725.3399.32.camel@prodigy.site> <20070824114825.GA12881@srcf.ucam.org> <1187957423.3404.10.camel@prodigy.site> <20070824140911.GA15085@srcf.ucam.org> <1187958773.3702.27.camel@prodigy.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35460 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbXHYE2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 00:28:13 -0400
Content-Disposition: inline
In-Reply-To: <1187958773.3702.27.camel@prodigy.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Holger Macht <hmacht@suse.de>, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, linux-acpi@vger.kernel.org

On Fri, 24 Aug 2007, Thomas Renninger wrote:
> > The driver shouldn't expose functionality that doesn't work.
> ?!? AFAIK Lenovos BIOS updates add some of those, or similar.

Lenovo doesn't really care about backwards compatibility like IBM did, and
they broke it badly when adding Vista ACPI "features".

> It seems like some Vista compatibility thing and I doubt they add code
> in a BIOS update which does not work. I am not sure whether it's the

They do. Often. Which is why there are so many updates.

> video functions itself, but Henrique told me about BIOS updates breaking
> current ThinkPad brightness control.
> The workaround is a bad hack, reading/writing of some kind of CMOS ACPI

Actually, that's no hack.  It is how ancient thinkpads did it, and something
that *all* thinkpads kept alive so far.  It is a compatibility layer that,
interestingly enough, Lenovo did NOT break when they decided to break the EC
register compatibility with older models.

Maybe they moved the LVDS pannel brightness control from the EC to the
GPU or somesuch, that would explain a lot...

> some field testing. The ACPI video extensions exist in a lot of (all?)
> current laptop modules and we should start making use of those.)

Agreed.

> > >   - Code cleanup: It would be great to rip out some duplicate code.

Will NOT happen.  I may break it into various sub-modules, but removing
useful code just won't happen anytime soon.

Now, if you were talking about the procfs interface, well, that one is toast
as soon as I can get rid of it, which will take a while yet. Unfortunately.

> The ACPI video spec functions are there and IMO those should get used
> instead. I also saw an Asus showing the Asus specific ACPI device and

Actually, sorry but I do intend to fix the brightness interface to work
fully with the 16-level new thinkpads when I get the time. It is not hard,
*AND* it has nothing to do with the brightness keys not working fine.  Blame
that one on userspace dirty tricks, BIOS bugs, and kernel video driver
(possible?) bugs/missing features.

The fix is simple: add one more bit to the brightness register, to hold
0..15.  What I haven't bothered to deep-look after yet is how to *detect*
that a thinkpad has 16 brightness levels, maybe by something in the
DSDT/SSDTs. I don't want to do it using a model whitelist/blacklist.

> already supported by OS" thing, you can count the days until the vendor
> specific things are going to vanish. Finally this is a great advantage

I sure hope so...

> for Linux being able to make use of a specified interface. And we should
> think about how to let video and vendor specific modules coexist and
> bringing the video module into a better shape...

Agreed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
