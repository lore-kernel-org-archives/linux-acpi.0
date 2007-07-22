From: Len Brown <len.brown@intel.com>
Subject: [PATCH 28/77] ACPI: delete cmdline documentation for deleted hotkey code
Date: Sun, 22 Jul 2007 05:14:13 -0400
Message-ID: <11850957311269-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33300 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761457AbXGVJPc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:32 -0400
In-Reply-To: <11850957302782-git-send-email-len.brown@intel.com>
Message-Id: <1c1558ec50618c4a179e0684037d9f7bb0c1a326.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stephen Hemminger <shemminger@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Stephen Hemminger <shemminger@linux-foundation.org>

This looks like left over text in the kernel parameters documentation.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ce91560..7ce5ea9 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -220,11 +220,6 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
 
-	acpi_generic_hotkey [HW,ACPI]
-			Allow consolidated generic hotkey driver to
-			override platform specific driver.
-			See also Documentation/acpi-hotkey.txt.
-
 	acpi_pm_good	[IA-32,X86-64]
 			Override the pmtimer bug detection: force the kernel
 			to assume that this machine's pmtimer latches its value
-- 
1.5.3.rc2.22.g69a9b
