From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI / ACPI PM: Run-time PM, PME handling and PCI bus type callbacks
Date: Sun, 13 Sep 2009 23:20:04 +0200
Message-ID: <200909132320.05077.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50572 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbZIMVYk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Sep 2009 17:24:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

The following patches implement experimental run-time PM support for PCI bus
type.

[1/4] - add PME status checking/clearing
[2/4] - Implement native PCIe PME driver for root ports
[3/4] - Add ACPI platform support for PCI PME signaling
[4/4] - Implement run-time PM callbacks for the PCI bus type

All of this is highly theoretical, because I didn't have the time to add
runtime PM callbacks to any drivers I can test, but at least the patchset
compiles and doesn't break things outright.

Comments welcome.

Thanks,
Rafael

