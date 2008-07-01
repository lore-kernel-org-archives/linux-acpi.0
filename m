From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PCI PM: Handling of PCI devices wake-up functionality (rev. 3)
Date: Tue, 1 Jul 2008 23:56:25 +0200
Message-ID: <200807012356.26669.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60714 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbYGAWNt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 18:13:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

Hi,

This is a new (3rd) iteration of the series of patches intended to rework the power
management of PCI devices so that the handling of their wake-up functionality
is consistent with the other PM operations and so that the user space can
manage the wake-up functionality of PCI devices using the
/sys/devices/.../power/wakeup interface regardless of whether the wake-up
function is based on the native PCI mechanism (PME#), or it is handled by the
platform (eg. ACPI).

Apart from the ACPI and PCI changes necessary for this purpose, the series
includes some clean-ups that are not strictly required, but make the code more
straightforward and (IMHO) easier to follow.

The patchset is on top of the linux-next from today.  It contains one
additional patch [1/9] which is a revert of another patch that shouldn't have
been put into linux-next (at least not in the way it was done).

Please review.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

