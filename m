From: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/25] asus-laptop: Fix rmmod of asus_laptop
Date: Fri, 24 Aug 2007 03:21:03 -0400
Message-ID: <11879400921598-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7250 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbXHXHVd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:33 -0400
In-Reply-To: <11879400911609-git-send-email-len.brown@intel.com>
Message-Id: <e1996a69e162b1c99c3d3802684d1c388b54f47d.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, Len Brown <len.brown@intel.com>

From: Guillaume Chazarain <guichaz@yahoo.fr>

The asus laptop driver conditionnaly registers leds in asus_led_register()
depending on their availability, but unconditionnaly unregisters them all at
exit time or when the module fails to load. Unregistering not registered leds
result in the following Oops. So we should check before unregistering.

 [<c032d2f9>] do_page_fault+0x511/0x5e9
 [<c032bae2>] error_code+0x6a/0x70
 [<c026abf8>] device_unregister+0x26/0x32
 [<f8864218>] led_classdev_unregister+0x58/0x94 [led_class]
 [<f88a90f8>] asus_led_exit+0x17/0x41 [asus_laptop]
 [<f88a91c9>] asus_laptop_exit+0xd/0x3f [asus_laptop]
 [<c013cee1>] sys_delete_module+0x17b/0x1a2
 [<c0106eae>] sysenter_past_esp+0x6b/0xa1

EIP: [<c026a9a3>] device_del+0xb/0x23a SS:ESP 0068:f594ef0c

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index d0fc4fd..40db9f7 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -1072,7 +1072,8 @@ static void asus_backlight_exit(void)
 }
 
 #define  ASUS_LED_UNREGISTER(object)				\
-	led_classdev_unregister(&object##_led)
+	if (object##_led.dev)					\
+		led_classdev_unregister(&object##_led)
 
 static void asus_led_exit(void)
 {
-- 
1.5.3.rc6.17.g1911
