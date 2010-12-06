From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/7] ACPI video: check cap._DDC flag before getting EDID
Date: Mon, 06 Dec 2010 15:04:24 +0800
Message-ID: <1291619064.19296.579.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40836 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab0LFHHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>


cap._DDC is defined but never used.
Check this flag now and don't try to get EDID for video output devices with this flag cleared.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1275,6 +1275,9 @@ int acpi_video_get_edid(struct acpi_devi
 		if (!video_device)
 			continue;
 
+		if (!video_device->cap._DDC)
+			continue;
+
 		if (type) {
 			switch (type) {
 			case ACPI_VIDEO_DISPLAY_CRT:


