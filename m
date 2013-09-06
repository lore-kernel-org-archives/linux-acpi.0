From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 03/14] ACPI: Tidy acpi_run_osc() declarations
Date: Fri, 06 Sep 2013 11:13:47 -0600
Message-ID: <20130906171347.11482.54142.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Move the acpi_run_osc() prototype next to the related structure and
update comments.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/acpi.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3ba9fe3..902cccf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -294,12 +294,14 @@ void __init acpi_nvs_nosave_s3(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
-	char *uuid_str; /* uuid string */
+	char *uuid_str;			/* UUID string */
 	int rev;
-	struct acpi_buffer cap; /* arg2/arg3 */
-	struct acpi_buffer ret; /* free by caller if success */
+	struct acpi_buffer cap;		/* list of DWORD capabilities */
+	struct acpi_buffer ret;		/* free by caller if success */
 };
 
+acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
+
 /* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
 #define OSC_QUERY_DWORD				0	/* DWORD 1 */
 #define OSC_SUPPORT_DWORD 			1	/* DWORD 2 */
@@ -312,8 +314,6 @@ struct acpi_osc_context {
 #define OSC_INVALID_REVISION_ERROR		0x00000008  /* return */
 #define OSC_CAPABILITIES_MASK_ERROR		0x00000010  /* return */
 
-acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
-
 /* Platform-Wide Capabilities _OSC: Capabilities DWORD 2: Support Field */
 #define OSC_SB_PAD_SUPPORT			0x00000001
 #define OSC_SB_PPC_OST_SUPPORT			0x00000002
