From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [patch] remove null-ifiers
Date: Thu, 29 Jan 2004 23:09:43 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040129225235.S96322@root.org>
References: <E1AgkrW-00080w-00@jaguar.mkp.net> <20040127150954.GA12740@hell.org.pl>
 <16406.32889.922823.45313@gargle.gargle.HOWL> <40168442.7020806@neggie.net>
 <16406.34107.51859.924117@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16406.34107.51859.924117-4mDQ13Tdud8Jw5R7aSpS0dP8p4LwMBBS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Jan 2004, Jes Sorensen wrote:
> >>>>> "John" == John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org> writes:
>
> John> Jes Sorensen wrote:
> >> We definately want to do this, this *is* how it works within the
> >> kernel.
>
> John> That may be the case, but in the process I think you are
> John> destroying vital information about which variables the code
> John> depends on being initialized to zero.  If the Linux kernel ever
> John> changed its policy, or if the code was used in something other
> John> than the Linux kernel (perhaps even being translated to some other
> John> computer language), you would need that information again.
>
> Not at all, it's standard Linux kernel convention, it won't
> change. Explicitly zeroing out variables cause more damage since it
> transfers them to the data segment from the bss segment.
>
> John> I suggest commenting out the assignment instead of deleting it:
>
> John>      static int foo /*= 0*/;
>
> It works, IMHO it's ugly, but if you find it helps, go ahead. I'd rather
> leave a comment like /* uninitialized global variables automatically go
> to the bss and get zeroed out */

I think you should have spelled that as:
/* http://www.eskimo.com/~scs/C-faq/top.html */

If you're translating code to another language, it's a good idea to know
how to use the original language.  This is not a Linux convention, it's
part of the K&R and ANSI standards for C and has been around at least 20
years, probably 30.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
