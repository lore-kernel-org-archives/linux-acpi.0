From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 02:54:18 +0100
Message-ID: <20050216015418.GC13753@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108500194.12031.21.camel@elrond.flymine.org> <42126506.8020407@colitti.com> <200502160141.11633.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502160141.11633.alistair-T7eSMZptz7IqdlJmJB21zg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alistair John Strachan <alistair-T7eSMZptz7IqdlJmJB21zg@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I would advise trying to compile a custom kernel from scratch with my
> > .config first.
> >
> > I got S3 working first with a very basic kernel config, but I couldn't
> > get it to work with my usual kernel. Assuming it was some feature that
> > caused the problem, I started disabling features in the hope of getting
> > it to work, but I ended up with two different kernels with seemingly
> > irrelevant differences, of which one would succesfully resume and one
> > wouldn't. So I started added features to the other kernel, and I never
> > found out what caused the problem.
> 
> I took your advice and built your kernel with a few modifications (XFS instead 
> of ext, etc.). If I boot the kernel with init=/bin/sh, I can actually 
> suspend! Thanks!
> 
> I will exhaustively enable and disable drivers tomorrow to figure out which 
> one is causing suspend to fail when I do a complete boot. Whatever we find is 
> clearly a bug that should be fixed.
> 
> It is not the framebuffer driver (I always ran without vesafb or radeonfb), 
> and it is not my ipw2200 or USB drivers.
> 
> Also, is USB suspend/resume supposed to work? My brief trials involved 
> modprobing the USB HCD modules, which still allowed me to suspend/resume, but 
> my USB mouse was non-functional on resume.

Yes, it seems to work quite okay. You may need to unplug/replug
devices after resume, but it should be basically ok.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
