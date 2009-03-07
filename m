From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.29-rc6-git7: Reported regressions from 2.6.28
Date: Sat, 7 Mar 2009 23:12:09 +0100
Message-ID: <200903072312.10731.rjw@sisk.pl>
References: <KiHv0irKPzE.A.l3.hUarJB@chimera> <1236129312.32297.259.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1236129312.32297.259.camel@rzhang-dt>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Natalie Protasevich <protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 04 March 2009, Zhang Rui wrote:
> On Wed, 2009-03-04 at 03:22 +0800, Rafael J. Wysocki wrote:
> 
> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=12705
> > Subject         : X200: Brightness broken since 2.6.29-rc4-58-g4c098bc
> > Submitter       : Nico Schottelius <nico-linux-20090213-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
> > Date            : 2009-02-13 9:33 (19 days old)
> > References      : http://marc.info/?l=linux-kernel&m=123451768406825&w=4
> > Handled-By      : Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > 
> 
> e806b4957412bf472d826bd8cc571da041248799 is first bad commit
> commit e806b4957412bf472d826bd8cc571da041248799
> Author: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> Date:   Thu Jan 22 09:56:58 2009 -0800
> 
>     drm/i915: Suppress GEM teardown on X Server exit in KMS mode.
>     
>     Fixes hangs when starting X for the second time.
>     
>     Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>     Signed-off-by: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>
> 
> http://marc.info/?l=linux-kernel&m=123479975503827&w=2

Thanks, updated.

Rafael
