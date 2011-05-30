From: Lin Ming <ming.m.lin@intel.com>
Subject: re: ACPI: Add D3 cold state
Date: Mon, 30 May 2011 16:57:37 +0800
Message-ID: <1306745857.9702.19.camel@minggr.sh.intel.com>
References: <20110530084250.GM3099@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab1E3I5Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 May 2011 04:57:16 -0400
In-Reply-To: <20110530084250.GM3099@shale.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 2011-05-30 at 16:42 +0800, Dan Carpenter wrote:
> Commit 28c2103dad04 "ACPI: Add D3 cold state" introduced a read past
> the end of the array in drivers/acpi/bus.c
> 
>    224  static int __acpi_bus_set_power(struct acpi_device *device, int state)
>    225  {
>    226          int result = 0;
>    227          acpi_status status = AE_OK;
>    228          char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
>    229
>    230          if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>                                                                    ^^^^^^^^^^^^^^^^^^
> 	This is 4 now.
> 
>    231                  return -EINVAL;
>    232
>    233          /* Make sure this is a valid target state */
>    234
>    235          if (state == device->power.state) {
>    236                  ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
>    237                                    state));
>    238                  return 0;
>    239          }
>    240
>    241          if (!device->power.states[state].flags.valid) {
>                                    ^^^^^^^^^^^^^
> 	This array has 4 elements so we are one space past the end
> 	of the array.

Ah! We need fix like below.

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a10ef5..ff246e8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -210,7 +210,7 @@ struct acpi_device_power_state {
 struct acpi_device_power {
 	int state;		/* Current state */
 	struct acpi_device_power_flags flags;
-	struct acpi_device_power_state states[4];	/* Power states (D0-D3) */
+	struct acpi_device_power_state states[5];	/* Power states (D0-D3Cold) */
 };
 
 /* Performance Management */





