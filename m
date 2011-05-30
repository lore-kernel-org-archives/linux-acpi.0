From: Dan Carpenter <error27@gmail.com>
Subject: re: ACPI: Add D3 cold state
Date: Mon, 30 May 2011 11:42:50 +0300
Message-ID: <20110530084250.GM3099@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41822 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab1E3InI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 May 2011 04:43:08 -0400
Received: by wya21 with SMTP id 21so2466611wya.19
        for <linux-acpi@vger.kernel.org>; Mon, 30 May 2011 01:43:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ming.m.lin@intel.com
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Commit 28c2103dad04 "ACPI: Add D3 cold state" introduced a read past
the end of the array in drivers/acpi/bus.c

   224  static int __acpi_bus_set_power(struct acpi_device *device, int state)
   225  {
   226          int result = 0;
   227          acpi_status status = AE_OK;
   228          char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
   229
   230          if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
                                                                   ^^^^^^^^^^^^^^^^^^
	This is 4 now.

   231                  return -EINVAL;
   232
   233          /* Make sure this is a valid target state */
   234
   235          if (state == device->power.state) {
   236                  ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
   237                                    state));
   238                  return 0;
   239          }
   240
   241          if (!device->power.states[state].flags.valid) {
                                   ^^^^^^^^^^^^^
	This array has 4 elements so we are one space past the end
	of the array.

   242                  printk(KERN_WARNING PREFIX "Device does not support D%d\n", state);
   243                  return -ENODEV;
   244          }

regards,
dan carpenter
