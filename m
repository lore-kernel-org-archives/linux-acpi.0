From: Xavier Gnata <xavier.gnata@gmail.com>
Subject: Sony vaio serie F PCIe PME service failure.
Date: Fri, 21 May 2010 23:44:04 +0200
Message-ID: <4BF6FEA4.1050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63804 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0EUVoG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2010 17:44:06 -0400
Received: by gyg13 with SMTP id 13so686129gyg.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2010 14:44:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I get that during the boot of the vaio VPCF11M1E using unpatched 2.6.34
from kernel.org:

[    2.047242] pcieport 0000:00:01.0: Failed to receive control of PCIe
PME service: ACPI _OSC failed
[    2.047249] pcie_pme: probe of 0000:00:01.0:pcie01 failed with error -13
[    2.047418] pcieport 0000:00:1c.0: Failed to receive control of PCIe
PME service: ACPI _OSC failed
[    2.047424] pcie_pme: probe of 0000:00:1c.0:pcie01 failed with error -13
[    2.047589] pcieport 0000:00:1c.1: Failed to receive control of PCIe
PME service: ACPI _OSC failed
[    2.047595] pcie_pme: probe of 0000:00:1c.1:pcie01 failed with error -13
[    2.047759] pcieport 0000:00:1c.2: Failed to receive control of PCIe
PME service: ACPI _OSC failed
[    2.047764] pcie_pme: probe of 0000:00:1c.2:pcie01 failed with error -13
[    2.047928] pcieport 0000:00:1c.5: Failed to receive control of PCIe
PME service: ACPI _OSC failed
[    2.047933] pcie_pme: probe of 0000:00:1c.5:pcie01 failed with error -13

for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done
returns :

/sys/bus/pnp/devices/00:00
PNP0a08
PNP0a03
/sys/bus/pnp/devices/00:01
PNP0200
/sys/bus/pnp/devices/00:02
INT0800
/sys/bus/pnp/devices/00:03
PNP0103
/sys/bus/pnp/devices/00:04
PNP0c04
/sys/bus/pnp/devices/00:05
PNP0c02
/sys/bus/pnp/devices/00:06
PNP0b00
/sys/bus/pnp/devices/00:07
PNP0303
/sys/bus/pnp/devices/00:08
SNY9011
PNP0f13
/sys/bus/pnp/devices/00:09
PNP0c02
/sys/bus/pnp/devices/00:0a
PNP0a03


Everthing looks fine except these messages during the boot.
Any clue about what's going wrong? (maybe nothing...)
I don't use any special boot options:
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

Xavier

