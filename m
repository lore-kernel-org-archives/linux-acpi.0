From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: Trackpoint (psmouse) dead after suspend/resume (S3)
Date: Wed, 11 Aug 2004 16:06:17 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <411A7C39.3050707@optonline.net>
References: <yzollhfbou5.fsf@localhost.localdomain> <20040811131848.GA1120@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040811131848.GA1120-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, vojtech-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>2.5.xx: keyboard and trackpoint dead, reloading psaux module fixes both
>>2.6.4: both devices work, no reloading necessary
>>2.6.7: keyboard works, trackpoint dead, reloading psmouse doesn't help
>>
>>I've poked around a bit and it seems that all writes to the AUX-port
>>times out, this causes the psmouse to disconnect.
>>
>>Any suggestions appreciated, Ole
> 
> 
> See if psmouse.proto=bare helps?

maybe also i8042.reset?

Ole, is it losing interrupts or is it completely dead? I know that serio 
only has knowledge of the generic i8042 device; in most cases it doesn't 
know a lot about initializing multi-function controller chips, such as 
the Winbond. The Winbond documentation is a little obscure on this 
subject - OK, a lot obscure - depending on which chip docs you look at, 
it only lists the register maps and doesn't describe the I/O port 
accesses needed to set the registers. However, if you look at 
parport_pc.c, you can see how to access the registers.

In any case, psmouse is just a shim between input and serio, not the 
driver itself, so as you have seen, reloading it doesn't help in most cases.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
