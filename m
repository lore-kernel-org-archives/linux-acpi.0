From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code for devices (rev. 3)
Date: Sat, 29 Mar 2008 23:17:49 +0100
Message-ID: <200803292317.50218.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60560 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbYC2W1g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Mar 2008 18:27:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

Hi,

The following three patches are intended to start the redesign of the suspend
and hibernation framework for devices.

The first one is the 5th revision of the patch introducing new callbacks for
suspend and hibernation.

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types (3rd revision of both).

The main differences between these patches and the previous revision:
* Dropped 'struct pm_noirq_ops' and introduced 'struct pm_ext_ops' that is a
  derivative of 'struct pm_ops' (adds the _noirq operations).
* Made device_pm_add() refuse to add devices for which
  dev->parent->power.status == DPM_INVALID
* Clarified (hopefully) the new platform and pci driver code

Please review.

Thanks,
Rafael

