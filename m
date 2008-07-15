From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 08:54:40 +0930 (CST)
Message-ID: <200807152324.m6FNOexd025572@turbo.physics.adelaide.edu.au>
References: <200807151446.31799.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:40636 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754003AbYGOXZT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 19:25:19 -0400
In-Reply-To: <200807151446.31799.trenn@suse.de> from "Thomas Renninger" at Jul 15, 2008 02:46:30 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: nokos@gmx.net, jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

> On Tuesday 15 July 2008 11:38:20 nokos@gmx.net wrote:
> > on the S6410 this prevents brightness control from working correctly.
> > the ACPI BIOS provides non-functional _BCM/_BQC so the video.ko is
> > registering backlight functions but does not work. Unfortunately not
> > loading video.ko isn't a solution since with
> > bc45b1d39a925b56796bebf8a397a0491489d85c the brightness keys are only
> > reported through video.ko.
> Is this an Intel graphics card?

It probably is.  Certainly the S7020 uses an intel chipset.  Unfortunately I
haven't had a chance to test this patch on my S7020 yet and won't have time
until at least tomorrow night.

> Then you should also try Matthew's/Hong's IGD extensions.
> It is likely that everything works out with video.ko then.

I'll track these down and give them a go.

> Using ACPI video events and pass them to the Fujitsu driver to change 
> backlight (is this how it works? Is this done through userspace?), mixes up 
> everything.

I don't fully understand this statement but from what I can tell this is not
how it works.  Whatever video.ko does, it doesn't work out the box on
certain Fujitsu laptops (S6410, S7020 confirmed) - the relevant backlight
controls provided by video.ko are either non-functional or give "no such
device" errors.  The Fujitsu driver hooks into the methods which are present
on these laptops through the custom Fujitsu FUJ02B1 device (SBLL/GBLL or
SBL2/GBLS depending on model) and uses these to provide a standard backlight
class interface.  Userspace is not involved here, nor are ACPI video events
utilised.  There's certainly no passing of ACPI video events into the
Fujitsu driver.

The pressing of the LCD brightness buttons are passed to userspace as ACPI
events but the actual changing of the brightness is handled entirely by the
kernel - the keypress events are for notification only.

> Either you have video.ko or fujitsu_acpi.ko or you are in trouble of double 
> touching the HW.

With both video.ko and fujitsu-laptop.ko loaded I don't think the hardware
can be double touched unless I'm missing something.  The reason why
fujitsu-laptop includes backlight control is because video.ko's methods
don't have any effect on the hardware.  If video.ko fails to control the
backlight then it's clearly not touching the same hardware as
fujitsu-laptop.

The reason why things go pear-shaped with
bc45b1d39a925b56796bebf8a397a0491489d85c when video.ko isn't loaded is
probably due to the code added to fujitsu-laptop by this patch.  Since
(non-functional) _BCM/_BQC are apparently present in this laptop, the new
code makes fujitsu-laptop think that ACPI video will handle the backlight
and so fujitsu-laptop doesn't set up its backlight control system.  We're
then right back where we started - video.ko "handles" the backlight but it
doesn't work with this hardware because the "standard" methods don't affect
the LCD brightness on these laptops.

Perhaps the IGD extensions will magically make video.ko drive the backlight
correctly with these laptops - I will have to test this myself.  However, as
things stand at the moment it seems that this patch causes a regression for
Fujitsu S-series owners.

Regards
  jonathan
