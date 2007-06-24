From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 0/4] PM: Rework struct pm_ops and related things
Date: Sun, 24 Jun 2007 22:39:04 +0200
Message-ID: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37116 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbXFXV3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Jun 2007 17:29:17 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

Hi,

I had some time to create patches implementing my suggestions from the previous
thread "PM: Introduce set_target method in pm_ops".  For completness I also
include the first patch that introduces .set_target() into the series.

The following series of patches:
* introduces the .set_target() method in 'struct pm_ops' so that the platform
  code knows in advance what sleep state the system is going to enter (this
  is necessary for ACPI and at91)
* moves the definition of 'struct pm_ops' to <include/suspend.h>
* changes the name of 'struct pm_ops' to 'struct platform_suspend_operations'
  and modified the names of some related functions and global variables
  accordingly
* modifies 'struct platform_suspend_operations' so that .prepare() and
  .finish() don't take arguments (.enter() still takes the state argument, 
  because some platforms don't implement the other callbacks)

I was only able to compile the patches on a PC, so if you can point me to
any tools I can use for testing them on the other affected architectures,
I'd be grateful.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

