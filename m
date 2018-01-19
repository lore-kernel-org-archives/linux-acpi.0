From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Fri, 19 Jan 2018 19:53:53 +0100
Message-ID: <20180119185353.GF13094@lunn.ch>
References: <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
 <20180118130026.GG32299@lunn.ch>
 <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine T?nart <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-ele>
List-Id: linux-acpi@vger.kernel.org

> Since I have a code that can be tested and easily modified to use
> different ACPI approaches with real platform MDIO controller
> (mvmdio.c) and NIC (mvpp2.c), in coming weeks I may be able to find
> some time to prepare a proof of concept based on GenericSerialBus.
> Please expect some RFC patches hopefully right after the coming merge
> window is closed.

It would also be interesting to know how the standardisation process
works.

I'm sure these is a FAQs, so maybe somebody could point us towards it.

Do we need to submit a proposed extension to the ACPI standard at the
same time as the patch? Should we not accept the code into Linux until
the proposal has been accepted? Or can we accept the code
provisionally, with the understanding that if the ACPI committee
rejects the extension, or suggest alternations, we can take the code
out of Linux without having to worry about backwards compatibility?

Thanks
      Andrew
