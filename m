From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 19/21] ACPI-video: Rename a jump label in
 acpi_video_device_lcd_query_levels()
Date: Mon, 5 Sep 2016 19:06:11 +0200
Message-ID: <581ebef3-6079-c33e-94fc-67277c4c013d@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 17:34:40 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5566f68..231fab3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -329,14 +329,13 @@ acpi_video_device_lcd_query_levels(acpi_handle handle,
 	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
 		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
 		status = -EFAULT;
-		goto err;
+		goto free_buffer;
 	}
 
 	*levels = obj;
 
 	return 0;
-
-err:
+ free_buffer:
 	kfree(buffer.pointer);
 
 	return status;
-- 
2.10.0
