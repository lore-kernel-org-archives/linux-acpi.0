From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: s4bios: does anyone use it?
Date: Sat, 5 Mar 2005 22:17:47 +0100
Message-ID: <20050305211747.GF1424@elf.ucw.cz>
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422A1FB6.3000504-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >Is there single user of s4bios? It used to work for me 4 notebooks
> >ago, but I never really used it. I think I'm the only person that ever
> >seen it working, but I could be wrong. Is there anyone using s4bios in
> >2.6.11?
> >
> >If not, I guess we should remove that code from kernel. It is not
> >usefull, and it is likely broken.
> >								Pavel

> I always suspend my Compaq Evo N6OOc to disk using "echo 4b > 
> /proc/acpi/sleep".
> I don't remember the reason why I originally did choose this one instead of 
> S4.
> I just checked that S4 and S4Bios work the same on 2.6.11-mm1 (even with my
> PCMCIA wireless card connected, great!).
> From what I remember, I didn't see any difference between S4 and S4Bios in
> recent vanilla kernels.

Can you try cat /proc/acpi/sleep? If there's no difference between S4
and S4bios, than you are probably just using plain S4...

> By the way, it seems that Radeon makes suspend slower because it needs
> to be blanked or something like that. Is there any way to avoid this ?

Yes, but it will take quite long to do it properly. pm_message_t
framework needs to go in, first.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
