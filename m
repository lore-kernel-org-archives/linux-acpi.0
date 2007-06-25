From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 0/8] PM: Rework struct pm_ops and related things (take 2)
Date: Tue, 26 Jun 2007 00:39:16 +0200
Message-ID: <200706260039.17530.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41910 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbXFYWri convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jun 2007 18:47:38 -0400
In-Reply-To: <200706242239.05678.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

Hi,

This is the second version of the patch series to rework pm_ops in orde=
r to
introduce the set_target() method etc.  This time I've takes some Dave'=
s
comments into consideration and I've realized that a method similar to
set_target() is also needed for hibernation, so I've reworked that too,=
 a bit.

The following series of patches:
* introduces the .set_target() method in 'struct pm_ops' so that the pl=
atform
=A0 code knows in advance what sleep state the system is going to enter=
 (this
=A0 is urgently needed by at91 and should go into 2.6.22 as a bugfix)
* makes ACPI use .set_target()
* adds an ACPI helper function for the devices to determine the power s=
tate
  to put the device into
* moves the definition of 'struct pm_ops' to <include/suspend.h>
* changes the name of 'struct pm_ops' to 'struct platform_suspend_opera=
tions'
=A0 and modifies the names of some related functions and global variabl=
es
=A0 accordingly
* modifies 'struct platform_suspend_operations' so that .prepare() and
=A0 .finish() don't take arguments (.enter() still takes the state argu=
ment,=20
=A0 because some platforms don't need to implement the other callbacks)
* reworks 'struct hibernation_ops' to add the new method analogous to
  .set_target()
* renames 'struct hibernation_ops' to 'struct hibernation_platform_oper=
ations'
  (in analogy with 'struct platform_suspend_operations')
The details are in the changelogs.

The series have been compilation-tested on x86_64 and I'm going to comp=
ile
it for all of the affected platforms.

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
