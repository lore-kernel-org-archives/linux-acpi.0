From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Mon, 12 Nov 2018 02:52:46 +0000
Message-ID: <ee74146068b04503a89c4a05d4e19792@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
 <20181108232353.GL5259@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "timur@kernel.org" <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2018/11/9 7:23, Andrew Lunn wrote:
> I'm just trying to ensure whatever is defined is flexible enough that
> we really can later support everything which DT does. We have PHYs on
> MDIO busses, inside switches, which are on MDIO busses, which are
> inside Ethernet interfaces, etc.
>
> An MDIO bus is very similar to an i2c bus. How is that described in
> ACPI? Anything we can learn from that?

All the documents I've seen are from UEFII/ACPICA and I have not seen any
independent description of MDIO in the ACPI documents. Maybe I missed a
document, too.

I think not all devices need to be described in ACPI. The ACPI defines what
should be included in a device, as well as some special definitions. Our
MDIO
doesn't need a special definition, because it's enough to use a generic ACPI
description. I think that's why MDIO doesn't have a separate description.

Cheers,
Dongsheng
