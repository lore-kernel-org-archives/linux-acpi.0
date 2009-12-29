From: Albert Vilella <avilella@gmail.com>
Subject: another discrete nvidia switch on/off for an assortment of laptops
Date: Tue, 29 Dec 2009 22:30:47 +0000
Message-ID: <358f4d650912291430u5e266764jd98a814621659c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40692 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbZL2Wat (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 17:30:49 -0500
Received: by ewy19 with SMTP id 19so3180155ewy.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 14:30:47 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi again,

In this occasion not providing a working module, but just a grep to
show 5 different laptop
models that use an almost identical ACPI call to report on the
discrete nvidia graphics switch:

All DSDT.dsl files are available here:
https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/312756
grep -e NVIF *.dsl

Acer_Aspire_7530G_nv.dsl:                Name (_UID, "NVIF")
Acer_Aspire_7530G_nv.dsl:                        Return
(\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
Acer_Aspire_7530G_nv.dsl:                    Method (NVIF, 3, NotSerialized)
Dell_Studio_XPS_13_nv.dsl:                Name (_UID, "NVIF")
Dell_Studio_XPS_13_nv.dsl:                        Return
(\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
Dell_Studio_XPS_13_nv.dsl:                    Method (NVIF, 3, NotSerialized)
Elitegroup_GF8100VM_nv.dsl:                            Name (_UID, "NVIF")
Elitegroup_GF8100VM_nv.dsl:                                    Return
(^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
Elitegroup_GF8100VM_nv.dsl:                    Method (NVIF, 3, NotSerialized)
MSI_EX630-034US.dsl:                            Name (_UID, "NVIF")
MSI_EX630-034US.dsl:                                    Return
(^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
MSI_EX630-034US.dsl:                    Method (NVIF, 3, NotSerialized)
MSI_EX630_nv.dsl:                            Name (_UID, "NVIF")
MSI_EX630_nv.dsl:                                    Return
(^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
MSI_EX630_nv.dsl:                    Method (NVIF, 3, NotSerialized)
Toshiba_Qosmio_X305_nv.dsl:                Name (_UID, "NVIF")
Toshiba_Qosmio_X305_nv.dsl:                        Return
(\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
Toshiba_Qosmio_X305_nv.dsl:                    Method (NVIF, 3, NotSerialized)

Cheers,

Albert.
