From: "Yankejian (Hackim Yim)" <yankejian@huawei.com>
Subject: Re: [PATCH] ACPI: Add phylib support code for mdio
Date: Thu, 10 Dec 2015 09:27:48 +0800
Message-ID: <5668D514.7070705@huawei.com>
References: <1449107683-69717-1-git-send-email-yankejian@huawei.com>
 <20151203104724.GB11655@xora-haswell.xora.org.uk> <566735CF.30000@redhat.com>
 <566802F0.2020103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:59524 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbLJB26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2015 20:28:58 -0500
In-Reply-To: <566802F0.2020103@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, Graeme Gregory <gg@slimlogic.co.uk>
Cc: rjw@rjwysocki.net, lenb@kernel.org, davem@davemloft.net, liguozhu@huawei.com, yisen.zhuang@huawei.com, huangdaode@hisilicon.com, lipeng321@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com



On 2015/12/9 18:31, Yankejian (Hackim Yim) wrote:
>
> On 2015/12/9 3:55, Al Stone wrote:
>> On 12/03/2015 03:47 AM, Graeme Gregory wrote:
>>> On Thu, Dec 03, 2015 at 09:54:43AM +0800, yankejian wrote:
>>>> Add support for getting the PHY devices on an MDIO bus by ACPI.
>>>> Currently many of the ethernet drivers are open coding a solution
>>>> for reading data out of ACPI to find the correct PHY device.
>>>> This patch implements a set of common routines are similar to of_mdio.c
>>>>
>>> The general conclusion for the ACPI on ARM64 discussion so far has been that
>>> things like PHYs should be setup by the firmware before the kernel takes
>>> control.
>>>
>>> I am unsure that this doing it the same way as DT with a different
>>> description language is the way to go.
>>>
>>> Graeme
>> I have to agree with Graeme: if this is supposed to be an arm64 server using
>> ACPI, please make sure the PHYs/clocks/regulators are set up properly before
>> passing control to the kernel.  That's the consensus so far on how this is to
>> be done.
>>
>> This also looks to be using _DSD in ACPI, which is another topic that's still
>> under discussion.  What does the ASL look like for these PHYs, as used in this
>> patch?
>>
> Hi Al
>
> The sample of the ASL for these PHYs is below:
>
>                 Device (PHY0) {
>                         Name (_DSD, Package () {
>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                 Package () {
>                                         Package () {"phy-addr", 0},
>                                         Package () {"ethernet-phy", "ethernet-phy-ieee802.3-c22"},
>                                 }
>                         })
>                 }
>
> Best Regards,
> yankejian
>
Maybe we need to add the ASL for mdio as well, the sample is shown below:

Device (MDIO) {
                Name(_HID, "HISI00B1")
                Name (_CRS, ResourceTemplate (){
                        Memory32Fixed (ReadWrite, 0x803c0000 , 0x10000)
                })

                Device (PHY0) {
                        Name (_DSD, Package () {
                                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                        Package () {"phy-addr", 0},
                                        Package () {"ethernet-phy", "ethernet-phy-ieee802.3-c22"},
                                }
                        })
                }
                Device (PHY1) {
                        Name (_DSD, Package () {
                                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                        Package () {"phy-addr", 1},
                                        Package () {"ethernet-phy", "ethernet-phy-ieee802.3-c22"},
                                }
                        })
                }
        }

Best Regards,
yankejian



