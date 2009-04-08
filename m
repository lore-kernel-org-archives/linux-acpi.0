From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/6] ACPI: button: minor cleanups
Date: Wed, 08 Apr 2009 09:39:33 -0600
Message-ID: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:15270 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbZDHPjf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:39:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These are minor cleanups - mostly whitespace and style.  With the
exception of the last, none should make any functional difference.

The last one does make a minor change in /proc "info" files: it
removes the "(FF)" or "(CM)" annotation for power and sleep buttons.
If anybody thinks that's important, I could rework that patch to
keep the annotations while removing the other useless distinctions
in the driver.

---

Bjorn Helgaas (6):
      ACPI: button: remove control method/fixed hardware distinctions
      ACPI: button: remove button->device pointer
      ACPI: button: cache hid/name/class pointers
      ACPI: button: use Linux style for getting driver_data
      ACPI: button: remove unnecessary null pointer checks
      ACPI: button: whitespace changes


 drivers/acpi/button.c |  140 +++++++++++++++----------------------------------
 1 files changed, 44 insertions(+), 96 deletions(-)

-- 
Bjorn
