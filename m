From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Sat, 30 Jun 2007 22:57:16 +0200
Message-ID: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35232 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbXF3VGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jun 2007 17:06:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

Hi,

This series of patches implements changes that are possible/necessary/d=
esirable
(IMO) after the introduction of the .set_target() method in 'struct pm_=
ops'
(the patch that introduces it is in -mm,
http://marc.info/?l=3Dlinux-mm-commits&m=3D118306698814722&w=3D2).

The patches make the following changes:
* make ACPI use the new .set_target() method in 'struct pm_ops'
* add an ACPI helper function for the devices to determine the power st=
ate
=A0 to put the device into
* move the definition of 'struct pm_ops' to <include/suspend.h>
* change the name of 'struct pm_ops' to 'struct platform_suspend_ops' a=
nd
  modify the names of some related functions and global variables accor=
dingly
* modify 'struct platform_suspend_ops' so that .prepare() and .finish()=
 don't
  take arguments (.enter() still takes the state argument, because some
  platforms don't need to implement the other callbacks)
* make some functions normally defined in kernel/power/main.c be also d=
efined
  when CONFIG_PM is unset
* make suspend_ops be a static variable
* rework 'struct hibernation_ops' to add the new method analogous to
=A0 .set_target()
* rename 'struct hibernation_ops' to 'struct platform_hibernation_ops' =
(in
  analogy with 'struct platform_suspend_ops')
The details are in the changelogs.

The series is on top of the current -mm (which is somewhat updated with=
 respect
to 2.6.22-rc6-mm1).  For convenience, there is a series of patches appl=
icable
on top of 2.6.22-rc6-mm1, including the $subject patchset, at:
http://www.sisk.pl/kernel/patches/2.6.22-rc6-mm1/ .

Comments welcome.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
