From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: Samsung P35, S3, black screen (radeon))
Date: Thu, 10 Feb 2005 20:31:23 +0100
Message-ID: <20050210193123.GC1391@elf.ucw.cz>
References: <1107695583.14847.167.camel@localhost.localdomain> <420BB267.8060108@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420BB267.8060108-sQDSfeB7uhw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bill Davidsen <davidsen-sQDSfeB7uhw@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>Rumors say that notebooks no longer have video bios at C000h:0; rumors
> >>say that video BIOS on notebooks is simply integrated into main system
> >>BIOS. I personaly do not know if rumors are true, but PCs are ugly
> >>machines....
> >>							
> >
> >
> >A small number of laptop systems are known to pull this trick. There are
> >other problems too - the video bios boot may make other assumptions
> >about access to PCI space, configuration, interrupts, timers etc.
> >
> >Some systems (intel notably) appear to expect you to use the bios
> >save/restore video state not re-POST.
> 
> Isn't that what it's there for? In any context other than save/restore I 
> wouldn't think using the BIOS was a good approach. But this is a special 
> case, and if there's a BIOS function which does the right thing, it 
> would seem to be easier to assume that the BIOS works than that the 
> driver can do every operation for a clean restart.
> 
> The problem is that while POST leaves the video in a known state, it may 
> not the known state you want, nor is it a given that you can get from 
> there to where you were on suspend. PC hardware isn't always that 
> dependable.

Eh? POST leaves video in 80x25 text mode, and we know how to handle
that mode just fine... Historically that's what we ran our consoles
at, so X can handle it etc.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
