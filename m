From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI / video: Use true for boolean value
Date: Tue, 23 Jan 2018 09:59:20 -0600
Message-ID: <20180123155920.GA23399@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-acpi@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index f53ccc6..76fb969 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -53,7 +53,7 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
-static bool brightness_switch_enabled = 1;
+static bool brightness_switch_enabled = true;
 module_param(brightness_switch_enabled, bool, 0644);
 
 /*
-- 
2.7.4
