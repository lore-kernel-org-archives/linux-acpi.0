From: Michael Dreher <dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: 2.5.58 hangs at boot
Date: Fri, 17 Jan 2003 22:17:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301172217.47624.dreher@math.tu-freiberg.de>
References: <F760B14C9561B941B89469F59BA3A847137F7E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847137F7E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 17. Januar 2003 21:51 schrieb Grover, Andrew:
> (CC-ing acpi-devel, hope that's OK.)
>
> > From: Michael Dreher [mailto:dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org]
> >
> > > So...if you take the printks out, does it stop booting again? ;-)
> >
> > I try now with 2.5.59. By the way, you are aware of a (small) thread
> > in lkml with subject "usb broken in 2.5?" some days ago. Greg
> > said that
> > nonworking usb may be due to interrupt routing problems of acpi.
> > I had such problems: sometimes my smartmedia reader came up
> > during boot,
> > sometimes not.
>
> Does /proc/interrupts show anything different for the USB device ACPI
> vs non-ACPI?

You mean switch off acpi from kernel command line ? Or compiling it out ?

This is with acpi:

karpfen:/tmp # cat /proc/interrupts
           CPU0
  0:     813890          XT-PIC  timer
  1:       1885          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       3968          XT-PIC  uhci-hcd, VIA8233
  7:       1895          XT-PIC  ehci-hcd, uhci-hcd, uhci-hcd
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       5598          XT-PIC  uhci-hcd, eth0
 12:      30059          XT-PIC  i8042
 14:      14842          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0
LOC:     813876
ERR:        156
MIS:          0






-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
