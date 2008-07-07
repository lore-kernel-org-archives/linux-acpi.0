From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] PCI PM: Handling of PCI devices wake-up functionality (rev. 4)
Date: Mon, 7 Jul 2008 03:30:01 +0200
Message-ID: <200807070330.02849.rjw@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57090 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbYGGBe7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jul 2008 21:34:59 -0400
In-Reply-To: <200807012356.26669.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Pavel Machek <pavel@suse.cz>

Hi Jesse,
 
This is a new (4th) iteration of the series of patches intended to rework the power
management of PCI devices so that the handling of their wake-up functionality
is consistent with the other PM operations and so that the user space can
manage the wake-up functionality of PCI devices using the
/sys/devices/.../power/wakeup interface regardless of whether the wake-up
function is based on the native PCI mechanism (PME#), or it is handled by the
platform (eg. ACPI).
 
Apart from the ACPI and PCI changes necessary for this purpose, the series
includes some clean-ups that are not strictly required, but make the code more
straightforward and (IMHO) easier to follow.

The patchset is on top of the linux-next branch of the PCI tree and is regarded
as 2.6.27 material.

Thanks,
Rafael

