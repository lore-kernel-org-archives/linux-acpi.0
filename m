From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Thu, 2 Sep 2004 16:30:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040902143034.GA676@elf.ucw.cz>
References: <1093972503.9372.38.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1093972503.9372.38.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Cc: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> 	Lo and Behold, I managed to get S3 to work on my laptop by following
> instructions on this website.
> 
> http://www.loria.fr/~thome/d600/
> 
> However, I've not tested it further(as in using the normal kernel boot
> up line in grub.conf) to verify if it is the same whether or not I use
> video=radeonfb.
> 
> I'm getting these errors during Suspend to disk.
> 
> Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 600000, is 1400000 kHz.
> Debug: sleeping function called from invalid context at mm/slab.c:1989
> in_atomic():1, irqs_disabled():0

Turn off CONFIG_PREEMPT. Or better test latest -rcX-mmX.
										Pavel
-- 
When do you have heart between your knees?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
