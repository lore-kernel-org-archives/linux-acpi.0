From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/3] ACPI: EC: Limit workaround for ASUS notebooks even more
Date: Wed, 14 Jan 2009 02:57:47 +0300
Message-ID: <20090113235746.10548.22798.stgit@thinkpad>
References: <20090113235739.10548.20626.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:33902 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751094AbZAMX5p (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 13 Jan 2009 18:57:45 -0500
In-Reply-To: <20090113235739.10548.20626.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

References: http://bugzilla.kernel.org/show_bug.cgi?id=11884

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8dfcbb8..e079426 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1027,7 +1027,8 @@ int __init acpi_ec_ecdt_probe(void)
 	 * which needs it, has fake EC._INI method, so use it as flag.
 	 * Keep boot_ec struct as it will be needed soon.
 	 */
-	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
+	if (!dmi_name_in_vendors("ASUS") ||
+	    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
 		return -ENODEV;
 install:
 	if (!ec_install_handlers(boot_ec)) {

