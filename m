From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: [patch] remove null-ifiers
Date: Tue, 27 Jan 2004 10:31:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40168442.7020806@neggie.net>
References: <E1AgkrW-00080w-00@jaguar.mkp.net>	<20040127150954.GA12740@hell.org.pl> <16406.32889.922823.45313@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16406.32889.922823.45313-4mDQ13Tdud8Jw5R7aSpS0dP8p4LwMBBS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jes Sorensen wrote:
>"Karol" == Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> writes:
> Karol> We certainly *don't* want to do that, last time I checked C did
> Karol> not actually guarantee to zero out uninitialized variables --
> Karol> unless it's different in the kernelspace. Are you sure pointers
> Karol> are initialized as NULLs?
> 
> Yes,
> 
> We definately want to do this, this *is* how it works within the
> kernel.

That may be the case, but in the process I think you are destroying 
vital information about which variables the code depends on being 
initialized to zero.  If the Linux kernel ever changed its policy, or if 
the code was used in something other than the Linux kernel (perhaps even 
being translated to some other computer language), you would need that 
information again.

I suggest commenting out the assignment instead of deleting it:

     static int foo /*= 0*/;

-John



-- 
http:// if  ile.org/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
