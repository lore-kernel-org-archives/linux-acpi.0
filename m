From: Scott Duplichan <sduplichan-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Compaq Evo 510SFF and ACPI
Date: Fri, 4 Jul 2003 04:57:41 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030704115741.84107.qmail@web13005.mail.yahoo.com>
References: <87of0app5v.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87of0app5v.fsf-E1YXmAG8v4VQD7NkSvH8p9BPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--- Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org> wrote:
> Scott Duplichan <sduplichan-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> writes:
> 
> > Alexander Hoogerhuis <alexh-KJKxBnNiUAU@public.gmane.org> wrote:
> > 
> > >I have a few Compaq Evo's that show the same symptom:
> > > 
> > > ACPI: Searched entire block, no RSDP was found.
> > > ACPI: RSDP located at physical address c00eaa10
> > > RSD PTR  v0 [COMPAQ]
> > > __va_range(0xf7f7b40, 0x68): idx=10 mapped at ffff5000
> > > ACPI table found: RSDT v1 [COMPAQ CPQ0050  8194.4656]
> > > ACPI: Too big length in RSDT: 120
> > 
> > 120 bytes minus 36 bytes leaves 84 bytes, or 21 table pointers.
> > I think some versions of Linux have a limit on the number of
> > tables that is smaller than 21. The ACPI spec lacks, among other
> > things, any guideline on what the maximum number of tables is.
> > 
> 
> Here's the offending piece of code:
> 
>         /*
>          * The number of tables is computed by taking the
>          * size of all entries (header size minus total
>          * size of RSDT) divided by the size of each entry
>          * (4-byte table pointers).
>          */
>         tables = (header->length - sizeof(acpi_table_header)) / 4;
>                                                                                 
>         memcpy(&saved_rsdt, rsdt, sizeof(saved_rsdt));
>                                                                                 
>         if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
>                 printk(KERN_WARNING "ACPI: Too big length in RSDT: %d\n",
> saved_rsdt.header.length);
>                 return -ENODEV;
>         }
> 
> ...which then basically says what it found doesnt add up to what it
> thinks it has?
> 
> mvh,
> A
> -- 
> Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
> CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
> "You have zero privacy anyway. Get over it."  --Scott McNealy

I believe the problem is that 'saved_rsdt' is smaller than the EVO rsdt.
If I am looking at the correct source code, the maximum number of
tables supported is ACPI_TABLE_COUNT, which is 17. That number is
based on the assumption that there is at most one table of each type.
But that assumption is not valid for the EVO 510, because it has many
SSDT tables, for a total of 21 tables.

-- 
Scott


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
