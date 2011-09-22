From: Bogdan Radulescu <bogdan@nimblex.net>
Subject: ACPI / PM: Blacklist Vaio VGN-FW520F machine known to require acpi_sleep=nonvs
Date: Thu, 22 Sep 2011 08:55:45 +0300
Message-ID: <CAKu+J91Apx2YWfYC=u=kZ_dD9jSvtHvPg1UgxUPiJeBchh-YRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36004 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1IVFzu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 01:55:50 -0400
Received: by qyk7 with SMTP id 7so2457266qyk.19
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2011 22:55:45 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl

Sony Vaio VGN-FW520F does not resume correctly without
acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.
References: https://bugzilla.kernel.org/show_bug.cgi?id=16396#c86

Signed-off-by: Bogdan Radulescu <bogdan@nimblex.net>

---
--- sleep.c.orig        2011-09-21 08:36:08.000000000 +0300
+++ sleep.c     2011-09-21 08:40:23.000000000 +0300
@@ -428,6 +428,14 @@ static struct dmi_system_id __initdata a
               DMI_MATCH(DMI_PRODUCT_NAME, "1000 Series"),
               },
       },
+       {
+       .callback = init_nvs_nosave,
+       .ident = "Sony Vaio VGN-FW520F",
+       .matches = {
+               DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+               DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW520F"),
+               },
+       },
       {},
 };
 #endif /* CONFIG_SUSPEND */
---
