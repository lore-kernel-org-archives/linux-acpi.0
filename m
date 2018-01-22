From: David Miller <davem@davemloft.net>
Subject: Re: [net-next: PATCH v4 0/7] Armada 7k/8k PP2 ACPI support
Date: Mon, 22 Jan 2018 10:57:50 -0500 (EST)
Message-ID: <20180122.105750.1953487955261969355.davem@davemloft.net>
References: <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
 <20180122.093525.1549534484738907077.davem@davemloft.net>
 <20180122144342.GB16923@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180122144342.GB16923@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andrew@lunn.ch
Cc: thomas.petazzoni@free-electrons.com, f.fainelli@gmail.com, graeme.gregory@linaro.org, ard.biesheuvel@linaro.org, netdev@vger.kernel.org, antoine.tenart@free-electrons.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, nadavh@marvell.com, linux-acpi@vger.kernel.org, neta@marvell.com, jaz@semihalf.com, gregory.clement@free-electrons.com, stefanc@marvell.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, tn@semihalf.com
List-Id: linux-acpi@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 22 Jan 2018 15:43:42 +0100

> On Mon, Jan 22, 2018 at 09:35:25AM -0500, David Miller wrote:
>> From: Marcin Wojtas <mw@semihalf.com>
>> Date: Mon, 22 Jan 2018 14:00:37 +0100
>> 
>> > There's a discussion about the ACPI vs generic MDIO/PHY change under
>> > initial version of the patchset, however the patches in question were
>> > for now abandoned from further re-sends.
>> 
>> But doesn't the results of that discussion determine whether the way ACPI
>> is being used in this patch series is what we want to do or not?
> 
> Hi David
> 
> The patches submitted here don't involve any ACPI for MDIO or PHY. It
> is all MAC. And it is using standard ACPI primitives for devices,
> nothing new.
> 
> It is not setting any precedence for MDIO and PHY. That is totally out
> of scope for these patches. Whatever is decided for MDIO and PHY can
> be added later.

Thanks for all of the clarifications.

Series applied to net-next, thank you.
