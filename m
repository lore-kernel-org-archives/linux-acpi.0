From: Hrvoje Habjanic <hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
Subject: Re: Re: HP xw6000 acpi problem
Date: Wed, 18 Jun 2003 11:53:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306181153.33680.hrvoje.habjanic@zg.hinet.hr>
References: <F760B14C9561B941B89469F59BA3A847E96F8B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F8B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello!

I've made partial success. In drivers/acpi/namespace/nsload.c ...
Consider the situation where one of SSDT tables HAS ERRORS. "acpi_ns_load_table" will return error.
BUT what about the rest of SSD tables? THEY DON'T GET LOADED/PARSED!?!?!?

  case ACPI_TABLE_SSDT:

    ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "Loading %d SSDTs\n",
      acpi_gbl_table_lists[ACPI_TABLE_SSDT].count));

    /*
     * Traverse list of SSDT tables
     */
    table_desc = acpi_gbl_table_lists[ACPI_TABLE_SSDT].next;
    for (i = 0; i<acpi_gbl_table_lists[ACPI_TABLE_SSDT].count; i++) {
      /*
       * Only attempt to load table if it is not
       * already loaded!
       */
      if (!table_desc->loaded_into_namespace) {
        status = acpi_ns_load_table (table_desc, acpi_gbl_root_node);
        if (ACPI_FAILURE (status)) {
           break;				<<<====== i think this may be a error.   =======
        }

        table_desc->loaded_into_namespace = TRUE;
      }

      table_desc = table_desc->next;
    }

    break;

If I modify thi block to:

  case ACPI_TABLE_SSDT:

    ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "Loading %d SSDTs\n",
      acpi_gbl_table_lists[ACPI_TABLE_SSDT].count));

    /*
     * Traverse list of SSDT tables
     */
    table_desc = acpi_gbl_table_lists[ACPI_TABLE_SSDT].next;
    for (i = 0; i<acpi_gbl_table_lists[ACPI_TABLE_SSDT].count; i++) {
      /*
       * Only attempt to load table if it is not
       * already loaded!
       */
      if (!table_desc->loaded_into_namespace) {
        status = acpi_ns_load_table (table_desc, acpi_gbl_root_node);
        if (ACPI_FAILURE (status)) {
          ACPI_DEBUG_PRINT ((ACPI_DB_INIT,"Error -> skipping to next"));
          /* break; */
        }
        else
          table_desc->loaded_into_namespace = TRUE;
      }

      table_desc = table_desc->next;
    }

    break;

Then my computer boots, and it seems to be working.

BUT, i'm not sure what i have done by modifying this ... Is this "the right way" to force parsing of ALL
SSDT tables, EVEN some of them have errors???

Please see:

http://free-zg.htnet.hr/HrvojeHabjanic/acpi


Hrvoje






On Tuesday 17 June 2003 21:16, Grover, Andrew wrote:
> Hi,
>
> ACPI should be printing a version string in the kernel boot messages.
> What is it for rc1 and rc2 respectively?
>
> Thanks -- Regards -- Andy
>
> > -----Original Message-----
> > From: Hrvoje Habjanic [mailto:hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org]
> > Sent: Tuesday, June 17, 2003 12:07 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] Re: HP xw6000 acpi problem
> >
> >
> >
> > Hi again ...
> >
> > OK, small update:
> >
> > acpi - rc1 is WORKING
> > but rc2 IS NOT!
> >
> > Maybe this helps ....
> >
> > Any clues yet?
> >
> > Hrvoje
> >
> > p.s. Previous post
> > http://sourceforge.net/mailarchive/forum.php?thread_id=2599281
>
> &forum_id=6102
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
