From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [buggy index field handling] [patch]
Date: Mon, 22 Sep 2003 20:02:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030922180220.GQ11391@poupinou.org>
References: <20030922171847.GN11391@poupinou.org> <20030922173615.GP11391@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030922173615.GP11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>, Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 22, 2003 at 07:36:15PM +0200, Ducrot Bruno wrote:
> On Mon, Sep 22, 2003 at 07:18:47PM +0200, Ducrot Bruno wrote:
> > Hi Andy,
> > 
> > There is a funny bug in acpi/executer/exfldio.c::acpi_ex_field_datum_io
> > 
> > When the field come from an indexed one, we read all the time from the
> > address obj_desc->index_field.value
> > Unfortunately, this is wrong, since the correct address is
> > obviously &obj_desc->index_field.value + field_datum_byte_offset
> 
> Ok, that one should be OK, now.  My apologize for the first one.
> 


Definitely, I need to go to sleep..  Take the one from Robert Vollmert
and that should be OK.

> 
> --- linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/22 17:09:20	1.1
> +++ linux-2.6.0-test5/drivers/acpi/executer/exfldio.c	2003/09/22 17:31:55
> @@ -413,6 +413,8 @@
>  
>  
>  	case ACPI_TYPE_LOCAL_INDEX_FIELD:
> +		{
> +		u32 old_addr = 0;
>  
>  
>  		/* Ensure that the index_value is not beyond the capacity of the register */
> @@ -424,9 +426,12 @@
>  
>  		/* Write the index value to the index_register (itself a region_field) */
>  
> +		old_addr = obj_desc->index_field.value;
> +		obj_desc->index_field.value += field_datum_byte_offset;
>  		status = acpi_ex_insert_into_field (obj_desc->index_field.index_obj,
> -				 &obj_desc->index_field.value,
> +				 &obj_desc->index_field.value + field_datum_byte_offset,
                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^
							      WEIRD!
>  				 sizeof (obj_desc->index_field.value));
> +		obj_desc->index_field.value = old_address;
>  		if (ACPI_FAILURE (status)) {
>  			return_ACPI_STATUS (status);
>  		}
> @@ -443,6 +448,7 @@
>  			status = acpi_ex_insert_into_field (obj_desc->index_field.data_obj,
>  					  value, obj_desc->common_field.access_byte_width);
>  		}
> +		}
>  		break;
>  
>  

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
