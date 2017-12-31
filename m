From: Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v2 0/5] Armada 7k/8k PP2 ACPI support
Date: Sun, 31 Dec 2017 12:58:35 +0100
Message-ID: <1514721520-18964-1-git-send-email-mw@semihalf.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36309 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdLaL6w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Dec 2017 06:58:52 -0500
Received: by mail-lf0-f68.google.com with SMTP id c19so31953832lfg.3
        for <linux-acpi@vger.kernel.org>; Sun, 31 Dec 2017 03:58:51 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: graeme.gregory@linaro.org, davem@davemloft.net, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, ezequiel.garcia@free-electrons.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com

Hi,

This a second version of a patchset, which introduces ACPI support
in mvpp2 driver. Comparing to the initial one, all patches
touching generic ACPI MDIO bus / PHY handling were removed
and after some modifications will be resend separately. They
may require a longer discussion in terms of phylink support
and ACPI specification extensions.

This way mvpp2 driver is able to operate using the link interrupt
capability (a.k.a. in-band management) on all ports, 1000BaseT RGMII
included. Driver operation was tested on top of the net-next branch
with both DT and ACPI on MacchiatoBin and Armada 7040 DB boards.

mvpp2 driver can work with the ACPI representation, as exposed
on a public branch:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
It was compiled together with the most recent Tianocore EDK2 revision.
Please refer to the firmware build instruction on MacchiatoBin board:
http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II

ACPI representation of PP2 controllers (withouth PHY support) can
be viewed in the github:
* MacchiatoBin:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/marvell-armada-wip/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl#L201

* Armada 7040 DB:
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/marvell-armada-wip/Platforms/Marvell/Armada/AcpiTables/Armada70x0/Dsdt.asl#L131

I will appreciate any comments or remarks.

Best regards,
Marcin

Changelog:
v1 -> v2:
* Remove MDIO patches
* Use PP2 ports only with link interrupts
* Release second region resources in mvpp2 driver (code moved from
  mvmdio), as explained in details in 5/5 commit message.

Marcin Wojtas (5):
  device property: Introduce fwnode_get_mac_address()
  device property: Introduce fwnode_get_phy_mode()
  net: mvpp2: simplify maintaining enabled ports' list
  net: mvpp2: use device_*/fwnode_* APIs instead of of_*
  net: mvpp2: enable ACPI support in the driver

 drivers/base/property.c              |  52 +++--
 drivers/net/ethernet/marvell/mvpp2.c | 222 ++++++++++++--------
 include/linux/property.h             |   3 +
 3 files changed, 180 insertions(+), 97 deletions(-)

-- 
2.7.4

