From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v3 0/7] Armada 7k/8k PP2 ACPI support
Date: Wed, 17 Jan 2018 21:20:39 +0100
Message-ID: <20180117202039.GD5894@lunn.ch>
References: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Sender: netdev-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, graeme.gregory@linaro.org, davem@davemloft.net, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, f.fainelli@gmail.com, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, stefanc@marvell.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 17, 2018 at 05:55:39PM +0100, Marcin Wojtas wrote:
> Hi,
> 
> This is a third version of the patchset introducing mvpp2 driver ability
> to operate with ACPI. Until follow-up generic MDIO is introduced
> it can using the link interrupt capability (a.k.a. in-band management)
> on all ports, 1000BaseT RGMII included.
> Driver operation was tested on top of the net-next branch
> with both DT and ACPI on MacchiatoBin and Armada 7040 DB boards.
> 
> The main changes were requested during v2 review, which was
> adding generic helper routines for:
> * interating over available fwnodes (new patch 4/7)
> * getting IRQ directly from fwnode (new patch 3/7)
> Thanks to the latter the driver code could be simplified
> and allowed to drop formula-based IRQ obtaining. Changes are
> summarized in the changelog below.

Hi Marcin

I don't know enough about ACPI to make a proper review of the changes.

But it does at least all look sensible.

    Andrew
