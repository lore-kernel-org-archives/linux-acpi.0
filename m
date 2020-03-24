Return-Path: <SRS0=S9MC=5J=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F5EC41621
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022CB2080C
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCXKJ2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:09:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:35742 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKJ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 06:09:28 -0400
IronPort-SDR: KEdh5rEhPyQZgdcCZJFvJyhmZxH6FBobO4Td2o3a8EWqBUwDrKbxvBY8k9Gf6UJpBjv3rc1g+y
 qhfdmXnEA+vQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 03:09:27 -0700
IronPort-SDR: P4V78Cb2y6Y0UxSwknOXZbVNZOLqmMUwBj+bkj6U5AxZRYbOq07Uxm0tnhVHeq8jWneudptE9D
 6CHlxAdnfUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="235538100"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2020 03:09:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A63211D; Tue, 24 Mar 2020 12:09:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] usb: core: Add ACPI support for USB interface devices
Date:   Tue, 24 Mar 2020 12:09:23 +0200
Message-Id: <20200324100923.8332-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently on ACPI-enabled systems the USB interface device has no link to
the actual firmware node and thus drivers may not parse additional information
given in the table. The new feature, proposed here, allows to pass properties
or other information to the drivers.

The ACPI companion of the device has to be set for USB interface devices
to achieve above. Use ACPI_COMPANION_SET macro to set this.

Note, OF already does link of_node and this is the same for ACPI case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rewrite commit message to emphasize that it is a new feature (Greg)
 drivers/usb/core/message.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 5adf489428aa..d5f834f16993 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -5,6 +5,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/acpi.h>
 #include <linux/pci.h>	/* for scatterlist macros */
 #include <linux/usb.h>
 #include <linux/module.h>
@@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->dev.of_node = usb_of_get_interface_node(dev,
 					configuration, ifnum);
 		}
+		ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
 		intf->dev.driver = NULL;
 		intf->dev.bus = &usb_bus_type;
 		intf->dev.type = &usb_if_device_type;
-- 
2.25.1

