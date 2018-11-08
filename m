From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Fri, 9 Nov 2018 00:23:53 +0100
Message-ID: <20181108232353.GL5259@lunn.ch>
References: <20181029124044.GB9174@lunn.ch>
 <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Sender: netdev-owner@vger.kernel.org
To: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: timur@kernel.org, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 08, 2018 at 03:21:29PM +0800, Wang Dongsheng wrote:
> Originally I just push "phy-handle" support for ACPI on the QCOM QDF2400
> platform. After some discussion and following Andrew's advice, I send
> out with a generic version of ACPI.
> 
> Current there is no clear documentation about MDIO/PHY for ACPI, so when
> I reading some documents about ACPI [1], I think we just need to reuse the
> DT binding in the ACPI.[2]. However, this series of patches are not
> fully compatible with all contents specified in DT binding.
> 
> The most important thing about this iseries is link the phy device and
> fwnode of acpi. Besides, we need to carry out bus scan at the mdio
> register. Therefore, I am not compatible with more DT binding properties
> in this series of patches. More support will be in the follow-up patches
> support, or some people do the support.
> 
> Example:
> Based on ACPI doc:
>     Documentation/acpi/dsd/data-node-references.txt
>     Documentation/acpi/dsd/graph.txt
> With _DSD device properties we can finally do this:
>     Device (MDIO) {
>         Name (_DSD, Package () {
>             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>             Package () { Package () { "ethernet-phy@0", PHY0 }, }
>         })
>         Name (PHY0, Package() {
>             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>             Package () { Package () { "reg", 0x0 }, }
>         })

I don't know much about ACPI. I do know DT. MDIO busses can have
multiple PHYs on them. Is the following valid to list two PHYs?

     Device (MDIO) {
         Name (_DSD, Package () {
             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
             Package () { Package () { "ethernet-phy@0", PHY0 }, }
         })
         Name (PHY0, Package() {
             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
             Package () { Package () { "reg", 0x0 }, }
         })
         Name (_DSD, Package () {
             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
             Package () { Package () { "ethernet-phy@10", PHY1 }, }
         })
         Name (PHY1, Package() {
             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
             Package () { Package () { "reg", 0x10 }, }
         })
     }


An MDIO bus can also have more than PHYs on them. There can be
Ethernet switches. Broadcom also have some with generic PHY devices on
them, and other odd things. That means whatever is on an MDIO bus is a
device in the Linux device model. How does that work? Do we need some
form Device (PHY) {}?

     Device (MDIO) {
         Device (PHY) {
             Name (_DSD, Package () {
                 ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                 Package () { Package () { "ethernet-phy@0", PHY0 }, }
             })
             Name (PHY0, Package() {
                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                 Package () { Package () { "reg", 0x0 }, }
             })
         }
         Device (PHY) {
             Name (_DSD, Package () {
                 ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                 Package () { Package () { "ethernet-phy@10", PHY1 }, }
             })
             Name (PHY1, Package() {
                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                 Package () { Package () { "reg", 0x10 }, }
             })
         Device (SWITCH) {
             Name (_DSD, Package () {
                 ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                 Package () { Package () { "switch@11", SWITCH0 }, }
             })
             Name (SWITCH0, Package() {
                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                 Package () { Package () { "reg", 0x11 }, }
             })
         }
      }

I'm just trying to ensure whatever is defined is flexible enough that
we really can later support everything which DT does. We have PHYs on
MDIO busses, inside switches, which are on MDIO busses, which are
inside Ethernet interfaces, etc.

An MDIO bus is very similar to an i2c bus. How is that described in
ACPI? Anything we can learn from that?

      Thanks
         Andrew
