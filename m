From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v2 4/5] net: mvpp2: use device_*/fwnode_* APIs
 instead of of_*
Date: Sun, 31 Dec 2017 20:18:36 +0100
Message-ID: <20171231191836.GA20455@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-5-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:49479 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdLaTSt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Dec 2017 14:18:49 -0500
Content-Disposition: inline
In-Reply-To: <1514721520-18964-5-git-send-email-mw@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, graeme.gregory@linaro.org, davem@davemloft.net, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, f.fainelli@gmail.com, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, ezequiel.garcia@free-electrons.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com

On Sun, Dec 31, 2017 at 12:58:39PM +0100, Marcin Wojtas wrote:
Hi Marcin

> Because there is no equivalent for for_each_available_child_of_node(),
> use device_for_each_child_node() and check the port availability
> inside the mvpp2_port_probe() routine.

Could device_each_available_child_node() be added? I guess this will
not be the last driver converted in this way, and having that macro
will help with future ports.

     Andrew
