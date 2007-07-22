From: Len Brown <len.brown@intel.com>
Subject: [PATCH 37/77] ACPI: netlink: remove unnecessary EXPORT_SYMBOL
Date: Sun, 22 Jul 2007 05:14:22 -0400
Message-ID: <11850957403722-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763114AbXGVJPq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:46 -0400
In-Reply-To: <1185095739370-git-send-email-len.brown@intel.com>
Message-Id: <b563d6f30d937510e02541930b1558d0f5759413.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/event.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 98627b0..de4def9 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -221,7 +221,6 @@ int acpi_bus_generate_genetlink_event(struct acpi_device *device,
 				  "Failed to send a Genetlink message!\n"));
 	return 0;
 }
-EXPORT_SYMBOL(acpi_bus_generate_genetlink_event);
 
 static int acpi_event_genetlink_init(void)
 {
@@ -245,7 +244,6 @@ int acpi_bus_generate_genetlink_event(struct acpi_device *device, u8 type,
 {
 	return 0;
 }
-EXPORT_SYMBOL(acpi_bus_generate_genetlink_event);
 
 static int acpi_event_genetlink_init(void)
 {
-- 
1.5.3.rc2.22.g69a9b
