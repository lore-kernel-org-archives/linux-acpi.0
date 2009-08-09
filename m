From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH] ACPI: includecheck fix for include/acpi/acpi_bus.h
Date: Sun, 09 Aug 2009 19:35:39 +0530
Message-ID: <1249826739.2957.13.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40421 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbZHIOGS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Aug 2009 10:06:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


fix the following 'make includecheck' warning:

  include/acpi/acpi_bus.h: linux/device.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 include/acpi/acpi_bus.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c65e4ce..2d8f6ef 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -356,7 +356,6 @@ void acpi_remove_dir(struct acpi_device *);
 /*
  * Bind physical devices with ACPI devices
  */
-#include <linux/device.h>
 struct acpi_bus_type {
 	struct list_head list;
 	struct bus_type *bus;
-- 
1.6.0.6



