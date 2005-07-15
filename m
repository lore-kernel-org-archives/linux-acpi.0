From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: RE: 2.6.13-rc3 ACPI regression and hang on x86-64
Date: Fri, 15 Jul 2005 12:51:49 +0200 (MEST)
Message-ID: <200507151051.j6FApn0N003458@harpo.it.uu.se>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 14 Jul 2005 15:23:52 -0400, Brown, Len wrote:
>>acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail
>>
>>on the console, and then the machine is hung hard.
>
>2.6.13-rc3 x86_64 failed, but 
>2.6.13-rc2 x86_64 worked
>
>And both of these revisions in the i386 kernel still work?

With the i386 kernel, 2.6.13-rc2 works perfectly.
With the i386 kernel, 2.6.13-rc3 mostly works, but
it fails to detect the CPU's C2 state.

>Is it possible for you to test the latest ACPI patch?
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
>2.6.13/

I was going to, but as it was for -rc2 not -rc3 I decided to
try Venkatesh Pallipadi's C-state FADT regression patch first.
<http://marc.theaimsgroup.com/?l=linux-kernel&m=112135903100520&w=2>
Success! That solved all my ACPI issues with -rc3.

"Yu, Luming" wrote:
>> on the console, and then the machine is hung hard.
>If you didn't press that key,   the machine still hung?

No it worked except for having no power management and an
unusable console due to ACPI having reduced the brightness.

/Mikael


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
