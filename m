From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Tue, 13 Nov 2018 07:36:50 +0000
Message-ID: <73a646f1a1984f47b2c15ec4711c6be2@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
 <20181108232353.GL5259@lunn.ch>
 <6ebdf08060c245a8a44fc4263eb308cc@HXTBJIDCEMVIW02.hxtcorp.net>
 <20181112172019.GC5075@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, "timur@kernel.org" <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hello Rafael,

On 2018/11/13 1:19, Andrew Lunn wrote:
>>> I'm just trying to ensure whatever is defined is flexible enough that
>>> we really can later support everything which DT does. We have PHYs on
>>> MDIO busses, inside switches, which are on MDIO busses, which are
>>> inside Ethernet interfaces, etc.
>> I think it can be satisfied. See the table I'm using above.
> Hi Dongsheng
>
>
> Since i don't know anything better, i think i have to trust you have
> this correct.
>
> It would be good to document this, so that the next person who needs
> to add ACPI support for a PHY has some documentation to look at.
> Could you add something to Documentation/acpi/dsd?

How about Andrew suggestion? I agree with Andrew.

Or We need to add the documentation to Documentation/acpi?
I see that both GPIO and I2C are down here.


Cheers,
Dongsheng
