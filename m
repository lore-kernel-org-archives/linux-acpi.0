From: Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Subject: Re: IBM Thinkpad R32 and ACPI
Date: Sun, 13 Apr 2003 00:31:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030413043123.GA23368@dao.cs.ohiou.edu>
References: <20030412173357.1e4ea127.linux.wali@gmx.de> <200304121812.h3CIC6g18608@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200304121812.h3CIC6g18608-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Cc: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I tried the patch on my x22. it fixed the problem. nice catch, Brian. 
as far as the sleep mode, S4 worked for me couples of weeks ago, but not any more. sad.

--ltong

On Sat, Apr 12, 2003 at 02:12:06PM -0400, bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:
> This problem is supposed to be fixed in the next release(see the archives).
> 
> The problem was solved for me (on my R32) by going to 
> drivers/acpi/events/evxfregn.c
> and removing one of the 
> 
> acpi_ut_remove_reference (handler_obj);
> 
> lines (there are two). 
> This might also help other Thinkpad users who have similar problems.
> 
> 
> Let me know how it goes.  Sleep functionality seems pretty broken at
> the moment.
> 
>  Here's a patch, if you prefer.
> 
> diff -u -r1.1.1.1 evxfregn.c
> --- linux-2.5.66/drivers/acpi/events/evxfregn.c	2 Apr 2003 03:34:04 -0000	1.1.1.1
> +++ linux-2.5.66/drivers/acpi/events/evxfregn.c	9 Apr 2003 16:18:25 -0000
> @@ -391,7 +391,7 @@
>  			/*
>  			 * Now we can delete the handler object
>  			 */
> -			acpi_ut_remove_reference (handler_obj);
> +
>  			acpi_ut_remove_reference (handler_obj);
>  
>  			goto unlock_and_exit;
> 
> 
> 
> 
> --
> Brian Perkins                                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
