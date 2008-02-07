From: Len Brown <lenb@kernel.org>
Subject: [PATCH 100/112] ACPI: video: call ACPI notifier chain for ACPI video notifications
Date: Thu,  7 Feb 2008 04:35:02 -0500
Message-ID: <7761f638f6e0f276fe8612ba306d09c40d1b553c.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758455AbYBGJg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:56 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Call notifier chain for display/brightness switch events.
The kernel mode graphics driver is interested in this.

Sign-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index d4b4b52..74ff0fa 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1765,6 +1765,7 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		break;
 	}
 
+	acpi_notifier_call_chain(device, event, 0);
 	input_report_key(input, keycode, 1);
 	input_sync(input);
 	input_report_key(input, keycode, 0);
@@ -1826,6 +1827,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 		break;
 	}
 
+	acpi_notifier_call_chain(device, event, 0);
 	input_report_key(input, keycode, 1);
 	input_sync(input);
 	input_report_key(input, keycode, 0);
-- 
1.5.4.23.gef5b9

