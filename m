From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 16:43:31 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41266273.1010604@optonline.net>
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
 <41265443.9050800@optonline.net> <200408202201.54083.stefandoesinger@gmx.at>
 <4126621B.3090701@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_i6AeQqBxz3OkM//vh2es3w)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <4126621B.3090701-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_i6AeQqBxz3OkM//vh2es3w)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: QUOTED-PRINTABLE


Oops. Forgot the patch again. See attached.

Nathan Bryant wrote:

> Stefan D=F6singer wrote:
>
>> If I re-programm the IRQ to something else than IRQ10, the device=
=20
>> doesn't resume too. So it's not only a problem of IRQ 11.
>> =20
>>
> Seems like an anything-at-all-other-than-IRQ-10 problem. If the=
=20
> current thinking is right, your BIOS is assigning IRQ10 during boot=
,=20
> so moving it anywhere else is what causes problems.
>
> But the current thinking doesn't quite seem right, because it seeem=
s=20
> like we're seeing these problems after the irqrouter is resumed. Ca=
n=20
> you verify that with the attached patch? The patch should give us=
=20
> enough information as long as you've got the proper kernel loglevel=
 set.
>
> Now, I wonder if the only reason it works when you set IRQ 10 is th=
at=20
> some other driver is unconditionally claiming the interrupt...
>
> Nathan
>
>> The ipw2100 driver calls pci_disable_device in it's suspend handle=
r.=20
>> But I think the ipw2100 maintainers need help with suspend/resume=
=20
>> because James Ketrenos can't test it on his own system.
>> =20
>>
> pci_disable_device() only turns off bus-mastering, it doesn't unmap=
=20
> the I/O or disable the slot. Maybe we also need to set power state =
D3=20
> and do a device-specific disable-interrupts, but I think D0 gets=
=20
> restored for us pretty early during resume anyway...
>
> Anyway, something doesn't quite add up...
>
> Nathan
>



--Boundary_(ID_i6AeQqBxz3OkM//vh2es3w)
Content-type: text/x-patch; name=pci_linkdebug.patch
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: inline; filename=pci_linkdebug.patch

=3D=3D=3D=3D=3D drivers/acpi/pci_link.c 1.32 vs edited =3D=3D=3D=3D=
=3D
--- 1.32/drivers/acpi/pci_link.c=092004-08-18 19:26:48 -04:00
+++ edited/drivers/acpi/pci_link.c=092004-08-20 16:28:40 -04:00
@@ -717,6 +717,8 @@
=20
 =09ACPI_FUNCTION_TRACE("irqrouter_resume");
=20
+=09printk(KERN_DEBUG "irqrouter_resume: called.\n");
+
 =09list_for_each(node, &acpi_link.entries) {
=20
 =09=09link =3D list_entry(node, struct acpi_pci_link, node);


--Boundary_(ID_i6AeQqBxz3OkM//vh2es3w)--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
