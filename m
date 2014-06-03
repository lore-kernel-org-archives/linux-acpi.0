From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: Namespace: Remove _PRP method support.
Date: Tue, 03 Jun 2014 15:32:34 +0200
Message-ID: <18718384.S2Nqt94PCR@vostro.rjw.lan>
References: <f55cebd888fc7073d133e202450f70f9f24bd902.1401772199.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61604 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754254AbaFCNPU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2014 09:15:20 -0400
In-Reply-To: <f55cebd888fc7073d133e202450f70f9f24bd902.1401772199.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Tuesday, June 03, 2014 01:20:32 PM Lv Zheng wrote:
> The _PRP method is not going to be a part of the ACPI standard. This patch
> removes its support code introduced by the following commits:
>  1. ACPICA: Predefined names: Add support for the _PRP method.
>  2. ACPICA: Update for _PRP predefined name.
>  3. ACPICA: Add support for _LPD and _PRP methods.
>  4. ACPICA: Back port of _PRP update.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Applied, thanks!

> ---
>  drivers/acpi/acpica/acpredef.h |    6 ------
>  include/acpi/acnames.h         |    1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
> index 34001a9..bd08817 100644
> --- a/drivers/acpi/acpica/acpredef.h
> +++ b/drivers/acpi/acpica/acpredef.h
> @@ -702,12 +702,6 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
>  	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
>  	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
>  
> -	{{"_PRP", METHOD_0ARGS,
> -	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each: 1 Str, 1 Int/Str/Pkg */
> -	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_STRING, 1,
> -		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
> -		     ACPI_RTYPE_PACKAGE | ACPI_RTYPE_REFERENCE, 1, 0),
> -
>  	{{"_PRS", METHOD_0ARGS,
>  	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
>  
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index f0e713f..3dd6e83 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -55,7 +55,6 @@
>  #define METHOD_NAME__HID        "_HID"
>  #define METHOD_NAME__INI        "_INI"
>  #define METHOD_NAME__PLD        "_PLD"
> -#define METHOD_NAME__PRP        "_PRP"
>  #define METHOD_NAME__PRS        "_PRS"
>  #define METHOD_NAME__PRT        "_PRT"
>  #define METHOD_NAME__PRW        "_PRW"
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
