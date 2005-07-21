From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Linux v2.6.13-rc3
Date: Thu, 21 Jul 2005 01:30:51 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>Len, ACPI people - can we fix this regression, please?
>
>Rafael even pinpoints exactly which patches are causing the=20
>problem, so why didn't they get reverted before sending them off to me?

Linus,
I'm sorry it was in '-rc3' -- that is as soon as I could
muster the bk->git transition.  Now that I'm running on git,
I expect I'll be able to get the development/testing/push
pipeline moving and back on schedule.

Yes, we discovered both of these regressions in mm.
Yes, Rafael has been a sport in filing good bug reports,
and his Asus L5D has been an interesting case.

Although we broke this system, I do believe that there is
significant value in keeping these changes in the mainline,
as I believe that it is the fastest path to improved support
for all systems.  Specifically...

Re: the EC burst mode regression.
This is an extremely important fix that has been nagging
many systems for years.  It has been reported to us by
distros as well as on kernel.org:
http://bugzilla.kernel.org/show_bug.cgi?id=3D3851
There has been a lot of discussion about this on the
mailing list and there have been several generations
of patches.  We are confident that this approach
is the correct solution, but clearly there are
some snags.  It is probable that the snags are
model specific.

Ironically, it would be a benefit if more machines
broke like the Asus L5D because we've had a heck of
a time trying to reproduce this.  Indeed, I purchased
an AMD laptop as similar to that model as I could find
and shipped it to China explicitly for Luming to debug
this very issue.  Alas, that model, only slightly different,
works perfectly...

Re: pci_link.c regression on suspend/resume
This is the issue that Patrick was trying to describe in the KS --
that we're knowingly breaking some drivers on suspend/resume.
http://bugzilla.kernel.org/show_bug.cgi?id=3D3469
We intentionally removed a hack we put in to blindly restore
PCI interrupt links.  The hack can never be reliable
because the AML interpreter must run to restore PCI links
and it must run arbitrary AML code.  But it can sleep on
memory allocation and semaphores, and thus can't reliably
run before we have interrupts enabled.

We discussed this on linux-pm and at the PM-summit, and the
consensus was that making the interrupt restoring process on
resume more like boot will lead to a more robust design.
The down-side is that drivers that worked before will break,
and it is not a quick fix as we work our way through it.

thanks,
-Len


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
