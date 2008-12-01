From: Len Brown <lenb@kernel.org>
Subject: Re: [intel/acpi] backlight - T61
Date: Sun, 30 Nov 2008 22:18:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811302158150.3314@localhost.localdomain>
References: <1227854824.3477.9.camel@hidalgo>
 <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
 <1227912656.17845.5.camel@hidalgo> <1228095176.2713.18.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:43578 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbYLADTS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Nov 2008 22:19:18 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB600H4PH7UVVZ1@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 30 Nov 2008 21:19:07 -0600 (CST)
In-reply-to: <1228095176.2713.18.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, Keith Packard <keithp@keithp.com>



> IMO, after loading i915 driver, the ACPI backlight I/F can work again,
> right?

No.
hotkeys have never worked in console mode,
but in 2.6.27, echo into /proc and /sys did work in console mode
and in 2.6.28 they do not.  So this is a regression.

> If this is true, why not always loading i915 both in X and console mode?
> the kernel mode setting should not only work for X mode.

I agree that the i915 driver should handle brightness, no matter if we
are in GUI mode or console mode.  Unfortunately, today it
doesn't seem to do anything in console mode.

That is why I pointed out that the regression here was
when we deleted the /proc and /sys nodes that actualy work
from console mode...

On a brightner note, I'm pleased to report that after upgrading
my T61 to FC10 from FC9, the brightness suddenly became consistent
across screen saver events.  ie. the brightness I set via hotkey
before the screen saver event was restored after the screen
comes back from screen blank.

However, testing FC10 with the latest upstream kernel,
including the i915 changes that appeared today...
it seems that GUI mode forgets the brighness when
I switch to console mode.  Eg. If I use /sys or
hotkeys in GUI mode to reduce brightness to 0,
it stays dim when I switch to console mode,
but switches back to max brightness when
I switch back to GUI mode.

-Len


