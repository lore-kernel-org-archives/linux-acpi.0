From: Nick Bowler <nbowler-7BP4RkwGw0uXmMXjJBpWqg@public.gmane.org>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Fri, 23 Apr 2010 11:31:45 -0400
Message-ID: <20100423153145.GA6072@elliptictech.com>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
 <20100420135636.GA10674@elliptictech.com>
 <201004210715.38621.rjw@sisk.pl>
 <20100421085739.GA2576@barney.localdomain>
 <20100421165758.GA23565@elliptictech.com>
 <20100423102338.GA3151@barney.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100423102338.GA3151-N6zOBCg9HoVSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jerome Glisse <glisse-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, DRI <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux PM List <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Maciej Rutecki <maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 12:23 Fri 23 Apr     , Jerome Glisse wrote:
> On Wed, Apr 21, 2010 at 12:57:58PM -0400, Nick Bowler wrote:
> > OK, if the failure is due to userspace is doing Very Bad Things(tm),
> > catching that seems reasonable.
> > 
> > Nevertheless, even if it happened by luck, the result was (ostensibly)
> > working programs that suddenly break once one "upgrades" to the latest
> > kernel.  If userspace can't be fixed before 2.6.34 is released, perhaps
> > a less cryptic log message would be appropriate?
> 
> I pushed fix into mesa for the depth issue i will look into the other
> one today and likely push kernel fix.

Great, thanks.  I'll try out the depth fix tonight.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
