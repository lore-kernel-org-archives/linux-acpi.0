From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Thu, 27 Aug 2009 20:23:20 +0930
Message-ID: <200908272023.21288.rusty@rustcorp.com.au>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera> <200908261833.37310.elendil@planet.nl> <20090826123647.e60d9555.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090826123647.e60d9555.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 27 Aug 2009 05:06:47 am Andrew Morton wrote:
> So in my tree I reworked it so that the new `force' arg gets passed
> through appropriately.  It compiles cleanly but I'd suggest that Len
> simply drop "misc:work_on_cpu-acpi" and we send it back to Rusty for
> some rechecking (sorry).

Sure.  My main motivation is to get rid of cpumasks on the stack; while
there, I tried to fix this up properly.

> Rusty/Len: please work out why the title for that patch went silly.

git-quiltimport uses the patch names, and doesn't extract the title.  I
assume that's what Stephen uses.  I didn't rename the patch when I rewrote
it not to use work_on_cpu.

> Rusty, please self-administer smackings for
> 
> 		struct set_throttling_info sti
> 			= { pr, p_throttling, t_state.target_state };
> 
> these things always start out simple and end up not-simple, so some poor
> schmuck has to clean them up so stuff doesn't break.
> 
> 		struct set_throttling_info sti = {
> 			.pr = pr,
> 			.p_throttling = p_throttling,
> 			.target_state = t_state.target_state,
> 			.force = force
> 		};
> 
> is better!

Meh... same concept applies to function arguments, and we rely on typechecking
to catch that (though we have little choice in C).

> My linux-next repair job:

OK, I've dropped these from my tree entirely to avoid more problems.

Can you take them?  They're not really at home in my tree.

arch-x86-kernel-acpi-cstatec-avoid-using-work_on_cpu.patch
misc:work_on_cpu-acpi.patch
misc:work_on_cpu-acpi-fix.patch
misc:work_on_cpu-dcdbas.patch

You can fetch them from http://ozlabs.org/~rusty/kernel/rr-latest/

(You'll want to rename the last three something sane...)

Thanks,
Rusty.
