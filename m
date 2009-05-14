From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 1/2] ACPI: acpi_device_register() should call device_register()
Date: Thu, 14 May 2009 08:31:32 -0600
Message-ID: <20090514143132.18569.36441.stgit@bob.kio>
References: <20090514142941.18569.75813.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:3571 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbZENUbe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 16:31:34 -0400
In-Reply-To: <20090514142941.18569.75813.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

There is no apparent reason for acpi_device_register() to manually
register a new device in two steps (initialize then add).

Just call device_register() directly.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/scan.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ff510b..b8f5c00 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -530,11 +530,10 @@ static int acpi_device_register(struct acpi_device *device,
 	if (device->parent)
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
-	device_initialize(&device->dev);
 	device->dev.release = &acpi_device_release;
-	result = device_add(&device->dev);
+	result = device_register(&device->dev);
 	if(result) {
-		dev_err(&device->dev, "Error adding device\n");
+		dev_err(&device->dev, "Error registering device\n");
 		goto end;
 	}
 

