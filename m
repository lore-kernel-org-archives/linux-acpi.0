From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Acer smart battery: acpi_sbs and linux-2.6.17
Date: Mon, 26 Jun 2006 01:14:33 +0200
Message-ID: <449F18D9.7060507@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:48851 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S965656AbWFYXOr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jun 2006 19:14:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Johan Vromans <jvromans@squirrel.nl>

Hello!

I've tried the modified acpi_sbs patch (acpi_sbs-20060422, modified by
Johan Vromans) for linux-2.6.16 with linux-2.6.17.

The patch applies and builds without a problem. The same for both
modules (acpi_sbs and i2c-acpi-ec). The modules work. But when the
battery is charged, I get divide errors from the kernel.

Jun 25 14:40:54 localhost kernel: divide error: 0000 [#1]
Jun 25 14:40:54 localhost kernel: PREEMPT
Jun 25 14:40:54 localhost kernel: Modules linked in: af_packet usbhid
nls_iso8859_1 nls_cp850 vfat fat radeon drm binfmt_misc rfcomm l2cap
bluetooth irtty_sir sir_dev thermal fan button autofs4 snd_intel8x0m
ipw2200 b44 mii ieee80211_crypt_tkip ieee80211_crypt_ccmp
ieee80211_crypt_wep ieee80211 ieee80211_crypt cpufreq_conservative
cpufreq_ondemand cpufreq_performance cpufreq_powersave acpi_cpufreq
freq_table processor ide_scsi sg sr_mod
cdrom scsi_mod acpi_sbs i2c_acpi_ec pcmcia firmware_class snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss joydev snd_pcm
snd_timer snd uhci_hcd 8250_pci soundcore snd_page_alloc ehci_hcd
intel_agp agpgart rtc usbcore i2c_i801 irda 8250 serial_core psmouse
ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core serio_raw
evdev crc_ccitt unix
Jun 25 14:40:54 localhost kernel: CPU:    0
Jun 25 14:40:54 localhost kernel: EIP:    0060:[<f99ccf50>]    Not
tainted VLI
Jun 25 14:40:54 localhost kernel: EFLAGS: 00210246   (2.6.17 #2)
Jun 25 14:40:54 localhost kernel: EIP is at
acpi_lbattery_read_state+0x111/0x1aa [acpi_sbs]
Jun 25 14:40:54 localhost kernel: eax: 00000000   ebx: dfc53800   ecx:
00000000   edx: 00000000
Jun 25 14:40:54 localhost kernel: esi: 00000001   edi: dc593640   ebp:
00000400   esp: f7c65f28
Jun 25 14:40:54 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun 25 14:40:54 localhost kernel: Process hald (pid: 3833,
threadinfo=f7c64000 task=f7c96030)
Jun 25 14:40:54 localhost kernel: Stack: f99ce463 dc593640 00000001
f7c65f54 c016bb83 dc593640 00000001 dc593660
Jun 25 14:40:54 localhost kernel:        00000000 00000001 c1bf1580
00000000 00000000 eb9af600 0807eea0 f7c65fa4
Jun 25 14:40:54 localhost kernel:        00000400 c01512b7 eb9af600
0807eea0 00000400 f7c65fa4 eb9af600 fffffff7
Jun 25 14:40:54 localhost kernel: Call Trace:
Jun 25 14:40:54 localhost kernel:  <c016bb83> seq_read+0xee/0x269
<c01512b7> vfs_read+0x87/0x11b
Jun 25 14:40:54 localhost kernel:  <c0151bdb> sys_read+0x3b/0x64
<c0102a37> sysenter_past_esp+0x54/0x75
Jun 25 14:40:54 localhost kernel: Code: 80 7b 08 00 ba 63 e4 9c f9 0f 44
c2 50 0f b7 43 0c 0f b7 93 9e 00 00 00 29 d0 0f af c6 6b c0 3c 0f b7 93
a4 00 00 00 89 d1 31 d2 <f7> f1 50 68 67 e4 9c f9 57 e8 f1 e7 79 c6 83
c4 10 eb 2d 68 a9
Jun 25 14:40:54 localhost kernel: EIP: [<f99ccf50>]
acpi_lbattery_read_state+0x111/0x1aa [acpi_sbs] SS:ESP 0068:f7c65f28


The notebook is an Acer Extensa 3002 WLMi. I don't use a modified DSDT
with this patch at the moment.


Regards,
Berthold Cogel


Regards
