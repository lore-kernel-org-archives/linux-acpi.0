From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] Check ACPI device poweroff capability
Date: Fri,  9 Nov 2012 09:54:54 +0800
Message-ID: <1352426096-15116-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57436 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523Ab2KIBzG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2012 20:55:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

This patchset introduces a way to check if ACPI has provided a way
to put the devicei into D3 cold power state.

This patchset is based on Rafael's patchset:
ACPI / PM: ACPI power management callback routines for subsystems
http://marc.info/?l=linux-acpi&m=135150188412673&w=2

Aaron Lu (2):
  acpi: introduce swset flag for power_state
  acpi: add function to check if poweroff is possible

 drivers/acpi/scan.c     | 9 ++++++++-
 include/acpi/acpi_bus.h | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.7.12.4

