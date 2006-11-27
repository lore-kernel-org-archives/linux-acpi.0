From: John Keller <jpk@sgi.com>
Subject: Re: [PATCH 3/3] - Add support for acpi_load_table/acpi_unload_table_id
Date: Mon, 27 Nov 2006 09:19:00 -0600 (CST)
Message-ID: <200611271519.kARFJ00S242531@fcbayern.americas.sgi.com>
References: <200611151124.27678.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:47076 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1754456AbWK0PTc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 10:19:32 -0500
In-Reply-To: <200611151124.27678.len.brown@intel.com> from "Len Brown" at Nov 15, 2006 11:24:27 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ayoung@sgi.com

Len,
 Can you tell us what we need to do to make this happen?
Is it just a matter of some legal text in the patch header?
Or??

Thanks
John


> 
> On Wednesday 15 November 2006 10:27, John Keller wrote:
> >  This patch makes acpi_load_table() available
> >  for use by removing it from the #ifdef ACPI_FUTURE_USAGE.
> > 
> >  It also adds a new routine used to unload an ACPI table
> >  of a given type and "id" - acpi_unload_table_id().
> >  The implementation of this new routine was almost a direct
> >  copy of existing routine acpi_unload_table() - only difference
> >  being that it only removes a specific table id instead of
> >  ALL tables of a given type.
> >  The SN hotplug driver (sgi_hotplug.c) now uses both of these
> >  interfaces to dynamically load and unload SSDT ACPI tables.
> > 
> >  Also, a few other ACPI routines now used by the SN hotplug
> >  driver are exported (since the driver can be a loadable module):
> > 
> >  acpi_ns_map_handle_to_node
> >  acpi_ns_convert_entry_to_handle
> >  acpi_ns_get_next_node
> > 
> > Signed-off-by: Aaron Young <ayoung@sgi.com>
> > 
> > ---
> > 
> >  drivers/acpi/namespace/nsutils.c |    4 ++
> >  drivers/acpi/namespace/nswalk.c  |    2 +
> >  drivers/acpi/tables/tbxface.c    |   47 ++++++++++++++++++++++++++++-
> >  include/acpi/acpixf.h            |    5 +--
> >  4 files changed, 55 insertions(+), 3 deletions(-)
> 
> John, Aaron,
> acpi/namespace/* files come to Linux from ACPICA.
> It is much easier for everybody if ACPICA changes make it in  "upstream"
> so that Linux doesn't diverge from the reference implementation.
> 
> If you grant Intel the license to distribute (a derivation) of your changes
> under BOTH the GPL and BSD licenses appearing at the top of these files,
> then we can do that.  Basically what this means is that other operating
> systems besides Linux will benefit from your changes too --
> some of them are open source (eg. FreeBSD) and some are not (eg. HPUX).
> 
> Please let me know.
> 
> thanks,
> -Len
> 
> > 
> > Index: linux-2.6/drivers/acpi/namespace/nsutils.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/namespace/nsutils.c	2006-10-23 08:48:15.836279420 -0500
> > +++ linux-2.6/drivers/acpi/namespace/nsutils.c	2006-10-23 09:17:33.930473274 -0500
> > @@ -701,6 +701,8 @@ struct acpi_namespace_node *acpi_ns_map_
> >  	return (ACPI_CAST_PTR(struct acpi_namespace_node, handle));
> >  }
> >  
> > +ACPI_EXPORT_SYMBOL(acpi_ns_map_handle_to_node)
> > +
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_ns_convert_entry_to_handle
> > @@ -737,6 +739,8 @@ acpi_handle acpi_ns_convert_entry_to_han
> >  ------------------------------------------------------*/
> >  }
> >  
> > +ACPI_EXPORT_SYMBOL(acpi_ns_convert_entry_to_handle)
> > +
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_ns_terminate
> > Index: linux-2.6/drivers/acpi/namespace/nswalk.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/namespace/nswalk.c	2006-10-23 08:48:15.836279420 -0500
> > +++ linux-2.6/drivers/acpi/namespace/nswalk.c	2006-10-23 09:17:33.930473274 -0500
> > @@ -119,6 +119,8 @@ struct acpi_namespace_node *acpi_ns_get_
> >  	return (NULL);
> >  }
> >  
> > +ACPI_EXPORT_SYMBOL(acpi_ns_get_next_node)
> > +
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_ns_walk_namespace
> > Index: linux-2.6/drivers/acpi/tables/tbxface.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/tables/tbxface.c	2006-10-23 08:48:15.856281906 -0500
> > +++ linux-2.6/drivers/acpi/tables/tbxface.c	2006-10-23 09:17:33.934473770 -0500
> > @@ -123,7 +123,6 @@ acpi_status acpi_load_tables(void)
> >  
> >  ACPI_EXPORT_SYMBOL(acpi_load_tables)
> >  
> > -#ifdef ACPI_FUTURE_USAGE
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_load_table
> > @@ -221,6 +220,52 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
> >  
> >  /*******************************************************************************
> >   *
> > + * FUNCTION:    acpi_unload_table_id
> > + *
> > + * PARAMETERS:  table_type    - Type of table to be unloaded
> > + *              id            - Owner ID of the table to be removed.
> > + *
> > + * RETURN:      Status
> > + *
> > + * DESCRIPTION: This routine is used to force the unload of a table (by id)
> > + *
> > + ******************************************************************************/
> > +acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id)
> > +{
> > +	struct acpi_table_desc *table_desc;
> > +
> > +	ACPI_FUNCTION_TRACE(acpi_unload_table);
> > +
> > +	/* Parameter validation */
> > +	if (table_type > ACPI_TABLE_ID_MAX)
> > +		return_ACPI_STATUS(AE_BAD_PARAMETER);
> > +
> > +	/* Find table from the requested type list */
> > +	table_desc = acpi_gbl_table_lists[table_type].next;
> > +	while (table_desc && table_desc->owner_id != id)
> > +		table_desc = table_desc->next;
> > +
> > +	if (!table_desc)
> > +		return_ACPI_STATUS(AE_NOT_EXIST);
> > +
> > +	/*
> > +	 * Delete all namespace objects owned by this table. Note that these
> > +	 * objects can appear anywhere in the namespace by virtue of the AML
> > +	 * "Scope" operator. Thus, we need to track ownership by an ID, not
> > +	 * simply a position within the hierarchy
> > +	 */
> > +	acpi_ns_delete_namespace_by_owner(table_desc->owner_id);
> > +
> > +	(void)acpi_tb_uninstall_table(table_desc);
> > +
> > +	return_ACPI_STATUS(AE_OK);
> > +}
> > +
> > +ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
> > +
> > +#ifdef ACPI_FUTURE_USAGE
> > +/*******************************************************************************
> > + *
> >   * FUNCTION:    acpi_unload_table
> >   *
> >   * PARAMETERS:  table_type    - Type of table to be unloaded
> > Index: linux-2.6/include/acpi/acpixf.h
> > ===================================================================
> > --- linux-2.6.orig/include/acpi/acpixf.h	2006-10-23 08:48:18.364593597 -0500
> > +++ linux-2.6/include/acpi/acpixf.h	2006-10-23 09:17:33.934473770 -0500
> > @@ -97,11 +97,12 @@ acpi_find_root_pointer(u32 flags, struct
> >  
> >  acpi_status acpi_load_tables(void);
> >  
> > -#ifdef ACPI_FUTURE_USAGE
> >  acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
> >  
> > -acpi_status acpi_unload_table(acpi_table_type table_type);
> > +acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id);
> >  
> > +#ifdef ACPI_FUTURE_USAGE
> > +acpi_status acpi_unload_table(acpi_table_type table_type);
> >  acpi_status
> >  acpi_get_table_header(acpi_table_type table_type,
> >  		      u32 instance, struct acpi_table_header *out_table_header);
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 

