From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] Platform / wmi: Fix potential memory leak in parse_wdg()
Date: Sat, 25 Jan 2014 00:14:35 +0800
Message-ID: <1390580075-14342-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, platform-driver-x86@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

we forgot to call wmi_free_devices() and free out.pointer
when alloc mamory failed.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/platform/x86/wmi.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 43d1329..e1338b5 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -797,8 +797,11 @@ static int parse_wdg(acpi_handle handle)
 			wmi_dump_wdg(&gblock[i]);
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
-		if (!wblock)
-			return -ENOMEM;
+		if (!wblock) {
+			wmi_free_devices();
+			retval = -ENOMEM;
+			goto out_free_pointer;
+		}
 
 		wblock->handle = handle;
 		wblock->gblock = gblock[i];
-- 
1.7.9.5
