From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi, add region addresses to conflict output [v2]
Date: Mon, 25 Nov 2013 23:55:24 +0100
Message-ID: <4789847.1fENKqDdQh@vostro.rjw.lan>
References: <1385403950-11297-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56665 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750709Ab3KYWmi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 17:42:38 -0500
In-Reply-To: <1385403950-11297-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Myron Stowe <mstowe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, mjg59@srcf.ucam.org, "Moore, Robert" <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Monday, November 25, 2013 01:25:50 PM Prarit Bhargava wrote:
> Currently the kernel does
> 
>  ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts
>  with Region \PMIO 1 (20130517/utaddress-251)
> 
> This patch outputs the region address so that we now see
> 
> ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts
> with Region 0x0000000000000400-0x000000000000047f \PMIO 1
> (20130927/utaddress-252)
> 
> which is a lot more useful for debugging.
> 
> Also fix some simple comment linewrapping issues in this function.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Myron Stowe <mstowe@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: mjg59@srcf.ucam.org
> 
> [v2]: minor change to comments

ACPICA patches should go to its upstream maintainers in the first place,
as per MAINTAINERS (CCed now).  Also ACPICA patches generally have to be
integrated into ACPICA upstream before appearing in the kernel.

Thanks!

> ---
>  drivers/acpi/acpica/utaddress.c |   53 +++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
> index e0a2e27..eb4f28d 100644
> --- a/drivers/acpi/acpica/utaddress.c
> +++ b/drivers/acpi/acpica/utaddress.c
> @@ -224,35 +224,40 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
>  
>  	while (range_info) {
>  		/*
> -		 * Check if the requested Address/Length overlaps this address_range.
> -		 * Four cases to consider:
> +		 * Check if the requested Address/Length overlaps this
> +		 * address_range.  Four cases to consider:
>  		 *
> -		 * 1) Input address/length is contained completely in the address range
> +		 * 1) Input address/length is contained completely in the
> +		 *    address range
>  		 * 2) Input address/length overlaps range at the range start
>  		 * 3) Input address/length overlaps range at the range end
>  		 * 4) Input address/length completely encompasses the range
>  		 */
> -		if ((address <= range_info->end_address) &&
> -		    (end_address >= range_info->start_address)) {
> -
> -			/* Found an address range overlap */
> -
> -			overlap_count++;
> -			if (warn) {	/* Optional warning message */
> -				pathname =
> -				    acpi_ns_get_external_pathname(range_info->
> -								  region_node);
> -
> -				ACPI_WARNING((AE_INFO,
> -					      "0x%p-0x%p %s conflicts with Region %s %d",
> -					      ACPI_CAST_PTR(void, address),
> -					      ACPI_CAST_PTR(void, end_address),
> -					      acpi_ut_get_region_name(space_id),
> -					      pathname, overlap_count));
> -				ACPI_FREE(pathname);
> -			}
> -		}
> -
> +		if ((address > range_info->end_address) &&
> +		    (end_address < range_info->start_address))
> +			goto next_range;
> +
> +		/* Found an address range overlap */
> +		overlap_count++;
> +
> +		if (!warn)
> +			goto next_range;
> +
> +		/* Optional warning message */
> +		pathname =
> +			 acpi_ns_get_external_pathname(range_info->region_node);
> +
> +		ACPI_WARNING((AE_INFO,
> +			      "0x%p-0x%p %s conflicts with Region 0x%p-0x%p %s %d",
> +			      ACPI_CAST_PTR(void, address),
> +			      ACPI_CAST_PTR(void, end_address),
> +			      acpi_ut_get_region_name(space_id),
> +			      ACPI_CAST_PTR(void, range_info->start_address),
> +			      ACPI_CAST_PTR(void, range_info->end_address),
> +			      pathname, overlap_count));
> +		ACPI_FREE(pathname);
> +
> +next_range:
>  		range_info = range_info->next;
>  	}
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
