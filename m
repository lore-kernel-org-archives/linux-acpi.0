From: Rafal <fatwildcat@gmail.com>
Subject: [PATCH] Restore _DOS value at video module unload
Date: Fri, 15 Aug 2014 14:07:31 +0000
Message-ID: <53EE1423.9010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:38071 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaHOMHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2014 08:07:40 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so2290408wgh.32
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2014 05:07:38 -0700 (PDT)
Received: from [192.168.1.4] ([37.248.255.234])
        by mx.google.com with ESMTPSA id u3sm6237648wif.12.2014.08.15.05.07.37
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 05:07:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

Restore _DOS (Enable/Disable Output Switching) to their default/initial 
value at video module unload.
Change allows to function properly a display switch after unload of the 
module.

--- linux-3.16.org/drivers/acpi/video.c    2014-08-03 22:25:02.000000000 
+0000
+++ linux-3.16/drivers/acpi/video.c    2014-08-12 12:24:18.754029732 +0000
@@ -1551,8 +1551,7 @@

  static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
  {
-    return acpi_video_bus_DOS(video, 0,
-                  acpi_osi_is_win8() ? 0 : 1);
+    return acpi_video_bus_DOS(video, 1, 0);
  }

  static void acpi_video_bus_notify(struct acpi_device *device, u32 event)

