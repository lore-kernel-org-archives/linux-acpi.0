From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: sysdev suspend/resume order?
Date: Sat, 14 Aug 2004 13:05:55 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F038F80A7@pdsmsx401.ccr.corp.intel.com>
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
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The problem is nearly all sysdev use device_initcall to register their
sysfs structure (and the resume/suspend functions). This cause the
sysdev' suspend/resume order is random.=20

Thanks,
Shaohua

>-----Original Message-----
>From: Pallipadi, Venkatesh
>Sent: Saturday, August 14, 2004 2:58 AM
>To: Li, Shaohua; 'Patrick Mochel'
>Cc: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'; Brown, Len
>Subject: RE: sysdev suspend/resume order?
>
>
>
>I think, there should be a relation between the order
>in which actual device initialization happens during
>the boot time and the order in which device initcalls
>are called (at boot time).
>
>In this example, actual PIC initialization happens
>before pci_link device initialization. So, device
>initcall should have a similar ordering. That will
>take care of this after S3 ordering in a natural manner.
>
>Thanks,
>Venki
>
>>-----Original Message-----
>>From: Li, Shaohua
>>Sent: Friday, August 13, 2004 12:37 AM
>>To: Patrick Mochel
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Pallipadi, Venkatesh
>>Subject: sysdev suspend/resume order?
>>
>>Patrick,
>>My sound card dies after S3 sometimes. Basically, if it dies
>>depends on the order of sysdev's resume. If IRQ router resume
>>before PIC (I use a tricky method to change order. It's
>>changing the initcall level of the sysfs initialization for
>>the device), the sound card die. Otherwise, it works. Is it
>>possible that we add some levels for sysdev? I'd like some
>>sysdevs resume before other sysdevs. Does this make sense?
>>
>>Thanks,
>>Shaohua
>>


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
