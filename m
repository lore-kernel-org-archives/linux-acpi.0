From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpi/nfit: Fix memory corruption/Unregister mce decoder on failure
Date: Wed, 31 May 2017 13:32:00 -0400
Message-ID: <1496251920-6129-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdEaRcD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 13:32:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Linda Knippers <linda.knippers@hpe.com>, jmoyer@redhat.com, lszubowi@redhat.com

nfit_init() calls nfit_mce_register() on module load.  When the module
load fails the nfit mce decoder is not unregistered.  The module's
memory is freed leaving the decoder chain referencing junk.  This will
cause panics as future registrations will reference the free'd memory.

Unregister the nfit mce decoder on module init failure.

[v2]: register and then unregister mce handler to avoid losing mce events
[v3]: also cleanup nfit workqueue

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Linda Knippers <linda.knippers@hpe.com>
Cc: jmoyer@redhat.com
Cc: lszubowi@redhat.com
---
 drivers/acpi/nfit/core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 656acb5d7166..f3c3e9d4563c 100644
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
@@ -3070,8 +3072,14 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
+	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	if (ret) {
+		nfit_mce_unregister();
+		destroy_workqueue(nfit_wq);
+	}
+
+	return ret;
 
-	return acpi_bus_register_driver(&acpi_nfit_driver);
 }
 
 static __exit void nfit_exit(void)
-- 
1.7.9.3

