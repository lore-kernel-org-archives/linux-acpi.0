From: Len Brown <lenb@kernel.org>
Subject: ACPI: disable stray GPE, prevent ACPI interrupt storm
Date: Tue, 20 Nov 2007 13:43:28 -0500
Message-ID: <200711201343.28940.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41549 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759088AbXKTSnv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 13:43:51 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Bob,
Rui's Linux patch below modifies an ACPICA file.

thanks,
-Len

commit a7f9b1f24974da287771e2d70b30d9ca7bd66684
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Tue Nov 20 13:38:59 2007 -0500

    ACPI: disable stray GPE, prevent ACPI interrupt storm
    
    GPEs are disabled depending on their type --
    WAKE, WAKE_RUN, and RUNTIME.  An error is returned
    if we are asked to disable a GPE that has no type.
    
    But at least one system exists that enables a GPE from AML
    that is not the EC GPE, and has no _Lxx/_Exx AML handler,
    and is thus never initialized.
    
    In this case, when an external CRT is plugged in,
    the GPE fires, we attempt to disable the GPE,
    but instead just return an error.
    So the GPE stays asserted and an ACPI interrupt storm follows.
    
    The fix is to disable a firing GPE,
    even if it comes from outer space.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=6217
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index e22f4a9..056b788 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -270,18 +270,18 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 	case ACPI_GPE_TYPE_WAKE_RUN:
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_WAKE_ENABLED);
 
-		/*lint -fallthrough */
+		/* fallthrough */
 
 	case ACPI_GPE_TYPE_RUNTIME:
 
 		/* Disable the requested runtime GPE */
 
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
-		break;
+
+		/* fallthrough */
 
 	default:
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		acpi_hw_write_gpe_enable_reg(gpe_event_info);
 	}
 
 	return_ACPI_STATUS(AE_OK);
