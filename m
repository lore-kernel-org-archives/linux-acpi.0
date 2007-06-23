From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/3] ACPICA: fix error path in new external package objects as method arguments
Date: Sat, 23 Jun 2007 11:04:47 -0400
Message-ID: <11826110902815-git-send-email-len.brown@intel.com>
References: <1182611088203-git-send-email-len.brown@intel.com>
 <11826110891391-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45508 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758010AbXFWPE5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Jun 2007 11:04:57 -0400
In-Reply-To: <11826110891391-git-send-email-len.brown@intel.com>
Message-Id: <83dd4504456d4b5e464d6ec4a7665e2c922db67f.1182611002.git.len.brown@intel.com>
In-Reply-To: <e7c746ef098770f863ba294adac5b30d124ba469.1182611002.git.len.brown@intel.com>
References: <e7c746ef098770f863ba294adac5b30d124ba469.1182611002.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

In the routine acpi_ut_create_package_object(), if the
ACPI_ALLOCATE_ZEROED() fails then ACPI_FREE(package_desc) is called as
part of the cleanup.  This should instead be
acpi_ut_remove_reference(package_desc) in order to remove the reference
acquired from acpi_ut_create_internal_object() [see the routine
acpi_ut_create_buffer_object() as an example of proper functionality].

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utobject.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index db0b9ba..76ee766 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -177,7 +177,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	package_elements = ACPI_ALLOCATE_ZEROED((acpi_size)
 						(count + 1) * sizeof(void *));
 	if (!package_elements) {
-		ACPI_FREE(package_desc);
+		acpi_ut_remove_reference(package_desc);
 		return_PTR(NULL);
 	}
 
-- 
1.5.2.1.255.gca6c0
