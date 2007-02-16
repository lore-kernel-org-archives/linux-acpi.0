From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] -  acpi_unload_table_id() always returns error
Date: Thu, 15 Feb 2007 23:29:55 -0500
Message-ID: <200702152329.55535.lenb@kernel.org>
References: <20070215200830.1822.98901.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39761 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423150AbXBPEbP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Feb 2007 23:31:15 -0500
In-Reply-To: <20070215200830.1822.98901.sendpatchset@attica.americas.sgi.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-acpi@vger.kernel.org, ayoung@sgi.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for the fix, John.
Do you grant Intel permission to apply it to the upstream ACPICA tree (with its non-GPL license)?

-Len

On Thursday 15 February 2007 15:08, John Keller wrote:
> acpi_unload_table_id() is always returning an error status.
> Also, once the matching table is found, don't bother looking
> for another match.
> 
> 
> Signed-off-by: John Keller <jpk@sgi.com>
> ---
> 
> 
> Index: release/drivers/acpi/tables/tbxface.c
> ===================================================================
> --- release.orig/drivers/acpi/tables/tbxface.c	2007-02-13 08:20:42.000000000 -0600
> +++ release/drivers/acpi/tables/tbxface.c	2007-02-15 14:04:07.855248010 -0600
> @@ -338,9 +338,9 @@ acpi_status acpi_unload_table_id(acpi_ow
>  	int i;
>  	acpi_status status = AE_NOT_EXIST;
>  
> -	ACPI_FUNCTION_TRACE(acpi_unload_table);
> +	ACPI_FUNCTION_TRACE(acpi_unload_table_id);
>  
> -	/* Find table from the requested type list */
> +	/* Find table in the global table list */
>  	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
>  		if (id != acpi_gbl_root_table_list.tables[i].owner_id) {
>  			continue;
> @@ -352,8 +352,9 @@ acpi_status acpi_unload_table_id(acpi_ow
>  		* simply a position within the hierarchy
>  		*/
>  		acpi_tb_delete_namespace_by_owner(i);
> -		acpi_tb_release_owner_id(i);
> +		status = acpi_tb_release_owner_id(i);
>  		acpi_tb_set_table_loaded_flag(i, FALSE);
> +		break;
>  	}
>  	return_ACPI_STATUS(status);
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
