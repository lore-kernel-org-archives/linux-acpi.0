From: "Manpreet Singh" <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Subject: RE: Spurious ACPI interrupts on 2.6.4
Date: Wed, 17 Mar 2004 11:46:53 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EB6B0A91B0F6AC44842492A8F6852CDE0C44FD@fcexmb01.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: YhLu  <YhLu-NmV4wUZxxR8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I tried using a PS2 keyboard instead of the USB keyboard I was using =
earlier,
but the interrupts are still present.

Thanks,
Manpreet.


-----Original Message-----
From: YhLu
To: Manpreet Singh; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Sent: 3/16/2004 10:35 PM
Subject: ??: [ACPI] Spurious ACPI interrupts on 2.6.4

You can disabled usb device from BIOS setup and check again.

-----????-----
???: Manpreet Singh [mailto:Manpreet.Singh-IrU4XInhIXM@public.gmane.org]=20
????: 2004?3?16? 15:05
???: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
??: [ACPI] Spurious ACPI interrupts on 2.6.4

Hi,

I am booting Linux kernel 2.6.4 on the Tyan S2098 motherboard (Intel
845GL
chipset). The system boots up a lot slower with ACPI enabled. It turns
out
that there are continuous spurious ACPI interrupts that cause this.

I would appreciate if someone has an insight to share on this issue.

Here is what /proc/interrupts look like after a few mins after boot-up:

           CPU0      =20
  0:    1340869          XT-PIC  timer
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ehci_hcd
  9:    1916095          XT-PIC  acpi, uhci_hcd
 11:          0          XT-PIC  uhci_hcd
 12:       3278          XT-PIC  uhci_hcd
 14:        918          XT-PIC  ide0
NMI:          0=20
ERR:          0

The only USB device is a USB keyboard. But I don't think all of these
interrupts are because of that.

Thanks,
Manpreet.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
