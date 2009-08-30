From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPI: Clarify resource conflict message
Date: Sun, 30 Aug 2009 15:46:22 +0200
Message-ID: <200908301546.22827.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54707 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbZH3NqV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Aug 2009 09:46:21 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

The message "ACPI: Device needs an ACPI driver" is misleading. The
device _may_ need an ACPI driver, if the BIOS implemented an API for
the device in question (which, AFAIK, can't be checked.) If not, then
either the generic "thermal" ACPI driver may be used, or nothing can
be done (other than a white list, if we really want to get hardware
monitoring on some machines.)

I propose to reword the message to:

ACPI: Device may still be supported by an ACPI driver

which I think is more correct. Comments and suggestions welcome.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/osl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.31-rc8.orig/drivers/acpi/osl.c	2009-08-28 19:48:58.000000000 +0200
+++ linux-2.6.31-rc8/drivers/acpi/osl.c	2009-08-30 10:10:51.000000000 +0200
@@ -1182,7 +1182,8 @@ int acpi_check_resource_conflict(struct
 			       res_list_elem->name,
 			       (long long) res_list_elem->start,
 			       (long long) res_list_elem->end);
-			printk(KERN_INFO "ACPI: Device needs an ACPI driver\n");
+			printk(KERN_INFO "ACPI: Device may still be supported"
+			       " by an ACPI driver\n");
 		}
 		if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
 			return -EBUSY;

-- 
Jean Delvare
Suse L3
