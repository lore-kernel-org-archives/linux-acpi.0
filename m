From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 16/21] ACPI-video: Rename jump labels in
 acpi_video_device_enumerate()
Date: Mon, 5 Sep 2016 19:03:04 +0200
Message-ID: <28f3e763-b1c5-d00e-8702-51cf2ae062d1@users.sourceforge.net>
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
Date: Mon, 5 Sep 2016 17:01:30 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index fcf74e7..2fc775a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1261,7 +1261,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Invalid _DOD data"));
 		status = -EFAULT;
-		goto out;
+		goto free_buffer;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
@@ -1272,7 +1272,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 			      GFP_KERNEL);
 	if (!active_list) {
 		status = -ENOMEM;
-		goto out;
+		goto free_buffer;
 	}
 
 	count = 0;
@@ -1296,8 +1296,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 
 	video->attached_array = active_list;
 	video->attached_count = count;
-
-out:
+ free_buffer:
 	kfree(buffer.pointer);
 	return status;
 }
-- 
2.10.0
