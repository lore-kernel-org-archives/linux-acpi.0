From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Power usage in S3
Date: Wed, 2 Mar 2005 00:34:22 +0100
Message-ID: <20050301233422.GF2062@elf.ucw.cz>
References: <20050228141701.4dc95eec@orfeo.nikhef.nl> <200502282045.30429.stefandoesinger@gmx.at> <20050228231322.GA1919@elf.ucw.cz> <200503012036.20047.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503012036.20047.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > I finally got the power issues resolved on my Thinkpad T40 too.  It can
> > > > only sleep in S3 for about 2 days too.  But, with a new high-capacity
> > > > battery, it could probably go for 4 days.  My wife's Thinkpad R40p can
> > > > go for about a week, but it has a new battery and the FireGL T2
> > > > graphics card rather than the Radeon 7500.  And it didn't need the
> > > > radeon power stuff -- it only needed acpi_sleep=s3_bios.  But, I am
> > > > sure we can do better than 2-2.5 days... *But*, I am very pleased that
> > > > we have come this far.  For almost a year, I was using swsusp2 every
> > > > night going home from work.  As nice as that is, it still is too slow
> > > > for an overnight sleep.
> > >
> > > My Acer Travelmate 803 looses ~20% battery power in 12 hours in S3 with
> > > Linux. Under Windows it dropped from 50% to 5% withhin 5h. Sounds
> > > strange, but at least the Linux value can be reproduced. I can't test
> > > with Windows again because it had to go to satisfy my disk space needs
> > > :-)
> >
> > Acer TM 803 is not yet in the video.txt list. What hacks do you need?
> >
> I thought it's in the list because it's mentioned in the video.txt file in the 
> kernel sources or better was mentioned namely before:
> 
> (5) radeon systems, where X can soft-boot your video card. You'll need
>   patched X, and plain text console (no vesafb or radeonfb), see
>   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html.

I thought that was tm800 and tm803 is different machine.. video.txt
updated. Thanks.

> For proper device resume it needs the patch which splits up the resume 
> functions so devices are re-enabled after leaving the acpi sleep state. I've 
> sent it to len some tome ago, but I don't know if it's in the acpi
> mainline.

Len is slow at taking patches :-(.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
