From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: ACPI and PRREMPT bug
Date: Mon, 7 Nov 2005 15:15:24 -0800
Message-ID: <20051107231524.GW7991@shell0.pdx.osdl.net>
References: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0356B628-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Moore, Robert (robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) wrote:
> You might try setting this flag (in acglobal.h) to TRUE:
> 
> /*
>  * Automatically serialize ALL control methods? Default is FALSE,
> meaning
>  * to use the Serialized/NotSerialized method flags on a per method
> basis.
>  * Only change this if the ASL code is poorly written and cannot handle
>  * reentrancy even though methods are marked "NotSerialized".
>  */
> ACPI_EXTERN UINT8       ACPI_INIT_GLOBAL (AcpiGbl_AllMethodsSerialized,
> FALSE);

I've chatted with another person having this issue.  Booting with
acpi_serialize (which sets that flag to true) does seem to fix the
problem.  I'm guessing thread_count gets decremented twice for one
increment, causing it to underflow wrapping to -1.

thanks,
-chris


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
