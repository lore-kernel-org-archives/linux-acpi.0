From: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: 21 Jan 2003 16:02:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043161338.1284.14.camel@gregers.imsb.au.dk>
References: <1043083690.1702.15.camel@localhost.localdomain>	<3E2C43D3.3020307@gmx.net>
	<3E2C70FB.1090905@gmx.net> <1043147191.1205.8.camel@gregers.imsb.au.dk>
	<3E2D372F.5040500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E2D372F.5040500-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Heiko

So far so good. This is what i have done:

I used the kernel linux-2.4.20 from kernel.org

Downloaded this patch from sourceforge: acpi-20021205-2.4.20.diff.gz

Applied the patch and afterwards your
patch:acpi_use_own_dsdt-2.4.20.diff (no errors ths time)

Copied acpi_dsdt.c to drivers/acpi/tables/

Compilled the kernel without any problems.

But when i boot the kernel it hangs with the same error as previous.
However i read at this site: http://repose.cx/n160/ that passing the
parameter "pci=noacpi" should solve the problem. It did. Well at least
the booting problem.

I do not know if the acpi is working correctly. When i enter the power
control setup in kde i get this message:

Your computer seems to have a partial ACPI installation
probably ACPI was enabled, but some of the sub-option
were not enabled - you need to enable at least 'AC Adaptor'
and 'Control Method Battery' and rebuild your kernel

I did enable both of these. What can i do next?

regards Christian





On Tue, 2003-01-21 at 13:03, Heiko Ettelbrueck wrote:
> Christian Brix Folsted Andersen wrote:
> > However i am having a bit of a problem applying your patch. The file
> > drivers/acpi/osl.c does not exist instead there is a file called os.c.
> > I looked at the file and tried to patch it manualy, but can not find the
> > position of the last part of the patch.
> > 
> > The first part was added at line 85 of os.c
> > 
> > static int acpi_irq_irq = 0;
> > static OSD_HANDLER acpi_irq_handler = NULL;
> > static void *acpi_irq_context = NULL;
> > 
> > extern unsigned char AmlCode[];
> > 
> > In which function is the last part supposed to go?
> > Which kernel did you use?
> 
> I use a vanilla kernel 2.4.20 with the ACPI patch 20021205. Did you use 
> another ACPI patch? Perhaps this part has changed...
> 
> The last part of the patch is for the function acpi_os_table_override:
> 
> <<original>>
> 
> acpi_status
> acpi_os_table_override (acpi_table_header *existing_table, 
> acpi_table_header **new_table)
> {
>          if (!existing_table || !new_table)
>                  return AE_BAD_PARAMETER;
> 
>          *new_table = NULL;
>          return AE_OK;
> }
> 
> <<patched>>
> 
> acpi_status
> acpi_os_table_override (acpi_table_header *existing_table, 
> acpi_table_header **new_table)
> {
>          if (!existing_table || !new_table)
>                  return AE_BAD_PARAMETER;
> 
>          *new_table = NULL;
>          if (strncmp(existing_table->signature, "DSDT", 4) == 0)
>                  *new_table = (acpi_table_header*)AmlCode;
>          else
>                  *new_table = NULL;
>          return AE_OK;
> }
> 
> I hope this will help. Please tell me whether you had success ;-)
> 
> Regards
> Heiko




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
