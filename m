From: Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] hpet: remove useless check if fixmem32 is NULL
Date: Wed,  4 Sep 2013 15:35:52 +0300
Message-ID: <1378298152-30765-1-git-send-email-tomas.winkler@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53236 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab3IDMgy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Sep 2013 08:36:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>, Randy Dunlap <rdunlap@infradead.org>

fixmem32 is assigned to address of res->data member
so the address is always valid

Actually since we are not checking for res != NULL
static analyzing is complaining about referencing the pointer
and consequent check for null.
The code snippet looks confusing also for human eyes.

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/hpet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 448ce5e..c8f4329 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -971,8 +971,6 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 		struct acpi_resource_fixed_memory32 *fixmem32;
 
 		fixmem32 = &res->data.fixed_memory32;
-		if (!fixmem32)
-			return AE_NO_MEMORY;
 
 		hdp->hd_phys_address = fixmem32->address;
 		hdp->hd_address = ioremap(fixmem32->address,
-- 
1.8.3.1

