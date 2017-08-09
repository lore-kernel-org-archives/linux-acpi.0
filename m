From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 4/9] ACPI-video: Return directly after a failed
 input_allocate_device()
Date: Wed, 9 Aug 2017 17:40:05 +0200
Message-ID: <fda98e08-1fd5-58e3-8dfe-208c35058064@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
 <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
 <3e0cdc5b-fd15-515a-82f2-2f44792664ed@users.sourceforge.net>
 <CAJZ5v0gWgxbtJ4m0eDkdOaR_usjTqmcWBWds5qprr+ydHhEjnA@mail.gmail.com>
 <6882cbb1-3f61-fb64-2972-30c277f28580@users.sourceforge.net>
 <CAJZ5v0hyhdUknW8RqpT6f4zAuPuMN1EN=P7C54Aa+VqEK2pcGw@mail.gmail.com>
 <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 15:15:16 +0200

* Return directly after a call of the function "input_allocate_device"
  failed at the beginning.

* Delete the jump label "out" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index f83ece9c830c..09ea1f115f55 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1903,10 +1903,8 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
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
@@ -1946,7 +1944,6 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 err_free_input:
 	input_free_device(input);
 	video->input = NULL;
-out:
 	return error;
 }
 
-- 
2.13.4
