From: Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>
Subject: Re: Sony Vaio Battery Info
Date: Fri, 20 Dec 2002 16:09:54 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021220160954.GA13548@the.earth.li>
References: <Pine.LNX.4.50.0212192106570.950-100000@phoenix.kerstin.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212192106570.950-100000-KjnUIgV0B0bsKMwAuzqOxrNldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

---- Original Message ----
> From Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
> Date: Thursday, 19 Dec 2002, 20:13
>
> I don't really know how to do this (finding the ec code won't be so hard,
> but I don't think that 'normal' libc time functions will work in kernel).
> Any volunteers? ;)

You shouldn't need to use the time functions .. just print out the
kernel's 'jiffy' count.  It's only 100Hz but since we're looking for
0.6s that shouldn't matter.

If you need debug timings more precisely then on x86:

#define _int64 long long // The kernel may have something like this already .. I can't remember
#define prectime() ({ _int64 u; asm("rdtsc": "=A" (u)); u; })

will give you a way of accessing the time stamp counter which on Pentium 
class chips will count CPU cycles .. which gives somewhat more precise 
profiling information.

This is something I keep meaning to look at, but I seem to be missing a 
large number of 'tuits' (especially the round variety).

-- 
Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>


-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
