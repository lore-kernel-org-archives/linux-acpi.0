From: Joerg Platte <jplatte@naasa.net>
Subject: Re: [2.6.30] Kernel bug with dock driver
Date: Tue, 16 Jun 2009 11:24:59 +0200
Message-ID: <200906161125.00685.jplatte@naasa.net>
References: <200906142100.48621.jplatte@naasa.net> <200906150936.41983.jplatte@naasa.net> <20090615202928.GA28319@khazad-dum.debian.net>
Reply-To: jplatte@naasa.net
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rosi.naasa.net ([212.8.0.13]:52187 "EHLO rosi.naasa.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbZFPJZE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 05:25:04 -0400
In-Reply-To: <20090615202928.GA28319@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Monday, 15. June 2009 schrieb Henrique de Moraes Holschuh:
> There might be a race there, as you call undock but you don't really =
know
> if the SCSI device was deleted.

I tried to undock a device without previously disabling it. Here's the =
result=20
after inserting it again:

ata2.00: disabled                                                      =
                                                                       =
                        =20
ACPI: \_SB_.PCI0.IDE0.SCND.MSTR - undocking                            =
                                                                       =
                        =20
ata2.00: detaching (SCSI 1:0:0:0)                                      =
                                                                       =
                        =20
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER=
_OK
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER=
_OK
BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<c01df5fa>] strcpy+0xe/0x1b
*pde =3D 00000000
Oops: 0000 [#1] PREEMPT
last sysfs file: /sys/devices/platform/dock.2/docked
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs radeo=
n drm=20
sco bridge stp llc bnep l2cap bluetooth ipt_MASQUERADE iptable_nat nf_n=
at=20
nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ipt_REJECT ipt_LOG xt_limit=20
xt_tcpudp xt_mac xt_multiport iptable_filter iptable_mangle ip_tables x=
_tables=20
nf_conntrack_ftp nf_conntrack vboxdrv binfmt_misc aes_i586 cryptomgr ae=
ad=20
pcompress crypto_blkcipher crypto_hash aes_generic crypto_algapi=20
lib80211_crypt_ccmp af_packet cpufreq_userspace cpufreq_stats=20
cpufreq_powersave autofs4 nsc_ircc fuse nls_utf8 ntfs nls_base ext2=20
deadline_iosched as_iosched ircomm_tty ircomm tun acpi_cpufreq sbs sbsh=
c=20
joydev snd_intel8x0 snd_intel8x0m snd_seq_oss snd_ac97_codec snd_seq_mi=
di=20
ac97_bus snd_rawmidi snd_pcm_oss snd_seq_midi_event snd_mixer_oss irtty=
_sir=20
snd_pcm snd_seq dvb_usb_cinergyT2 yenta_socket sir_dev snd_seq_device=20
rsrc_nonstatic thinkpad_acpi dvb_usb pcmcia rfkill ipw2200 snd_timer dv=
b_core=20
led_class i2c_i801 rng_core rtc_cmos pcmcia_core video ac libipw parpor=
t_pc=20
8250_pci parport psmouse 8250_pnp snd lib80211 output soundcore rtc_cor=
e nvram=20
serio_raw rtc_lib button snd_page_alloc pcspkr 8250 battery processor i=
rda=20
serial_core crc_ccitt evdev ext3 jbd mbcache usbhid hid sd_mod ata_gene=
ric=20
pata_acpi ata_piix uhci_hcd ehci_hcd libata e1000 usbcore scsi_mod inte=
l_agp=20
agpgart thermal fan unix cpufreq_conservative cpufreq_ondemand freq_tab=
le=20
radeonfb fb_ddc backlight i2c_algo_bit cfbcopyarea i2c_core cfbimgblt=20
cfbfillrect fbcon tileblit font bitblit softcursor fb

Pid: 52, comm: kacpi_notify Not tainted (2.6.30 #1) 2373G1G
EIP: 0060:[<c01df5fa>] EFLAGS: 00010286 CPU: 0
EIP is at strcpy+0xe/0x1b
EAX: f302482c EBX: f3024800 ECX: f302482c EDX: 00000000
ESI: 00000000 EDI: f302482c EBP: f70a4f34 ESP: f70a4f28
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process kacpi_notify (pid: 52, ti=3Df70a4000 task=3Df704c980 task.ti=3D=
f70a4000)
Stack:
 f3024800 f3024814 f3024844 f70a4f64 c01fc898 010a4f54 00000000 f70c287=
9
 00000004 f30e83c0 f3024818 00000014 f97c8132 f69b2600 00000000 f70a4f7=
0
 f97c814e 00000000 f70a4f7c f97c8023 f7070460 f70a4f8c c020199d f4e37ee=
0
Call Trace:
 [<c01fc898>] ? acpi_bus_generate_netlink_event+0x140/0x199
 [<f97c8132>] ? bay_notify+0x0/0x1f [thinkpad_acpi]
 [<f97c814e>] ? bay_notify+0x1c/0x1f [thinkpad_acpi]
 [<f97c8023>] ? dispatch_acpi_notify+0x23/0x26 [thinkpad_acpi]
 [<c020199d>] ? acpi_ev_notify_dispatch+0x4c/0x57
 [<c01f4558>] ? acpi_os_execute_deferred+0x20/0x2c
 [<c012cff6>] ? worker_thread+0x15a/0x1fd
 [<c01f4538>] ? acpi_os_execute_deferred+0x0/0x2c
 [<c012fc7d>] ? autoremove_wake_function+0x0/0x33
 [<c012ce9c>] ? worker_thread+0x0/0x1fd
 [<c012f8bc>] ? kthread+0x42/0x67
 [<c012f87a>] ? kthread+0x0/0x67
 [<c01030d3>] ? kernel_thread_helper+0x7/0x10
Code: ff ff 21 e3 8b 5b 18 83 eb 07 39 d9 73 08 89 01 89 51 04 31 c0 c3=
 b8 f2=20
ff ff ff c3 90 55 89 c1 89 e5 57 89 c7 56 89 d6 83 ec 04 <ac> aa 84 c0 =
75 fa=20
5a 89 c8 5e 5f 5d c3 55 89 e5 57 89 c7 56 89
EIP: [<c01df5fa>] strcpy+0xe/0x1b SS:ESP 0068:f70a4f28
CR2: 0000000000000000
---[ end trace 798a63a30da95ce2 ]---

> So, please try to reproduce this by sending a number of delete reques=
ts
> back-to-back in a row, and also mixing delete requests with undock
> requests. When you find out what causes the OOPS (and it _is_ a bug i=
n the
> kernel if any of those oops), we can try to direct the bug report to
> someone who can fix the problem.
>
> > to undock a device while it is in the process of being undocked? Ho=
w
> > should I modify the udev rule to prevent another execution each tim=
e a
> > drive is inserted into the bay?
>
> You will need locking, unfortunately.  Also, check if there is a devi=
ce in
> the bay.  event+device in bay =3D=3D hotunplug.  event+no device in b=
ay =3D=3D
> hotplug.
>
> That is, if the events don't already tell you (i.e. different events =
for
> plug and unplug).  I don't recall right now if the ACPI events are
> different, but I do recall the thinkpad BIOS follows the ACPI spec
> correctly on this area.

Since I was not able to reproduce the initial bug yesterday I remembere=
d that=20
I deinstalled acpid because of Debian Bug#522756 (acpid terminates each=
 time I=20
unplug the mouse). After installing acpid again (and disabling the udev=
 rule)=20
the Bug appeared again. However, in my acpid config I call a script for=
 both=20
events:

event=3Dibm/bay device:0f 00000001 00000000
action=3D/usr/local/sbin/ultrabay_close

This is the content of /usr/local/sbin/ultrabay_close
echo 12 > /proc/acpi/ibm/beep
sync
echo 0 0 0 > /sys/class/scsi_host/host1/scan

event=3Dibm/bay device:0f 00000003 00000000
action=3D/usr/local/sbin/ultrabay_open

ultrabay_open is identical to the script posted in my last mail. Maybe =
there's=20
a problem with the scan command, because the kernel tries to scan for d=
evices=20
automatically.=20

It looks like there are still some bugs in the dock handling when using=
 it=20
improperly :)

Best regards,
J=F6rg


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
