From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
Date: Tue, 2 Jan 2018 15:08:52 +0100
Message-ID: <20180102140852.GE15036@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
 <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
 <20180102133347.GB15036@lunn.ch>
 <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, linux-acpi@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory =?iso-8859-1?Q?Cl=E9ment?= <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, nadavh@marvell.com, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz Jaszczyk <jaz@semihalf.com>, Tomasz
List-Id: linux-acpi@vger.kernel.org

> Indeed in of_mdio_bus_register_phy, there is of_irq_get. This is more
> a discussion for a MDIO bus / ACPI patchset, but we either find a way
> to use IRQs with ACPI obtained from child nodes or for this world the
> functionality will be limited (at least for the beginning).

Hi Marcin

What i want to avoid is adding something which partially works, and
then have to throw it all away and start again in order to add full
support.

If ACPI really limits interrupts to devices, maybe we need a totally
different representation of MDIO and PHYs in ACPI to what it used in
device tree? The same may be true for the Ethernet ports of the mvpp2?
They might have to be represented as real devices, not children of a
device? Maybe trying to map DT to ACPI on a one-to-one basis is the
wrong approach?

	Andrew
