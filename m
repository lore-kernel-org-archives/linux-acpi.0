From: Servet Portakal <servetportakal@gmail.com>
Subject: [BUG] Ksoftirqd and kworker use 100 percent of the cpu core
Date: Sat, 28 Apr 2012 14:33:13 +0300
Message-ID: <CAFp-nYjEWA-W2X9eYYGD2hAPMosQpZCowiiPCG70D2ZZQB22Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43676 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905Ab2D1LdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2012 07:33:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello,

Ksoftirqd and kworker use 100 percent of the cpu core after resuming fr=
om the
suspend and the hibernation mode. For example;  Ksoftirqd/1 %42,
kworker/1:0 %29, kworker/1:1 %28.

I'm not an expert. nonetheless I tried to pick some
error messegas to ease your work.

ata1: ACP=C4=B0 set timing mode failed (status: 0x300b)
ata3.00 : exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00 : failed command :READ VER=C4=B0FY SECTOR(S)
cmd: 40/00:01:00:00:00/00:00:00:00/e0 tag 0
res: 40/00:01:00:00:00/00:00:00:00/40 Emask:0x4 (timeout)
pm_op():scsi_bus_resume_common+0x0/0x60 returns 134217730
PM: Device 2:0:0:0 failed to resume async:error 134217730

Other messages that I picked randomly...

ata3: lost interrupt
(Status 0x50)
ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x00000000FFFFFFFF) is
beyond end of
object (20110623/exoparg2-418)
ACPI Error: Method parse/execution failed [\_SB_.PCI0.IDEC.IDE0._STM] (=
Node
ffff8800ba233b40), AE_AML_PACKAGE_LIMIT (20110623/psparse-536)
ata3.00: status: { DRDY }
ata3: soft resetting link
ata3.00: configured for UDMA/133
ata3.00: device reported invalid CHS sector 0
ata3: EH complete
sd 2:0:0:0: [sda] START_STOP FAILED
sd 2:0:0:0: [sda] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
sd 2:0:0:0: [sda]  Add. Sense: No additional sense information
WARNING: at /build/buildd/linux-3.2.0/kernel/power/suspend_test.c:53
suspend_test_finish+0x86/0x90()
Hardware name: F5SR
Component: resume devices, time: 30308
Modules linked in: nls_iso8859_1 nls_cp437 vfat fat bnep rfcomm
pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) fglrx(P) vboxdrv(O)
parport_pc ppdev joydev btusb bluetooth snd_hda_codec_realtek uvcvideo
videodev v4l2_compat_ioctl32 snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm snd_seq_midi snd_rawmidi arc4 snd_seq_midi_event snd_seq
snd_timer snd_seq_device snd psmouse serio_raw video ath9k mac80211
soundcore asus_laptop sparse_keymap input_polldev snd_page_alloc
ath9k_common ath9k_hw ath cfg80211 sis_agp lp parport usbhid hid
usb_storage uas sata_sis sis190
Pid: 5804, comm: pm-suspend Tainted: P
Call Trace:
[<ffffffff810651af>] warn_slowpath_common+0x7f/0xc0
[<ffffffff810652a6>] warn_slowpath_fmt+0x46/0x50
[<ffffffff810a9566>] suspend_test_finish+0x86/0x90
[<ffffffff810a925b>] suspend_devices_and_enter+0xfb/0x1f0
[<ffffffff810a9421>] enter_state+0xd1/0x110
[<ffffffff810a7e27>] state_store+0xb7/0x130
[<ffffffff8130854f>] kobj_attr_store+0xf/0x30
[<ffffffff811e995f>] sysfs_write_file+0xef/0x170
[<ffffffff81176393>] vfs_write+0xb3/0x180
[<ffffffff811766ba>] sys_write+0x4a/0x90
[<ffffffff81659fc2>] system_call_fastpath+0x16/0x1b
PM: Finishing wakeup.
Restarting tasks ... done.
[fglrx:fireglAsyncioIntEnableMsgHandler] *ERROR* interrupt source
ff000066 is not supported on this hardware (return code =3D 1)
EXT4-fs (sda5): re-mounted. Opts: errors=3Dremount-ro,commit=3D0
[fglrx:fireglAsyncioIntEnableMsgHandler] *ERROR* interrupt source
ff000066 is not supported on this hardware (return code =3D 1)
sis190: 0000:00:04.0: Error EEPROM read 0
ERST: Table is not found!
GHES: HEST is not enabled!
Simple Boot Flag value
0xc0 read from CMOS RAM was invalid

/usr/lib/pm-utils/sleep.d/49bluetooth suspend suspend: not applicable.
Running hook /usr/lib/pm-utils/sleep.d/55NetworkManager suspend suspend=
:
Having NetworkManager put all interaces to sleep...Failed.

/usr/lib/pm-utils/sleep.d/55NetworkManager suspend suspend: success.
Running hook /usr/lib/pm-utils/sleep.d/60_wpa_supplicant suspend suspen=
d:
=46ailed to connect to wpa_supplicant - wpa_ctrl_open: No such file or =
directory

ACPI Error: Method parse/execution failed [\_SB_.PCI0.IDEC.IDE0._STM] (=
Node
ffff8800ba233b40), AE_AML_PACKAGE_LIMIT (20110623/psparse-536)
pulseaudio[1821]: [pulseaudio]
bluetooth-util.c: Error from RegisterEndpoint reply:
org.freedesktop.DBus.Error.UnknownMethod

On windows 7, suspend mode was not working when I open hybrid-sleep
mode. =C4=B0t may help...

You know suspend mode is crucial for mobile devices. So I can't use
ubuntu regularly.
=C4=B0f you solve this problem, I will be so delighted.

Best regards.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
