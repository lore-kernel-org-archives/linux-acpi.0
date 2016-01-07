From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] acpi: avoid leaking format string into kobject name
Date: Thu, 7 Jan 2016 11:24:29 -0800
Message-ID: <20160107192429.GA5113@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36622 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbcAGTYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 14:24:31 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so173221403pab.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jan 2016 11:24:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The dn->name is expected to be used as a literal, so add the missing
"%s".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 707cf6213bc2..b9afb47db7ed 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -104,7 +104,7 @@ static void acpi_expose_nondev_subnodes(struct kobject *kobj,
 
 		init_completion(&dn->kobj_done);
 		ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
-					   kobj, dn->name);
+					   kobj, "%s", dn->name);
 		if (ret)
 			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
 		else
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
