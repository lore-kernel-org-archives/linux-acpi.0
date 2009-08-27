From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Thu, 27 Aug 2009 14:36:53 -0700
Message-ID: <20090827143653.52308d6d.akpm@linux-foundation.org>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera>
	<200908261833.37310.elendil@planet.nl>
	<20090826123647.e60d9555.akpm@linux-foundation.org>
	<200908272023.21288.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200908272023.21288.rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 27 Aug 2009 20:23:20 +0930
Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> wrote:

> > My linux-next repair job:
> 
> OK, I've dropped these from my tree entirely to avoid more problems.
> 
> Can you take them?  They're not really at home in my tree.
> 
> arch-x86-kernel-acpi-cstatec-avoid-using-work_on_cpu.patch
> misc:work_on_cpu-acpi.patch
> misc:work_on_cpu-acpi-fix.patch
> misc:work_on_cpu-dcdbas.patch
> 
> You can fetch them from http://ozlabs.org/~rusty/kernel/rr-latest/
> 
> (You'll want to rename the last three something sane...)

Those patches are already in today's linux-next so I can't carry them.

Please email them over in the traditional fashion once that situation
has sorted itself out?
