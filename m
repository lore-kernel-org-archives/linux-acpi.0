From: Takanori Watanabe <takawata-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 18:19:20 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408100919.SAA19847@axe-inc.co.jp>
References: <20040810083807.GF28939@aero.ensim.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Tue, 10 Aug 2004 01:38:07 MST."
             <20040810083807.GF28939-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <20040810083807.GF28939-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>, Borislav Deianov wrote:
>On Tue, Aug 10, 2004 at 04:24:39PM +0800, Li, Shaohua wrote:
>>
>> IBM hotkey has a unique ID. In T40, it's 'IBM0068'. I guess other
>> IBM laptops also use it. Using a hardcode path in the patch possibly
>> isn't a good idea.
>
>Agreed. I was originally using acpi_bus_register_driver() and refering
>to devices by HID but that turned out to not work very well for the
>dock (ACPI drops it if it's not present at boot) and embedded
>controller (the ec driver has already grabbed it). So I switched to
>looking things up by the path. I see your point, though, I'll see what
>I can do.

Probably this may unable to work on other Thinkpads.
I have X31 and i1620, and there are some incompatibility on 
AML between two.
Generic notify events Bus check, Device Wake, Eject request,
may have to be caught by enumrator.

>> BTW, I'm interested in how can you know the meaning of 'DHKC',
>> 'MHKC' and etc. They are non-standard ACPI methods.
>
>Guesswork from the disassembled DSDT and trial and error...

I wrote such driver for FreeBSD (though I don't implement
docking station).

http://www.init-main.com/acpi_tpkey/



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
