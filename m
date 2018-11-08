From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Thu, 8 Nov 2018 15:21:29 +0800
Message-ID: <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
References: <20181029124044.GB9174@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181029124044.GB9174@lunn.ch>
Sender: netdev-owner@vger.kernel.org
To: andrew@lunn.ch, timur@kernel.org
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Originally I just push "phy-handle" support for ACPI on the QCOM QDF2400
platform. After some discussion and following Andrew's advice, I send
out with a generic version of ACPI.

Current there is no clear documentation about MDIO/PHY for ACPI, so when
I reading some documents about ACPI [1], I think we just need to reuse the
DT binding in the ACPI.[2]. However, this series of patches are not
fully compatible with all contents specified in DT binding.

The most important thing about this iseries is link the phy device and
fwnode of acpi. Besides, we need to carry out bus scan at the mdio
register. Therefore, I am not compatible with more DT binding properties
in this series of patches. More support will be in the follow-up patches
support, or some people do the support.

Example:
Based on ACPI doc:
    Documentation/acpi/dsd/data-node-references.txt
    Documentation/acpi/dsd/graph.txt
With _DSD device properties we can finally do this:
    Device (MDIO) {
        Name (_DSD, Package () {
            ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
            Package () { Package () { "ethernet-phy@0", PHY0 }, }
        })
        Name (PHY0, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () { Package () { "reg", 0x0 }, }
        })
    }

    Device (MACO) {
        Name (_DSD, Package () {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () { Package () { "phy-handle", \_SB.MDIO, "ethernet-phy@0" }, }
        })
    }

Tested: QDF2400 (ACPI), buildin/insmod/rmmod

[1]:
Documentation/acpi/dsd/data-node-references.txt
Documentation/acpi/dsd/graph.txt

[2]:
Documentation/devicetree/bindings/phy/phy-bindings.txt
https://lore.kernel.org/patchwork/patch/597296/

Wang Dongsheng (3):
  acpi: Add acpi mdio support code
  net: qcom/emac: split phy_config to mdio bus create and get phy device
  net: qcom/emac: add phy-handle support for ACPI

 drivers/acpi/Kconfig                          |   6 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/acpi_mdio.c                      | 167 ++++++++++++++++++
 drivers/net/ethernet/qualcomm/emac/emac-mac.c |  19 +-
 drivers/net/ethernet/qualcomm/emac/emac-phy.c | 142 ++++++++++-----
 drivers/net/phy/mdio_bus.c                    |   3 +
 include/linux/acpi_mdio.h                     |  82 +++++++++
 7 files changed, 369 insertions(+), 51 deletions(-)
 create mode 100644 drivers/acpi/acpi_mdio.c
 create mode 100644 include/linux/acpi_mdio.h

-- 
2.18.0
