From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI:video: skip evaluating _DOD when it does not exist
Date: Fri, 27 May 2016 15:47:06 +0800
Message-ID: <1464335226-11212-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43404 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbcE0HrS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 03:47:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, alex.hung@canonical.com

Some system supports hybrid graphics and its discrete VGA
does not have any connectors and therefore has no _DOD method.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/acpi_video.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5fdac39..549cdbe 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1211,6 +1211,9 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 	union acpi_object *dod = NULL;
 	union acpi_object *obj;
 
+	if (!video->cap._DOD)
+		return AE_NOT_EXIST;
+
 	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
 	if (!ACPI_SUCCESS(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
-- 
1.7.9.5

