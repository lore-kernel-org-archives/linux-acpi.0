From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: Don't init EC early if it has no _INI
Date: Sat, 03 Nov 2007 13:12:57 +0300
Message-ID: <20071103101257.6536.73851.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51084 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbXKCKNM (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 3 Nov 2007 06:13:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Option to init EC early inserted to handle #8598 ASUS problem,
introduced several others. 
EC driver in this particular case has fake _INI method, not present on
other machines, which don't need or break from this workaround, so lets use
its presence as a flag for early init.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9262
Reference: http://bugzilla.kernel.org/show_bug.cgi?id=8598
Reference: https://bugzilla.novell.com/show_bug.cgi?id=334806
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 06b78e5..d4dc38f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -881,12 +881,15 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 	} else {
+		acpi_handle x;
 		printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
 		status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
 						boot_ec, NULL);
 		/* Check that acpi_get_devices actually find something */
 		if (ACPI_FAILURE(status) || !boot_ec->handle)
 			goto error;
+		if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
+			goto error;
 	}
 
 	ret = ec_install_handlers(boot_ec);

