From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Date: Tue, 9 Nov 2004 00:08:03 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC033@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


>On Mon, Nov 08, 2004 at 10:46:30PM +0800, Yu, Luming wrote:
>> >All we need is an acpi_get_gendev_handle that takes a=20
>struct device and
>> >returns the acpi_handle for it.  Now, maybe that'd be best=20
>> >done by placing
>> >a pointer in the struct device, but I bet it'd be just as=20
>good to walk
>> >the namespace looking for the corresponding device.
>>=20
>>   It will fail if you just simply walk namespace to find out=20
>> the corresponding acpi object, because there are NO
>> hardware id or compatible id  can be passed in.
>> Please check function acpi_bus_match.
>
>It doesn't need the HID or CID.  Look at Shaohua's patches --=20
>they don't
>use HID or CID either.
>
Yes, I made a mistake, please forget that point.

But another statement I made should be valid.
That is how to use geographical address to
locate corresponding acpi object.

For example,  ACPI define IDE as the following:

Device (IDE0){ /* primary controller */
	Name (_ADR, 0)
	Method (_GTM )
	...
	Device(PRIM) /* primary adapter */
		Name (_ADR, 0)
		Method(_GTM)
		...
		Device(MSTR) /* master channel */
			Name (_ADR,0)
			Method(_GTF)

  We need not only able to locate acpi object IDE0
but also we need to locate object PRIM underneath
IDE0,  and MSTR underneath PRIM. Thus, IDE driver=20
can fully take advantage from ACPI, in terms of=20
configuration and power management.

  Maybe we need to invent a method called
map_device_addr_to_acpi_handle to be  generic solution.

Thanks,
Luming


 =20





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
