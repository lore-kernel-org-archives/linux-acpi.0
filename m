From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Fri, 1 Jul 2016 01:11:03 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C3731@ORSMSX110.amr.corp.intel.com>
References: <1467330612-26242-1-git-send-email-mmayer@broadcom.com>
 <1467330612-26242-4-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48830 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbcGABLJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 21:11:09 -0400
In-Reply-To: <1467330612-26242-4-git-send-email-mmayer@broadcom.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

Where is "strtolower" implemented?


> -----Original Message-----
> From: Markus Mayer [mailto:mmayer@broadcom.com]
> Sent: Thursday, June 30, 2016 4:50 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: Markus Mayer; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
> 
> Call strtolower() rather than walking the string explicitly to convert it
> to lowercase.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
> 
> *** Please note that there don't seem to be any callers of
> acpi_ut_strlwr().
> *** It may be possible to remove the function altogether.
> 
>  drivers/acpi/acpica/utnonansi.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/utnonansi.c
> b/drivers/acpi/acpica/utnonansi.c index 3465fe2..b6e11dc 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
> 
> **************************************************************************
> ****/
>  void acpi_ut_strlwr(char *src_string)
>  {
> -	char *string;
> -
>  	ACPI_FUNCTION_ENTRY();
> -
> -	if (!src_string) {
> -		return;
> -	}
> -
> -	/* Walk entire string, lowercasing the letters */
> -
> -	for (string = src_string; *string; string++) {
> -		*string = (char)tolower((int)*string);
> -	}
> +	strtolower(src_string);
>  }
> 
> 
> /*************************************************************************
> ******
> --
> 2.7.4

