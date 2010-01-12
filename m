From: Darren Jenkins <darrenrjenkins@gmail.com>
Subject: [PATCH] drivers/acpi/power_meter.c : remove double kfree()
Date: Tue, 12 Jan 2010 23:37:07 +1100
Message-ID: <1263299827.4571.11.camel@ICE-BOX>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38172 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0ALMhQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2010 07:37:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: djwong@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

resource->domain_devices can be double kfree()'d in a couple of places.
Fix this by setting num_domain_devices = 0 after the kfree().

Coverity CID: 13356, 13355, 13354

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com> 

diff --git drivers/acpi/power_meter.c drivers/acpi/power_meter.c
index 2ef7030..18ce00a 100644
--- drivers/acpi/power_meter.c
+++ drivers/acpi/power_meter.c
@@ -534,6 +534,7 @@ static void remove_domain_devices(struct acpi_power_meter_resource *resource)
 
 	kfree(resource->domain_devices);
 	kobject_put(resource->holders_dir);
+	resource->num_domain_devices = 0;
 }
 
 static int read_domain_devices(struct acpi_power_meter_resource *resource)
@@ -740,7 +741,6 @@ skip_unsafe_cap:
 
 	return res;
 error:
-	remove_domain_devices(resource);
 	remove_attrs(resource);
 	return res;
 }


