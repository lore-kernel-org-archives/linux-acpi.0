From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: HP Compaq nc6320
Date: Wed, 11 Oct 2006 23:08:36 +0100
Message-ID: <1160604516.5349.14.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:44231 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161549AbWJKWIl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 18:08:41 -0400
Received: from acce212d.ipt.aol.com ([172.206.33.45]:60736 helo=[192.168.1.70])
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1GXmFg-0003yj-Om (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Wed, 11 Oct 2006 23:08:36 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I decided to revert the HP bios back to F.06, and now - to my surprise,
on boot, I get an extra SSDT! (The CpuPm one).

[17179569.184000] ACPI: RSDP (v000
HP                                    ) @ 0x000f7d70
[17179569.184000] ACPI: RSDT (v001 HP     30AA     0x28040620 HP
0x00000001) @ 0x3f7e5684
[17179569.184000] ACPI: FADT (v002 HP     30AA     0x00000002 HP
0x00000001) @ 0x3f7e5600
[17179569.184000] ACPI: MADT (v001 HP     30AA     0x00000001 HP
0x00000001) @ 0x3f7e56c0
[17179569.184000] ACPI: MCFG (v001 HP     30AA     0x00000001 HP
0x00000001) @ 0x3f7e5728
[17179569.184000] ACPI: TCPA (v002 HP     30AA     0x00000001 HP
0x00000001) @ 0x3f7e5764
[17179569.184000] ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT
0x0100000e) @ 0x3f7f4af8
[17179569.184000] ACPI: SSDT (v001 HP        CpuPm 0x00003000 INTL
0x20050624) @ 0x3f7f5327
[17179569.184000] ACPI: DSDT (v001 HP       nc6340 0x00010000 MSFT
0x0100000e) @ 0x00000000

The CpuPm SSDT table contains _PDC and _OSC methods, and generally looks
useful.

Still, linux doesn't load either speedstep-centrino, or acpi-speedstep.
I'll poke some more, but it looks promising.

I wounder why the BIOS F.08 doesn't have the CpuPm SSDT? It appeared to
flash correctly when I first installed it. Perhaps even booting windows
(to downgrade to F.06) had some effect on the bios to bring back the
SSDT? Perhaps it is only in the F.06.

Does anyone have any contacts with HP who might shed any light on this?

Regards

Peter Clifton


