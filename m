From: Matthew Palmer <mpalmer@hezmatt.org>
Subject: Lenovo S10e, charge_full == 0 ?!?
Date: Mon, 1 Jun 2009 07:42:20 +1000
Message-ID: <20090531214220.GK27997@hezmatt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sasquatch.hezmatt.org ([70.85.129.92]:38930 "EHLO
	sasquatch.hezmatt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZEaVv5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 May 2009 17:51:57 -0400
Received: from hezmatt.org (unknown [10.6.66.6])
	by sasquatch.hezmatt.org (Postfix) with ESMTP id 49A65282E2B
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jun 2009 07:42:18 +1000 (EST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[Please Cc me; I'm not subscribed to the list]

Hi,

I've just bought a Lenovo S10e ideapad, and it's going nicely except that
/sys/class/power_supply/BAT0/charge_full is 0, rather than something
pleasantly large and reassuring.  This is causing battery monitors to
produce all sorts of crazy results.  The rest of the battery parameters seem
OK (nothing abnormally 0 in uevent), including charge_full_design.  I've
charged and dischaged the battery a couple of times, just to make sure it's
not some sort of "initialisation" problem.

I've tried with both 2.6.26-2 (out of Debian Lenny), and also 2.6.29-2 (from
Debian Sid), and the results are the same.  I'd try a git tree kernel, but
wihch one?  Linus' tree?  The Linux ACPI tree?  If anyone recognises this
problem and can point me at a likely candidate for a fix, I'm happy to try
it out, but randomly firing away at kernel trees, given the likely build
speed on this little netbook, is likely to be an exercise in frustration.

Failing that, does anyone have any pointers as to where I could start in
tracking this down?  It seems like it'll be a fairly straightforward bug --
the driver's probably just looking in the wrong place for the value, and
needs a re-education.  I'm completely unfamiliar with ACPI and the kernel
code relating to ACPI, though, so perhaps it's a lot more complicated than
that.  Worst case, if all else fails, I'm thinking that a "fix" might be to
check if charge_full == 0, and if so use charge_full_design.  It's ugly, but
better than the current (hah!) situation.

- Matt
