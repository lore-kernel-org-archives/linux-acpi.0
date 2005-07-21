From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3
Date: Thu, 21 Jul 2005 12:09:45 +0200
Message-ID: <200507211209.46039.rjw@sisk.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thursday, 21 of July 2005 07:30, Brown, Len wrote:
> >Len, ACPI people - can we fix this regression, please?
> >
> >Rafael even pinpoints exactly which patches are causing the 
> >problem, so why didn't they get reverted before sending them off to me?
> 
> Linus,
> I'm sorry it was in '-rc3' -- that is as soon as I could
> muster the bk->git transition.  Now that I'm running on git,
> I expect I'll be able to get the development/testing/push
> pipeline moving and back on schedule.
> 
> Yes, we discovered both of these regressions in mm.
> Yes, Rafael has been a sport in filing good bug reports,
> and his Asus L5D has been an interesting case.
> 
> Although we broke this system, I do believe that there is
> significant value in keeping these changes in the mainline,
> as I believe that it is the fastest path to improved support
> for all systems.  Specifically...

In short: If the changes are generally needed, I can live with them
(as long as I know what patches to revert :-)).

Still it would be nice to let people know what to do if they have problems with
these changes.  Many people don't run -rc kernels and even more people
don't run -mm, so they have no idea that there are known regressions  ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
