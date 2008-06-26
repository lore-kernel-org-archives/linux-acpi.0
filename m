From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] PCI PM: Handling of PCI devices wake-up functionality (rev. 2)
Date: Fri, 27 Jun 2008 00:22:23 +0200
Message-ID: <200806270022.24496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33499 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbYFZWbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 18:31:05 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

Hi,

This is a new iteration of the series of patches intended to rework the power
management of PCI devices so that the handling of their wake-up functionality
is consistent with the other PM operations and so that the user space can
manage the wake-up functionality of PCI devices using the
/sys/devices/.../power/wakeup interface regardless of whether the wake-up
function is based on the native PCI mechanism (PME#), or it is handled by the
platform (eg. ACPI).

Apart from the ACPI and PCI changes necessary for this purpose, the series
includes some clean-ups that are not strictly required, but make the code more
straightforward and (IMHO) easier to follow.

Please review.

Thanks,
Rafael

