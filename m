From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 21:42:47 +0100
Message-ID: <20050217204247.GA2386@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net> <20050217195456.GA5963@openzaurus.ucw.cz> <4214FFCE.4080703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214FFCE.4080703-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
> >>4. Include a mandantory description of video bringup after resume
> > 
> > That sounds overcomplicated. Simply add this to the specs:
> 
> You have to start to think like a vendor with a long legacy. Then my
> spec draft will make more sense. Basically, you can't tell a vendor
> that his hardware is broken or he will ignore your efforts from that
> point on. "It's a question of honour." If, on the other hand, a
> vendor can claim his products are conforming to the spec by issuing
> a software update for broken hardware, it is much more likely that
> the spec gets accepted.

Well, whether you POST video or not is still only
software... anyway...

Your _WAK idea could work for notebooks (but if you did it in _WAK
you'd break windows, so you'd have to call it _VWK (VideoWaK) or
something), but for desktop where user can plug in any video card he
buys... I do not see how you can get away with something other than
normal POST.

> > BIOS must do that during normal boot; this should be very little
> > additional work.
> 
> Not necessarily. Some BIOSes stay in graphics mode during the whole
> bootup (at least it seems so) and would have to include additional
> code to enter 80x25 text mode.

??? When grub is launched, you are in 80x25 text mode.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
