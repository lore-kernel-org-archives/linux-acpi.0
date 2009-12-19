From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFD] Asynchronous suspend/resume of PCI devices
Date: Sun, 20 Dec 2009 00:31:38 +0100
Message-ID: <200912200031.38775.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36064 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbZLSXa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Dec 2009 18:30:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

Hi,

I'd like to know your opinions about the viability of suspending and resuming
PCI devices asynchronously during system-wide PM transitions (suspend to RAM
and hibernation).

Linus says it's generally dangerous, because some PCI devices may indirectly
depend on the others, but if that's the case, I wonder if we really can power
manage PCI devices at run time.

It follows from my experiments that suspending and resuming PCI devices
asynchronously doesn't lead to problems as long as we make sure that every
PCI device is suspended before and resumed after its ACPI "shadow" partner.
However, I'm not sure if this is generally correct.

What are possible problems we can run into while doing asynchronous suspend
and resume of PCI devices?  What do we need to do in general to avoid that
problems?

Please tell me what you think.

Thanks,
Rafael
