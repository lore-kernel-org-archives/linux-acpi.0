From: Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: RE: Overriding tables ... (was: Compaq 1720US, 2.4.18, acp
	i-7,24 - Help)
Date: 14 Aug 2002 02:22:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1029284532.1370.3.camel@U414>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: hrhawk-JGs/UdohzUI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grr.. exims playing up again! But just in case this does get double posted,
there is a correction anyway...

The code snippet should obviously have   ,sizeof(*new_table->signature)   rather
than sizeof(new_table->signature). Pointers never were my strong poing.

READ ON!


On Tue, 2002-08-13 at 23:41, Moore, Robert wrote:
> 
> The description of acpi_tb_table_override is "Attempts override of current
> table with a new one if provided by the host OS" in the current ACPI
> release.
> 
> Tb_table_override calls Os_table_override which in turn must examine the
> table header (esp. the signature) and decide whether to override or not.
> 
> The recent issue seems to be that tbget now calls tb_table_override for all
> tables, not just the DSDT.  Therefore, os_table_override must now check the
> table signature.

I concur entirely, this was the point of the code snippet, a suggestion
of how the checking could be achieved.

IMHO the problem could have been entirely avoided if the functions in
osl.c were documented, both as to what they are intended to do and
probably also a note where this is yet to be fully implimented. Had the
desctiption of acpi_os_table_override been in osl.c where the function
resided instead of tbget.c, it would have been clear that the function
was designed to check the validity of the replacement table and nobody
would have suggested patches to replace the DSDT go there.

I am happy to read through the code and try to document what has been
implimented if required, but I think it would be better achieved by
someone with a better understanding not only of what is implimented, but
also the intended functionality. 

If this documentation is done now, I think the advancement of the acpi
code will be much hastened, since people like myself with a little bit
of spare time over the holidays could contribute by reading over parts
of the code to find bugs, rather than having to spend hours trying to
get familiar with ever aspect of the acpi code, in order to understand
what is/should be/might be supposed to me happening in each function. 

This is, of course just my 2c worth and my intention is not at all to
offend anyone who has contributed to what is now, for most people,
fairly usable and stable code.

On a related subject, I think the 2 lines to do the checking in function
os_table_override in osl.c should read:

if(strncmp(existing_table->signature,*new_table->signature,sizeof(*new_table->signature)-1)
          *new_table = NULL ;

since the size of the signature presumably does not always have to be
the size of XSDT_SIG as I had previously suggested.



> 
> 
> -----Original Message-----
> From: Huw Hawkins [mailto:hrhawk-JGs/UdohzUI@public.gmane.org] 
> Sent: Tuesday, August 13, 2002 2:23 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Overriding tables ... (was: Compaq 1720US, 2.4.18, acpi-7,24
> - Help)
> 
> This was the point of my earlier post (Patching tables osl.c doesn't
> work as advertised ... ).
> 
>  As far as I can see, the propper place for putting patches to override
> tables would be in tbget.c since appears to be a function
> (acpi_tb_table_override) written with hooks for exactly this purpose. 
> 
> ___HOWEVER___
>  this function will not work, since the function
> acpi_os_table_override(&old_table, &new_table) in fact is not written to
> do what the documentation in tbget.c suggests. To make this happen I
> would suggest something along these lines.
> 
> ------------------------------------------------------------------------
> 
> /* ********************************************************************
>  *
>  * FUNCTION:	acpi_os_table_override
>  *
>  * PARAMETERS:   existing_table	- Pointer to the existing table header
>  * 		 new_table 	- pointer to pointer to new table header
>  *
>  * RETURN :	 AE_OK       (or possibly at a later date error codes?)
>  *
>  * DESCRIPTION : will examine the header and decide whether to override
>  *		 a table with a new table.  Returning either a pointer
>  *		 to the new table if it is a valid substitution or NULL 
>  *		 otherwise
>  * ********************************************************************/
> 
> acpi_status
> acpi_os_table_override (acpi_table_header *existing_table,
> acpi_table_header **new_table)
> {
> 	if (!existing_table || !new_table)
> 		return AE_BAD_PARAMETER;
> 
> 	
> if(strncmp(existing_table->signature,*new_table->signature,sizeof(XSDT_SIG)-
> 1)
>          *new_table = NULL ;
> 
> 	return AE_OK;
> }
> 
> 
> -------------------------------------------------------------------------
> 
> 
>  On a related note, the whole of the osl.c file needs documentation, to
> aid further efforts at development.
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=31
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
