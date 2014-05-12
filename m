From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / TPM: Fix resume regression on Chromebooks
Date: Mon, 12 May 2014 02:13:11 +0200
Message-ID: <1815337.lCisGfjnvC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61868 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753795AbaEKX41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 May 2014 19:56:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>, James Duley <jagduley@gmail.com>, Phillip Dixon <phil@dixon.gen.nz>, Brandon Casey <drafnel@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Chromebooks (at least Acer C720 and Pixel) implement an ACPI object
for TPM, but don't implement the _DSM method to support PPI.  As
a result, the TPM driver fails to load on those machines after
commit 1569a4c4ceba (ACPI / TPM: detect PPI features by checking
availability of _DSM functions) which causes them to fail to
resume from system suspend, becuase they require the TPM hardware
to be put into the right state during resume and the TPM driver
is necessary for that.

Fix the problem by making tpm_add_ppi() return 0 when tpm_ppi_handle
is still NULL after walking the ACPI namespace in search for the PPI
_DSM, which allows the TPM driver to load and operate the hardware
(during system resume in particular), but avoid creating the PPI
sysfs group in that case.

This change is based on a prototype patch from Jiang Liu.

Fixes: 1569a4c4ceba (ACPI / TPM: detect PPI features by checking availability of _DSM functions)
References: https://bugzilla.kernel.org/show_bug.cgi?id=74021
Reported-by: James Duley <jagduley@gmail.com>
Reported-by: Phillip Dixon <phil@dixon.gen.nz>
Tested-by: Brandon Casey <drafnel@gmail.com>
Cc: 3.14+ <stable@vger.kernel.org> # 3.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/tpm/tpm_ppi.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/char/tpm/tpm_ppi.c
===================================================================
--- linux-pm.orig/drivers/char/tpm/tpm_ppi.c
+++ linux-pm/drivers/char/tpm/tpm_ppi.c
@@ -328,13 +328,11 @@ int tpm_add_ppi(struct kobject *parent)
 	/* Cache TPM ACPI handle and version string */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
 			    ppi_callback, NULL, NULL, &tpm_ppi_handle);
-	if (tpm_ppi_handle == NULL)
-		return -ENODEV;
-
-	return sysfs_create_group(parent, &ppi_attr_grp);
+	return tpm_ppi_handle ? sysfs_create_group(parent, &ppi_attr_grp) : 0;
 }
 
 void tpm_remove_ppi(struct kobject *parent)
 {
-	sysfs_remove_group(parent, &ppi_attr_grp);
+	if (tpm_ppi_handle)
+		sysfs_remove_group(parent, &ppi_attr_grp);
 }

