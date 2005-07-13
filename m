From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: Linux v2.6.13-rc3
Date: Wed, 13 Jul 2005 04:04:39 -0700
Message-ID: <20050713040439.33a8d149.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


ugh, bad.

Begin forwarded message:

Date: Wed, 13 Jul 2005 12:59:04 +0200
From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3


Hi,

On Wednesday, 13 of July 2005 07:05, Linus Torvalds wrote:
> 
> Yes,
>  it's _really_ -rc3 this time, never mind the confusion with the commit 
> message last time (when the Makefile clearly said -rc2, but my over-eager 
> fingers had typed in a commit message saying -rc3).
> 
> There's a bit more changes here than I would like, but I'm putting my foot 
> down now. Not only are a lot of people going to be gone next week for LKS 
> and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> down.

FYI, on my box (Asus L5D, Athlon 64 + nForce3, 64-bit kernel) there are two
regressions wrt -rc2 related to ACPI.  First, the battery monitor does not work
(http://bugzilla.kernel.org/show_bug.cgi?id=4665)
and second, the box hangs solid during resume from disk if IO-APIC is not used
(http://bugzilla.kernel.org/show_bug.cgi?id=4416).

The problems have been known for quite some time and remain unresolved,
but apparently they have made it to mainline nevertheless.  I understand
nobody else has reported them, but I also know of some people who run
Linux on the same hardware and 2.6.13 will not work for them if these
issues are present in it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
