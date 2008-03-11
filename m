From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]  ACPI:  Ignore _BQC object when registering backlight
	device
Date: Tue, 11 Mar 2008 16:56:47 +0800
Message-ID: <1205225807.6425.3.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41243 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYCKJI2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 05:08:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Ignore _BQC object when registering backlight device
>From : Zhao Yakui <yakui.zhao@intel.com>

According to acpi spec , the objects of  _BCL and _BCM are required if
integrated LCD is present and supports brightness level .The _BQC is
the optional object. So the _BQC object is ignored when the backlight device
is registered in ACPI video driver.

http://bugzilla.kernel.org/show_bug.cgi?id=10206

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -713,7 +713,7 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
-	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
+	if (device->cap._BCL && device->cap._BCM && max_level > 0) {
 		int result;
 		static int count = 0;
 		char *name;


