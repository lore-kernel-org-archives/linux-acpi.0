From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Fri, 11 Mar 2011 23:00:08 +0100
Message-ID: <201103112300.09291.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D7B2E010200002300029B57@novprvlin0050.provo.novell.com> <201103112234.42885.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48189 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab1CKWAO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2011 17:00:14 -0500
In-Reply-To: <201103112234.42885.oldium.pro@seznam.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: Al Cho <ACho@novell.com>, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Friday 11 March 2011 22:34:42 Old=C5=99ich Jedli=C4=8Dka wrote:
> Hi Joey Lee,
>=20
> On Friday 11 March 2011 22:25:37 Joey Lee wrote:
> > Hi Old=C5=99ich,
> >=20
> > =E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 21:54 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi again,
> > >=20
> > > On Friday 11 March 2011 21:34:24 Joey Lee wrote:
> > > > =E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 21:21 +0100=EF=
=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > Hi Joey Lee,
> > > > >=20
> > > > > On Thursday 10 March 2011 23:02:27 Joey Lee wrote:
> > > > > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-10 =E6=96=BC 19:37 +010=
0=EF=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > > >=20
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > This is about Acer WMI driver and bluetooth support. I ho=
pe I'm
> > > > > > > at the right place with my question :-)
> > > > > > >=20
> > > > > > > I tried to use bluetooth again on my Acer TravelMate 5730=
G and
> > > > > > > discovered a usability problem. I've checked 2.6.38-rc7:
> > > > > > >=20
> > > > > > > 0. On startup, the bluetooth LED is off, acer-bluetooth S=
W
> > > > > > > rfkill is blocked.
> > > > > >=20
> > > > > > Yes, this is right behavior.
> > > > > >=20
> > > > > > Because have a acer-wmi patch in 2.6.38 to sync the connect=
ion
> > > > > > devices (wlan, bluetooth, 3G) status with BIOS.
> > > > > > Acer BIOS fills-in the device initial states in SMBIOS when
> > > > > > system boot, then acer-wmi dirver sync this states with
> > > > > > killswitch. By default, Acer BIOS set the bluetooth to off.
> > > > > >=20
> > > > > > > 1. I have to enable the HW bluetooth switch to get the
> > > > > > > bluetooth LED running (USB device appears in lsusb). The
> > > > > > > acer-bluetooth SW rfkill is unblocked, the SW rfkill of h=
ci0
> > > > > > > is blocked.
> > > > > >=20
> > > > > > Yes, this is also right behavior, because acer-wmi driver w=
ill
> > > > > > maintain the killswitch status with BIOS.
> > > > > >=20
> > > > > > > 2. Next I have to unblock SW rfkill on hci0 by a call to
> > > > > > > `rfkill unblock <number of hci0>`.
> > > > > > > 3. Last I have to enable the HCI by the call to `hciconfi=
g hci0
> > > > > > > up`.
> > > > > >=20
> > > > > > About 2. - 3.
> > > > > > I thought the above behavior causes by rfkill-input reverse=
 the
> > > > > > hci0's killswitch when you pressed HW bluetooth, the HW blu=
etooth
> > > > > > send out a KEY_BLUETHOOTH keycode then rfkill-input capture=
 it to
> > > > > > do hci0's status reverse.
> > > > > > I suggest leave userland application to do killswitch, don'=
t use
> > > > > > rfkill-input.
> > > > > >=20
> > > > > > You can do:
> > > > > > 	- Use rfkill unblock acer-bluetooth SW killswitch, don't u=
se HW
> > > > > > 	bluetooth
> > > > > >=20
> > > > > > switch. - If you still want to use HW bluetooth switch, the=
n I
> > > > > > suggest
> > > > > >=20
> > > > > > disable your rfkill-input. Have 2 way:
> > > > > > 		+ Use urfkill daemon:
> > > > > http://www.freedesktop.org/wiki/Software/urfkill
> > > > >=20
> > > > > > 		  This is a userland daemon can lock the rfkill-input to
> > >=20
> > > disable it
> >=20
> > Did you mean you direct set CONFIG_RFKILL_INPUT=3DN in kernel and r=
ebuild
> > kernel? or you used userland app like urfkill to send out ioctl to
> > disable rfkill-input?
> >=20
> > > > > > temporarily. + Direct set CONFIG_RFKILL_INPUT=3DN in kernel=
, but
> > > > > > you will need to rebuild kernel. After set rfkill-input dis=
able,
> > > > > > you need control killswitch from userland. You can control =
it by
> > > > > > rfkill tool or also try urfkill daemon.
> > > > >=20
> > > > > Actually this doesn't work. When I unblock the SW switch by
> > > > > calling `rfkill unblock <number of acer-bluetooth>`, it unblo=
cks
> > > > > the SW killswitch, the bluetooth LED goes up, the hci0 shows-=
up
> > > > > (USB device and killswitch), but initial state of hci0's
> > > > > killswitch is "blocked". So I still need to unblock it manual=
ly. I
> > > > > would preffer to don't be forced to do step 2, also for the H=
W
> > > > > switch (which should do the same job I think).
> > > > >=20
> > > > > Cheers,
> > > > > Old=C5=99ich.
> > > >=20
> > > > That's weird!
> > > > Because acer-wmi driver only maintain the killswitch on by itse=
lf and
> > > > will not touch hci driver's killswitch. I don't know why hci's
> > > > killswitch initial state is 0, need to check hci driver and rfk=
ill
> > > > staff.
> > > >=20
> > > > Could you please share your bluetooth device to us?
> > > > Please send out "lsusb" result when bluetooth device available.
> > >=20
> > > Bus 008 Device 002: ID 0a5c:2101 Broadcom Corp. Bluetooth Control=
ler
> > >=20
> > > dmesg shows the following:
> > >=20
> > > [ 2422.322067] usb 8-2: new full speed USB device using uhci_hcd =
and
> > > address 3 [ 2422.528212] usb 8-2: New USB device found, idVendor=3D=
0a5c,
> > > idProduct=3D2101 [ 2422.528223] usb 8-2: New USB device strings: =
Mfr=3D1,
> > > Product=3D2, SerialNumber=3D0
> > > [ 2422.528231] usb 8-2: Product: Acer Module
> > > [ 2422.528238] usb 8-2: Manufacturer: Broadcom Corp
> > >=20
> > > `rfkill list` shows the following
> > >=20
> > > 1) Before I enable the SW killswitch:
> > >=20
> > > 0: acer-wireless: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 1: acer-bluetooth: Bluetooth
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> > >=20
> > > 2: acer-threeg: Wireless WAN
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> > >=20
> > > 3: phy0: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 2) After I run `rfkill unblock 1`:
> > >=20
> > > 0: acer-wireless: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 1: acer-bluetooth: Bluetooth
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 2: acer-threeg: Wireless WAN
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> > >=20
> > > 3: phy0: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 6: hci0: Bluetooth
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> > >=20
> > > I've repeated it several times, so hci0 has number 6 now.
> > >=20
> > > Thanks for help,
> > > Old=C5=99ich.
> >=20
> > Thank's for your test result.
> > Want to double confirm with you...
> > The above result is base on CONFIG_RFKILL_INPUT=3DN ?
>=20
> No, that was just a formatting problem of a "reply" to a mail. That w=
asn't
> my reaction, it was just a word from the previous line. I'm still usi=
ng
> CONFIG_RFKILL_INPUT=3DY.
>=20
> Old=C5=99ich.
>=20
> > I just simply check the rfkill stuff,
> > I found when CONFIG_RFKILL_INPUT set to enable and there have any d=
river
> > call rfkill_init_sw_state before register rfkill object, then rfkil=
l
> > will sync this state to all killswitch that have the same type and =
also
> > will set the same initial state to new killswitch have the same typ=
e.
> >=20
> > Looks like rfkill will sync the state for the same type killswitch =
if
> > used rfkill_init_sw_state, I will do more detail debug and trace fo=
r
> > rfkill stuff, then find out solution.

I've added dump_trace() into hci_rfkill_set_block and the result is thi=
s:

[   85.180724] hci_rfkill_set_block: f36bb800 name hci0 blocked 1
[   85.180734] Pid: 8, comm: kworker/1:0 Not tainted 2.6.38-drm+ #106
[   85.180740] Call Trace:
[   85.180758]  [<c080ae7b>] ? hci_rfkill_set_block+0x3b/0x60
[   85.180769]  [<c08a9b58>] ? rfkill_set_block+0x68/0xe0
[   85.180778]  [<c08a9e36>] ? rfkill_sync_work+0x26/0x40
[   85.180791]  [<c027e851>] ? process_one_work+0x121/0x370
[   85.180802]  [<c0263a0b>] ? get_parent_ip+0xb/0x40
[   85.180810]  [<c08a9e10>] ? rfkill_sync_work+0x0/0x40
[   85.180820]  [<c027ee3c>] ? worker_thread+0x11c/0x3b0
[   85.180831]  [<c027ed20>] ? worker_thread+0x0/0x3b0
[   85.180840]  [<c0282144>] ? kthread+0x74/0x80
[   85.180849]  [<c02820d0>] ? kthread+0x0/0x80
[   85.180859]  [<c022f1f6>] ? kernel_thread_helper+0x6/0x10

It goes from rfkill_sync_work. That is all I can do now, I guess you wi=
ll be=20
faster than me in finding the solution :-)

Cheers,
Old=C5=99ich.

> >=20
> >=20
> > Thank's a lot!
> > Joey Lee
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
