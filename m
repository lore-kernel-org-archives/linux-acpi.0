From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI Cleanup :Initialize EC global lock based on the
	return status
Date: Tue, 04 Nov 2008 15:41:49 +0800
Message-ID: <1225784509.26020.73.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24887 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYKDHew (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 4 Nov 2008 02:34:52 -0500
In-Reply-To: <20081031184233.8588.42241.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, alan-jenkins@tuffmail.co.uk

Subject: ACPI: Cleanup :Initialize EC global lock based on the return status
From: Zhao Yakui <yakui.zhao@intel.com>

Initialize the EC global lock based on the returned value of _GLK object.
Only when AE_OK is returned by the acpi_evaluate_integer, the EC global lock
will be assigned based on the return value of _GLK object.Otherwise it means
that there is no _GLK object and the global lock won't be required when EC
is accessed.
If the return value of _GLK object is not zero, it means that GLobal lock
will be required when EC is accessed.
If the return value of _GLK object is zero, it means that GLobal lock
won't be required when EC is accessed.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Alexey Starikovskiy <astarikovskiy@suse.de>
cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

---
 drivers/acpi/ec.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -752,8 +752,28 @@ ec_parse_device(acpi_handle handle, u32 
 	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
 	tmp = 0;
-	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
-	ec->global_lock = tmp;
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
+	status = acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
+	if (ACPI_SUCCESS(status)) {
+		/*
+		 * If the return value is not zero, it means that global lock
+		 * is required when EC is accessed
+		 */
+		if (tmp)
+			ec->global_lock = 1;
+		else
+			ec->global_lock = 0;
+	} else
+		ec->global_lock = 0;
 	ec->handle = handle;
 	return AE_CTRL_TERMINATE;
 }


