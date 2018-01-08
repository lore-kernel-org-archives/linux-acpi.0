From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Mon, 8 Jan 2018 16:42:43 +0100
Message-ID: <20180108154243.GA30962@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:60451 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933735AbeAHPmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Jan 2018 10:42:51 -0500
Content-Disposition: inline
In-Reply-To: <20180108151453.GB31502@xora-haswell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nad>

w> I am not familiar with MDIO, but if its similar or a specific
> implementation of a serial bus that does sound sane!

It is a two wire serial bus. A good overview can be found here:

https://www.totalphase.com/support/articles/200349206-MDIO-Background

	Andrew
