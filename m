From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 1/3] acpi: Add acpi mdio support code
Date: Mon, 12 Nov 2018 18:25:36 +0100
Message-ID: <20181112172536.GD5075@lunn.ch>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
 <2bf82b60c52bd3fc38b733e38fd991c9d31af6b9.1541660504.git.dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2bf82b60c52bd3fc38b733e38fd991c9d31af6b9.1541660504.git.dongsheng.wang@hxt-semitech.com>
Sender: netdev-owner@vger.kernel.org
To: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: timur@kernel.org, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 08, 2018 at 03:22:16PM +0800, Wang Dongsheng wrote:
> Add support for parsing the ACPI data node for PHY devices on an MDIO bus.
> The current implementation depend on mdio bus scan.
> With _DSD device properties we can finally do this:
> 
>     Device (MDIO) {
>         Name (_DSD, Package () {
>             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>             Package () { Package () { "ethernet-phy@0", PHY0 }, }
>         })
>         Name (PHY0, Package() {
>             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>             Package () { Package () { "reg", 0x0 }, }
>         })
>     }
> 
>     Device (MACO) {
>         Name (_DSD, Package () {
>             ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>             Package () { Package () { "phy-handle", \_SB.MDIO, "ethernet-phy@0" }, }
>         })
>     }
> 
> Documentations:
>     The DT "phy-handle" binding that we reuse for ACPI is documented in
>     Documentation/devicetree/bindings/phy/phy-bindings.txt
> 
>     Documentation/acpi/dsd/data-node-references.txt
>     Documentation/acpi/dsd/graph.txt
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
>  drivers/acpi/Kconfig       |   6 ++
>  drivers/acpi/Makefile      |   1 +
>  drivers/acpi/acpi_mdio.c   | 167 +++++++++++++++++++++++++++++++++++++
>  drivers/net/phy/mdio_bus.c |   3 +
>  include/linux/acpi_mdio.h  |  82 ++++++++++++++++++
>  5 files changed, 259 insertions(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 9705fc986da9..0fefa3410ce9 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -252,6 +252,12 @@ config ACPI_PROCESSOR_IDLE
>  config ACPI_MCFG
>  	bool
>  
> +config ACPI_MDIO
> +	def_tristate PHYLIB
> +	depends on PHYLIB
> +	help
> +	  ACPI MDIO bus (Ethernet PHY) accessors
> +
>  config ACPI_CPPC_LIB
>  	bool
>  	depends on ACPI_PROCESSOR
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 6d59aa109a91..ec7461a064fc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -41,6 +41,7 @@ acpi-y				+= ec.o
>  acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
>  acpi-y				+= pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
> +acpi-$(CONFIG_ACPI_MDIO)	+= acpi_mdio.o
>  acpi-y				+= acpi_lpss.o acpi_apd.o
>  acpi-y				+= acpi_platform.o
>  acpi-y				+= acpi_pnp.o
> diff --git a/drivers/acpi/acpi_mdio.c b/drivers/acpi/acpi_mdio.c
> new file mode 100644
> index 000000000000..293bf9a63197
> --- /dev/null

> +++ b/drivers/acpi/acpi_mdio.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Lots of code in this file is copy from drivers/of/of_mdio.c
> +// Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.

I agree with Rafael here. We should try to refactor and combine this
code. And where possible, we should try to add a uniform fwnode_ API
which underneath either uses OF or ACPI, depending on the type of the
node. We already have fwnode_get_mac_address(), fwmode_irq_get(),
fwnode_get_phy_mode(), so where possible, PHYs should be no different.

      Andrew
