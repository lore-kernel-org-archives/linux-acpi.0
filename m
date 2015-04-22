From: Kast Bernd <kastbernd@gmx.de>
Subject: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Wed, 22 Apr 2015 16:12:24 +0200
Message-ID: <f14ffb9df15cdf617bb4ccae575a9787866675c8.1429653764.git.kastbernd@gmx.de>
References: <cover.1429653764.git.kastbernd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58473 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757161AbbDVOMc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2015 10:12:32 -0400
Content-Disposition: inline
In-Reply-To: <cover.1429653764.git.kastbernd@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentin.chary@gmail.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dvhart@infradead.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

acpi_os_get_physical_address will be needed by an acpi driver (asus-wmi.c).
Additionally it could  be used by dell-laptop.c instead of directly calling virt_to_phys.

acpi_os_get_physical_address gets exported and ACPI_FUTURE_USAGE is removed

Signed-off-by: Kast Bernd <kastbernd@gmx.de>
---
 drivers/acpi/osl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f9eeae8..566e6ad 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -524,7 +524,6 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 }
 EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
 {
@@ -535,7 +534,7 @@ acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
 
 	return AE_OK;
 }
-#endif
+EXPORT_SYMBOL(acpi_os_get_physical_address);
 
 #define ACPI_MAX_OVERRIDE_LEN 100
 
-- 
2.3.5

