From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Overriding tables ... (was: Compaq 1720US, 2.4.18, acp
	i-7,24 - Help)
Date: Tue, 13 Aug 2002 14:41:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6DD@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: 'Huw Hawkins' <hrhawk-JGs/UdohzUI@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The description of acpi_tb_table_override is "Attempts override of current
table with a new one if provided by the host OS" in the current ACPI
release.

Tb_table_override calls Os_table_override which in turn must examine the
table header (esp. the signature) and decide whether to override or not.

The recent issue seems to be that tbget now calls tb_table_override for all
tables, not just the DSDT.  Therefore, os_table_override must now check the
table signature.

Bob



-----Original Message-----
From: Huw Hawkins [mailto:hrhawk-JGs/UdohzUI@public.gmane.org] 
Sent: Tuesday, August 13, 2002 2:23 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Overriding tables ... (was: Compaq 1720US, 2.4.18, acpi-7,24
- Help)

This was the point of my earlier post (Patching tables osl.c doesn't
work as advertised ... ).

 As far as I can see, the propper place for putting patches to override
tables would be in tbget.c since appears to be a function
(acpi_tb_table_override) written with hooks for exactly this purpose. 

___HOWEVER___
 this function will not work, since the function
acpi_os_table_override(&old_table, &new_table) in fact is not written to
do what the documentation in tbget.c suggests. To make this happen I
would suggest something along these lines.

------------------------------------------------------------------------

/* ********************************************************************
 *
 * FUNCTION:	acpi_os_table_override
 *
 * PARAMETERS:   existing_table	- Pointer to the existing table header
 * 		 new_table 	- pointer to pointer to new table header
 *
 * RETURN :	 AE_OK       (or possibly at a later date error codes?)
 *
 * DESCRIPTION : will examine the header and decide whether to override
 *		 a table with a new table.  Returning either a pointer
 *		 to the new table if it is a valid substitution or NULL 
 *		 otherwise
 * ********************************************************************/

acpi_status
acpi_os_table_override (acpi_table_header *existing_table,
acpi_table_header **new_table)
{
	if (!existing_table || !new_table)
		return AE_BAD_PARAMETER;

	
if(strncmp(existing_table->signature,*new_table->signature,sizeof(XSDT_SIG)-
1)
         *new_table = NULL ;

	return AE_OK;
}


-------------------------------------------------------------------------


 On a related note, the whole of the osl.c file needs documentation, to
aid further efforts at development.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
