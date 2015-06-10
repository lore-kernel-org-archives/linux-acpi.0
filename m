From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/1 linux-next] ACPICA: use swap() in acpi_ns_sort_list()
Date: Wed, 10 Jun 2015 16:48:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F327A@ORSMSX112.amr.corp.intel.com>
References: <1433953975-24445-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38705 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965430AbbFJQsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 12:48:30 -0400
In-Reply-To: <1433953975-24445-1-git-send-email-fabf@skynet.be>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

I don't think this is portable across operating systems. Which is a requirement for ACPICA.



> -----Original Message-----
> From: Fabian Frederick [mailto:fabf@skynet.be]
> Sent: Wednesday, June 10, 2015 9:33 AM
> To: linux-kernel@vger.kernel.org
> Cc: Julia Lawall; Fabian Frederick; Moore, Robert; Zheng, Lv; Wysocki,
> Rafael J; Len Brown; linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: [PATCH 1/1 linux-next] ACPICA: use swap() in acpi_ns_sort_list()
> 
> Use kernel.h macro definition.
> 
> Thanks to Julia Lawall for Coccinelle scripting support.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/nsrepair2.c
> b/drivers/acpi/acpica/nsrepair2.c index c30672d..7513799 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -904,7 +904,6 @@ acpi_ns_sort_list(union acpi_operand_object
> **elements,  {
>  	union acpi_operand_object *obj_desc1;
>  	union acpi_operand_object *obj_desc2;
> -	union acpi_operand_object *temp_obj;
>  	u32 i;
>  	u32 j;
> 
> @@ -920,11 +919,8 @@ acpi_ns_sort_list(union acpi_operand_object
> **elements,
>  			      obj_desc2->integer.value))
>  			    || ((sort_direction == ACPI_SORT_DESCENDING)
>  				&& (obj_desc1->integer.value <
> -				    obj_desc2->integer.value))) {
> -				temp_obj = elements[j - 1];
> -				elements[j - 1] = elements[j];
> -				elements[j] = temp_obj;
> -			}
> +				    obj_desc2->integer.value)))
> +				swap(elements[j - 1], elements[j]);
>  		}
>  	}
>  }
> --
> 2.4.2

