From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / platform: fix comment about the platform device name
Date: Fri, 18 Jan 2013 16:09:35 +0200
Message-ID: <1358518175-23197-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8496 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab3AROIc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2013 09:08:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>

We don't use _UID anymore, instead the name will be taken from the
corresponding ACPI device (adev). Fix the obsolete comment.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index db129b9..5554aea 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -29,7 +29,7 @@ ACPI_MODULE_NAME("platform");
  * that's the case, create and register a platform device, populate its common
  * resources and returns a pointer to it.  Otherwise, return %NULL.
  *
- * The platform device's name will be taken from the @adev's _HID and _UID.
+ * Name of the platform device will be the same as @adev's.
  */
 struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 {
-- 
1.7.10.4

