From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2] acpi/nfit: Fix memory corruption/Unregister mce decoder on failure
Date: Tue, 23 May 2017 11:14:18 -0400
Message-ID: <1495552458-16708-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967218AbdEWPOZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 11:14:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73AA085540
        for <linux-acpi@vger.kernel.org>; Tue, 23 May 2017 15:14:24 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>

nfit_init() calls nfit_mce_register() on module load.  When the module
load fails the nfit mce decoder is not unregistered.  The module's
memory is freed leaving the decoder chain referencing junk.  This will
cause panics as future registrations will reference the free'd memory.

Unregister the nfit mce decoder on module init failure.

[v2]: register and then unregister mce handler to avoid losing mce events

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/nfit/core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 656acb5d7166..450e4a233b5e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3043,6 +3043,8 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 
 static __init int nfit_init(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 56);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
@@ -3070,8 +3072,12 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
+	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	if (ret)
+		nfit_mce_unregister();
+
+	return ret;
 
-	return acpi_bus_register_driver(&acpi_nfit_driver);
 }
 
 static __exit void nfit_exit(void)
-- 
1.7.9.3

