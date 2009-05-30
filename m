From: Len Brown <lenb@kernel.org>
Subject: [PATCH 47/65] ACPI: use LNXCPU, not ACPI_CPU,
 for Linux-specific processor _HID
Date: Fri, 29 May 2009 21:42:25 -0400
Message-ID: <b9417f84e17b93a6976a8a88b38bf9567975cb38.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33022 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322AbZE3BnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:04 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00BLGORPXYT3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:01 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI_PROCESSOR_OBJECT_HID is a synthetic _HID that Linux generates
for "Processor" definitions.  Unlike "Device" definitions, "Processor"
definitions do not have a _HID in the namespace, so we generate a
fake _HID.  By convention, all these fake _HIDs begin with "LNX".

This does change the user-visible _HID for "Processor" objects --
previously, we used "ACPI_CPU" and this changes that to "LNXCPU",
which starts with "LNX" as do all the other made-up _HIDs.  This
change is visible in processor filenames and "hid" files under
/sys/devices/LNXSYSTM:00/.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_drivers.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 0352c8f..c9922b3 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -57,7 +57,7 @@
  */
 
 #define ACPI_POWER_HID			"LNXPOWER"
-#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
+#define ACPI_PROCESSOR_OBJECT_HID	"LNXCPU"
 #define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
 #define ACPI_THERMAL_HID		"LNXTHERM"
-- 
1.6.0.6

