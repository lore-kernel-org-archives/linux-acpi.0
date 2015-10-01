From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning
Date: Thu, 1 Oct 2015 17:57:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D357F6E@ORSMSX112.amr.corp.intel.com>
References: <1443720528-14499-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9000 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756644AbbJAR5x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Oct 2015 13:57:53 -0400
In-Reply-To: <1443720528-14499-1-git-send-email-prarit@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

I seem to remember that this came up a long time ago.

Perhaps someone else will remember.


> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Thursday, October 01, 2015 10:29 AM
> To: devel@acpica.org
> Cc: Prarit Bhargava; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len
> Brown; linux-acpi@vger.kernel.org
> Subject: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx should
> not result in a loud warning
> 
> 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either 1 or 2
> integers") changed the error handling in AcpiGetSleepTypeData such that
> 
> ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> (20130517/hwxface-571)
> 
> is displayed on systems not implementing individual ACPI \_Sx sleep
> states.
> Since these states are optional the loud warning is incorrect.  This patch
> changes the kernel to the older behaviour of not warning on a missing
> \_Sx.
> 
> Before patch:
> 
> [root@dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep State"
>  ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> (20130517/hwxface-571)  ACPI Exception: AE_NOT_FOUND, While evaluating
> Sleep State [\_S2_] (20130517/hwxface-571)  ACPI Exception: AE_NOT_FOUND,
> While evaluating Sleep State [\_S3_] (20130517/hwxface-571)
> [root@dell-pem520-03 ~]#
> 
> After patch:
> 
> [root@dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep State"
> [root@dell-pem520-03 ~]#
> 
> Fixes: 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either
> 1 or 2 integers")
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/acpi/acpica/hwxface.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
> index 5f97468..8f50a7f 100644
> --- a/drivers/acpi/acpica/hwxface.c
> +++ b/drivers/acpi/acpica/hwxface.c
> @@ -508,6 +508,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> *sleep_type_a, u8 *sleep_type_b)
>  	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
>  	status = acpi_ns_evaluate(info);
>  	if (ACPI_FAILURE(status)) {
> +		/* \_Sx states are optional */
>  		goto cleanup;
>  	}
> 
> @@ -517,7 +518,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> *sleep_type_a, u8 *sleep_type_b)
>  		ACPI_ERROR((AE_INFO, "No Sleep State object returned from
> [%s]",
>  			    info->relative_pathname));
>  		status = AE_AML_NO_RETURN_VALUE;
> -		goto cleanup;
> +		goto cleanup1;
>  	}
> 
>  	/* Return object must be of type Package */ @@ -526,7 +527,7 @@
> acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8
> *sleep_type_b)
>  		ACPI_ERROR((AE_INFO,
>  			    "Sleep State return object is not a Package"));
>  		status = AE_AML_OPERAND_TYPE;
> -		goto cleanup1;
> +		goto cleanup2;
>  	}
> 
>  	/*
> @@ -570,16 +571,17 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> *sleep_type_a, u8 *sleep_type_b)
>  		break;
>  	}
> 
> -cleanup1:
> +cleanup2:
>  	acpi_ut_remove_reference(info->return_object);
> 
> -cleanup:
> +cleanup1:
>  	if (ACPI_FAILURE(status)) {
>  		ACPI_EXCEPTION((AE_INFO, status,
>  				"While evaluating Sleep State [%s]",
>  				info->relative_pathname));
>  	}
> 
> +cleanup:
>  	ACPI_FREE(info);
>  	return_ACPI_STATUS(status);
>  }
> --
> 1.7.9.3

