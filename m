From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: ACPI I/O resource conflicts with ACPI region SMBI
Date: Thu, 22 Dec 2011 11:52:43 -0800
Message-ID: <20111222195243.GB18208@xanatos>
References: <CA+7wUszDweffRXgBQz0Mzv74Bk+OAVcdduAHLi_tB5EwJidoJA@mail.gmail.com>
 <20111216102758.GD5974@elie.hsd1.il.comcast.net>
 <CA+7wUsxRg52yC+wu7uO-YChPEbQ3vaYWG6F7ee=iPx8YX7omWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59081 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947Ab1LVTws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Dec 2011 14:52:48 -0500
Content-Disposition: inline
In-Reply-To: <CA+7wUsxRg52yC+wu7uO-YChPEbQ3vaYWG6F7ee=iPx8YX7omWQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 644174@bugs.debian.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Dec 22, 2011 at 04:18:56PM +0100, Mathieu Malaterre wrote:
> On Fri, Dec 16, 2011 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
> > =A0- Please test a v3.2 release candidate from experimental. =A0The=
 only
> > =A0 packages from outside squeeze that should be needed for this, a=
side
> > =A0 from the kernel image itself, are linux-base and initramfs-tool=
s.
> >
> > =A0- If it reproduces the problem, please blacklist the xhci_hcd
> > =A0 module by writing
> >
> > =A0 =A0 =A0 =A0blacklist xhci_hcd
> >
> > =A0 to a file /etc/modprobe.d/mm-blacklist-xhci.conf, run
> >
> > =A0 =A0 =A0 =A0update-initramfs -u -k all
> >
> > =A0 and reboot to try again without USB 3.0 support. =A0If we're ve=
ry
> > =A0 lucky, this will work around the problem. =A0In that case, plea=
se
> > =A0 write a summary of the problem to upstream
> > =A0 (linux-usb@vger.kernel.org, cc-ing Sarah Sharp
> > =A0 <sarah.a.sharp@linux.intel.com> and either me or this bug log s=
o we
> > =A0 can track the resulting discussion). =A0Be sure to include:
> >
> > =A0 =A0- steps to reproduce the problem
> > =A0 =A0- symptoms, and how they differ from what you expected
> > =A0 =A0- ways to avoid triggering the problem (maybe some USB ports
> > =A0 =A0 =A0trigger it and others don't? etc)
> > =A0 =A0- full "dmesg" output from booting, and a photo of the scree=
n
> > =A0 =A0 =A0after reproducing the problem (ideally by running "modpr=
obe
> > =A0 =A0 =A0xhci_hcd" in the very same run of Linux), as attachments
> > =A0 =A0- which kernel versions you've tested, and what happened wit=
h each
> > =A0 =A0- a link to this bug log for the full story
> > =A0 =A0- any other weird symptoms or observations
>=20
> System: Dell System Vostro 3750 / Portable Computer
>=20
> Ok. So I am running: 3.2.0-rc4-amd64 from debian experimental.
>=20
> No mouse plugged to USB 2.0/3.0 interface: boot is fine
> Mouse plugged to USB 2.0 interface: boot is fine
> Mouse plugged to USB 3.0 interface: boot simply stops

Does the boot stop when you have a non-HID USB device plugged into the
USB 3.0 port (e.g. hub or flash drive or USB speaker)?  It could be an
issue with a buggy BIOS trying to use the mouse and keyboard (HID
devices) attached to the USB 3.0 host.  Perhaps it changes the ACPI
tables when it tries to use the USB 3.0 host controller, and
accidentally overlaps the regions?  But if your keyboard and mouse were
under USB 2.0, maybe it will only map in the USB 2.0 host controller.

> As suggested by Jonathan N. [1] here is what I did next:
>=20
> $ cat /etc/modprobe.d/mm-blacklist-xhci.conf
> blacklist xhci_hcd
> $ update-initramfs -u -k all
> $ sudo reboot

Were you blacklisting xhci only because of the "xhci_hcd 0000:03:00.0:
WARN: Stalled endpoint" messages?  Because those messages are harmless,
and don't mean anything is *wrong* with the host controller.

Even if there's no xHCI driver loaded, it seems that ACPI is noticing
the conflict between the PCI registers and another region.  So unloadin=
g
the xHCI driver won't help your system boot.  You'd need to get a fix
into the ACPI subsystem to work around the conflict.  I don't think any
xHCI driver modification can help here.

> 3.2.0-rc4-amd64 refuse to boot as soon as I plug my mouse to USB 3.0
> port (screenshot at [2]). USB 2.0 and no mouse still boot fine.
>=20
> I am attaching dmesg from a kernel boot, when mouse is attached to US=
B
> 2.0 port (see [3]).
>=20
> I think I'll revert to 2.6.39-bpo.2-amd64 because kernel does not
> seems to like my video card. When I suspend/resume, screen is
> displayed on screen Ctrl+Shift+F8, while pointer stays on
> Ctrl+Shift+F7. I can type fine from Ctrl+Shift+F7, since I can see
> results on Ctrl+Shift+F8. I'll try to compile the nvidia kernel and
> see if suspend/resume works.
>=20
>=20
> Refs:
> [1] http://bugs.debian.org/644174
> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D644174#64
> [3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D644174#69

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
