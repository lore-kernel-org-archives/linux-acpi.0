From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3
Date: Wed, 13 Jul 2005 11:53:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131145310.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
 <200507131259.04855.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507131259.04855.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Len, ACPI people - can we fix this regression, please?

Rafael even pinpoints exactly which patches are causing the problem, so 
why didn't they get reverted before sending them off to me?

Grumble. I don't like being sent known-bad patches when we're trying to 
calm things down.

		Linus


On Wed, 13 Jul 2005, Rafael J. Wysocki wrote:
>
> Hi,
> 
> On Wednesday, 13 of July 2005 07:05, Linus Torvalds wrote:
> > 
> > Yes,
> >  it's _really_ -rc3 this time, never mind the confusion with the commit 
> > message last time (when the Makefile clearly said -rc2, but my over-eager 
> > fingers had typed in a commit message saying -rc3).
> > 
> > There's a bit more changes here than I would like, but I'm putting my foot 
> > down now. Not only are a lot of people going to be gone next week for LKS 
> > and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> > down.
> 
> FYI, on my box (Asus L5D, Athlon 64 + nForce3, 64-bit kernel) there are two
> regressions wrt -rc2 related to ACPI.  First, the battery monitor does not work
> (http://bugzilla.kernel.org/show_bug.cgi?id=4665)
> and second, the box hangs solid during resume from disk if IO-APIC is not used
> (http://bugzilla.kernel.org/show_bug.cgi?id=4416).
> 
> The problems have been known for quite some time and remain unresolved,
> but apparently they have made it to mainline nevertheless.  I understand
> nobody else has reported them, but I also know of some people who run
> Linux on the same hardware and 2.6.13 will not work for them if these
> issues are present in it.
> 
> Greets,
> Rafael
> 
> 
> -- 
> - Would you tell me, please, which way I ought to go from here?
> - That depends a good deal on where you want to get to.
> 		-- Lewis Carroll "Alice's Adventures in Wonderland"
> 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
