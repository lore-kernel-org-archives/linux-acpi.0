From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Mon, 12 Nov 2018 18:20:19 +0100
Message-ID: <20181112172019.GC5075@lunn.ch>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
 <20181108232353.GL5259@lunn.ch>
 <6ebdf08060c245a8a44fc4263eb308cc@HXTBJIDCEMVIW02.hxtcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ebdf08060c245a8a44fc4263eb308cc@HXTBJIDCEMVIW02.hxtcorp.net>
Sender: netdev-owner@vger.kernel.org
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> > I'm just trying to ensure whatever is defined is flexible enough that
> > we really can later support everything which DT does. We have PHYs on
> > MDIO busses, inside switches, which are on MDIO busses, which are
> > inside Ethernet interfaces, etc.
> 
> I think it can be satisfied. See the table I'm using above.

Hi Dongsheng


Since i don't know anything better, i think i have to trust you have
this correct.

It would be good to document this, so that the next person who needs
to add ACPI support for a PHY has some documentation to look at.
Could you add something to Documentation/acpi/dsd?

      Andrew
