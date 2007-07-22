From: Len Brown <len.brown@intel.com>
Subject: [PATCH 74/77] ACPI: update feature-removal-schedule.txt, /sys/firmware/acpi/namespace is gone
Date: Sun, 22 Jul 2007 05:14:59 -0400
Message-ID: <11850957791127-git-send-email-len.brown@intel.com>
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
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
 <11850957721285-git-send-email-len.brown@intel.com>
 <11850957721315-git-send-email-len.brown@intel.com>
 <11850957741937-git-send-email-len.brown@intel.com>
 <1185095775978-git-send-email-len.brown@intel.com>
 <1185095776538-git-send-email-len.brown@intel.com>
 <1185095777144-git-send-email-len.brown@intel.com>
 <11850957781461-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764622AbXGVJQU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:20 -0400
In-Reply-To: <11850957781461-git-send-email-len.brown@intel.com>
Message-Id: <7a9b9068b8c7b526894904c0b9b90354825b8fbd.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The /sys/firmware/acpi/namespace has already been removed in 2.6.21.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 49ae1ea..22fe37e 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -227,20 +227,6 @@ Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
 
-What:	/sys/firmware/acpi/namespace
-When:	2.6.21
-Why:	The ACPI namespace is effectively the symbol list for
-	the BIOS.  The device names are completely arbitrary
-	and have no place being exposed to user-space.
-
-	For those interested in the BIOS ACPI namespace,
-	the BIOS can be extracted and disassembled with acpidump
-	and iasl as documented in the pmtools package here:
-	http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils
-Who:	Len Brown <len.brown@intel.com>
-
----------------------------
-
 What:	ACPI procfs interface
 When:	July 2007
 Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
-- 
1.5.3.rc2.22.g69a9b
