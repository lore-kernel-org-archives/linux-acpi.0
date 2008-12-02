From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND] [PATCH 4/6] ACPI: make inactive table management
 configurable
Date: Mon, 01 Dec 2008 21:53:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812012152000.339@localhost.localdomain>
References: <1226478547.15014.174.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:33884 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYLBCyL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 21:54:11 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB800BE1APX66J5@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Dec 2008 20:53:58 -0600 (CST)
In-reply-to: <1226478547.15014.174.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Zhang-Rui,
Please tell me how the kernel size grows w/ this new code added.
If it isn't cheap enough to enable all the time, then we
probably have to re-consider if it is a good idea to
implement it vs its benefit.

Of course, being a developer who has to ask peole
to manually dump tables, it is worth a lot to me,
but may not be worth the memory to every system
on the planet that uses ACPI.

-- 
-Len Brown
Intel Open Source Technology Center

On Wed, 12 Nov 2008, Zhang Rui wrote:

> Introduce flag ACPI_INACTIVE_TABLE_MANAGEMENT,
> which is used to disable/enable the inactive
> table management.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/tables/tbutils.c |    3 ++-
>  drivers/acpi/tables/tbxface.c |   18 +++++++++++++++++-
>  include/acpi/acconfig.h       |    4 ++++
>  include/acpi/acglobal.h       |    2 ++
>  4 files changed, 25 insertions(+), 2 deletions(-)
> 
> Index: linux-acpi-2.6/drivers/acpi/tables/tbutils.c
> ===================================================================
> --- linux-acpi-2.6.orig/drivers/acpi/tables/tbutils.c
> +++ linux-acpi-2.6/drivers/acpi/tables/tbutils.c
> @@ -452,11 +452,12 @@ acpi_tb_parse_root_table(acpi_physical_a
>  					"using RSDT"));
>  		}
>  	}
> +#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
>  	acpi_inactive_tables_root_pointer =
>  		(address == rsdt_address ? xsdt_address : rsdt_address);
>  	acpi_inactive_tables_entry_size =
>  		(table_entry_size == sizeof(u32) ? sizeof(u64) : sizeof(u32));
> -
> +#endif
>  	/* Map the RSDT/XSDT table header to get the full table length */
>  
>  	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
> Index: linux-acpi-2.6/drivers/acpi/tables/tbxface.c
> ===================================================================
> --- linux-acpi-2.6.orig/drivers/acpi/tables/tbxface.c
> +++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c
> @@ -165,6 +165,7 @@ acpi_initialize_tables(struct acpi_table
>   * 		and install them to the global inactive table list.
>   *
>   ******************************************************************************/
> +#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
>  acpi_status __init
>  acpi_initialize_inactive_tables(void)
>  {
> @@ -284,6 +285,13 @@ acpi_initialize_inactive_tables(void)
>  
>  	return_ACPI_STATUS(status);
>  }
> +#else
> +acpi_status __init
> +acpi_initialize_inactive_tables(void)
> +{
> +	return AE_OK;
> +}
> +#endif
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_reallocate_root_table
> @@ -617,6 +625,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_ind
>   * DESCRIPTION: Obtain a table by an index into the global inactive table list.
>   *
>   ******************************************************************************/
> +#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
>  acpi_status
>  acpi_get_inactive_table_by_index(u32 table_index,
>  				 struct acpi_table_header **table)
> @@ -652,7 +661,14 @@ acpi_get_inactive_table_by_index(u32 tab
>  	*table = acpi_gbl_inactive_root_table_list.tables[table_index].pointer;
>  	return_ACPI_STATUS(AE_OK);
>  }
> -
> +#else
> +acpi_status
> +acpi_get_inactive_table_by_index(u32 table_index,
> +					struct acpi_table_header **table)
> +{
> +	return AE_NOT_FOUND;
> +}
> +#endif
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_tb_load_namespace
> Index: linux-acpi-2.6/include/acpi/acconfig.h
> ===================================================================
> --- linux-acpi-2.6.orig/include/acpi/acconfig.h
> +++ linux-acpi-2.6/include/acpi/acconfig.h
> @@ -119,6 +119,10 @@
>  
>  #define ACPI_ROOT_TABLE_SIZE_INCREMENT  4
>  
> +/* Support ACPI inactive table management */
> +
> +#define ACPI_INACTIVE_TABLE_MANAGEMENT
> +
>  /******************************************************************************
>   *
>   * ACPI Specification constants (Do not change unless the specification changes)
> Index: linux-acpi-2.6/include/acpi/acglobal.h
> ===================================================================
> --- linux-acpi-2.6.orig/include/acpi/acglobal.h
> +++ linux-acpi-2.6/include/acpi/acglobal.h
> @@ -139,9 +139,11 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
>   * acpi_gbl_FADT is a local copy of the FADT, converted to a common format.
>   */
>  ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
> +#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
>  ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_inactive_root_table_list;
>  ACPI_EXTERN acpi_physical_address acpi_inactive_tables_root_pointer;
>  ACPI_EXTERN u32 acpi_inactive_tables_entry_size;
> +#endif
>  ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
>  extern u8 acpi_gbl_permanent_mmap;
>  
> 
> 
