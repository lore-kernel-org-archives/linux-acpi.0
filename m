From: Tommi Kyntola <kynde@ts.ray.fi>
Subject: [PATCH] acpi: fan after suspend-to-mem fix
Date: Thu, 1 Mar 2007 14:24:55 +0200 (EET)
Message-ID: <Pine.GSO.3.95q.1070301142021.15769D-100000@sunray18.ts.ray.fi>
Reply-To: Tommi Kyntola <kynde@ts.ray.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pontus.edelkey.net ([213.138.147.130]:60629 "EHLO
	pontus.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbXCAMhk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Mar 2007 07:37:40 -0500
Received: from raysrv05.ray.fi (213138149030.edelkey.net [213.138.149.30])
	by pontus.edelkey.net (8.13.7/8.13.7) with ESMTP id l21COwYG029257
	for <linux-acpi@vger.kernel.org>; Thu, 1 Mar 2007 14:24:58 +0200
Received: from localhost (kynde@localhost)
	by sunray18.ts.ray.fi (8.9.3+Sun/8.9.3) with SMTP id OAA15783
	for <linux-acpi@vger.kernel.org>; Thu, 1 Mar 2007 14:24:55 +0200 (EET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


acpi_fan_suspend should probably set state to ACPI_D3, rather than
ACPI_D0. With this change the fan works after S3 suspend atleast on
HP nw8000 laptop, for which the suspended fan has been broken since
sword-and-stone.

Signed-off-by: Tommi Kyntola <tommi.kyntola@ray.fi>
---

 Why this was ACPI_D0 beats me, but it's been that way since
 the _suspend/_resume functios got added in the commit
 0feabb01d93e5801d1127416a66cfc3963280bca (2.6.18-rc1, I think).

 The fan hasn't worked on my HP nw8000 laptop after an S3 suspend
 ever, but fixing that ACPI_D3 there finally makes it work as
 expected.

 If there was some hidden reason why that was set to ACPI_D0,
 then perhaps a config option for some ICH4 or HP laptops
 is called for.

 drivers/acpi/fan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 045c894..7ae70b0 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -243,7 +243,7 @@ static int acpi_fan_suspend(struct acpi_device *device, int state)
 	if (!device)
 		return -EINVAL;
 
-	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
+	acpi_bus_set_power(device->handle, ACPI_STATE_D3);
 
 	return AE_OK;
 }
--
1.5.0.2




