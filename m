From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH] i2c-scmi: Provide module aliases for automatic loading
Date: Fri, 12 Feb 2010 13:51:21 -0800
Message-ID: <20100212215121.GM29569@tux1.beaverton.ibm.com>
References: <20100210180116.GG29604@tux1.beaverton.ibm.com> <d35bed621002101007y639fd3c7k736ef53ff400f79@mail.gmail.com> <20100210204057.2ca95b0d@hyperion.delvare> <d35bed621002101223ida7758fp5ccbedfe25bd3148@mail.gmail.com> <20100211012105.GH29604@tux1.beaverton.ibm.com> <d35bed621002102333i701a212re957efb600cbda5f@mail.gmail.com> <20100211091743.287030b0@hyperion.delvare> <d35bed621002110842h54c8185fqf3bf481ad63df7bf@mail.gmail.com> <20100212185241.GJ29604@tux1.beaverton.ibm.com> <20100212200955.05730d69@hyperion.delvare>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:52014 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0BLVvg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2010 16:51:36 -0500
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1CLk31h013298
	for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2010 14:46:03 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o1CLpRhu102940
	for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2010 14:51:28 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o1CLpQdU016406
	for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2010 14:51:27 -0700
Content-Disposition: inline
In-Reply-To: <20100212200955.05730d69@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "D. Can Celasun" <dcelasun@gmail.com>, Huaxu Wan <huaxu.wan@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Ok, here's a quick patch to provide the module aliases.  Lightly tested, and
requires the patch that defines ACPI_SMBUS_IBM_HID.
---
i2c-scmi: Provide module aliases for automatic loading

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/i2c/busses/i2c-scmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 4c9fb4c..388cbdc 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -54,6 +54,7 @@ static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
 	{"", 0}
 };
+MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
 
 #define ACPI_SMBUS_STATUS_OK			0x00
 #define ACPI_SMBUS_STATUS_FAIL			0x07
