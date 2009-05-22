From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/4] ACPI: use handle, not device, in system notification path
Date: Fri, 22 May 2009 11:43:36 -0600
Message-ID: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:5503 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119AbZEVRne (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 13:43:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Currently, ACPI hotplug is mostly handled in drivers.  I'm working on moving
that hotplug support out of drivers and into the Linux/ACPI core.

These patches change the Linux/ACPI notify handling to use the
acpi_handle a bit longer before looking up an acpi_device.

System notifications often deal with device presence and status change.
In these cases, we may not have an acpi_device.  For example, we may
get a Device Check notification on an object that previously was not
present.  Since the object was not present, we would not have had an
acpi_device for it.

Note: The last patch in this series depends on this previous patch
that is not upstream yet:
    http://patchwork.kernel.org/patch/21076/

Comments welcome.

---

Bjorn Helgaas (4):
      ACPI: use handle, not device, in system notification path
      ACPI: remove unused return values from Bus Check & Device Check handling
      ACPI: remove unused "status_changed" return value from Check Device handling
      ACPI: simplify notification debug messages


 drivers/acpi/bus.c |   93 +++++++++++++---------------------------------------
 1 files changed, 23 insertions(+), 70 deletions(-)

-- 
Bjorn
