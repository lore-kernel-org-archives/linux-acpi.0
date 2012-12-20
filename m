From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] acpi_get_sleep_type_data(): accept package with one element
Date: Thu, 20 Dec 2012 22:22:43 +0100
Message-ID: <1385066.qAIMAB6X4i@vostro.rjw.lan>
References: <1356024683-28542-1-git-send-email-lersek@redhat.com> <1356024683-28542-2-git-send-email-lersek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39174 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2LTVR2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Dec 2012 16:17:28 -0500
In-Reply-To: <1356024683-28542-2-git-send-email-lersek@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Laszlo Ersek <lersek@redhat.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thursday, December 20, 2012 06:31:23 PM Laszlo Ersek wrote:
> Citation from "ACPIspec50.pdf":
> 
>   7.3.4 System \_Sx states
> 
>     [...]
> 
>     Return Value:
> 
>     A Package containing an Integer containing register values for
>     sleeping
> 
> Hence accept one-element packages as well when parsing sleep states, in
> addition to the currently accepted multi-element packages.
> 
> See the ACPICA upstream posting under [1].
> 
> This change is prompted by OVMF svn rev 14003 [2] that creates the \_S3
> and \_S4 packages with a single DWORD in each:
> 
>   Name (\_S3, Package (0x01)
>   {
>       0x00000001
>   })
>   Name (\_S4, Package (0x01)
>   {
>       0x00000002
>   })
> 
> Tested with a RHEL-6 kernel (patch applies verbatim) in virtual machines.
> Without the patch,
> - on OVMF, errors like
> 
>   ACPI Error: Sleep State return package does not have at least two
>               elements (20120711/hwxface-511)
>   ACPI Exception: AE_AML_NO_OPERAND, While evaluating SleepState [\_S3_],
>                   bad Sleep object ffff880119a33cf0 type Package
>                   (20120711/hwxface-543)
> 
>   are logged and suspend doesn't work,
> 
> - on SeaBIOS, which provides multi-element packages, suspend works.
> 
> With the patch, the messages are gone on OVMF, and the VM can be suspended
> with both boot firmwares.
> 
> [1] http://lists.acpica.org/pipermail/devel/2012-December/000405.html
> [2] http://tianocore.git.sourceforge.net/git/gitweb.cgi?p=tianocore/edk2;a=commitdiff;h=14430c55c8d0e9a8487c2c74155e63299632ef5e

Well, the patch modifies ACPICA, so it would need to go through the ACPICA
upstream for us to take it to the kernel.

Adding a CC to Bob Moore, who's the upstream ACPICA maintainer.

Thanks,
Rafael


> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  drivers/acpi/acpica/hwxface.c |   60 ++++++++++++++++++++++-------------------
>  1 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
> index 05a154c..6cd5bb0 100644
> --- a/drivers/acpi/acpica/hwxface.c
> +++ b/drivers/acpi/acpica/hwxface.c
> @@ -499,39 +499,43 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
>  	}
>  
>  	/*
> -	 * The package must have at least two elements. NOTE (March 2005): This
> -	 * goes against the current ACPI spec which defines this object as a
> -	 * package with one encoded DWORD element. However, existing practice
> -	 * by BIOS vendors seems to be to have 2 or more elements, at least
> -	 * one per sleep type (A/B).
> +	 * The current ACPI spec (v 5.0) defines this object as a package with
> +	 * one encoded DWORD element.
> +	 *
> +	 * Existing practice by BIOS vendors seems to be to have 2 or more
> +	 * elements, at least one per sleep type (A/B).
>  	 */
> -	else if (info->return_object->package.count < 2) {
> +	else if (info->return_object->package.count == 0) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Sleep State return package does not have at least two elements"));
> +			    "Sleep State return package does not have elements"));
>  		status = AE_AML_NO_OPERAND;
> -	}
> -
> -	/* The first two elements must both be of type Integer */
> -
> -	else if (((info->return_object->package.elements[0])->common.type
> -		  != ACPI_TYPE_INTEGER) ||
> -		 ((info->return_object->package.elements[1])->common.type
> -		  != ACPI_TYPE_INTEGER)) {
> -		ACPI_ERROR((AE_INFO,
> -			    "Sleep State return package elements are not both Integers "
> -			    "(%s, %s)",
> -			    acpi_ut_get_object_type_name(info->return_object->
> -							 package.elements[0]),
> -			    acpi_ut_get_object_type_name(info->return_object->
> -							 package.elements[1])));
> -		status = AE_AML_OPERAND_TYPE;
>  	} else {
> -		/* Valid _Sx_ package size, type, and value */
> +		union acpi_operand_object **elements;
>  
> -		*sleep_type_a = (u8)
> -		    (info->return_object->package.elements[0])->integer.value;
> -		*sleep_type_b = (u8)
> -		    (info->return_object->package.elements[1])->integer.value;
> +		elements = info->return_object->package.elements;
> +
> +		if (elements[0]->common.type != ACPI_TYPE_INTEGER) {
> +			ACPI_ERROR((AE_INFO,
> +				    "1st element in Sleep State return package is not Integer "
> +				    "(%s)",
> +				    acpi_ut_get_object_type_name(elements[0])));
> +			status = AE_AML_OPERAND_TYPE;
> +		}
> +		else if (info->return_object->package.count == 1) {
> +			*sleep_type_a = (u8) elements[0]->integer.value;
> +			*sleep_type_b = (u8)(elements[0]->integer.value >> 8);
> +		}
> +		else if (elements[1]->common.type != ACPI_TYPE_INTEGER) {
> +			ACPI_ERROR((AE_INFO,
> +				    "2nd element in Sleep State return package is not Integer "
> +				    "(%s)",
> +				    acpi_ut_get_object_type_name(elements[1])));
> +			status = AE_AML_OPERAND_TYPE;
> +		}
> +		else {
> +			*sleep_type_a = (u8)elements[0]->integer.value;
> +			*sleep_type_b = (u8)elements[1]->integer.value;
> +		}
>  	}
>  
>  	if (ACPI_FAILURE(status)) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
