From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ACPICA: acpi_ds_resolve_package_element: Use proper status when logging exception
Date: Fri, 12 Jan 2018 12:37:06 +0100
Message-ID: <20180112113707.3833-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754403AbeALLhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 06:37:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Do not override the status which causes us to call acpi_exception with the
status returned by the acpi_ns_externalize_name call we do to get a name
to log.

Related: https://bugzilla.kernel.org/show_bug.cgi?id=198167
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/dspkginit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 6d487edfe2de..cddbbed2f344 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -372,9 +372,9 @@ acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 				ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
 				NULL, &resolved_node);
 	if (ACPI_FAILURE(status)) {
-		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
-						  (char *)element->reference.
-						  aml, NULL, &external_path);
+		acpi_ns_externalize_name(ACPI_UINT32_MAX,
+					 (char *)element->reference.aml, NULL,
+					 &external_path);
 
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Could not find/resolve named package element: %s",
-- 
2.14.3

