From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 and S4 fix for 2.5.x XFS
Date: Wed, 19 Feb 2003 11:35:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030219103518.GF23503@atrey.karlin.mff.cuni.cz>
References: <20030219101418.GB15374@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030219101418.GB15374-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org, SATOH Fumiyasu <fumiya-xe/Jz1KxH3h3+QwDJ9on6Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Eric Sandeen <sandeen-sJ/iWh9BUns@public.gmane.org> wrote a fix for 2.5.x page_buf.c that is
> similar to that for 2.4.x and allows for pagebufd to enter refrigerator
> correctly. It seems to work fine for me (2.5.61), though I also suffer 
> from some mysterious XFS problems that need further inquiring.
> 
> Everyone using XFS and S3 or S4 is highly encouraged to test this patch on
> a 2.5.x kernel. The patch is below:

Patch looks good; submit it to trivial if it looks like it works...

									Pavel

> --- /usr/tmp/TmpDir.23920-0/linux/fs/xfs/pagebuf/page_buf.c_1.94        Tue Feb 18 20:43:38 2003
> +++ linux/fs/xfs/pagebuf/page_buf.c     Tue Feb 18 20:34:50 2003
> @@ -57,6 +57,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/proc_fs.h>
>  #include <linux/workqueue.h>
> +#include <linux/suspend.h>
> 
>  #include <support/debug.h>
>  #include <support/kmem.h>
> @@ -1591,6 +1592,9 @@
> 
>         INIT_LIST_HEAD(&tmp);
>         do {
> +               if (current->flags & PF_FREEZE)
> +                       refrigerator(PF_IOTHREAD);
> +
>                 if (pbd_active == 1) {
>                         del_timer(&pb_daemon_timer);
>                         pb_daemon_timer.expires = jiffies +
> 
> 
> 
> 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
