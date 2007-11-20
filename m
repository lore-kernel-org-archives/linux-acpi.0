From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH -v2] ACPI: disable the gpe that doesn't have a GPE handler
	correctly
Date: Tue, 20 Nov 2007 17:22:52 +0800
Message-ID: <1195550573.2971.41.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4102 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549AbXKTJNr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 04:13:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The current code only disable the GPE by judging the
GPE type, which is one of WAKE, RUNTIME and WAKE_RUN.
In bug 6217, GPE 17 is enabled by the AML code ...
And it will be triggerred when an extra CRT is connected.
As GPE 17 is not ec gpe, and there is no _Lxx/_Exx method
exists in the _GPE scope, the type flag of GPE 17 is none
of the three GPE types.
In this case, the GPE is not disabled correctly.

http://bugzilla.kernel..org/show_bug.cgi?id=6217

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/events/evgpe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/events/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/events/evgpe.c
+++ linux-2.6/drivers/acpi/events/evgpe.c
@@ -277,11 +277,11 @@ acpi_status acpi_ev_disable_gpe(struct a
 		/* Disable the requested runtime GPE */
 
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
-		break;
+
+		/*lint -fallthrough */
 
 	default:
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		acpi_hw_write_gpe_enable_reg(gpe_event_info);
 	}
 
 	return_ACPI_STATUS(AE_OK);
