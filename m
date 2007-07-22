From: Len Brown <len.brown@intel.com>
Subject: [PATCH 21/77] ACPI: update MAINTAINERS for EC and battery
Date: Sun, 22 Jul 2007 05:14:06 -0400
Message-ID: <11850957242656-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6612 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762653AbXGVJPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:25 -0400
In-Reply-To: <11850957232745-git-send-email-len.brown@intel.com>
Message-Id: <a4146557cdfcd1adf1a8e8c92493c2cebe1088a1.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Update ACPI Embedded Controller driver maintainer
with Alexey Starikovskiy's new e-mail address at Novell/SuSE.

Also, Alexey is taking over responsibility for the battery drivers.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ce895a..89b7cc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,15 +232,15 @@ T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 S:	Supported
 
 ACPI BATTERY DRIVERS
-P:	Vladimir P. Lebedev
-M:	vladimir.p.lebedev@intel.com
+P:	Alexey Starikovskiy
+M:	astarikovskiy@suse.de
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
 
 ACPI EC DRIVER
 P:	Alexey Starikovskiy
-M:	alexey.y.starikovskiy@linux.intel.com
+M:	astarikovskiy@suse.de
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
-- 
1.5.3.rc2.22.g69a9b
