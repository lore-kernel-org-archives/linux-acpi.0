From: akpm@linux-foundation.org
Subject: [patch for 2.6.34? 1/1] power_meter: acpi_device_class "power_meter_resource" too long
Date: Tue, 27 Apr 2010 14:01:07 -0700
Message-ID: <201004272101.o3RL17kH019428@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53131 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107Ab0D0VBM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 17:01:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, error27@gmail.com, djwong@us.ibm.com, stable@kernel.org

From: Dan Carpenter <error27@gmail.com>

acpi_device_class can only be 19 characters and a NULL terminator.

The current code has a buffer overflow in acpi_power_meter_add():
       strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);

Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/power_meter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/power_meter.c~power_meter-acpi_device_class-power_meter_resource-too-long drivers/acpi/power_meter.c
--- a/drivers/acpi/power_meter.c~power_meter-acpi_device_class-power_meter_resource-too-long
+++ a/drivers/acpi/power_meter.c
@@ -35,7 +35,7 @@
 #define ACPI_POWER_METER_NAME		"power_meter"
 ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
-#define ACPI_POWER_METER_CLASS		"power_meter_resource"
+#define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
 
 #define NUM_SENSORS			17
 
_
