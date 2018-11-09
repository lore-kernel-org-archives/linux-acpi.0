From: Timur Tabi <timur@kernel.org>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Thu, 8 Nov 2018 18:37:25 -0600
Message-ID: <f86b43f0-bb72-e445-7bc0-254f07acda17@kernel.org>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
 <20181108232353.GL5259@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108232353.GL5259@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/8/18 5:23 PM, Andrew Lunn wrote:
> I don't know much about ACPI. I do know DT. MDIO busses can have
> multiple PHYs on them. Is the following valid to list two PHYs?
> 
>       Device (MDIO) {
>           Name (_DSD, Package () {
>               ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>               Package () { Package () { "ethernet-phy@0", PHY0 }, }
>           })
>           Name (PHY0, Package() {
>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>               Package () { Package () { "reg", 0x0 }, }
>           })
>           Name (_DSD, Package () {
>               ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>               Package () { Package () { "ethernet-phy@10", PHY1 }, }
>           })
>           Name (PHY1, Package() {
>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>               Package () { Package () { "reg", 0x10 }, }
>           })
>       }

You can't have the same DSD twice.  It would need to look like this:

          Name (PHY1, Package() {
              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
              Package () { Package () { "reg", 0, 0x10 }, }
          })
