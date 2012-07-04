From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Fix possible fault in return package object repair
 code
Date: Wed, 04 Jul 2012 10:02:32 +0800
Message-ID: <1341367352.3978.2.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57987 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541Ab2GDCCe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jul 2012 22:02:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, Vlastimil Babka <caster@gentoo.org>, linux-acpi <linux-acpi@vger.kernel.org>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem that can occur when a lone package object is
wrapped with an outer package object in order to conform to
the ACPI specification. Can affect these predefined names:
_ALR,_MLS,_PSS,_TRT,_TSS,_PRT,_HPX,_DLM,_CSD,_PSD,_TSD

https://bugzilla.kernel.org/show_bug.cgi?id=44171

Reported-by: Vlastimil Babka <caster@gentoo.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

Len, 

This is an important bug fix.
Could you merge it?

 drivers/acpi/acpica/nspredef.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 23ce096..fe66260 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -638,7 +638,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			/* Create the new outer package and populate it */
 
 			status =
-			    acpi_ns_wrap_with_package(data, *elements,
+			    acpi_ns_wrap_with_package(data, return_object,
 						      return_object_ptr);
 			if (ACPI_FAILURE(status)) {
 				return (status);
-- 
1.7.2.5



