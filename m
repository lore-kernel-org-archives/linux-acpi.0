From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Mon, 2 Jul 2007 16:28:25 +0200
Message-ID: <200707021628.27139.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl> <200707012128.41742.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40771 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbXGBOVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 10:21:20 -0400
In-Reply-To: <200707012128.41742.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Nigel Cunningham <nigel@nigel.suspend2.net>

On Monday, 2 July 2007 06:28, David Brownell wrote:
> On Saturday 30 June 2007, Rafael J. Wysocki wrote:
> >=20
> > The patches make the following changes:
> > * make ACPI use the new .set_target() method in 'struct pm_ops'
> > * add an ACPI helper function for the devices to determine the powe=
r state
> > =A0 to put the device into
> > * move the definition of 'struct pm_ops' to <include/suspend.h>
> > * change the name of 'struct pm_ops' to 'struct platform_suspend_op=
s' and
> >   modify the names of some related functions and global variables a=
ccordingly
> > * modify 'struct platform_suspend_ops' so that .prepare() and .fini=
sh() don't
> >   take arguments (.enter() still takes the state argument, because =
some
> >   platforms don't need to implement the other callbacks)
> > * make some functions normally defined in kernel/power/main.c be al=
so defined
> >   when CONFIG_PM is unset
> > * make suspend_ops be a static variable
> > * rework 'struct hibernation_ops' to add the new method analogous t=
o
> > =A0 .set_target()
> > * rename 'struct hibernation_ops' to 'struct platform_hibernation_o=
ps' (in
> >   analogy with 'struct platform_suspend_ops')
>=20
> These look like good cleanups and, in some cases, enhancements.

Thanks. :-)

Well, the patches 1/9 and 3/9-9/9 seem to be in a good shape (2/9 needs=
 some
more work, perhaps I'll be able to do something about it later today), =
but I
have to wait with them for the Russell's ARM patchset to be merged.  Fo=
r now,
I'll just include them in the hibernation and suspend patchset
(http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc7/patches/)=
=2E

BTW, Russell, is there any chance that your patchest will be in -mm bef=
ore
it's merged?  My patches will go through -mm anyway ...

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
