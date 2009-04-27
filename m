From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/3] ACPI: use LNXCPU, not ACPI_CPU,
	for Linux-specific processor _HID
Date: Mon, 27 Apr 2009 16:33:36 -0600
Message-ID: <20090427223336.16549.82546.stgit@bob.kio>
References: <20090427223244.16549.99553.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:24055 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759AbZD0Wdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 18:33:36 -0400
In-Reply-To: <20090427223244.16549.99553.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

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

