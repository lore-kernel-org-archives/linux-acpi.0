From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: pmtools - acpiexec
Date: Mon, 05 Sep 2005 19:45:56 +0200
Message-ID: <431C8454.5080408@suse.de>
References: <6694B22B6436BC43B429958787E454984CF9E2@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6694B22B6436BC43B429958787E454984CF9E2@mssmsx402nb>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Starikovskiy, Alexey Y wrote:
>  Hi,
> 
> Actually, acpiexec should work on Linux without any changes to source.
> Besides, last version is 20050902.
Very funny...,
http://developer.intel.com/technology/iapc/acpi/downloads.htm
still points to:
http://developer.intel.com/technology/iapc/acpi/downloads/acpica-unix-20050624.tar.gz

Is there another site to download latest changes?
An official read-only CVS (with mail notification on changes or similar) would really be appreciated.

      Thomas
> 
> Regards,
> 	Alex.
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas
> Renninger
> Sent: Monday, September 05, 2005 8:31 PM
> To: ML ACPI-devel
> Subject: [ACPI] pmtools - acpiexec
> 
> Hi,
> 
> I recently played with acpiexec to debug a DSDT.
> 
> This seems to be a very useful tool to debug/execute DSDTs outside the
> kernel?
> Is it supposed to work?
> 
> The first Hunk of this patch makes it compile/link again.
> 
> It came out that the AcpiGbl_RootNode was not allocated.
> I tried it with the second Hunk, but it seems as if this Node has
> to be created in some special way, as parsing of the DSDT segfaults
> when it tries to find the parent of the (global root?) node.
> 
> Thanks,
> 
>       Thomas
> ---------------------------------------------
> diff -ru tmp/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c
> /home/trenn/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c
> --- tmp/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c
> 2005-06-24 23:31:40.000000000 +0200
> +++ /home/trenn/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c
> 2005-09-05 01:41:23.000000000 +0200
> @@ -308,6 +308,8 @@
> 
>       /* Get the command line options */
> 
> +    AcpiUtInitGlobals ();
> +
>       while ((j = AcpiGetopt (argc, argv, "?b^dgio:svx:")) != EOF)
> switch(j)
>       {
>       case 'b':
> @@ -384,6 +386,9 @@
>           }
> 
>           AeBuildLocalTables (Table);
> +   if (AcpiGbl_RootNode == NULL)
> +       AcpiGbl_RootNode = AcpiNsCreateNode (0);
> +
>           Status = AeInstallTables ();
>           if (ACPI_FAILURE (Status))
>           {
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing &
> QA
> Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
