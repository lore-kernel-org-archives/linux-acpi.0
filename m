From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC, PATCH] sysdev suspend/resume order?
Date: Mon, 16 Aug 2004 13:17:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB60029C6914@scsmsx403.amr.corp.intel.com>
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
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Nathan Bryant [mailto:nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org]=20
>Sent: Monday, August 16, 2004 12:40 PM
>To: Nathan Bryant
>Cc: Pallipadi, Venkatesh; Li, Shaohua; Patrick Mochel; Pavel=20
>Machek; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len
>Subject: Re: [ACPI] [RFC, PATCH] sysdev suspend/resume order?
>
>Nathan Bryant wrote:
>> Pallipadi, Venkatesh wrote:
>>=20
>>> =20
>>> Problem:
>>> Most of the sysdev_register calls in various devices
>>> are being done using device_initcalls. This method of=20
>initialization=20
>>> has a side-effect, as we loose the ordering requirements=20
>for various=20
>>> resume calls. Order in which _resume() functions gets=20
>called during a=20
>>> resume, just depends on the order device_initcalls were called on=20
>>> these devices.
>>>
>>> Shaohua's mail below describes one issue that is a result of this=20
>>> problem, where in pci link device get initialized before PIC. There=20
>>> can be more issues like this.
>>=20
>>=20
>> Actually, the PCI links are initialized from a=20
>subsys_initcall, which is=20
>> not to be confused with a device_initcall, and anyway the PCI links=20
>> don't have their own suspend/resume callbacks unless you're using a=20
>> specific patch that I posted.
>
>Ok, I take that back. Looks like my patch was merged to=20
>mainline. Well I=20
>suppose I can help restructure that. As I mentioned a week or=20
>two ago in=20
>a separate thread, I think it may be a good idea to control these=20
>init-order issues by combining these IRQrouting-related sys_device=20
>drivers into a single logical driver, then you handle the ordering=20
>issues within the driver. I'd like to get some feedback on=20
>that idea. If=20
>Shaohua can tell me precisely what order he wants to see, that=20
>would help.

I think the basic resume ordering should be=20
- APIC (if enabled)
- IOAPIC (or PIC)
- Link device
- All drivers

I somehow feel doing it in a single driver may increase the complexity
of this whole thing. Especially with various APIC/IOAPIC configs and=20
boot time parameters.

Thanks,
Venki



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
