From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI: disable stray GPE, prevent ACPI interrupt storm
Date: Fri, 30 Nov 2007 14:15:21 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A403C6FF27@orsmsx415.amr.corp.intel.com>
References: <200711201343.28940.lenb@kernel.org> <B28E9812BAF6E2498B7EC5C427F293A403B8044D@orsmsx415.amr.corp.intel.com> <1195608803.2971.2.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36783 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755751AbXK3WPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Nov 2007 17:15:23 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1195608803.2971.2.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

I don't understand why the GPE was enabled in the first place.

GPEs start out all disabled. They only get enabled if an _Lxx/_Exx
method is found.

I'm all for defensive programming (if all else fails...), but I'm
worried that there is a bug somewhere else that is accidentally enabling
this GPE.

>> >    But at least one system exists that enables a GPE from AML
>> >    that is not the EC GPE, and has no _Lxx/_Exx AML handler,
>> >    and is thus never initialized.

Yes, it should be "initialized". All GPEs are disabled by default.

Please check this out.
Thanks,
Bob








>-----Original Message-----
>From: Zhang, Rui
>Sent: Tuesday, November 20, 2007 5:33 PM
>To: Moore, Robert
>Cc: Len Brown; linux-acpi@vger.kernel.org; Alexey Starikovskiy
>Subject: RE: ACPI: disable stray GPE, prevent ACPI interrupt storm
>
>
>On Wed, 2007-11-21 at 07:11 +0800, Moore, Robert wrote:
>> BTW, this kind of change begs for a comment
>>
>Sounds good. :)
>
>Thanks,
>Rui
>>     default:
>>         /*
>>          * Even if we don't know the GPE type, make sure that we
always
>>          * disable it. This can prevent a certain type of GPE flood,
>> where
>>          * the GPE has no _Lxx/_Exx method, and it cannot be
determined
>
>>          * whether the GPE is wake, run, or wake/run.
>>          */
>>         Status = AcpiHwWriteGpeEnableReg (GpeEventInfo);
>>         break;
>>
>>
>> >-----Original Message-----
>> >From: Len Brown [mailto:lenb@kernel.org]
>> >Sent: Tuesday, November 20, 2007 10:43 AM
>> >To: Moore, Robert
>> >Cc: linux-acpi@vger.kernel.org; Zhang, Rui; Alexey Starikovskiy
>> >Subject: ACPI: disable stray GPE, prevent ACPI interrupt storm
>> >
>> >Bob,
>> >Rui's Linux patch below modifies an ACPICA file.
>> >
>> >thanks,
>> >-Len
>> >
>> >commit a7f9b1f24974da287771e2d70b30d9ca7bd66684
>> >Author: Zhang Rui <rui.zhang@intel.com>
>> >Date:   Tue Nov 20 13:38:59 2007 -0500
>> >
>> >    ACPI: disable stray GPE, prevent ACPI interrupt storm
>> >
>> >    GPEs are disabled depending on their type --
>> >    WAKE, WAKE_RUN, and RUNTIME.  An error is returned
>> >    if we are asked to disable a GPE that has no type.
>> >
>> >    But at least one system exists that enables a GPE from AML
>> >    that is not the EC GPE, and has no _Lxx/_Exx AML handler,
>> >    and is thus never initialized.
>> >
>> >    In this case, when an external CRT is plugged in,
>> >    the GPE fires, we attempt to disable the GPE,
>> >    but instead just return an error.
>> >    So the GPE stays asserted and an ACPI interrupt storm follows.
>> >
>> >    The fix is to disable a firing GPE,
>> >    even if it comes from outer space.
>> >
>> >    http://bugzilla.kernel.org/show_bug.cgi?id=6217
>> >
>> >    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> >    Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> >    Signed-off-by: Len Brown <len.brown@intel.com>
>> >
>> >diff --git a/drivers/acpi/events/evgpe.c
b/drivers/acpi/events/evgpe.c
>> >index e22f4a9..056b788 100644
>> >--- a/drivers/acpi/events/evgpe.c
>> >+++ b/drivers/acpi/events/evgpe.c
>> >@@ -270,18 +270,18 @@ acpi_status acpi_ev_disable_gpe(struct
>> >acpi_gpe_event_info *gpe_event_info)
>> > 	case ACPI_GPE_TYPE_WAKE_RUN:
>> > 		ACPI_CLEAR_BIT(gpe_event_info->flags,
>> ACPI_GPE_WAKE_ENABLED);
>> >
>> >-		/*lint -fallthrough */
>> >+		/* fallthrough */
>> >
>> > 	case ACPI_GPE_TYPE_RUNTIME:
>> >
>> > 		/* Disable the requested runtime GPE */
>> >
>> > 		ACPI_CLEAR_BIT(gpe_event_info->flags,
>> ACPI_GPE_RUN_ENABLED);
>> >-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
>> >-		break;
>> >+
>> >+		/* fallthrough */
>> >
>> > 	default:
>> >-		return_ACPI_STATUS(AE_BAD_PARAMETER);
>> >+		acpi_hw_write_gpe_enable_reg(gpe_event_info);
>> > 	}
>> >
>> > 	return_ACPI_STATUS(AE_OK);
