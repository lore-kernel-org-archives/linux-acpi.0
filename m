From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Proposed ACPI Licensing change
Date: Sat, 7 Dec 2002 01:24:06 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021207002405.GR2544@fs.tum.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 06, 2002 at 04:10:00PM -0800, Grover, Andrew wrote:

> Hi all,

Hi Andrew,

>...
> One consequence of this is that we have not been able to benefit directly
> from patches from other Linux contributors. The reason is, patches submitted
> to code only under the GPL must also be GPL, and therefore we cannot take
> them directly and still make our code available under a license other than
> the GPL. (We have to determine the problem the patch fixes and then do the
> fix ourselves.)
>...
> In order to solve this, we are considering releasing the Linux version of
> the interpreter under a dual license. This would allow direct incorporation
> of changes. Any patches submitted against the ACPI core code would
> implicitly be allowed to be used by us in a non-GPL context. This is already
> done elsewhere in the Linux kernel source by the PCMCIA code, for example.
> 
> Comments?

two comments regarding the right of an author to freely choose under 
which license(s) he wants to make his patch available:

If a submitter wants to allow you to use his patch under both licenses 
he's already able to allow you to do so.

You can't forbid people to send GPL-only patches, so if a person doesn't
want his patch under your looser license you can't enforce that he also
releases it under your looser license.

> Regards -- Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
