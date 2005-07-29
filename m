From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Followup on 2.6.13-rc3 ACPI processor C-state regression
Date: Fri, 29 Jul 2005 10:59:22 -0700
Message-ID: <20050729105922.3da4b3aa.akpm@osdl.org>
References: <3b0ffc1f050713150527c7c649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3b0ffc1f050713150527c7c649-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kevin Radloff <radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Kevin Radloff <radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
> detected on my Fujitsu Lifebook P7010D. I found that in the merge at:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=893b074e3d1a48a4390cf84b4c1a10ef6be2460c;hp=c9d671cf7857dbc7101e99d469fa24eed711ac60;hb=5028770a42e7bc4d15791a44c28f0ad539323807;f=drivers/acpi/processor_idle.c
> 
> .. in the section at (please forgive my destruction of the formatting) ...
> 
> @@ -787,10 +843,7 @@ static int acpi_processor_get_power_info
>          if ((result) || (acpi_processor_power_verify(pr) < 2)) {
>              result = acpi_processor_get_power_info_fadt(pr);
>              if (result)
> -                return_VALUE(result);
> -
> -            if (acpi_processor_power_verify(pr) < 2)
> -                return_VALUE(-ENODEV);
> +               result = acpi_processor_get_power_info_default_c1(pr);
>          }
> 
> .. a call to acpi_processor_power_verify() is removed, which breaks
> detection of C2/C3 capabilities if the above
> acpi_processor_get_power_info_cst() failed. It it had succeeded (and
> returned 0), then acpi_processor_power_verify() is called in the
> conditional statement, which will set the valid flags for C2/C3. But
> if it fails, like on my laptop, then the valid flags will never be
> set, despite the fact that the acpi_processor_get_power_info_fadt()
> function finds the necessary info for a subsequent
> acpi_processor_power_verify() call to succeed.
> 
> I don't know what exactly the proper fix here is (with the
> introduction of the acpi_processor_get_power_info_default_c1()
> function, that is), but simply reversing this part of the patch fixes
> detection of C2/C3 on my laptop.
> 

Len, Kevin confirms that the below patch fixes the above regression for
him.  Should we merge it now?


From: Jindrich Makovicka <makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org>

Re-enable C2/C3 states for systems without CST.  Fixes a regression after
the patch for C2/C3 support for multiprocessors
(http://bugme.osdl.org/show_bug.cgi?id=4401), which accidentally removed
the acpi_processor_power_verify() call.

Signed-off-by: Jindrich Makovicka <makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without	2005-07-14 15:53:47.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2005-07-14 15:53:47.000000000 -0700
@@ -881,7 +881,7 @@ static int acpi_processor_get_power_info
 	result = acpi_processor_get_power_info_cst(pr);
 	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if (result)
+		if ((result) || acpi_processor_power_verify(pr) < 2)
 			result = acpi_processor_get_power_info_default_c1(pr);
 	}
 
_



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
