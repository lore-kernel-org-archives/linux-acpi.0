From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v4 0/7] Armada 7k/8k PP2 ACPI support
Date: Mon, 22 Jan 2018 15:43:42 +0100
Message-ID: <20180122144342.GB16923@lunn.ch>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
 <20180118132322.GE2690@kwain>
 <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
 <20180122.093525.1549534484738907077.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:58564 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeAVOn4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 09:43:56 -0500
Content-Disposition: inline
In-Reply-To: <20180122.093525.1549534484738907077.davem@davemloft.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mw@semihalf.com, linux-kernel@vger.kernel.org, antoine.tenart@free-electrons.com, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, graeme.gregory@linaro.org, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, f.fainelli@gmail.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, stefanc@marvell.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com

On Mon, Jan 22, 2018 at 09:35:25AM -0500, David Miller wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> Date: Mon, 22 Jan 2018 14:00:37 +0100
> 
> > There's a discussion about the ACPI vs generic MDIO/PHY change under
> > initial version of the patchset, however the patches in question were
> > for now abandoned from further re-sends.
> 
> But doesn't the results of that discussion determine whether the way ACPI
> is being used in this patch series is what we want to do or not?

Hi David

The patches submitted here don't involve any ACPI for MDIO or PHY. It
is all MAC. And it is using standard ACPI primitives for devices,
nothing new.

It is not setting any precedence for MDIO and PHY. That is totally out
of scope for these patches. Whatever is decided for MDIO and PHY can
be added later.

   Andrew
