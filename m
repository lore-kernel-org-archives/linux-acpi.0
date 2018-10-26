From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v3 2/2] net: qcom/emac: add phy-handle support for ACPI
Date: Fri, 26 Oct 2018 02:18:57 +0000
Message-ID: <0a55d42c839140dd9a5264ab4dae4c8e@HXTBJIDCEMVIW02.hxtcorp.net>
References: <78719753-77bd-596a-dfc7-ccd676850283@kernel.org>
 <cover.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <7935985e49270ad2948b2a52d26510bdf55572e6.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <20181025192430.GA16785@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "timur@kernel.org" <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2018/10/26 3:24, Andrew Lunn wrote:
> On Thu, Oct 25, 2018 at 06:09:15PM +0800, Wang Dongsheng wrote:
>> Use "phy-handle" to porint an internal MDIO device port.
> Hi Dongsheng
>
> You are basically defining how all future ACPI based MAC drivers get
> access to their PHY. This needs to become part of the ACPI standard,
> etc.
>
> This code should not be hidden away in the emac driver. It needs to be
> placed somewhere public so other drivers can use it. And it needs good
> documentation, including an example of what needs to go into the ACPI
> tables, etc.
Hi Andrew

I saw AppliedMicro(apm) xgene has used "phy-handle" for ACPI method, so
I guess "phy-handle" has become part of the ACPI standard. But I cannot
make sure.
I tried to confirm the property is defined in the document(Like DT
binding). However, I did not find any documentation on the description
property definition on the UEFI/ACPICA website.
But when I was reading Documentation/acpi/DSD-properties-rules.txt, my
understanding is we should try to conform to DT bindings. So maybe ACPI
doesn't have such a document, just DT bindings.

Cheers,
Dongsheng

> Thanks
> 	Andrew
>
