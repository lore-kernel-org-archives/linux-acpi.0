From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Mon, 8 Jan 2018 15:53:12 +0100
Message-ID: <20180108145312.GH10940@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:60372 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932785AbeAHOx0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Jan 2018 09:53:26 -0500
Content-Disposition: inline
In-Reply-To: <20180108144548.GA31502@xora-haswell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nad>

On Mon, Jan 08, 2018 at 02:45:48PM +0000, Graeme Gregory wrote:
> On Thu, Jan 04, 2018 at 05:20:36PM +0100, Andrew Lunn wrote:
> > > > I already agreed with 'reg' being awkward in the later emails.
> > > > Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
> > > > 
> > > Ah it is an actual address, then yes _ADR is probably more appropriate.
> > 
> > Newbie ACPI question. What is the definition of an address?
> > 
> > In this cause, we are talking about an address of a device on an MDIO
> > bus. It takes a value between 0 and 31.
> > 
> > How are IC2 device addresses represented in ACPI? MDIO devices and I2C
> > devices are pretty similar. So it would make sense to use the same as
> > what I2C uses.
> > 
> Too big (and has table) to sensibly quote, but defined in ACPI spec
> 
> 6.1.1 _ADR (Address)
> 
> Ive never though been quite sure if that is just an example list of
> address types or its supposed to be canonical (in which case some ECRs
> are needed to the spec).

Hi Graeme

I took a quick look at version 6.2, and noticed i2c devices use
_ADR(). So using it for MDIO seems O.K.

However, i2c, spi and uart devices all seem to be described using
GenericSerialBus. Maybe the correct way to describe MDIO devices is to
also use GenericSerialBus?

     Andrew


