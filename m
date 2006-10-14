From: Len Brown <len.brown@intel.com>
Subject: [PATCH 27/28] ACPICA: Fix incorrect handling of PCI Express Root Bridge _HID
Date: Sat, 14 Oct 2006 04:06:08 -0400
Message-ID: <1160813204734-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61957 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752129AbWJNIDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:24 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <aeb1104814e1177b865eec4f4b364602f5fcb6d1.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Mon, 2 Oct 2006 19:18:03 +0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>

I could not get correct PCI Express bus number from the structure of
acpi_object_extra. I always get zero as bus number regardless of bus
location. I found that there is incorrect comparison with _HID (PNP0A08) in
acpi/events/evrgnini.c and PCI Express _BBN method always fail.
Therefore, we always get zero as PCI Express bus number.
http://bugzilla.kernel.org/show_bug.cgi?id=7145

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evrgnini.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 5b3c7a8..203d135 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -225,13 +225,12 @@ acpi_ev_pci_config_region_setup(acpi_han
 				if (!
 				    (ACPI_STRNCMP
 				     (object_hID.value, PCI_ROOT_HID_STRING,
-				      sizeof(PCI_ROOT_HID_STRING))
-				     ||
-				     !(ACPI_STRNCMP
-				       (object_hID.value,
-					PCI_EXPRESS_ROOT_HID_STRING,
-					sizeof(PCI_EXPRESS_ROOT_HID_STRING)))))
-				{
+				      sizeof(PCI_ROOT_HID_STRING)))
+				    ||
+				    !(ACPI_STRNCMP
+				      (object_hID.value,
+				       PCI_EXPRESS_ROOT_HID_STRING,
+				       sizeof(PCI_EXPRESS_ROOT_HID_STRING)))) {
 
 					/* Install a handler for this PCI root bridge */
 
-- 
1.4.3.rc2.g23bed-dirty
