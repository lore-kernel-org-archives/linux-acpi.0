From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] acpi: video: no automatic brightness changes by firmware
Date: Mon, 17 Jun 2013 09:01:10 +0800
Message-ID: <51BE5FD6.6070405@intel.com>
References: <51B98CFD.7090409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61323 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002Ab3FQBAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Jun 2013 21:00:43 -0400
In-Reply-To: <51B98CFD.7090409@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Micael Dias <kam1kaz3@gmail.com>, Dan Garton <dan.garton@gmail.com>, Bob Ziuchkovski <bob.ziuchkovski@gmail.com>

Starting from win8, MS backlight control driver will set bit 2 of the
parameter of control method _DOS, to inform firmware it should not
perform any automatic brightness changes. This mostly affects hotkey
notification deliver - if we do not set this bit, on hotkey press,
firmware may choose to adjust brightness level instead of sending out
notification and doing nothing.

So this patch sets bit 2 when calling _DOS so that GUIs can show the
notification window on hotkey press.

The MS document on win8 backlight control is here:
http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305

This patch solves problem for ASUS N56VZ and ASUS N56VJ, both for
notification delivery and for brightness control.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52951
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=56711
Reported-and-tested-by: Micael Dias <kam1kaz3@gmail.com>
Reported-and-tested-by: Dan Garton <dan.garton@gmail.com>
Reported-and-tested-by: Bob Ziuchkovski <bob.ziuchkovski@gmail.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b8299f2..f8fa541 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1543,12 +1543,12 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 0);
+	return acpi_video_bus_DOS(video, 0, 1);
 }
 
 static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 1);
+	return acpi_video_bus_DOS(video, 0, 0);
 }
 
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
-- 
1.8.3.3.gfada522
