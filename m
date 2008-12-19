From: Len Brown <lenb@kernel.org>
Subject: _DIS ACPI PCI Interrupt Links
Date: Fri, 19 Dec 2008 03:22:50 -0500
Message-ID: <1229674972-1511-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:25542 "EHLO
	vms173009.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752572AbYLSIWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 03:22:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KC4005QF72MDU92@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 02:18:23 -0600 (CST)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id mBJ8MqVM001563	for
 <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 03:22:52 -0500
Received: (from lenb@localhost)	by localhost.localdomain (8.14.2/8.14.2/Submit)
 id mBJ8MqcR001561	for linux-acpi@vger.kernel.org; Fri,
 19 Dec 2008 03:22:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

We've had the reference counting on Links disabled
since 2.6.12.  Time to try to enable it and re-learn
why we disabled it back then:-)

This allows links to get back into the _DISabled state
when drivers free IRQs.  They may free IRQs at
unload time, or at suspend time.

For suspend, this allows us to "act more like boot",
in that links start off in _DIS and are programmed
as the drivers request them.

irqrouter_resume() will still restore the
links that were not in the _DIS state at suspend.
(Though I really don't like this routine, and how
 it runs AML with irqs disabled)

One opportunity for a bug on resume we may have is
that we don't actually force all the links to _DIS
before we start programming them as we do at boot time.
We can add that if it turns out to be a problem --
but would do it with interrupts on, like we do at boot...

Anyway, this all works for me...
If Rafael comes through with PCI Core code to
free IRQ at suspend for all devices, then we may
find outselves very close to the state where all
the links are disabled at suspend and irqrouter_resume()
has nothing to do.


cheers,
-- Len Brown - Intel Open Source Technology Center
