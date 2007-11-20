From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI: disable stray GPE, prevent ACPI interrupt storm
Date: Tue, 20 Nov 2007 12:24:52 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A403B8026F@orsmsx415.amr.corp.intel.com>
References: <200711201343.28940.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54539 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760447AbXKTUY5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 15:24:57 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200711201343.28940.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Ok

/*lint -fallthrough */

Our lint needs this


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Tuesday, November 20, 2007 10:43 AM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org; Zhang, Rui; Alexey Starikovskiy
>Subject: ACPI: disable stray GPE, prevent ACPI interrupt storm
>
>Bob,
>Rui's Linux patch below modifies an ACPICA file.
>
>thanks,
>-Len
>
>commit a7f9b1f24974da287771e2d70b30d9ca7bd66684
>Author: Zhang Rui <rui.zhang@intel.com>
>Date:   Tue Nov 20 13:38:59 2007 -0500
>
>    ACPI: disable stray GPE, prevent ACPI interrupt storm
>
>    GPEs are disabled depending on their type --
>    WAKE, WAKE_RUN, and RUNTIME.  An error is returned
>    if we are asked to disable a GPE that has no type.
>
>    But at least one system exists that enables a GPE from AML
>    that is not the EC GPE, and has no _Lxx/_Exx AML handler,
>    and is thus never initialized.
>
>    In this case, when an external CRT is plugged in,
>    the GPE fires, we attempt to disable the GPE,
>    but instead just return an error.
>    So the GPE stays asserted and an ACPI interrupt storm follows.
>
>    The fix is to disable a firing GPE,
>    even if it comes from outer space.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=6217
>
>    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>    Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>    Signed-off-by: Len Brown <len.brown@intel.com>
>
>diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
>index e22f4a9..056b788 100644
>--- a/drivers/acpi/events/evgpe.c
>+++ b/drivers/acpi/events/evgpe.c
>@@ -270,18 +270,18 @@ acpi_status acpi_ev_disable_gpe(struct
>acpi_gpe_event_info *gpe_event_info)
> 	case ACPI_GPE_TYPE_WAKE_RUN:
> 		ACPI_CLEAR_BIT(gpe_event_info->flags,
ACPI_GPE_WAKE_ENABLED);
>
>-		/*lint -fallthrough */
>+		/* fallthrough */
>
> 	case ACPI_GPE_TYPE_RUNTIME:
>
> 		/* Disable the requested runtime GPE */
>
> 		ACPI_CLEAR_BIT(gpe_event_info->flags,
ACPI_GPE_RUN_ENABLED);
>-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
>-		break;
>+
>+		/* fallthrough */
>
> 	default:
>-		return_ACPI_STATUS(AE_BAD_PARAMETER);
>+		acpi_hw_write_gpe_enable_reg(gpe_event_info);
> 	}
>
> 	return_ACPI_STATUS(AE_OK);
