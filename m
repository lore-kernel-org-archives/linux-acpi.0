From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/30] ACPI: Enable bit 11 in _PDC to advertise hw coord
Date: Sat, 07 Feb 2009 01:41:35 -0500
Message-ID: <d96f94c604453f87fe24154b87e1e9a3a72511f8.1233988827.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12280 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZBGGmG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:06 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00KUHNXR3XZ1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:52 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

Bit 11 in intel PDC definitions is meant for OS capability to handle
hardware coordination of P-states. In Linux we have always supported
hwardware coordination of P-states. Just let the BIOSes know that we
support it, by setting this bit.

Some BIOSes use this bit to choose between hardware or software coordination
and without this change below, BIOSes switch to software coordination, which
is not very optimal in terms of power consumption and extra wakeups from idle.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/pdc_intel.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
index e72bfdd..552637b 100644
--- a/include/acpi/pdc_intel.h
+++ b/include/acpi/pdc_intel.h
@@ -14,6 +14,7 @@
 #define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
 #define ACPI_PDC_C_C1_FFH		(0x0100)
 #define ACPI_PDC_C_C2C3_FFH		(0x0200)
+#define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
@@ -22,6 +23,7 @@
 #define ACPI_PDC_EST_CAPABILITY_SWSMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
 					 ACPI_PDC_SMP_P_SWCOORD | \
+					 ACPI_PDC_SMP_P_HWCOORD | \
 					 ACPI_PDC_P_FFH)
 
 #define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
-- 
1.5.6.6

