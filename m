From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [RFC PATCH 0/3] acpi: Add acpi mdio support code
Date: Sat, 10 Nov 2018 09:10:34 +0000
Message-ID: <6ebdf08060c245a8a44fc4263eb308cc@HXTBJIDCEMVIW02.hxtcorp.net>
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

Hi Andrew,

On 2018/11/9 7:23, Andrew Lunn wrote:
> On Thu, Nov 08, 2018 at 03:21:29PM +0800, Wang Dongsheng wrote:
>> Originally I just push "phy-handle" support for ACPI on the QCOM QDF2400
>> platform. After some discussion and following Andrew's advice, I send
>> out with a generic version of ACPI.
>>
>> Current there is no clear documentation about MDIO/PHY for ACPI, so when
>> I reading some documents about ACPI [1], I think we just need to reuse the
>> DT binding in the ACPI.[2]. However, this series of patches are not
>> fully compatible with all contents specified in DT binding.
>>
>> The most important thing about this iseries is link the phy device and
>> fwnode of acpi. Besides, we need to carry out bus scan at the mdio
>> register. Therefore, I am not compatible with more DT binding properties
>> in this series of patches. More support will be in the follow-up patches
>> support, or some people do the support.
>>
>> Example:
>> Based on ACPI doc:
>>     Documentation/acpi/dsd/data-node-references.txt
>>     Documentation/acpi/dsd/graph.txt
>> With _DSD device properties we can finally do this:
>>     Device (MDIO) {
>>         Name (_DSD, Package () {
>>             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>>             Package () { Package () { "ethernet-phy@0", PHY0 }, }
>>         })
>>         Name (PHY0, Package() {
>>             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>             Package () { Package () { "reg", 0x0 }, }
>>         })
> I don't know much about ACPI. I do know DT. MDIO busses can have
> multiple PHYs on them. Is the following valid to list two PHYs?
>
>      Device (MDIO) {
>          Name (_DSD, Package () {
>              ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>              Package () { Package () { "ethernet-phy@0", PHY0 }, }
>          })
>          Name (PHY0, Package() {
>              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>              Package () { Package () { "reg", 0x0 }, }
>          })
>          Name (_DSD, Package () {
>              ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>              Package () { Package () { "ethernet-phy@10", PHY1 }, }
>          })
>          Name (PHY1, Package() {
>              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>              Package () { Package () { "reg", 0x10 }, }
>          })
>      }

Multiple PHYs example:


    Device (MDIO)
    {
        Name (_DSD, Package () {
        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
            Package () {

                Package () { "ethernet-phy@0", PHY0 },

                Package () { "ethernet-phy@1", PHY1 },
                ...

                ...

            }
        })
       
        Name (PHY0, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "reg", 0x0 },
            }
        })


        Name (PHY1, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "reg", 0x1 },
            }
        })
   }

    Device (MAC0)

    {

        // _DSD: Device-Specific Data
        Name (_DSD, Package (0x02) {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
            Package () {
                Package () { "phy-handle", Package () { \_SB.MDIO,
"ethernet-phy@0" } },
                ...
                ...
            }
        })

    }


    Device (MAC1)

    {

        // _DSD: Device-Specific Data
        Name (_DSD, Package (0x02) {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
            Package () {
                Package () { "phy-handle", Package () { \_SB.MDIO,
"ethernet-phy@1" } },
                ...
                ...
            }
        })

    }

>
> An MDIO bus can also have more than PHYs on them. There can be
> Ethernet switches. Broadcom also have some with generic PHY devices on
> them, and other odd things. That means whatever is on an MDIO bus is a
> device in the Linux device model. How does that work? Do we need some
> form Device (PHY) {}?

ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b") describes a ACPI data node.

The data node can contain property or pointer.


Let's look at the table I'm using:

Device (MAC1)
{
    // _DSD: Device-Specific Data
    Name (_DSD, Package (0x02) {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
        Package (0x07) {
            Package () { "phy-handle", Package () { \_SB.MAC1.MDIO,
"ethernet-phy@1" } },
            Package () { "dev-refs", \_SB.MAC0 },
            Package () { "refs0-dev", Package () { \_SB.MAC1.MDIO,
"refs@0" } },
            Package () { "refs1-dev", Package () { \_SB.MAC1.MDIO,
"refs@1" } },
            ...
            ...
        }
    })

    Device (MDIO)
    {
        Name (_DSD, Package () {
        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
            Package () {
                Package () { "ethernet-phy@1", PHY1 },
                Package () { "refs@0",  REF0},
                Package () { "refs@1",  REF1},
            }
        })
        
        //Contain a property
        Name (PHY1, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "reg", 0x1 },
            }
        })
        
        //Point to a device
        Name (REF0, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "child-refs-dev", \_SB.MAC0 },
            }
        })
        
        //Contain a property and a pointer that point to a device
        Name (REF1, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "property", 0x5 },
                Package () { "child-refs-dev", \_SB.MAC0 },
            }
        })
    }
}


>      Device (MDIO) {
>          Device (PHY) {
>              Name (_DSD, Package () {
>                  ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>                  Package () { Package () { "ethernet-phy@0", PHY0 }, }
>              })
>              Name (PHY0, Package() {
>                  ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                  Package () { Package () { "reg", 0x0 }, }
>              })
>          }
>          Device (PHY) {
>              Name (_DSD, Package () {
>                  ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>                  Package () { Package () { "ethernet-phy@10", PHY1 }, }
>              })
>              Name (PHY1, Package() {
>                  ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                  Package () { Package () { "reg", 0x10 }, }
>              })
>          Device (SWITCH) {
>              Name (_DSD, Package () {
>                  ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>                  Package () { Package () { "switch@11", SWITCH0 }, }
>              })
>              Name (SWITCH0, Package() {
>                  ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                  Package () { Package () { "reg", 0x11 }, }
>              })
>          }

    Device (MDIO)
    {
        Name (_DSD, Package () {
        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
            Package () {
                Package () { "ethernet-phy@1", PHY1 },
                Package () { "switch@0",  SW00 },

                Package () { "switch@1",  SW01 },
            }
        })
        
        //Contain a property
        Name (PHY1, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "reg", 0x1 },
            }
        })
 
        Name (SW00, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "reg", 0x0 },
            }
        })

        Name (SW01, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "property", 0x5 },
            }
        })
    }


>       }
>
> I'm just trying to ensure whatever is defined is flexible enough that
> we really can later support everything which DT does. We have PHYs on
> MDIO busses, inside switches, which are on MDIO busses, which are
> inside Ethernet interfaces, etc.

I think it can be satisfied. See the table I'm using above.


> An MDIO bus is very similar to an i2c bus. How is that described in
> ACPI? Anything we can learn from that?

About the data node, I just read the Kernel Documentation/acpi/dsd/

And others learn from ACPI spec.


Cheers,

Dongsheng
