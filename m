From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Trackpoint (psmouse) dead after suspend/resume (S3)
Date: 12 Aug 2004 07:13:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzo657pym5b.fsf@pb-d-128-141-40-148.cern.ch>
References: <yzollhfbou5.fsf@localhost.localdomain>
	<20040811131848.GA1120@openzaurus.ucw.cz>
	<411A7C39.3050707@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <411A7C39.3050707-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, vojtech-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ole> 2.5.xx: keyboard and trackpoint dead, reloading psaux module fixes both
Ole> 2.6.4: both devices work, no reloading necessary
Ole> 2.6.7: keyboard works, trackpoint dead, reloading psmouse doesn't help

Pavel> See if psmouse.proto=bare helps?

Nathan> maybe also i8042.reset?

I had concluded that the track-point hardware was in fact not powered
up and I was able to work around the problem by telling BIOS I'm
running some Windows. This makes the S3 resume sequence take notably
longer - it used to wake up almost promptly but now it spends a few
seconds flashing various symbols ("LEDs") before it comes back to C.

Strangely, it seems that I have to use a custom DSDT where I
explicitly initialize "Name (TOSS, 0x01)", I'm not able to achieve the
same effect by means of acpi_osi.

Strangely as well, 2.6.4 worked (and had the "long" resume
sequence) with the stock DSDT.

Thanks, Ole


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
