From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI: event: replace strcpy() by strscpy()
Date: Mon, 22 Apr 2019 11:39:34 -0500
Message-ID: <20190422163934.GA2636@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-acpi@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warnings:

"You might overrun the 15-character fixed-size string event->bus_id
by copying bus_id without checking the length."

"You might overrun the 20-character fixed-size string event->device_class
by copying device_class without checking the length."

Addresses-Coverity-ID: 139001 ("Copy into fixed size buffer")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/acpi/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 5a127f3f2d5c..47f21599f2ab 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -131,8 +131,8 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 	event = nla_data(attr);
 	memset(event, 0, sizeof(struct acpi_genl_event));
 
-	strcpy(event->device_class, device_class);
-	strcpy(event->bus_id, bus_id);
+	strscpy(event->device_class, device_class, sizeof(event->device_class));
+	strscpy(event->bus_id, bus_id, sizeof(event->bus_id));
 	event->type = type;
 	event->data = data;
 
-- 
2.21.0
