From: Paul Fox <pgf@laptop.org>
Subject: Re: a question about lid input device
Date: Wed, 07 Jul 2010 12:51:04 -0400
Message-ID: <16574.1278521464@foxharp.boston.ma.us>
References: <1276412011.19052.19294.camel@rzhang1-desktop> <20100614020127.GA30773@khazad-dum.debian.net> <8005.1278515660@foxharp.boston.ma.us> <20100707162511.GA25178@core.coreip.homeip.net> (sfid-20100707_122520_618357_7AE4DCBB)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colo4.heeltoe.com ([207.210.93.145]:38169 "EHLO
	colo4.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab0GGQvG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2010 12:51:06 -0400
In-reply-to: <20100707162511.GA25178@core.coreip.homeip.net> (sfid-20100707_122520_618357_7AE4DCBB)
Content-ID: <16569.1278521464.1@foxharp.boston.ma.us>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>

dmitry wrote:
 > On Wed, Jul 07, 2010 at 11:14:20AM -0400, Paul Fox wrote:
 > > henrique de moraes holschuh wrote:
 > >  > On Sun, 13 Jun 2010, Zhang Rui wrote:
 > >  > > Then we update the lid switch status when a Lid notification comes.
 > >  > > right?
 > >  > 
 > >  > Yes.
 > >  > 
 > >  > > Then, IMO, userspace can get the lid status
 > >  > > via /sys/class/input/inputX/uevent, right?
 > >  > 
 > >  > No, only through an IOCTL.
 > >  > 
 > >  > > /sys/class/input/input1/uevent:EV==21
 > >  > 
 > >  > That's an bitmap of al EV_EV it supports.
 > >  > 
 > >  > > /sys/class/input/input1/uevent:SW==1
 > >  > 
 > >  > That's an bitmap of al EV_SW it supports.
 > >  > 
 > >  > > Lid is opened but SW is set, I tried to close/open the lid and found
 > >  > > that this bit never changes. is there something I misunderstand? can we
 > >  > > get the lid status in userspace?
 > >  > 
 > >  > IOCTL(), only.
 > >  > 
 > >  > Since nobody got a input-utils standard package (or added something to
 > >  > util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
 > >  > shell scripts that want to query EV_SW state...
 > > 
 > > i understand that it's not fully general, but for the case of
 > > the lid:  is /proc/acpi/button/lid/LID/state going away?
 > > 
 > 
 > Yes, according to feature-removal.txt ACPI procfs interface shoudl have
 > been gone back in 2008.

thanks.  i understand that adding sysfs entries for all the bells
and whistles on modern input devices might seem prohibitive.  on
the other hand, there are some basic interfaces that are very
usefully accessed from the shell.  i guess either way the
information is available, but having to rely on a utility package
for intermediate access always introduces new packaging
dependencies, release skew issues, etc, etc.

paul
=---------------------
 paul fox, pgf@laptop.org
