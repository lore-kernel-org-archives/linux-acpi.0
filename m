From: Len Brown <lenb@kernel.org>
Subject: [PATCH 004/112] ACPI: disable stray GPE, prevent ACPI interrupt storm
Date: Thu,  7 Feb 2008 04:33:26 -0500
Message-ID: <a7f9b1f24974da287771e2d70b30d9ca7bd66684.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754178AbYBGJfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:21 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

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
---
 drivers/acpi/events/evgpe.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
1.5.4.23.gef5b9

