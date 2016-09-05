From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 10/21] ACPI-video: Return directly after a failed
 input_allocate_device()
Date: Mon, 5 Sep 2016 18:57:12 +0200
Message-ID: <33f0a736-8682-1f0d-22cb-0ea6216cfb30@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 15:46:19 +0200

* Return directly after a call of the function "input_allocate_device"
  failed at the beginning.

* Delete the jump label "out" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 74e5a40..6c871dd 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1852,10 +1852,8 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 	int error;
 
 	video->input = input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto out;
-	}
+	if (!input)
+		return -ENOMEM;
 
 	error = acpi_video_bus_start_devices(video);
 	if (error)
@@ -1895,7 +1893,6 @@ err_stop_dev:
 err_free_input:
 	input_free_device(input);
 	video->input = NULL;
-out:
 	return error;
 }
 
-- 
2.10.0

