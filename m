From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 16:58:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03860E23@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

On Tuesday, August 10, 2004 4:38 PM Borislav Deianov wrote:
>To: Li, Shaohua
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] ibm-acpi-0.1
>
>On Tue, Aug 10, 2004 at 04:24:39PM +0800, Li, Shaohua wrote:
>>
>> IBM hotkey has a unique ID. In T40, it's 'IBM0068'. I guess other
>> IBM laptops also use it. Using a hardcode path in the patch possibly
>> isn't a good idea.
>
>Agreed. I was originally using acpi_bus_register_driver() and refering
>to devices by HID but that turned out to not work very well
I guess only supporting hotkey is ok in the file. If you want to support
docking station, use a new file.

>dock (ACPI drops it if it's not present at boot) and embedded
Actually supporting dock station isn't just executing _EJ0 and _DCK, you
possibly need to scan the new PCI devices under the dock station.=20

>controller (the ec driver has already grabbed it). So I switched to
>looking things up by the path. I see your point, though, I'll see what
>I can do.
>
>> BTW, I'm interested in how can you know the meaning of 'DHKC',
>> 'MHKC' and etc. They are non-standard ACPI methods.
>
>Guesswork from the disassembled DSDT and trial and error...
Great job!

Thanks,
Shaohua
>
>Regards,
>Boris


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
