From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/4] properly create kobjects in acpi/scan.c
Date: Tue, 24 Aug 2004 14:45:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <44BDAFB888F59F408FAE3CC35AB47041A3B61B@orsmsx409>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
>> Btw, why don't we just convert ACPI to be standard driver core bus=20
>> with standard drivers and devices? I could cook up something... The=20
>> /sys/firmware/acpi hierarchy is not populated with any=20
>useful data yet=20
>> so there should be no concern of breakign userspace interface (I am=20
>> mot talking about removing /proc/acpi part at the moment).
>
>Funny you should mention it.
>
>My current opinion is that /sys/firmware/acpi should probably=20
>not exist at all, and that there should be a single=20
>/sys/devices including both ACPI-enumerated and pci-enumerated=20
>devices.  Adam and I have been ganging up on Patrick on this,=20
>but we don't have him convinced yet...
>
For my hotplug work I am currently banking on
/sys/firmware/acpi/namespace/ACPI
 to find the all the children devices and from there to find the
corresponding logical
 devices. Once I find the all child devices then the scripts would turn
online or offline of all the child devices.

If we are proposing to eliminate /sys/firmware/acpi can anyone pass a
pointer to the above discussion.

Thanks,
Anil Keshavamurthy
=09


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
