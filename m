From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [acpi:battery?] kernel oops on boot
Date: Wed, 14 Apr 2010 15:12:05 +0200
Message-ID: <u2gffd8902a1004140612h560dbc9di6377450661c81422@mail.gmail.com>
References: <20100414095750.GA3304@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:49113 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271Ab0DNNMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2010 09:12:08 -0400
In-Reply-To: <20100414095750.GA3304@swordfish.minsk.epam.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I have the same problem on my thinkpad T30 since this week:

The kernel boots very slowly until the message:

* Loading kernel modules...

there my kernel hangs there forever now.

The first problem is shown after the start of the udev (:

* Waiting for /dev to be fully populated...

[   18.273664] BUG: unable to handle kernel paging request at 0033393a
[   18.274036] IP: [<c027d8f5>] acpi_ex_read_data_from_field+0x117/0x14=
e
[   18.274249] *pde =3D 00000000
[   18.274446] Oops: 0000 [#1]
[   18.274625] last sysfs file:
/sys/devices/pci0000:00/0000:00:1f.1/ide0/0.0/block/hda/dev
[   18.274625] Modules linked in : battery ac processor rng_core
button uhci_hcd ehci_hcd thermal usbcore [last unloaded:
scsi_wait_scan]
[   18.274625]
[   18.274625] Pid: 1077, comm: async/0 Not tained 2.6.34-rc4 #61
2366DG3/2366DG3
[   18.274625] EIP: 0060:[<c027d8f5>] EFLAGS: 00010246 CPU:0
[   18.274625] EIP is at acpi_ex_read_data_from_field+0x117/0x14e
[   18.274625] EAX: 00000000 EBX: 00333931 ECX: 00000000 EDX: 00000000
[   18.274625] ESI: 00000000 EDI: efa4dd70 EBP: efa4dd64 ESP: efa4dd50
[   18.274625]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[   18.274625]  Process async/0 (pid:1077, ti=3Defa4c000 task=3D f70a28=
50
task.ti=3Defa4c000
[   18.274625]  Stack: <me do not want to type it all...>
[   18.274625]  Call Trace:
[   18.274625]  [<c02823be>] ? acpi_ex_resolve_node_to_value+0x166/0x1d=
c
[   18.274625]  [<c027e226>] ? acpi_ex_resolve_to_value+0x65/0x6f
[   18.274625]  [<c0279065>] ? acpi_ds_evaluate_name_path+0x71/0xdc
=2E...<me do not want to type it all...>...
[   18.274625]  [<c0102e3e>] ? kernel_thread_helper+0x6/0x10
[   18.274625]  Code: c6 74 4e 0f b6 0d 7d a6 7e c0 8d 50 0c 0f b6 43
09 89 55 f0 89 4d ec e8 93 42 00 00 8b 55 f0 89 d8 8b 4d ec e8 9e 12
00 00 89 c2 <0f> b6 43 09 89 55 f0 e8 44 42 00 00 8b 55 f0 85 d2 74 0f
89 f0
[   18.274625]  EIP: [<c027d8f5>] ?
acpi_ex_read_data_from_field+0x117/0x14e SS: ESP 0068:efa4dd50
[   18.274625] CR2: 000000000033393a
[   18.274625] ---[ end trace da97996273142d42 ]---
[   18.274625] bus: 'pcmcia': registered
=2E..
* Starting early crypto disks...
* Cleaning up ifdown...
* Loading kernel modules...
--- FREEEZE ---

I can boot into the lap with the stable 2.6.32.11 and can give other
infos like the current kernelconfig of this laptop. But I will wait
for the reboot, leaving the message still open, if anybody needs more
info.


sincerelly your
Chris

2010/4/14 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>:
>
> Hello,
> Kernel oops on early stages. The below trace is "copy-paste" from the=
 paper
> since syslog is not runing yet.
>
> kernel: .34-rc4-git1 /* also tested on .34-rc4 .34-rc3-git10 */
> laptop: ASUS f3jc x86
>
>
> ds: 007b es:007b fs:00d8 gs:00e8 ss:0068
> process: async/0
> stack:
> =A0 =A0 =A0 =A00000000 c144c708 f66cdd20 c109fc0b f723c1b8 f71fcec0 f=
71aa208 00000020
> =A0 =A0 =A0 =A0<0> =A0 =A0 c11c4d40 00001000 000000b6 c12f61e0 c12f61=
bc f723c1b8 f71aa208
> =A0 =A0 =A0 =A0f71fcec0
> =A0 =A0 =A0 =A0<0> =A0 =A0 f66cdd54 c11c4d58 00000020 f66cdd64 f73a0f=
84 f723c1b8 f70cdc70
> =A0 =A0 =A0 =A0f66cdd74
>
> call trace:
> =A0 =A0 =A0 =A0__kmalloc+0xe1
> =A0 =A0 =A0 =A0acpi_ex_read_data_from_field+0x156
> =A0 =A0 =A0 =A0acpi_ex_read_data_from_field+0x16e
> =A0 =A0 =A0 =A0acpi_ex_resolve_node_to_value
> =A0 =A0 =A0 =A0acpi_ex_resolve_to_value
> =A0 =A0 =A0 =A0acpi_ds_evaluate_name_path
> =A0 =A0 =A0 =A0acpi_ds_exec_end_op
> =A0 =A0 =A0 =A0acpi_ps_parse_loop
> =A0 =A0 =A0 =A0trace_hardirqs_on
> =A0 =A0 =A0 =A0acpi_ps_parse_aml
> =A0 =A0 =A0 =A0acpi_ps_execute_method
> =A0 =A0 =A0 =A0acpi_ns_eveluate
> =A0 =A0 =A0 =A0acpi_evaluate_object
> =A0 =A0 =A0 =A0acpi_battery_update
> =A0 =A0 =A0 =A0acpi_battery_add
> =A0 =A0 =A0 =A0acpi_device_probe
> =A0 =A0 =A0 =A0driver_probe_device
> =A0 =A0 =A0 =A0__driver_attach
> =A0 =A0 =A0 =A0bus_for_each_dev
> =A0 =A0 =A0 =A0driver_attach
> =A0 =A0 =A0 =A0__driver_attach
> =A0 =A0 =A0 =A0bus_add_driver
> =A0 =A0 =A0 =A0driver_register
> =A0 =A0 =A0 =A0trace_hardirqs_on_caller
> =A0 =A0 =A0 =A0acpi_bus_register_driver
> =A0 =A0 =A0 =A0acpi_battery_init_async
> =A0 =A0 =A0 =A0async_thread
> =A0 =A0 =A0 =A0default_wake_function
> =A0 =A0 =A0 =A0async_thread
> =A0 =A0 =A0 =A0kthread
> =A0 =A0 =A0 =A0kthread
> =A0 =A0 =A0 =A0kernel_thread_helper
>
> code:
> =A0 =A0 =A0 =A0fb 00 00 b8 0b 00 00 00 83 c4 14 e9 7a 01 =A0 00 00 31=
 c0 8b 7d d4 8b 4d dc 31 d2 f3 aa 6a 00
> =A0 =A0 =A0 =A00f b6 4b 1d 8b 43 10 8d 74 01 ff 89 f0 <f7> f1 31 d2 8=
9 45 cc 0f b6 43 1c 8d 04 06 8d 75 ec
> =A0 =A0 =A0 =A0f7 f1 31 d2
>
> eip: <c11c66dd> acpi_ex_extract_from_field+0x5c/0x1c3 ss:esp 0068:f66=
cdcf8
>
>
> =A0 =A0 =A0 =A0Sergey



--=20
--=20
=2E.....oooO..............
=2E....(....).....Oooo...
=2E.....)../.....(....)....
=2E....(_/.......)../.....
=2E..............(_/.......
=2E.. I WAS ..............
=2E......... HERE...... ;)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
