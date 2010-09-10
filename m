From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] acpi: handle ACPI0007 Device in acpi_early_set_pdc
Date: Thu, 09 Sep 2010 18:56:59 -0700
Message-ID: <4C89906B.1050406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:52941 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab0IJB65 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Sep 2010 21:58:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Brown, Len" <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


When bios switch to use Device object instead of Processor statement.

the SSDT for Pstate/Cstate/Tstate can not be loaded dynamically.

So try to scan ACPI0007 in addition to Processor.

this fix regression: 2.6.32 is ok.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/acpi/processor_core.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -352,4 +352,5 @@ void __init acpi_early_processor_set_pdc
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
+	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
 }
