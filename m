From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
Date: Thu, 11 Nov 2004 00:38:33 +0100
Message-ID: <20041110233833.GD1099@elf.ucw.cz>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099707007.13834.1969.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > The patch below completely removes 7 functions that were
> > EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes
> > another one that was previously EXPORT_SYMBOL'ed static.
> > 
> > It also removes another unused global function to completely remove
> > drivers/acpi/hardware/hwtimer.c which contained no function used
> > anywhere in the kernel.
> > 
> > Please comment on whether this patch is correct or whether in-kernel
> > users of these functions are pending.
> > 
> > 
> > diffstat output:
> >  drivers/acpi/acpi_ksyms.c        |    8 -
> >  drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
> >  drivers/acpi/hardware/Makefile   |    2
> >  drivers/acpi/hardware/hwtimer.c  |  200
> > -------------------------------
> >  drivers/acpi/resources/rsxface.c |   52 --------
> >  drivers/acpi/scan.c              |    6
> >  drivers/acpi/utilities/utxface.c |   89 -------------
> >  include/acpi/achware.h           |   17 --
> >  include/acpi/acpi_bus.h          |    1
> >  include/acpi/acpixf.h            |   24 ---
> >  10 files changed, 6 insertions(+), 584 deletions(-)
> 
> No, I can't apply this one as-is.
> Some of these routines are not called now
> simply because Linux/ACPI is evolving and we don't
> yet take advantage of some of the things supported
> by ACPICA core we use.

I believe right thing to do is remove them now, and re-add them later
(if they are ever needed).

Single line patch somewhere which happens to pull whole evxfevnt.c
would be pretty "expensive", but would not certainly look so...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
