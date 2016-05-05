From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / sysfs: fix error code in get_status()
Date: Thu, 5 May 2016 16:23:04 +0300
Message-ID: <20160505132304.GF3038@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The problem with ornamental, do-nothing gotos is that they lead to
"forgot to set the error code" bugs.  We should be returning -EINVAL
here but we don't.  It leads to an uninitalized variable in
counter_show():

    drivers/acpi/sysfs.c:603 counter_show()
    error: uninitialized symbol 'status'.

Fixes: 1c8fce27e275 ('ACPI: introduce drivers/acpi/sysfs.c')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0243d37..4b3a9e2 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -555,23 +555,22 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
 static int get_status(u32 index, acpi_event_status *status,
 		      acpi_handle *handle)
 {
-	int result = 0;
+	int result;
 
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
-		goto end;
+		return -EINVAL;
 
 	if (index < num_gpes) {
 		result = acpi_get_gpe_device(index, handle);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 					"Invalid GPE 0x%x", index));
-			goto end;
+			return result;
 		}
 		result = acpi_get_gpe_status(*handle, index, status);
 	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
 		result = acpi_get_event_status(index - num_gpes, status);
 
-end:
 	return result;
 }
 
