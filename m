From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
Date: Tue, 2 Jan 2018 14:33:47 +0100
Message-ID: <20180102133347.GB15036@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
 <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:50306 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbeABNd6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Jan 2018 08:33:58 -0500
Content-Disposition: inline
In-Reply-To: <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory =?iso-8859-1?Q?Cl=E9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz

> Apart from the phylink's SFP support that may require in-band
> management, it's an alternative to the normal PHY handling. Once MDIO
> bus + PHYs are supported for ACPI, phylib support will be used instead
> of the IRQs, so there should be no problem here.

Hi Marcin

However, phylib and phylink can use IRQs. The PHY can interrupt when
there is a change of state. This can be seen in the DT binding
documentation example:

ethernet-phy@0 {
        compatible = "ethernet-phy-id0141.0e90", "ethernet-phy-ieee802.3-c22";
        interrupt-parent = <&PIC>;
        interrupts = <35 IRQ_TYPE_EDGE_RISING>;
        reg = <0>;

Whatever ACPI support you propose needs to include interrupts.

May i suggest you take a look at
arch/arm/boot/dts/vf610-zii-dev-rev-c.dts and ensure your ACPI work
can support this. I know you tend to concentrate of Marvell parts.
Although it is a Freescale SoC, the Ethernet parts are all Marvell.

The SoC exports an MDIO bus. We then have an MDIO multiplexer, which
exports 8 MDIO busses. Of these only 2 are used in this design. Each
bus has an Ethernet switch. Each switch has an MDIO bus, which the
embedded PHYs are on. The Ethernet switch is also an interrupt
controller for the PHYs interrupts. So the PHYs have interrupt
properties pointing back to the switch.

	   Andrew



