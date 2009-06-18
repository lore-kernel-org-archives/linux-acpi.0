From: Joerg Platte <jplatte@naasa.net>
Subject: Re: [2.6.30] Kernel bug with dock driver
Date: Thu, 18 Jun 2009 23:22:52 +0200
Message-ID: <200906182322.54566.jplatte@naasa.net>
References: <200906142100.48621.jplatte@naasa.net> <200906161125.00685.jplatte@naasa.net> <20090617123440.GA400@khazad-dum.debian.net>
Reply-To: jplatte@naasa.net
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rosi.naasa.net ([212.8.0.13]:41156 "EHLO rosi.naasa.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbZFRVWz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 17:22:55 -0400
In-Reply-To: <20090617123440.GA400@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Wednesday, 17. June 2009 schrieb Henrique de Moraes Holschuh:
Hi Henrique,

> If it causes a NULL derreference, it means someone has changed API an=
d did
> NOT change all callsites.  It is that simple.
>
> Joerg, please apply this patch, and report the results...  WARNING: y=
ou
> will not get bay events from thinkpad-acpi, so be careful to not remo=
ve
> from the bay a device that is still active...

This time I got two BUGs while being on battery and without acpid:

------------[ cut here ]------------
WARNING: at drivers/platform/x86/thinkpad_acpi.c:4565 bay_notify+0x35/0=
x5e=20
[thinkpad_acpi]()
Hardware name: 2373G1G
thinkpad_acpi: dev_name() is returning NULL
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs radeo=
n drm=20
sco bridge stp llc bnep l2cap bluetooth ipt_MASQUERADE iptable_nat nf_n=
at=20
nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ipt_REJECT ipt_LOG xt_limit=20
xt_tcpudp xt_mac xt_multiport iptable_filter iptable_mangle ip_tables x=
_tables=20
nf_conntrack_ftp nf_conntrack vboxdrv binfmt_misc af_packet cpufreq_use=
rspace=20
cpufreq_stats cpufreq_powersave autofs4 nsc_ircc fuse nls_utf8 ntfs nls=
_base=20
ext2 deadline_iosched as_iosched ircomm_tty ircomm tun acpi_cpufreq sbs=
 sbshc=20
joydev snd_intel8x0m snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss=20
snd_mixer_oss snd_pcm snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi=
_event=20
snd_seq snd_timer snd_seq_device irtty_sir thinkpad_acpi ipw2200 libipw=
=20
yenta_socket sir_dev rfkill snd rsrc_nonstatic lib80211 soundcore pcmci=
a=20
rtc_cmos psmouse led_class pcmcia_core snd_page_alloc i2c_i801 rng_core=
=20
8250_pci irda pcspkr serio_raw nvram parport_pc 8250_pnp rtc_core parpo=
rt=20
button rtc_lib processor battery ac crc_ccitt 8250 serial_core evdev ex=
t3 jbd=20
mbcache sd_mod ata_generic pata_acpi ata_piix libata uhci_hcd ehci_hcd =
e1000=20
scsi_mod usbcore intel_agp agpgart video output thermal fan unix=20
cpufreq_conservative cpufreq_ondemand freq_table radeonfb fb_ddc backli=
ght=20
i2c_algo_bit cfbcopyarea i2c_core cfbimgblt cfbfillrect fbcon tileblit =
font=20
bitblit softcursor fb
Pid: 52, comm: kacpi_notify Not tainted 2.6.30 #1
Call Trace:
 [<c011f839>] warn_slowpath_common+0x60/0x90
 [<f9767132>] ? bay_notify+0x0/0x5e [thinkpad_acpi]
 [<c011f89d>] warn_slowpath_fmt+0x24/0x27
 [<f9767167>] bay_notify+0x35/0x5e [thinkpad_acpi]
 [<f9767023>] dispatch_acpi_notify+0x23/0x26 [thinkpad_acpi]
 [<c02018cd>] acpi_ev_notify_dispatch+0x4c/0x57
 [<c01f4488>] acpi_os_execute_deferred+0x20/0x2c
 [<c012cff6>] worker_thread+0x15a/0x1fd
 [<c01f4468>] ? acpi_os_execute_deferred+0x0/0x2c
 [<c012fc7d>] ? autoremove_wake_function+0x0/0x33
 [<c012ce9c>] ? worker_thread+0x0/0x1fd
 [<c012f8bc>] kthread+0x42/0x67
 [<c012f87a>] ? kthread+0x0/0x67
 [<c01030d3>] kernel_thread_helper+0x7/0x10
---[ end trace 0469584017b9bddb ]---
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Stopping disk
ata2.00: disabled
ACPI: \_SB_.PCI0.IDE0.SCND.MSTR - undocking
ACPI Warning (nspredef-0290): \_SB_.PCI0.LPC_.EC__.BEEP: Excess argumen=
ts -=20
needs 1, found 2 [20090320]
------------[ cut here ]------------
WARNING: at drivers/platform/x86/thinkpad_acpi.c:4565 bay_notify+0x35/0=
x5e=20
[thinkpad_acpi]()
Hardware name: 2373G1G
thinkpad_acpi: dev_name() is returning NULL
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs radeo=
n drm=20
sco bridge stp llc bnep l2cap bluetooth ipt_MASQUERADE iptable_nat nf_n=
at=20
nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ipt_REJECT ipt_LOG xt_limit=20
xt_tcpudp xt_mac xt_multiport iptable_filter iptable_mangle ip_tables x=
_tables=20
nf_conntrack_ftp nf_conntrack vboxdrv binfmt_misc af_packet cpufreq_use=
rspace=20
cpufreq_stats cpufreq_powersave autofs4 nsc_ircc fuse nls_utf8 ntfs nls=
_base=20
ext2 deadline_iosched as_iosched ircomm_tty ircomm tun acpi_cpufreq sbs=
 sbshc=20
joydev snd_intel8x0m snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss=20
snd_mixer_oss snd_pcm snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi=
_event=20
snd_seq snd_timer snd_seq_device irtty_sir thinkpad_acpi ipw2200 libipw=
=20
yenta_socket sir_dev rfkill snd rsrc_nonstatic lib80211 soundcore pcmci=
a=20
rtc_cmos psmouse led_class pcmcia_core snd_page_alloc i2c_i801 rng_core=
=20
8250_pci irda pcspkr serio_raw nvram parport_pc 8250_pnp rtc_core parpo=
rt=20
button rtc_lib processor battery ac crc_ccitt 8250 serial_core evdev ex=
t3 jbd=20
mbcache sd_mod ata_generic pata_acpi ata_piix libata uhci_hcd ehci_hcd =
e1000=20
scsi_mod usbcore intel_agp agpgart video output thermal fan unix=20
cpufreq_conservative cpufreq_ondemand freq_table radeonfb fb_ddc backli=
ght=20
i2c_algo_bit cfbcopyarea i2c_core cfbimgblt cfbfillrect fbcon tileblit =
font=20
bitblit softcursor fb
Pid: 52, comm: kacpi_notify Tainted: G        W  2.6.30 #1
Call Trace:
 [<c011f839>] warn_slowpath_common+0x60/0x90
 [<f9767132>] ? bay_notify+0x0/0x5e [thinkpad_acpi]
 [<c011f89d>] warn_slowpath_fmt+0x24/0x27
 [<f9767167>] bay_notify+0x35/0x5e [thinkpad_acpi]
 [<f9767023>] dispatch_acpi_notify+0x23/0x26 [thinkpad_acpi]
 [<c02018cd>] acpi_ev_notify_dispatch+0x4c/0x57
 [<c01f4488>] acpi_os_execute_deferred+0x20/0x2c
 [<c012cff6>] worker_thread+0x15a/0x1fd
 [<c01f4468>] ? acpi_os_execute_deferred+0x0/0x2c
 [<c012fc7d>] ? autoremove_wake_function+0x0/0x33
 [<c012ce9c>] ? worker_thread+0x0/0x1fd
 [<c012f8bc>] kthread+0x42/0x67
 [<c012f87a>] ? kthread+0x0/0x67
 [<c01030d3>] kernel_thread_helper+0x7/0x10
---[ end trace 0469584017b9bddc ]---

Hope it helps...

Best regards,
J=F6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
