From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 05 Feb 2004 17:13:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40226BA8.8040703@basmevissen.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB9@hdsmsx402.hd.intel.com> <1075995857.5758.43.camel@tinny.home.foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1075995857.5758.43.camel-3lu5YwujmwObGSPjaX/RoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Scott T. Smith wrote:
> 
>>Linux users should buy machines from OEMs that support Linux,
>>and not buy machines from OEMs that ignore Linux.  There are
>>OEMS that validate their platforms with Linux today -- this isn't
>>3-5 years away.
> 
> 
> That argument simply doesn't work for laptops (which seems to me to be
> the main driving force behind ACPI, but I recognize ACPI is useful for
> desktops too).  There are too many reasons to pick one machine over
> another, including weight, size, price/performance, screen quality
> (size/resolution), keyboard quality/layout/size, touchpad vs nipple,

I prefer the latter being called "Janet" from now on :-))

> etc.  In the end, it's a compromise of course, so it'd be nice if there
> was one less constraint on my purchasing decision (i.e. ACPI).
> 

The availibility of a fixed DSDT might help. At least you get a working 
notebook to write e-mails to the supplier that they should fix their DSDT.

I'm wondering if it is possible to overload the DSDT for Windows. Think 
of a hack in grub to pre-load another DSDT in RAM.

BIOS are compressed, so they need to be extracted to RAM. So changing it 
(eventualy only changing the pointer to a different location) should be 
possible.

Why would we need it? Simply to check a DSDT on Windows before 
submitting it to the manufacturer. That can ease acceptance of a DSDT-patch.

Regards,

Bas.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
