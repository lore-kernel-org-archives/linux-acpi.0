From: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Subject: Re: [patch] remove null-ifiers
Date: Tue, 27 Jan 2004 10:35:23 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16406.34107.51859.924117@gargle.gargle.HOWL>
References: <E1AgkrW-00080w-00@jaguar.mkp.net>
	<20040127150954.GA12740@hell.org.pl>
	<16406.32889.922823.45313@gargle.gargle.HOWL>
	<40168442.7020806@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40168442.7020806-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "John" == John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org> writes:

John> Jes Sorensen wrote:
>> We definately want to do this, this *is* how it works within the
>> kernel.

John> That may be the case, but in the process I think you are
John> destroying vital information about which variables the code
John> depends on being initialized to zero.  If the Linux kernel ever
John> changed its policy, or if the code was used in something other
John> than the Linux kernel (perhaps even being translated to some other
John> computer language), you would need that information again.

Not at all, it's standard Linux kernel convention, it won't
change. Explicitly zeroing out variables cause more damage since it
transfers them to the data segment from the bss segment.

John> I suggest commenting out the assignment instead of deleting it:

John>      static int foo /*= 0*/;

It works, IMHO it's ugly, but if you find it helps, go ahead. I'd rather
leave a comment like /* uninitialized global variables automatically go
to the bss and get zeroed out */

Jes


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
