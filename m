From: Thomas Renninger <trenn@suse.de>
Subject: ACPI video extensions - ACPI vendor specific drivers vs. video
	module
Date: Fri, 24 Aug 2007 09:48:45 +0200
Message-ID: <1187941725.3399.32.camel@prodigy.site>
References: <1187344606.8780.845.camel@queen.suse.de>
	 <20070817131853.GA5027@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:39652 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbXHXHss (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:48:48 -0400
In-Reply-To: <20070817131853.GA5027@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Holger Macht <hmacht@suse.de>, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, linux-acpi@vger.kernel.org


On Fri, 2007-08-17 at 10:18 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 17 Aug 2007, Thomas Renninger wrote:
> > do you know about this problem? Maybe it already got fixed up
> > in 2.6.23?
> 
> Yes.  Look in my git tree for the patch, or you could use the rolled-up
> patches for 2.6.22 in ibm-acpi.sf.net.  Or you can just backport what is in
> 2.6.23-rc3.
Thanks.
> 
> That said, I probably will have to mess with the module kconfig and add a
> parameter before 2.6.23 is out,
You want to encapsulate the new brightness add-ons into a .config
Variable? I like that idea, then this could easily be removed as soon as
video module is working with ThinkPads.

> so please don't ship that as a stable
> release.
Do you think it makes sense to backport the new brightness parts and
ship it now or not?

> Back to the problem... Basically, the firmware does not store in an EC
> register the brightness level anymore.  I can still read it from CMOS, so I
> added a parameter to let the user choose what the driver should do, and made
> it use only CMOS for Lenovo boxes.  It seems to work on every lenovo box,
> even those who still update the EC register like IBM thinkpads did.
> 
> How the firmware behaves depends on Lenovo thinkpad model and BIOS revision.
> The thruth is, that Lenovo is moving brightness away from the thinkpad mode
> to the generic ACPI mode in their models.  As they update the BIOSes for the
> older models, they would break as well (x60 is the last one that appears to
> work in the old way).
> 
> For the same reasons, volume is often broken in these thinkpads too.  In
> that case, it is Lenovo borkage: there is no excuse for screwing up the
> volume firmware, since it is not a part of the ACPI spec.
IMO this the wrong way to go.
It looks like (as you already mentioned above) BIOS vendors implement
the video ACPI spec extensions and on longterm this code should vanish
from the ThinkPad module again and it should be possible to let
brightness and other video functionality be done by the video module.
That vendors make use of the ACPI spec defined video extensions can be
of great advantage for us, we finally could get these functionalities on
a wide range of system.
To identify which laptop can safely use the video extensions and which
one needs to be driven by the legacy (vendor specific) methods is a
challenge though.
It would be great if someone can find out whether Vista requires the
video extensions (maybe by checking BIOS update notes mentioning Vista
compatibility and/or video/ACPI updates). I also saw an ASUS laptop
providing the old asus specific ACPI device to alter e.g. brightness,
but also the new video extension functions.
I could imagine that distinguishing can be done through the OSI/_OS (or
similar, there are two ACPI functions to identify the OS, the old one is
called from OS telling the BIOS which OS is running, the other one is
called from BIOS and OS tells which OS are supported IIRC). Maybe if a
Vista string is in the game, the video extensions are armed...
Maybe there is a specific function the OS must call to make the video
extensions work.

Hmm, I am going to add some people to CC who I know working on other
laptop specific drivers.
I also add acpi list, hope that is ok with you. It would be great and
very interesting if people can collect acpidumps before and after BIOS
got updated with Vista and/or video functionality. Maybe someone should
open a bug for collecting them and for giving developers a good
reference how we safely could identify machines (not only ThinkPads)
that should work with the video module.

   Thomas

