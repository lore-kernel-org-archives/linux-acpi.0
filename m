From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI run-time Power Management
Date: Fri, 9 Oct 2009 00:51:50 +0200
Message-ID: <200910090051.50932.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45253 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbZJHWyj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Oct 2009 18:54:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

Hi,

The following four patches implement some features needed for PCI run-time PM.

[1/4] adds a function for checking and clearing the PME status of a device

[2/4] adds support for PCIe native PME signaling mechanism

[3/4] adds support for ACPI-based PME signaling at run time

[4/4] adds prototype run-time PM callbacks for the PCI bus type

Patches [1/4] - [3/4] are rather complete, unless I missed something,
but [4/4] still requires some work.  For example, there should be some sort of
synchronization between the run-time PM and system-wide sleep transitions
which is missing at the moment.  In addition, it would make sense to
"autosuspend" PCI devices without drivers which has not been implemented
yet.

Comments welcome.

Thanks,
Rafael

