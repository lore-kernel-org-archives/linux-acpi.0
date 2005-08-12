From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI: don't complain about PCI root bridges without
 _SEG
Date: Fri, 12 Aug 2005 01:11:33 -0400
Message-ID: <1123823493.6574.15.camel@toshiba>
References: <200507271632.17447.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507271632.17447.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

applied to-akpm

thanks,
-Len

On Wed, 2005-07-27 at 18:32 -0400, Bjorn Helgaas wrote:
> There are lots of single-PCI-segment machines that don't supply _SEG
> for the root bridges.  The PCI root bridge driver silently assumes
> the segment to be zero in this case, so glue.c shouldn't complain
> either.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> Index: work/drivers/acpi/glue.c
> ===================================================================
> --- work.orig/drivers/acpi/glue.c       2005-07-25 15:04:22.000000000
> -0600
> +++ work/drivers/acpi/glue.c    2005-07-26 15:25:26.000000000 -0600
> @@ -168,9 +168,6 @@
>         status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
> &seg);
>         if (status == AE_NOT_FOUND) {
>                 /* Assume seg = 0 */
> -               printk(KERN_INFO PREFIX
> -                      "Assume root bridge [%s] segment is 0\n",
> -                      (char *)buffer.pointer);
>                 status = AE_OK;
>                 seg = 0;
>         }
> 
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
