From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Initialize EC global lock based on the return value
	of _GLK
Date: Mon, 03 Nov 2008 16:24:05 +0800
Message-ID: <1225700645.26020.42.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48237 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbYKCIRN (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:17:13 -0500
In-Reply-To: <20081031184233.8588.42241.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, alan-jenkins@tuffmail.co.uk

Subject: ACPI: Initialize EC global lock based on the return value of
_GLK
From: Zhao Yakui <yakui.zhao@intel.com>

Initialize the EC global lock based on the returned value of _GLK
object.Only when AE_OK is returned by the acpi_evaluate_integer, the EC
global lock will be assigned based on the return value of _GLK
object.Otherwise it means that there is no _GLK object and the global
lock won't be required when EC is accessed.
If the return value of _GLK object is not zero, it means that GLobal
lock will be required when EC is accessed.
If the return value of _GLK object is zero, it means that GLobal lock 
won't be required when EC is accessed.

http://bugzilla.kernel.org/show_bug.cgi?id=11917

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Alexey Starikovskiy <astarikovskiy@suse.de>
cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/acpi/ec.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -751,8 +751,21 @@ ec_parse_device(acpi_handle handle, u32 
 		return status;
 	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
-	ec->global_lock = tmp;
+	status = acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
+	/*
+	 * Only when AE_OK is returned by acpi_evaluate_interger,
+	 * the ec->global_lock will be assigned based on the returned
+	 * value by _GLK. Otherwise it means that there is no _GLK object
+	 * and global lock won't be required when EC is accessed.
+	 * If the return value of _GLK object is not zero, it means that
+	 * global lock will be required when EC is accessed.
+	 * If the return value of _GLK object is zero, it means that
+	 * global lock won't be required when EC is accessed.
+	 */
+	if (ACPI_SUCCESS(status))
+		ec->global_lock = !!tmp;
+	 else
+		ec->global_lock = 0;
 	ec->handle = handle;
 	return AE_CTRL_TERMINATE;
 }


