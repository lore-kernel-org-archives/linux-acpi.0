From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Re: D600 + S3 Sleep
Date: Wed, 23 Mar 2005 18:16:52 +0800
Message-ID: <1111573013.26351.65.camel@neuromancer.home.net>
References: <1111137292.23665.5.camel@neuromancer.home.net>
	 <20050318105425.GJ14600@project-bob.org>
	 <1111144388.23668.46.camel@neuromancer.home.net>
	 <20050318115313.GK14600@project-bob.org>
	 <20050318140556.GB18696@message-id.gmane0305.slipkontur.de>
	 <20050318160957.GL14600@project-bob.org>
	 <1111469595.27022.37.camel@neuromancer.home.net>
	 <20050322122150.GP14600@project-bob.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050322122150.GP14600-PWUXgD0Mw7gU45xQlXEPcg@public.gmane.org>
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

On Tue, 2005-03-22 at 12:21 +0000, Proinnsias Breathnach wrote:
> On Tue, Mar 22, 2005 at 01:33:15PM +0800, Ow Mun Heng wrote:
> > And Yes, Proinnsais, sadly the config you mentioned, I tried but it
> > doesn't work. It doesn't Come back up. POST for the video doesn't happen
> > for some reason for my config.
> > 
> > Gentoo/Linux on DELL D600 1.4Ghz 
> 
> For what it's worth - my D600 is running BIOS A14 and is a 1.6Ghz with
> the full centrino (ipw2200), Radeon M9 and 1400*1050 14" screen.

1.4Ghz centrino (ndiswrapper), Radeon M9 and 1400x1050

> 
> It's not a vanilla kernel, rather Ubuntu's current 2.6.10 which I
> believe contains the 2.6.11 acpi code.

I'm using suspend2-sources from gentoo. Basically it's 2.6.11 patched
with suspend2 and gensplash and a few fixes from 2.6.11.2 (IIRC)

> 
> Grub boots the kernel with only : root=/dev/hda2 ro vga=normal
> 
> What BIOS do you have - and indeed - what command-line are you using ?
Was A14, upgraded to A15 to see if it works.

root=/dev/hda3 video=vesafb:ywrap,mtrr,1280x1024-24@60
splash=verbose,theme:emergence resume2=swap:/dev/hda5

Orignially, then after you suggested only

root=/dev/hda3 vga=normal resume2=swap:/dev/hda5

> It's annoying to get going - but shouldn't take so much time - the
> laptop can remain in S3 suspend for 5 days or more easily.

Well.. it's annoying me now. 

-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 
98% Microsoft(tm) Free!! 
Neuromancer 18:14:55 up 2 days, 7:57, 7 users, load average: 0.73, 0.80,
0.74 




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
