From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: CS553x MFD doesn't get registered on Axiomtek SBC84622 (Geode LX) =?iso-8859-1?Q?due_to_a_conflict_between_SystemIO_and_OpRegion_ranges?=
Date: Thu, 11 May 2017 18:00:39 +0200
Message-ID: <ddb1c055-2483-496f-9095-942bab029b6e@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from office2.cesnet.cz ([195.113.144.244]:33183 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdEKQHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2017 12:07:38 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:ad0a:52e5:c55e:e1c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 84FB820006
        for <linux-acpi@vger.kernel.org>; Thu, 11 May 2017 18:00:39 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I have an Axiomtek SBC84622, a board based on AMD Geode LX which uses a=20
CS553x MFD for providing access to the I2C bus master and some GPIO pins=20
(and other stuff). I'm running 4.9.23, and driver/device registration fails=20=

on my board due to some conflict in the ACPI data. As a result of that,=20
kernel says that "MFD add devices failed" with EBUSY (-16), and no I2C bus=20=

is visible.

I went through the cs5535_mfd_probe -> mfd_add_devices -> mfd_add_device=20
call chain. The function that fails is `acpi_check_resource_conflict`=20
within the `mfd_add_device`. Because I am brave and clueless when it comes=20=

to ACPI, I commented out the `goto fail_alias` so that a failed validation=20=

of the ACPI data doesn't cause mfd_add_device's failure, and after that,=20
the I2C bus started working and all devices were registered properly as far=20=

as I can tell. Here's what gets shown in the dmesg after I added a couple=20
more printks:

[    0.533493] mfd_add_devices: calling mfd_add_device 0
[    0.533796] mfd_add_devices: calling mfd_add_device 1
[    0.533898] ACPI Warning: SystemIO range=20
0x0000000000006100-0x00000000000061FF conflicts with OpRegion=20
0x0000000000006100-0x00000000000061FF (\_SB.GPIO)=20
(20160831/utaddress-247)\x007)
[    0.534232] ACPI: If an ACPI driver is available for this device, you=20
should use it instead of the native driver
[    0.534367] PWN mfd_add_device: acpi_check_resource_conflict failed
[    0.534670] cs5535-gpio cs5535-gpio: reserved resource region [io =20
0x6100-0x61ff]
[    0.535145] mfd_add_devices: calling mfd_add_device 2
[    0.535449] cs5535-mfgpt cs5535-mfgpt: reserved resource region [io =20
0x6200-0x623f]
[    0.535582] cs5535-mfgpt cs5535-mfgpt: 0 MFGPT timers available
[    0.535673] mfd_add_devices: calling mfd_add_device 3
[    0.535934] mfd_add_devices: calling mfd_add_device 4
[    0.536073] ACPI Warning: SystemIO range=20
0x0000000000009C00-0x0000000000009C3F conflicts with OpRegion=20
0x0000000000009C3C-0x0000000000009C3C (\SCPP)=20
(20160831/utaddress-247)\x007)
[    0.536342] ACPI Warning: SystemIO range=20
0x0000000000009C00-0x0000000000009C3F conflicts with OpRegion=20
0x0000000000009C24-0x0000000000009C27 (\VSAB)=20
(20160831/utaddress-247)\x007)
[    0.536604] ACPI: If an ACPI driver is available for this device, you=20
should use it instead of the native driver
[    0.536735] PWN mfd_add_device: acpi_check_resource_conflict failed
[    0.536992] cs5535-mfd 0000:00:0f.0: 5 devices registered.

I.e., registration of subdevices #1 and #4 would fail if the mfd_add_device=20=

cared about the acpi_check_resource_conflict.

I've checked the manufacturer's database for an updated BIOS, but it seems=20=

that they don't provide anything. The version that I have is "1.0.0" dating=20=

back to 2009, so I don't think there are big chances of a fix from the=20
vendor. I'm quite happy that I now have my I2C. I would be even happier if=20=

the geode_wdt also started working, but that's for some other time.

What can I do in order to fix this properly? I very quickly glanced through=20=

the log of drivers/mfd/mfd-core.c and I see some bits which suggest that=20
maybe this particular board might need some more quirks. I have=20
approximately zero knowledge of ACPI and kernel programming. I'll be happy=20=

to test patches which fix this, and I can also provide dumps of ACPI tables=20=

or whatever else is needed.

With kind regards,
Jan
