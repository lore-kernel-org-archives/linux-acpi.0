From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: video: no automatic brightness changes by firmware
Date: Tue, 16 Jul 2013 13:08:05 +0800
Message-ID: <51E4D535.10009@intel.com>
References: <51B98CFD.7090409@intel.com> <51BE5FD6.6070405@intel.com> <20130617224040.GB14793@srcf.ucam.org> <51BFA628.8000804@intel.com> <51D61E3B.2000205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58625 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab3GPFH3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 01:07:29 -0400
In-Reply-To: <51D61E3B.2000205@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Micael Dias <kam1kaz3@gmail.com>, Dan Garton <dan.garton@gmail.com>, Bob Ziuchkovski <bob.ziuchkovski@gmail.com>

Starting from win8, MS backlight control driver will set bit 2 of the
parameter of control method _DOS, to inform firmware it should not
perform any automatic brightness changes. This mostly affects hotkey
notification deliver - if we do not set this bit, on hotkey press,
firmware may choose to adjust brightness level instead of sending out
notification and doing nothing.

So this patch sets bit 2 when calling _DOS so that GUIs can show the
notification window on hotkey press. This behavior change is only
necessary for win8 systems.

The MS document on win8 backlight control is here:
http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52951
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=56711
Reported-by: Micael Dias <kam1kaz3@gmail.com>
Reported-by: Dan Garton <dan.garton@gmail.com>
Reported-by: Bob Ziuchkovski <bob.ziuchkovski@gmail.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
Apply on top of:
https://patchwork.kernel.org/patch/2812951/ (expose OSI version)
https://patchwork.kernel.org/patch/2827793/ (win8 video quirk)

Micael, Dan and Bob,
Please give the patch a test if possible, thanks.

v2: Make the behavior change only for win8 systems; use the newly added
    function acpi_video_backlight_quirks as the condition check for win8.

 drivers/acpi/video.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 01b1a25..bc2954b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1534,14 +1534,20 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 /* acpi_video interface */
 
+/*
+ * Win8 requires setting bit2 of _DOS to let firmware know it shouldn't
+ * preform any automatic brightness change on receiving a notification.
+ */
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 0);
+	return acpi_video_bus_DOS(video, 0,
+				  acpi_video_backlight_quirks() ? 1 : 0);
 }
 
 static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 1);
+	return acpi_video_bus_DOS(video, 0,
+				  acpi_video_backlight_quirks() ? 0 : 1);
 }
 
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
--
1.8.3.2.10.g43d11f4 
