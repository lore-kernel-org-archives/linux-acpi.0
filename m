From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 12:00:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: stefandoesinger-RbZlAiThDcE@public.gmane.org, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org




>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Stefan D=F6singer
>Sent: Friday, August 20, 2004 9:36 AM
>To: Nathan Bryant
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Linux Kernel=20
>list; Li, Shaohua
>Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
>> Stefan -
>>
>> Also - did suspend/resume for the ipw2100 ever work under any kernel
>> version?
>Yes, it works with acpi=3Dnoirq at least up to 2.6.7(not tested=20
>with later=20
>versions, but I'm sure it does)
>It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and a=20
>modified dsdt which forces LNKE to IRQ 10. I attached a dmesg=20
>output of a=20
>successful resume.
>
>Cheers,
>Stefan

This seems to be the same resume order issue, that Shaohua is hitting.

On my system the resume order looks like this:
Resuming System Devices
Resuming type 'cpu':
 cpu0
aux driver resume 0xc010e410 (mtrr_restore)
aux driver resume 0xc03365f0 (cpufreq_resume)
Resuming type 'i8259':
 i82590
Resuming type 'timer':
 timer0
Resuming type 'pit':
 pit0
Resuming type 'lapic':
 lapic0
Resuming type 'irqrouter':
 irqrouter0
Resuming type 'i8042':
 i80420

The current theory I have for this issue is we resume pci_link driver
A bit too late, which is causing this problem.

Say a particular device doesn't do anything for suspend and resume.
So, as soon as we resume this particular device can start =20
generating interrupts. Once we have PIC enabled, it starts sending=20
interrupts and no one handles that original IRQ. As pci_link that=20
resumes later is reprogramming the device to different IRQ, where the=20
driver is handling the device.

That's probably the reason why it works with acpi=3Dnoirq or=20
modified DSDT. Does it make sense?

I think we have to resume pci_link device before PIC.=20
We should be able to achieve this my changing the makefile orders.

Thanks,
Venki
=20


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
