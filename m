From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] acpi: Fix typo in video_detect.c
Date: Fri, 20 Dec 2013 00:51:37 +0900
Message-ID: <1387468297-10678-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Correct "**retyurn_value" to "**return_value".

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/acpi/video_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 84875fd..f0447d3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -50,7 +50,7 @@ static bool acpi_video_caps_checked;
 
 static acpi_status
 acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
-			  void **retyurn_value)
+			  void **return_value)
 {
 	long *cap = context;
 
-- 
1.8.5.1.163.gd7aced9
