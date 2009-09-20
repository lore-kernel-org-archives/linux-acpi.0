From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Sun, 20 Sep 2009 11:47:25 -0600
Message-ID: <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
References: <4AB1C907.1070503@gmail.com>
	 <20090920162306.GA18214@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:28348 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZITRrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Sep 2009 13:47:23 -0400
In-Reply-To: <20090920162306.GA18214@dreamland.darkstar.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun, Sep 20, 2009 at 10:23 AM, Luca Tettamanti <kronos.it@gmail.com>=
 wrote:
> Il Wed, Sep 16, 2009 at 11:28:39PM -0600, Robert Hancock ha scritto:
>> Just built a new system with an Asus P7P55D PRO motherboard. The
>> ATK0110 driver doesn't seem to be able to retrieve any hardware
>> monitoring parameters successfully, sensors gives:
>>
>> atk0110-acpi-0
>> Adapter: ACPI interface
>> ERROR: Can't get value of subfeature in0_input: I/O error
>> Vcore Voltage: =A0 =A0 =A0+0.00 V =A0(min =3D =A0+0.80 V, max =3D =A0=
+1.60 V)
>> ERROR: Can't get value of subfeature in1_input: I/O error
>> +3.3V Voltage: =A0 =A0 =A0+0.00 V =A0(min =3D =A0+2.97 V, max =3D =A0=
+3.63 V)
>> ERROR: Can't get value of subfeature in2_input: I/O error
>> +5V Voltage: =A0 =A0 =A0 =A0+0.00 V =A0(min =3D =A0+4.50 V, max =3D =
=A0+5.50 V)
>>
>> etc. and dmesg spits out a bunch of these:
>>
>> ATK0110 ATK0110:00: atk_read_value_new: ACPI exception: AE_BUFFER_OV=
ERFLOW
>>
>> I'm guessing this board uses a different format than what the driver
>> is expecting. I'm attaching the gzipped decompiled DSDT from the
>> board, hopefully it's useful to somebody..
>
> Please try the following patch, it should detect the proper buffer si=
ze.
>

Obviously something not quite right:

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<ffffffff81301b1f>] acpi_ut_copy_isimple_to_esimple+0x3e/0x16e
PGD 11d5c8067 PUD 11d680067 PMD 0
Oops: 0002 [#1] SMP
last sysfs file:
/sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:03/ATK0110:00/hwmo=
n/hwmon0/in0_input
CPU 3
Modules linked in: ipv6 cpufreq_ondemand acpi_cpufreq freq_table fuse
dm_multipath uinput snd_ice1724 snd_rawmidi snd_seq_device
snd_hda_codec_via snd_ice17xx_ak4xxx snd_ac97_codec snd_hda_intel
snd_hda_codec ac97_bus snd_ak4xxx_adda snd_ak4114 snd_hwdep snd_pcm
snd_pt2258 snd_i2c snd_timer gspca_spca561 snd gspca_main videodev
ata_generic r8169 v4l1_compat firewire_ohci pata_acpi usb_storage
firewire_core i2c_i801 snd_page_alloc soundcore mii
v4l2_compat_ioctl32 asus_atk0110 wmi joydev pata_jmicron i2c_core
pcspkr serio_raw hwmon crc_itu_t [last unloaded: scsi_wait_scan]
Pid: 2475, comm: sensors-applet Not tainted 2.6.31-rc0 #6 System Produc=
t Name
RIP: 0010:[<ffffffff81301b1f>]  [<ffffffff81301b1f>]
acpi_ut_copy_isimple_to_esimple+0x3e/0x16e
RSP: 0018:ffff88011f2d1c48  EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
RDX: 0000000000000018 RSI: ffff88011f2d1dc8 RDI: 0000000000000000
RBP: ffff88011f2d1c68 R08: ffff88013ba9a2d0 R09: ffff88013ba9a2d0
R10: 00000000c261101f R11: 00000000c261101f R12: ffff88013ba70a40
R13: ffff88011f2d1dd8 R14: ffff88013b2d3fc0 R15: ffff88011f2d1dc8
=46S:  00007f7cdbea1800(0000) GS:ffff880028260000(0000) knlGS:000000000=
0000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000011f398000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process sensors-applet (pid: 2475, threadinfo ffff88011f2d0000, task
ffff88011f2c8000)
Stack:
 0000000000004001 00000000c261101f ffff88011f2d1cc8 ffff88011f2d1dc8
<0> ffff88011f2d1ca8 ffffffff81301ce3 ffff88013b2d3fc0 00000000c261101f
<0> 0000000000000000 00000000c261101f 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff81301ce3>] acpi_ut_copy_iobject_to_eobject+0x94/0xb3
 [<ffffffff812f6911>] acpi_evaluate_object+0x1b5/0x21a
 [<ffffffff812f69b1>] acpi_evaluate_object_typed+0x3b/0xfa
 [<ffffffffa00405d6>] atk_input_show+0x1a0/0x2bb [asus_atk0110]
 [<ffffffff81011f82>] ? system_call_fastpath+0x16/0x1b
Code: 28 00 00 00 48 89 45 e8 31 c0 48 89 f3 49 89 f8 48 89 ce 48 c7
01 00 00 00 00 48 85 ff 0f 84 1d 01 00 00 b9 06 00 00 00 48 89 df <f3>
ab 41 0f b6 40 09 89 03 41 8a 78 09 40 80 ff 03 74 56 77 12
RIP  [<ffffffff81301b1f>] acpi_ut_copy_isimple_to_esimple+0x3e/0x16e
 RSP <ffff88011f2d1c48>
CR2: 0000000000000000
---[ end trace d7191dbc499ceceb ]---

Based on the disassembly I think this memset is what failed in
drivers/acpi/acpica/utcopy.c, in the acpi_ut_copy_isimple_to_esimple
function:

	/* Always clear the external object */

	ACPI_MEMSET(external_object, 0, sizeof(union acpi_object));
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
