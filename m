From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 16:42:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4126621B.3090701@optonline.net>
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
 <41265443.9050800@optonline.net> <200408202201.54083.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200408202201.54083.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan D=F6singer wrote:

>If I re-programm the IRQ to something else than IRQ10, the device do=
esn't=20
>resume too. So it's not only a problem of IRQ 11.
> =20
>
Seems like an anything-at-all-other-than-IRQ-10 problem. If the curre=
nt=20
thinking is right, your BIOS is assigning IRQ10 during boot, so movin=
g=20
it anywhere else is what causes problems.

But the current thinking doesn't quite seem right, because it seeems=
=20
like we're seeing these problems after the irqrouter is resumed. Can =
you=20
verify that with the attached patch? The patch should give us enough=
=20
information as long as you've got the proper kernel loglevel set.

Now, I wonder if the only reason it works when you set IRQ 10 is that=
=20
some other driver is unconditionally claiming the interrupt...

Nathan

>The ipw2100 driver calls pci_disable_device in it's suspend handler.=
 But I=20
>think the ipw2100 maintainers need help with suspend/resume because =
James=20
>Ketrenos can't test it on his own system.
> =20
>
pci_disable_device() only turns off bus-mastering, it doesn't unmap t=
he=20
I/O or disable the slot. Maybe we also need to set power state D3 and=
 do=20
a device-specific disable-interrupts, but I think D0 gets restored fo=
r=20
us pretty early during resume anyway...

Anyway, something doesn't quite add up...

Nathan



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
