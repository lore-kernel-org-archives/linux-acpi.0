From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Re: D600 + S3 Sleep
Date: Tue, 22 Mar 2005 13:33:15 +0800
Message-ID: <1111469595.27022.37.camel@neuromancer.home.net>
References: <1111137292.23665.5.camel@neuromancer.home.net>
	 <20050318105425.GJ14600@project-bob.org>
	 <1111144388.23668.46.camel@neuromancer.home.net>
	 <20050318115313.GK14600@project-bob.org>
	 <20050318140556.GB18696@message-id.gmane0305.slipkontur.de>
	 <20050318160957.GL14600@project-bob.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318160957.GL14600-PWUXgD0Mw7gU45xQlXEPcg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-18 at 16:09 +0000, Proinnsias Breathnach wrote:
> On Fri, Mar 18, 2005 at 03:05:56PM +0100, Stefan Seyfried wrote:
> > On Fri, Mar 18, 2005 at 11:53:13AM +0000, Proinnsias Breathnach wrote:
> > > Unless someone comes up with a nice way of making it work with vga=795
> > > (or whatever it was I used have before ...)
> > 
> > not much hope here, i have had one of our X developers pondering over this
> > one (he knows the radeon chipsets pretty well) but to no avail. It seems
> > the machine never wakes up if _any_ framebuffer is used (radeonfb also does
> > not work).
> Oh well :)
> 
> Life's like that !
> 
> I konw the FB stuff works if the acpi_late_bios patch is used per:
> http://www.loria.fr/~thome/d600/

I've tested it and it worked.

But it was too much work to get S3 done so I dropped it.

Now that I saw S3 is working for others, I thought I try again.

And Yes, Proinnsais, sadly the config you mentioned, I tried but it
doesn't work. It doesn't Come back up. POST for the video doesn't happen
for some reason for my config.

Not sure why and not sure how much of an incentive I have to go do it
since S4 with suspend2 works like a charm. (Except for the stupid
Xscreensaver thing causing intermittent hangs. I've sent an email to
suspend2 list)

> 
> But I've not been bothered to test it personally !
> 
> P

-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 
98% Microsoft(tm) Free!! 
Neuromancer 13:33:14 up 1 day, 3:16, 7 users, load average: 1.73, 0.79,
0.48 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
