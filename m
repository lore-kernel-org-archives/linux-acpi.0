From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [2.6 patch] kill acpi_ksyms.c
Date: 11 Nov 2004 23:56:55 -0500
Message-ID: <1100235412.5519.922.camel@d845pe>
References: <20041105215021.GF1295@stusta.de>
	 <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de>
	 <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
	 <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
	 <20041109014021.GB15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041109014021.GB15077-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Mon, 2004-11-08 at 20:40, Adrian Bunk wrote:
...
> Below is as a preparation a patch that removes acpi_ksyms.c .
> 
> It shouldn't make any practical difference.
> 
> The function acpi_db_user_commands that wasn't available in the whole
> kernel sources was EXPORT_SYMBOL'ed. The patch removes this bogus
> export.
> 
> 
> diffstat output:
>  drivers/acpi/Makefile             |    2
>  drivers/acpi/acpi_ksyms.c         |  165
> ------------------------------
>  drivers/acpi/bus.c                |   10 +
>  drivers/acpi/ec.c                 |    2
>  drivers/acpi/events/evxface.c     |   10 +
>  drivers/acpi/events/evxfevnt.c    |    8 +
>  drivers/acpi/events/evxfregn.c    |    4
>  drivers/acpi/hardware/hwregs.c    |    4
>  drivers/acpi/hardware/hwsleep.c   |    4
>  drivers/acpi/hardware/hwtimer.c   |    5
>  drivers/acpi/namespace/nsxfeval.c |    4
>  drivers/acpi/namespace/nsxfname.c |    4
>  drivers/acpi/namespace/nsxfobj.c  |    5
>  drivers/acpi/osl.c                |   18 +++
>  drivers/acpi/pci_irq.c            |    2
>  drivers/acpi/pci_root.c           |    2
>  drivers/acpi/resources/rsxface.c  |    7 +
>  drivers/acpi/scan.c               |    6 -
>  drivers/acpi/tables/tbconvrt.c    |    2
>  drivers/acpi/tables/tbxface.c     |    3
>  drivers/acpi/tables/tbxfroot.c    |    2
>  drivers/acpi/utilities/utdebug.c  |    7 +
>  drivers/acpi/utilities/utglobal.c |    4
>  drivers/acpi/utilities/utxface.c  |    2
>  drivers/acpi/utils.c              |    4
>  include/acpi/acdebug.h            |    5
>  26 files changed, 112 insertions(+), 179 deletions(-)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
