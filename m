From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Tue, 27 Feb 2007 23:30:22 +0100
Message-ID: <200702272330.22968.rjw@sisk.pl>
References: <1172601905.5428.28.camel@localhost.localdomain> <200702272304.01756.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38461 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbXB0W2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Feb 2007 17:28:09 -0500
In-Reply-To: <200702272304.01756.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristian =?iso-8859-15?q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, 27 February 2007 23:04, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Tuesday, 27 February 2007 19:45, Kristian Gr=F8nfeldt S=F8rensen w=
rote:
> > Hi.
> >=20
> > PROBLEM: "BUG:" when resumimg from suspend-to-ram=20
> > =09
> > My laptop have a problem with resuming from suspend-to-ram.=20
> > It does not occur every time - most of the time, resume works witho=
ut
> > any problem.at all.
> >=20
> > After it occurs, the laptop refuses to go into suspend-to-ram mode =
until
> > next reboot.
>=20
> What do you mean by "refuses"?  Are there any suspicious messages in
> dmesg?
>=20
> > The system is a Debian unstable running with a self-compiled 2.6.20
> > kernel downloaded from kernel.org.=20
> >=20
> > I've only tried suspend-to-ram on 2.6.20 so I don't know whether or=
 not
> > other versions might have the same problem.
> >=20
> > I'm not subscribed to the list. Please CC me.
>=20
> I guess one of the drivers you use goes awry at some point.  Please p=
rovide
> us with more information (like dmesg output after a failing resume).

I'm sorry, I've just been told you sent it. :-)

> CLASS: Unregistering class device. ID =3D 'event3'
> class_uevent - name =3D event3
> class_device_create_uevent called for event3
> device class 'event3': release.
> class_device_create_release called for event3
> BUG: unable to handle kernel paging request at virtual address 6b6b6b=
6b
>  printing eip:
> f8825a81
> *pde =3D 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: tg3 battery ac thermal fan button i915 drm binfmt_=
misc
> rfcomm l2cap ipv6 fuse capability commoncap cpufreq_performance aoe
> af_packet nls_utf8 ntfs nls_iso8859_1 nls_cp437 vfat fat dm_snapshot
> dm_mirror dm_mod ieee80211_cr ypt_tkip ieee80211_crypt pd6729 snd_seq=
_dummy
> snd_seq_oss snd_seq_midi snd_rawmi di snd_seq_midi_event snd_seq
> snd_seq_device sermouse hci_vhci hci_uart wbsd mmc _block mmc_core tu=
n msr
> cpuid cpufreq_stats container video speedstep_lib speeds tep_centrino
> processor sr_mod sbp2 scsi_mod ide_cd cdrom eth1394 hci_usb bluetoo t=
h
> pcmcia firmware_class irda snd_intel8x0m snd_intel8x0 snd_ac97_codec
> crc_ccit t ac97_bus snd_pcm_oss snd_mixer_oss rtc i2c_i801 snd_pcm
> snd_timer ohci1394 iee e1394 i2c_core serio_raw intel_agp iTCO_wdt sn=
d
> soundcore snd_page_alloc ehci_hc d pcspkr uhci_hcd yenta_socket
> rsrc_nonstatic pcmcia_core usbcore agpgart moused ev evdev
> CPU:    0
> EIP:    0060:[<f8825a81>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.20-x300 #1)
> EIP is at evdev_disconnect+0xb1/0xe0 [evdev]

This points us to a suspect.  Can you please run "gdb vmlinux" against =
the
vmlinux in your kernel sources directory and then

gdb> l *evdev_disconnect+0xb1

> eax: 00000000   ebx: 6b6b675b   ecx: 10000000   edx: 00000000
> esi: f73212a8   edi: f6dcf5c4   ebp: e6f31f04   esp: e6f31ef8
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 9025, ti=3De6f30000 task=3Def56a070 task.ti=3D=
e6f30000)
> Stack: 00000000 f6ca2528 f7321264 e6f31f24 c02a899f 00000000 f6dcfcf0
> f6dcfcf0 f253ce90 c1a3002c c1a610a4 e6f31f34 f8ccd0c5 f8ccece0 c1a300=
2c
> e6f31f48 c0263225 00000000 f8ccee00 00000000 e6f31f50 f8ccd7d1 e6f31f=
b0
> c013e772 Call Trace:
>  [<c01041ea>] show_trace_log_lvl+0x1a/0x30
>  [<c01042a9>] show_stack_log_lvl+0xa9/0xd0
>  [<c01044bf>] show_registers+0x1ef/0x360
>  [<c0104734>] die+0x104/0x240
>  [<c0115ba5>] do_page_fault+0x2b5/0x5c0
>  [<c0335b5c>] error_code+0x74/0x7c
>  [<c02a899f>] input_unregister_device+0xaf/0x160
>  [<f8ccd0c5>] acpi_button_remove+0x2b/0x3f [button]
>  [<c0263225>] acpi_bus_unregister_driver+0x40/0xaa
>  [<f8ccd7d1>] acpi_button_exit+0xd/0x6a [button]
>  [<c013e772>] sys_delete_module+0x142/0x1b0
>  [<c0103220>] syscall_call+0x7/0xb
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code: f0 74 3c 8d b4 26 00 00 00 00 8d 83 08 04 00 00 b9 06 00 02 00 =
ba 1d
> 00 00                                                                =
     =20
>                00 e8 eb 54 95 c7 8b 9b 10 04 00 00 81 eb 10 04 00 00 =
<8b>
> 83 10 04 00 00 0f 18                                                 =
     =20
>                               00 90 8d 83 10 04 00 00 39 f0 75 cb 5b =
EIP:
> [<f8825a81>] evdev_disconnect+0xb1/0xe0 [evdev] SS:ESP 0068:e6f31ef8


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
