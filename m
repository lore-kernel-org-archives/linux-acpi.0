From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.13-rc3-mm1: a regression
Date: Sun, 17 Jul 2005 22:11:56 +0200
Message-ID: <200507172211.56487.rjw@sisk.pl>
References: <20050715013653.36006990.akpm@osdl.org> <200507162330.18810.rjw@sisk.pl> <20050716143945.735906ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050716143945.735906ce.akpm-3NddpPZAyC0@public.gmane.org>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday, 16 of July 2005 23:39, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> >
> > On Friday, 15 of July 2005 10:36, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> >  > 
> >  > (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
> >  > kernel.org syncs up)
> > 
> >  There seems to be a regression wrt 2.6.13-rc3 which causes my box (Asus L5D,
> >  Athlon 64 + nForce3) to hang solid during resume from disk on battery power.
> > 
> >  First, 2.6.13-rc3-mm1 is affected by the problems described at:
> >  http://bugzilla.kernel.org/show_bug.cgi?id=4416
> >  http://bugzilla.kernel.org/show_bug.cgi?id=4665
> >  These problems go away after applying the two attached patches.  Then, the
> >  box resumes on AC power but hangs solid during resume on battery power.
> >  The problem is 100% reproducible and I think it's related to ACPI.
> 
> That recent acpi merge seems to have damaged a number of people...
> 
> Are you able to test Linus's latest -git spanshot?  See if there's a
> difference between -linus and -mm behaviour?

I was afraid you would say so. ;-)

The -rc3-git-[2-4] kernels are unaffected by the problem described, so it seems
to be specific to -rc3-mm1.

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
