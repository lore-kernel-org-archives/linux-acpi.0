From: Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: Overriding tables ... (was: Compaq 1720US, 2.4.18, acpi-7,24 - Help)
Date: 13 Aug 2002 23:23:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1029273798.1080.21.camel@U414>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

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

	if(strncmp(existing_table->signature,*new_table->signature,sizeof(XSDT_SIG)-1)
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
