From: Jerome Glisse <glisse-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Fri, 23 Apr 2010 12:23:38 +0200
Message-ID: <20100423102338.GA3151@barney.localdomain>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
 <20100420135636.GA10674@elliptictech.com>
 <201004210715.38621.rjw@sisk.pl>
 <20100421085739.GA2576@barney.localdomain>
 <20100421165758.GA23565@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100421165758.GA23565-7BP4RkwGw0uXmMXjJBpWqg@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, DRI <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2010 at 12:57:58PM -0400, Nick Bowler wrote:
> On Wed, Apr 21, 2010 at 07:15:38AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday 20 April 2010, Nick Bowler wrote:
> > > Please list these two similar regressions from 2.6.33 in the r600 DRM:
> > > 
> > >  * r600 CS checker rejects GL_DEPTH_TEST w/o depth buffer:
> > >            https://bugs.freedesktop.org/show_bug.cgi?id=27571
> > > 
> > >  * r600 CS checker rejects narrow FBO renderbuffers:
> > >            https://bugs.freedesktop.org/show_bug.cgi?id=27609
> > 
> > Do you want to me to add them as one entry or as two separate bugs?
> 
> As upstream doesn't consider the first to be a kernel issue, I guess you
> should just list the second.
> 
> On 10:57 Wed 21 Apr     , Jerome Glisse wrote:
> > First one is userspace bug, i need to look into the second one.
> > ie we were lucky the hw didn't lockup without depth buffer and
> > depth test enabled.
> 
> OK, if the failure is due to userspace is doing Very Bad Things(tm),
> catching that seems reasonable.
> 
> Nevertheless, even if it happened by luck, the result was (ostensibly)
> working programs that suddenly break once one "upgrades" to the latest
> kernel.  If userspace can't be fixed before 2.6.34 is released, perhaps
> a less cryptic log message would be appropriate?
> 
> -- 
> Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)

I pushed fix into mesa for the depth issue i will look into the other
one today and likely push kernel fix.

Cheers,
Jerome
