From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: ACPI I/O resource conflicts with ACPI region SMBI
Date: Mon, 2 Jan 2012 10:14:30 -0800
Message-ID: <20120102181430.GA8562@xanatos>
References: <CA+7wUszDweffRXgBQz0Mzv74Bk+OAVcdduAHLi_tB5EwJidoJA@mail.gmail.com>
 <20111216102758.GD5974@elie.hsd1.il.comcast.net>
 <CA+7wUsxRg52yC+wu7uO-YChPEbQ3vaYWG6F7ee=iPx8YX7omWQ@mail.gmail.com>
 <20111222195243.GB18208@xanatos>
 <CA+7wUswZph6iOKVZS5y9S-LPf72ToYPrG6ExXawhqQs_1KM5DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57756 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab2ABSOc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jan 2012 13:14:32 -0500
Content-Disposition: inline
In-Reply-To: <CA+7wUswZph6iOKVZS5y9S-LPf72ToYPrG6ExXawhqQs_1KM5DQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 644174@bugs.debian.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Dec 28, 2011 at 06:11:14PM +0100, Mathieu Malaterre wrote:
> On Thu, Dec 22, 2011 at 8:52 PM, Sarah Sharp
> <sarah.a.sharp@linux.intel.com> wrote:
> > On Thu, Dec 22, 2011 at 04:18:56PM +0100, Mathieu Malaterre wrote:
> >> On Fri, Dec 16, 2011 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.=
com> wrote:
> >> System: Dell System Vostro 3750 / Portable Computer
> >>
> >> Ok. So I am running: 3.2.0-rc4-amd64 from debian experimental.
> >>
> >> No mouse plugged to USB 2.0/3.0 interface: boot is fine
> >> Mouse plugged to USB 2.0 interface: boot is fine
> >> Mouse plugged to USB 3.0 interface: boot simply stops
> >
> > Does the boot stop when you have a non-HID USB device plugged into =
the
> > USB 3.0 port (e.g. hub or flash drive or USB speaker)? =A0It could =
be an
> > issue with a buggy BIOS trying to use the mouse and keyboard (HID
> > devices) attached to the USB 3.0 host. =A0Perhaps it changes the AC=
PI
> > tables when it tries to use the USB 3.0 host controller, and
> > accidentally overlaps the regions? =A0But if your keyboard and mous=
e were
> > under USB 2.0, maybe it will only map in the USB 2.0 host controlle=
r.
>=20
> I tried booting kernel 3.0.2 (debian/unstable 3.2.0-rc4-amd64) with a
> USB key plugged into USB 3.0 and was stuck again. So I can confirm
> that with a normal USB key (non-HID) plugged in USB 3.0 port, makes
> the kernel refuse to boot.

Please try a USB hub as well.  It's possible the BIOS is trying to read
from the flash drive (which is what I assume you mean by USB key).

> >> As suggested by Jonathan N. [1] here is what I did next:
> >>
> >> $ cat /etc/modprobe.d/mm-blacklist-xhci.conf
> >> blacklist xhci_hcd
> >> $ update-initramfs -u -k all
> >> $ sudo reboot
> >
> > Were you blacklisting xhci only because of the "xhci_hcd 0000:03:00=
=2E0:
> > WARN: Stalled endpoint" messages? =A0Because those messages are har=
mless,
> > and don't mean anything is *wrong* with the host controller.
>=20
> I simply blindly follow the suggestion.

Yeah, don't try to blacklist xhci-hcd.  It's not useful.

> > Even if there's no xHCI driver loaded, it seems that ACPI is notici=
ng
> > the conflict between the PCI registers and another region. =A0So un=
loading
> > the xHCI driver won't help your system boot. =A0You'd need to get a=
 fix
> > into the ACPI subsystem to work around the conflict. =A0I don't thi=
nk any
> > xHCI driver modification can help here.
>=20
> Is there a way to check if bug is related to ACPI or rather USB 3.0 ?

The log messages seem to indicate that it's either an ACPI or a BIOS
issue.  I really can't suggest any other tests without some input from
the ACPI folks.  The best solution I can suggest is not boot with a USB
device plugged into your USB 3.0 port.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
