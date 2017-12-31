From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
Date: Sun, 31 Dec 2017 20:23:54 +0100
Message-ID: <20171231192354.GB20455@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1514721520-18964-6-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: thomas.petazzoni@free-electrons.com, f.fainelli@gmail.com, graeme.gregory@linaro.org, ard.biesheuvel@linaro.org, netdev@vger.kernel.org, antoine.tenart@free-electrons.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, nadavh@marvell.com, linux-acpi@vger.kernel.org, neta@marvell.com, ezequiel.garcia@free-electrons.com, jaz@semihalf.com, gregory.clement@free-electrons.com, tn@semihalf.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

> * Modify way of obtaining interrupts - with ACPI they are resources
>   bound to struct platform_device and it's not possible to obtain
>   them directly from the child node. Hence a formula is used, depending
>   on the port_id and number of possible CPUs.

Hi Marcin

I know nothing about ACPI. Is this limitation with respect to
interrupts fundamental to ACPI, or just that nobody has implemented
flexible interrupt support yet?

> * Until proper MDIO bus and PHY handling with ACPI is established in the
>   kernel, use only link interrupts feature in the driver.

I think interrupts might be interesting with PHY devices, since they
are child nodes of the MDIO device....

    Andrew
