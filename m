From: "Huw H" <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: Patching tables osl.c doesn't work as advertised ... (was 2.4.19 & latest acpi & patched dsdt (tosh3k))
Date: Sun, 11 Aug 2002 07:11:13 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17dj8L-000JDo-00@f11.mail.ru>
Reply-To: "Huw H" <hrhawk-JGs/UdohzUI@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
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

Heya all again,
   I've found the cause of my troubles!

   In the file linux/drivers/acpi/osl.c the function acpi_os_table_override()
isn't properly implimented. The patch on ftp.poupinou.org needs to check which
table is being overriden, otherwise all tables get replaced... Maybe it should
be something like:

-------------------------------

acpi_status
acpi_os_table_override (acpi_table_header *existing_table,
                          acpi_table_header **new_table)
{
        if (!existing_table || !new_table)
                return AE_BAD_PARAMETER;

        *new_table = (ACPI_TBLPTR *) AmlCode;

        if (ACPI_STRNCMP ((char *) existing_table,
                          (char *) *new_table, sizeof (XSDT_SIG) -1))
                {
                        *new_table = NULL;
                };

        return AE_OK;
}

------------------------

Ideally though I think the override belongs in
linux/drivers/acpi/tables/tbget.c and the acpi_os_table_override() function
should just return the AE_OK if the signatures match, or set the new table
pointer to NULL otherwise and/or return the appropriate errwor code. This is I
believe the expected behaviour of this function.



Bruno, your patched dsdt works brilliantly so far. THANKS!!


Huw



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
