From: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] `unaligned access' in acpi get_root_bridge_busnr()
Date: Thu, 20 Oct 2005 13:27:27 +0200
Message-ID: <43577F1F.3070209@gmail.com>
References: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <17239.4347.595396.783239-t0Sv2hkTHA9yuP2ZY8HSTlptZk9uqtcn@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter Chubb <peterc-M3ycANVxPotyL3EAZA59ERCuuivNXqWP@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Peter Chubb napsal(a):

>In drivers/acpi/glue.c the address of an integer is cast to the
>address of an unsigned long.  This breaks on systems where a long is
>larger than an int --- for a start the int can be misaligned; for a
>second the assignment through the pointer will overwrite part of the
>next variable.
>
>Patch is against linux-2.6.14-rc4
>
>Signed-off-by: Peter Chubb <peterc-M3ycANVxPotyL3EAZA59ERCuuivNXqWP@public.gmane.org>
>
>Index: linux-2.6-import/drivers/acpi/glue.c
>===================================================================
>--- linux-2.6-import.orig/drivers/acpi/glue.c	2005-09-09 09:08:49.928854100 +1000
>+++ linux-2.6-import/drivers/acpi/glue.c	2005-10-20 13:32:32.126445742 +1000
>@@ -89,46 +89,46 @@ static int acpi_find_bridge_device(struc
> /* Get PCI root bridge's handle from its segment and bus number */
> struct acpi_find_pci_root {
> 	unsigned int seg;
> 	unsigned int bus;
> 	acpi_handle handle;
> };
> 
> static acpi_status
> do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
> {
>-	int *busnr = (int *)data;
>+	unsigned long *busnr = (unsigned long *)data;
>  
>
Is the cast here really needed?

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
