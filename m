From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Re: ACPI I/O resource conflicts with ACPI region SMBI
Date: Wed, 28 Dec 2011 18:11:14 +0100
Message-ID: <CA+7wUswZph6iOKVZS5y9S-LPf72ToYPrG6ExXawhqQs_1KM5DQ@mail.gmail.com>
References: <CA+7wUszDweffRXgBQz0Mzv74Bk+OAVcdduAHLi_tB5EwJidoJA@mail.gmail.com>
 <20111216102758.GD5974@elie.hsd1.il.comcast.net> <CA+7wUsxRg52yC+wu7uO-YChPEbQ3vaYWG6F7ee=iPx8YX7omWQ@mail.gmail.com>
 <20111222195243.GB18208@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55358 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab1L1RLg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Dec 2011 12:11:36 -0500
In-Reply-To: <20111222195243.GB18208@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 644174@bugs.debian.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Dec 22, 2011 at 8:52 PM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Thu, Dec 22, 2011 at 04:18:56PM +0100, Mathieu Malaterre wrote:
>> On Fri, Dec 16, 2011 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>> > =A0- Please test a v3.2 release candidate from experimental. =A0Th=
e only
>> > =A0 packages from outside squeeze that should be needed for this, =
aside
>> > =A0 from the kernel image itself, are linux-base and initramfs-too=
ls.
>> >
>> > =A0- If it reproduces the problem, please blacklist the xhci_hcd
>> > =A0 module by writing
>> >
>> > =A0 =A0 =A0 =A0blacklist xhci_hcd
>> >
>> > =A0 to a file /etc/modprobe.d/mm-blacklist-xhci.conf, run
>> >
>> > =A0 =A0 =A0 =A0update-initramfs -u -k all
>> >
>> > =A0 and reboot to try again without USB 3.0 support. =A0If we're v=
ery
>> > =A0 lucky, this will work around the problem. =A0In that case, ple=
ase
>> > =A0 write a summary of the problem to upstream
>> > =A0 (linux-usb@vger.kernel.org, cc-ing Sarah Sharp
>> > =A0 <sarah.a.sharp@linux.intel.com> and either me or this bug log =
so we
>> > =A0 can track the resulting discussion). =A0Be sure to include:
>> >
>> > =A0 =A0- steps to reproduce the problem
>> > =A0 =A0- symptoms, and how they differ from what you expected
>> > =A0 =A0- ways to avoid triggering the problem (maybe some USB port=
s
>> > =A0 =A0 =A0trigger it and others don't? etc)
>> > =A0 =A0- full "dmesg" output from booting, and a photo of the scre=
en
>> > =A0 =A0 =A0after reproducing the problem (ideally by running "modp=
robe
>> > =A0 =A0 =A0xhci_hcd" in the very same run of Linux), as attachment=
s
>> > =A0 =A0- which kernel versions you've tested, and what happened wi=
th each
>> > =A0 =A0- a link to this bug log for the full story
>> > =A0 =A0- any other weird symptoms or observations
>>
>> System: Dell System Vostro 3750 / Portable Computer
>>
>> Ok. So I am running: 3.2.0-rc4-amd64 from debian experimental.
>>
>> No mouse plugged to USB 2.0/3.0 interface: boot is fine
>> Mouse plugged to USB 2.0 interface: boot is fine
>> Mouse plugged to USB 3.0 interface: boot simply stops
>
> Does the boot stop when you have a non-HID USB device plugged into th=
e
> USB 3.0 port (e.g. hub or flash drive or USB speaker)? =A0It could be=
 an
> issue with a buggy BIOS trying to use the mouse and keyboard (HID
> devices) attached to the USB 3.0 host. =A0Perhaps it changes the ACPI
> tables when it tries to use the USB 3.0 host controller, and
> accidentally overlaps the regions? =A0But if your keyboard and mouse =
were
> under USB 2.0, maybe it will only map in the USB 2.0 host controller.

I tried booting kernel 3.0.2 (debian/unstable 3.2.0-rc4-amd64) with a
USB key plugged into USB 3.0 and was stuck again. So I can confirm
that with a normal USB key (non-HID) plugged in USB 3.0 port, makes
the kernel refuse to boot.

After a normal boot, key appears as :
[  158.736727] usb 3-2: new high-speed USB device number 2 using xhci_h=
cd
[  158.755680] xhci_hcd 0000:03:00.0: WARN: short transfer on control e=
p
[  158.756522] xhci_hcd 0000:03:00.0: WARN: short transfer on control e=
p
[  158.757426] xhci_hcd 0000:03:00.0: WARN: short transfer on control e=
p
[  158.758299] xhci_hcd 0000:03:00.0: WARN: short transfer on control e=
p
[  158.758698] usb 3-2: New USB device found, idVendor=3D0951, idProduc=
t=3D160f
[  158.758708] usb 3-2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D3
[  158.758714] usb 3-2: Product: DT Mini Slim
[  158.758719] usb 3-2: Manufacturer: Kingston
[  158.758723] usb 3-2: SerialNumber: 0019E06B07B5F9A1879A0D15
[  158.760294] scsi7 : usb-storage 3-2:1.0
[  159.760670] scsi 7:0:0:0: Direct-Access     Kingston DT Mini Slim
  1.00 PQ: 0 ANSI: 2
[  159.763089] sd 7:0:0:0: Attached scsi generic sg2 type 0
[  159.763655] sd 7:0:0:0: [sdb] 15654848 512-byte logical blocks:
(8.01 GB/7.46 GiB)
[  159.763834] sd 7:0:0:0: [sdb] Write Protect is off
[  159.763841] sd 7:0:0:0: [sdb] Mode Sense: 16 0f 09 51
[  159.764012] sd 7:0:0:0: [sdb] Incomplete mode parameter data
[  159.764019] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[  159.765193] sd 7:0:0:0: [sdb] Incomplete mode parameter data
[  159.765200] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[  159.765778]  sdb: sdb1
[  159.766855] sd 7:0:0:0: [sdb] Incomplete mode parameter data
[  159.766865] sd 7:0:0:0: [sdb] Assuming drive cache: write through
[  159.766875] sd 7:0:0:0: [sdb] Attached SCSI removable disk


>> As suggested by Jonathan N. [1] here is what I did next:
>>
>> $ cat /etc/modprobe.d/mm-blacklist-xhci.conf
>> blacklist xhci_hcd
>> $ update-initramfs -u -k all
>> $ sudo reboot
>
> Were you blacklisting xhci only because of the "xhci_hcd 0000:03:00.0=
:
> WARN: Stalled endpoint" messages? =A0Because those messages are harml=
ess,
> and don't mean anything is *wrong* with the host controller.

I simply blindly follow the suggestion.

> Even if there's no xHCI driver loaded, it seems that ACPI is noticing
> the conflict between the PCI registers and another region. =A0So unlo=
ading
> the xHCI driver won't help your system boot. =A0You'd need to get a f=
ix
> into the ACPI subsystem to work around the conflict. =A0I don't think=
 any
> xHCI driver modification can help here.

Is there a way to check if bug is related to ACPI or rather USB 3.0 ?

Thanks again,
--=20
Mathieu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
