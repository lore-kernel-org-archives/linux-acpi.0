From: Mayuresh Chitale <mchitale@apm.com>
Subject: ACPI support for optee driver
Date: Wed, 20 Sep 2017 14:17:38 +0530
Message-ID: <CAL-zptO3xg4k_B_S1SfKOghHGAUjqp56W9vqDdV3xgpUJ6b8dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:48161 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdITIrk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Sep 2017 04:47:40 -0400
Received: by mail-pg0-f41.google.com with SMTP id v23so1336329pgc.5
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2017 01:47:39 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-acpi@vger.kernel.org

Hi,

I am working on adding APCI support to optee kernel driver and was
considering implementing it in the following way:

- An optee device node would be added to the bios as follows:
Device(OPTE) {
      Name(_HID, ...)
      Name(_CID, ...)
      Name(_DDN, ...)
      Name (_DSD, Package () {
          Package () {
            Package (2) {"method", "smc"}
          }
      })
    }

- The optee kernel driver would then search for \\SB.OPTE device using
acpi_get_handle and parse the node to get the conduit method.

I was wondering if this is the correct way to implement it and if so
do I need to get the OPTE device registered?  Your feedback is really
appreciated.

Thanks,
Mayuresh.
