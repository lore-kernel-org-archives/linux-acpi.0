From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning [v2]
Date: Fri, 9 Oct 2015 02:02:13 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC675E@SHSMSX101.ccr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37D36303A@ORSMSX112.amr.corp.intel.com>
 <1444243849-27929-1-git-send-email-prarit@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D970F57@ORSMSX111.amr.corp.intel.com>
 <56167C58.8000405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51967 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbbJICCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2015 22:02:18 -0400
In-Reply-To: <56167C58.8000405@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Moore, Robert" <robert.moore@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Why don't you fix this in the invoker side?
For example:
If (acpi_get_handle())
	acpi_evaluate_object()
So that the AE_NOT_FOUND warning can still be kept for the real troubles?
There are really scenarios that such warning is useful for catching bugs.

Thanks and best regards
-Lv

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Prarit Bhargava
> Sent: Thursday, October 08, 2015 10:23 PM
> To: Moore, Robert; devel@acpica.org
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx should not result in a loud warning [v2]
> 
> 
> 
> On 10/08/2015 10:19 AM, Moore, Robert wrote:
> > We'll do the ACPICA version of this, although with probably with some changes.
> > Thanks,
> 
> Thanks Bob.  If you could let me know when this lands in github(?) that would be
> great.  I'll reference it in the backport upstream.
> 
> P.
> 
> > Bob
> >
> >
> >> -----Original Message-----
> >> From: Prarit Bhargava [mailto:prarit@redhat.com]
> >> Sent: Wednesday, October 07, 2015 11:51 AM
> >> To: devel@acpica.org
> >> Cc: Prarit Bhargava; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len
> >> Brown; linux-acpi@vger.kernel.org
> >> Subject: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx should
> >> not result in a loud warning [v2]
> >>
> >> 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either 1 or 2
> >> integers") changed the error handling in AcpiGetSleepTypeData such that
> >>
> >> ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> >> (20130517/hwxface-571)
> >>
> >> is displayed on systems not implementing individual ACPI \_Sx sleep
> >> states.
> >> Since these states are optional the loud warning is incorrect.  This patch
> >> changes the kernel to the older behaviour of not warning on a not found
> >> \_Sx.
> >>
> >> Before patch:
> >>
> >> [root@dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep State"
> >>  ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> >> (20130517/hwxface-571)  ACPI Exception: AE_NOT_FOUND, While evaluating
> >> Sleep State [\_S2_] (20130517/hwxface-571)  ACPI Exception: AE_NOT_FOUND,
> >> While evaluating Sleep State [\_S3_] (20130517/hwxface-571)
> >> [root@dell-pem520-03 ~]#
> >>
> >> After patch:
> >>
> >> [root@dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep State"
> >> [root@dell-pem520-03 ~]#
> >>
> >> v2: Suggested by Robert Moore: Do not warn on AE_NOT_FOUND, otherwise warn
> >> loudly
> >>
> >> Fixes: 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either
> >> 1 or 2 integers")
> >> Cc: Robert Moore <robert.moore@intel.com>
> >> Cc: Lv Zheng <lv.zheng@intel.com>
> >> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >> ---
> >>  drivers/acpi/acpica/hwxface.c |   15 ++++++++++-----
> >>  1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
> >> index 5f97468..b450133 100644
> >> --- a/drivers/acpi/acpica/hwxface.c
> >> +++ b/drivers/acpi/acpica/hwxface.c
> >> @@ -507,9 +507,13 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> >> *sleep_type_a, u8 *sleep_type_b)
> >>  	info->relative_pathname =
> >>  	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
> >>  	status = acpi_ns_evaluate(info);
> >> -	if (ACPI_FAILURE(status)) {
> >> +	if (status == AE_NOT_FOUND) {
> >> +		/* \_Sx states are optional */
> >>  		goto cleanup;
> >>  	}
> >> +	if (ACPI_FAILURE(status)) {
> >> +		goto cleanup1;
> >> +	}
> >>
> >>  	/* Must have a return object */
> >>
> >> @@ -517,7 +521,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> >> *sleep_type_a, u8 *sleep_type_b)
> >>  		ACPI_ERROR((AE_INFO, "No Sleep State object returned from
> >> [%s]",
> >>  			    info->relative_pathname));
> >>  		status = AE_AML_NO_RETURN_VALUE;
> >> -		goto cleanup;
> >> +		goto cleanup1;
> >>  	}
> >>
> >>  	/* Return object must be of type Package */ @@ -526,7 +530,7 @@
> >> acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8
> >> *sleep_type_b)
> >>  		ACPI_ERROR((AE_INFO,
> >>  			    "Sleep State return object is not a Package"));
> >>  		status = AE_AML_OPERAND_TYPE;
> >> -		goto cleanup1;
> >> +		goto cleanup2;
> >>  	}
> >>
> >>  	/*
> >> @@ -570,16 +574,17 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> >> *sleep_type_a, u8 *sleep_type_b)
> >>  		break;
> >>  	}
> >>
> >> -cleanup1:
> >> +cleanup2:
> >>  	acpi_ut_remove_reference(info->return_object);
> >>
> >> -cleanup:
> >> +cleanup1:
> >>  	if (ACPI_FAILURE(status)) {
> >>  		ACPI_EXCEPTION((AE_INFO, status,
> >>  				"While evaluating Sleep State [%s]",
> >>  				info->relative_pathname));
> >>  	}
> >>
> >> +cleanup:
> >>  	ACPI_FREE(info);
> >>  	return_ACPI_STATUS(status);
> >>  }
> >> --
> >> 1.7.9.3
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
