From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: D600 + S3 Sleep
Date: Fri, 18 Mar 2005 19:13:08 +0800
Message-ID: <1111144388.23668.46.camel@neuromancer.home.net>
References: <1111137292.23665.5.camel@neuromancer.home.net>
	 <20050318105425.GJ14600@project-bob.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318105425.GJ14600-PWUXgD0Mw7gU45xQlXEPcg@public.gmane.org>
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

On Fri, 2005-03-18 at 10:54 +0000, Proinnsias Breathnach wrote:
> On Fri, Mar 18, 2005 at 05:14:52PM +0800, Ow Mun Heng wrote:
> > Hi All,
> > 
> > 	Anyone here managed to get S3 to work on the D600?
> > 
> > I'm on 2.6.11 kernel and still the same Black Screen after resume
> > persists.
> > 
> > I've tried Software Suspend 2 and By golly, it's much faster then SW1.
> > 
> Yes, it's quite simple and reliable, you need to append vga=normal to
> your command-line as neither vesafb nor radeonfb play nice. 
> 
> After that - my mileage has been good (4 or 5 day suspends, and 8 or 9
> day uptimes so far), yours may vary though

vga=normal??

So that means no High-Res Console??

Right now, I'm using

root=/dev/hda3 video=vesafb:ywrap,mtrr,1280x1024-24@60
splash=verbose,theme:emergence resume2=swap:/dev/hda5

So.. I need to remove all of those and only left with this??

root=/dev/hda3 vga=normal resume2=swap:/dev/hda5 ??


-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 
98% Microsoft(tm) Free!! 
Neuromancer 19:10:31 up 3:26, 6 users, load average: 0.30, 0.57, 0.58 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
