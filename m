From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: power-off on boot
Date: Mon, 9 Aug 2004 16:04:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040809140438.GB1792@openzaurus.ucw.cz>
References: <1090129494.5124.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1090129494.5124.23.camel@localhost>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Cc: ACPI-Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have an "interesting" behavior with 2.6.6 and 2.6.7, and I was
> wondering if this list would mind helping me figure out what's causing
> it. 
> 
> Basically, the machine turns off while it's booting. It doesn't get far
> enough to mount any filesystems, so there aren't any logs. On a hunch, I
> turned on ACPI-debugging, and noticed that the kernel immediately begins
> spewing warnings about a critical trap (that's from memory, I can't be
> completely sure if that's literally the string), and that the CPU is
> over 120 degrees C. Now, I'm actually *underclocking* my CPU because I
> have very bad luck with hardware, and I happen to know that the
> temperature never goes above 38 degrees C (according to my BIOS and the
> hardware meter glued to the heat sync). 

Try compiling thermal.ko as a module, then ldebug what went wrong.



-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
