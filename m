From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly when
	failing in _REG object
Date: Wed, 26 Nov 2008 16:50:47 +0800
Message-ID: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61550 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223AbYKZInn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Nov 2008 03:43:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, astarikovskiy@suse.de

Hi, All

    On some laptops as it fails in evaluating the _REG object, which brings that
EC device can't be initialized correctly. But the EC space handler is not removed.
In such case maybe EC internal register will still be accessed in AML code. It is
not reasonable.
    The following patch is to fix the above issue. When it fails in evaluating the
_REG object, the EC space handler should be removed explicitly. 
    Thanks for the comments.
    

    On some laptops the incorrect status is returned by acpi_install_space
_handler because of the buggy _REG object, which causes that the EC device can't
be initialized correctly. 
    In such case it will be appropriate that the EC space handler is removed
explicitly if OS fails in evaluating _REG object.

http://bugzilla.kernel.org/show_bug.cgi?id=11884

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc:Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -916,6 +916,17 @@ static int ec_install_handlers(struct ac
 			printk(KERN_ERR "Fail in evaluating the _REG object"
 				" of EC device. Broken bios is suspected.\n");
 		} else {
+			/*
+			 * If incorrect status is returned because of the buggy
+			 * _REG object, the EC space handler should be
+			 * uninstalled explicitly.
+			 * Otherwise maybe the EC internal register is still
+			 * accessed in AML code although EC device is not
+			 * initialized correctly.
+			 */
+			acpi_remove_address_space_handler(ec->handle,
+						ACPI_ADR_SPACE_EC,
+						&acpi_ec_space_handler);
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
 			return -ENODEV;


