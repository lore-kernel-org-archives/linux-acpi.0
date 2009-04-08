From: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: commit "ACPI: battery: asynchronous init" brokes my boot up
	process
Date: Wed, 8 Apr 2009 12:51:29 +0200
Message-ID: <5a4c581d0904080351m6811ab81i59c9bc1043071d3@mail.gmail.com>
References: <208cbae30904080338x749800b0o392886ab023018b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62914 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbZDHKvc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 06:51:32 -0400
In-Reply-To: <208cbae30904080338x749800b0o392886ab023018b6@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Wed, Apr 8, 2009 at 12:38 PM, Alexey Klimov <klimov.linux@gmail.com>=
 wrote:
> Hello,
>
> I don't know if i do right thing creating this letter but looks like
> this commit 0f66af530116e9f4dd97f328d91718b56a6fc5a4 "ACPI: battery:
> asynchronous init" brokes my boot up process. My machine is pentium-m
> cpu, Gentoo, gcc 4.3.3-r2.

Vegard Nossum posted a patch that fixes this problem, it's
 currently applied in Len Brown's tree so it should soon
 appear in the mainline kernel:

http://lkml.indiana.edu/hypermail/linux/kernel/0904.0/03127.html

> When openRC started and i got something like "Processing udev
> events(?)" (i can't see exactly words) i got this:
>
> ACPI: Battery Slot [BAT1] (battery present)
> BUG: unable to handle kernel paging request at f8530030
> IP: [<f8530030>] 0xf8530030
> *pde =3D 37288067 *pte =3D 00000000
> Oops: 0000 [#1]
> last sysfs file: /sys/devices/pnp0/00:07/id
> Modules linked in: ehci_hcd(+) sg container(+) battery uhci_hcd
> thermal button ac usbhid hid cpufreq_ondemand acpi_cpufreq
> snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec ac97_bus snd_pc=
m
> snd_timer snd soundcore snd_page_alloc usbcore rtc_cmos rtc_core
> rtc_lib
>
> Pid: 913, comm: async/0 Not tainted (2.6.29 #34) TravelMate 2350
> EIP: 0060:[<f8530030>] EFLAGS: 00010246 CPU: 0
> EIP is at 0xf8530030
> EAX: 00000000 EBX: 00000216 ECX: 00000001 EDX: 00000000
> ESI: c0129c47 EDI: f64bb5a0 EBP: 00000000 ESP: f660dfb0
> =A0DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
> Process async/0 (pid: 913, ti=3Df660d000 task=3Df6574d40 task.ti=3Df6=
60d000)
> Stack:
> =A0c0129d1e f7035f88 00000296 00000000 f6574d40 c0115dd2 f7035fc8 c03=
69bc0
> =A000000000 00000000 c0125c76 c0125c40 00000000 c0102f23 f7035f7c 000=
00000
> =A000000000 00000000 00005067 003c8067
> Call Trace:
> =A0[<c0129d1e>] ? async_thread+0xd7/0x1a8
> =A0[<c0115dd2>] ? default_wake_function+0x0/0x8
> =A0[<c0125c76>] ? kthread+0x36/0x5a
> =A0[<c0125c40>] ? kthread+0x0/0x5a
> =A0[<c0102f23>] ? kernel_thread_helper+0x7/0x10
> Code: =A0Bad EIP value.
> EIP: [<f8530030>] 0xf8530030 SS:ESP 0068:f660dfb0
> CR2: 00000000f8530030
> ---[ end trace d9fadf449e253313 ]---
> ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf0080000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
>
> And boot up process freezes when system tries to restart udev later.
> I didn't =A0have this issue in 2.6.29-git12. It presented in
> 2.6.29-git15 and 2.6.30-rc1.
> Firstly i thought that there is conflict(or race) with usb modules,
> and i tried to unplug all my usb devices before reboot, but issue
> still present in 2.6.30-rc1.
>
> Well, then i removed many apci modules like button, fan, battery,
> thermal and finally figured out that battery module is buggy on my
> system.
> I cancel changes provided by this commit in drivers/acpi/battery.c
> file and re-compiled modules. Boot up started to works fine.
>
> Probably this happens due to: 1) cos my notebook too old and battery
> isn't works long, 2) Gentoo' boot up process is bad.
> May be kernel option in menuconfig can be appropriate?
>
> --
> Best regards, Klimov Alexey

--alessandro

 "Sun keeps rising in the west / I keep on waking fully confused"

   (The Replacements, "Within Your Reach")
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
