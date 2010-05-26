From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPICA: Handle large field apertures.
Date: Wed, 26 May 2010 10:49:18 +0800
Message-ID: <1274842158.28455.18.camel@minggr.sh.intel.com>
References: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>
	 <20100525105910.2629.76253.stgit@thinkpad>
	 <1274841567.28455.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19417 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105Ab0EZCuU (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 25 May 2010 22:50:20 -0400
In-Reply-To: <1274841567.28455.16.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Wed, 2010-05-26 at 10:39 +0800, Lin Ming wrote:
> On Tue, 2010-05-25 at 18:59 +0800, Alexey Starikovskiy wrote:
> > Allow field reads of more than 64 bits if the field is properly aligned.
> > EC driver will be able to read in bursts of up to 32 bytes with this patch.
> 
> Hi, Alexey,
> 
> Got a divide-by-zero fault when running aslts test.
> 
> $cd aslts/src/runtime/collections/functional/region
> $iasl MAIN.asl
> $acpiexec -bex,mn00 region.aml
> ......
> Floating point exception
> 
> It's because in the region test case, ObjDesc->CommonField.BitLength is
> 2048 and ObjDesc->CommonField.AccessByteWidth is UINT8,
> 
> ObjDesc->CommonField.AccessByteWidth =
> 		    ACPI_ROUND_BITS_UP_TO_BYTES(ObjDesc->CommonField.BitLength);
> 
> so this assignment causes ObjDesc->CommonField.AccessByteWidth to zero.
> 
> Although this test case nearly can not exist in real BIOS aml code, but
> how about add below code to do more check?
> 
> diff --git a/source/components/executer/exprep.c b/source/components/executer/exprep.c
> index 95fa502..65cbe39 100644
> --- a/source/components/executer/exprep.c
> +++ b/source/components/executer/exprep.c
> @@ -511,6 +511,7 @@ AcpiExPrepFieldValue (
>      ACPI_OPERAND_OBJECT     *ObjDesc;
>      ACPI_OPERAND_OBJECT     *SecondDesc = NULL;
>      UINT32                  Type;
> +    UINT32                  AccessByteWidth;
>      ACPI_STATUS             Status;
>  
> 
> @@ -568,8 +569,12 @@ AcpiExPrepFieldValue (
>  	/* allow full data read from EC address space */
>  	if (ObjDesc->Field.RegionObj->Region.SpaceId == ACPI_ADR_SPACE_EC) {
>  	    if (ObjDesc->CommonField.BitLength > 8) {
> -		ObjDesc->CommonField.AccessByteWidth =
> -		    ACPI_ROUND_BITS_UP_TO_BYTES(ObjDesc->CommonField.BitLength);
> +                AccessByteWidth = ACPI_ROUND_BITS_UP_TO_BYTES(ObjDesc->CommonField.BitLength);
> +
> +                /* The max of ObjDesc->CommonField.AccessByteWidth is 0xFF */
> +                if (!(AccessByteWidth >> 8)) {

Better to test AccessByteWidth as below,

+                if (!(AccessByteWidth & ~0xFF)) {


> +		    ObjDesc->CommonField.AccessByteWidth = AccessByteWidth;
> +                }
>  	    }
>  	}
>  
> ---
> Lin Ming


