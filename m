From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Mon, 7 Dec 2015 14:15:37 +0800
Message-ID: <56652409.8070905@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
 <2299982.06P4iKpkWk@wuerfel>
 <20151203104131.GA11655@xora-haswell.xora.org.uk>
 <56603D17.4080707@huawei.com> <20151203155612.GA2935@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:3241 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbLGGR3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2015 01:17:29 -0500
In-Reply-To: <20151203155612.GA2935@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org



On 2015/12/3 23:56, Lorenzo Pieralisi wrote:
> On Thu, Dec 03, 2015 at 09:01:11PM +0800, Kefeng Wang wrote:
>> Hi Graeme, Arnd, and Lorenzo,
>>
>> Firstly, we absolutely agree with the point which use AML to do some=
 "special"
>> initialisation and configuration.
>=20
> Good.
>=20
>> SAS and NIC driver were accepted by linux in hisilicon hip05 chip, a=
nd the drivers
>> reset the control by syscon, we want to use "_RST" method, which is =
introduced by
>> ACPI 6.0 spec in "7.3.25 _RST (Device Reset)", is it reasonable and =
standard for us?
>=20
> Can you point me at the drivers you are referring to please ?

SAS=EF=BC=9A https://lkml.org/lkml/2015/11/17/572
      [PATCH v5 19/32] scsi: hisi_sas: add v1 HW initialisation code
      static int reset_hw_v1_hw(struct hisi_hba *hisi_hba);

HNS=EF=BC=9A drivers/net/ethernet/hisilicon/hns_mdio.c
      static int hns_mdio_reset(struct mii_bus *bus)=EF=BC=9B

>=20
>> But here is a scene, we can not find a suitable way to support ACPI.=
 There is no
>> independent memory region in some module(the driver not upstreamed),=
 that is,
>> when write and read the module's register, we must r/w by syscon. An=
y advice?
>=20
> What do you mean ? You mean that the reset control is a piece of HW
> that is shared between multiple "components" ? What's your concern
> about AML code driving those registers here ?

This is unrelated to reset control.

I mean we have some driver(not upstreamed), like LLC(last level cache),=
 when access the register
of llc, we need help through syscon, because the llc has no independent=
 registers region , steps
of Read and Write register in those drivers is shown below,

 1) get the syscon base;
 2) configure and choose the module which need to be accessed;
 3) R/W the value from the syscon, that is, get/set the value from/to l=
lc;

Every read and write the register in those drivers, we must through sys=
con. That is why we need
syscon to support ACPI.

Thanks,
Kefeng


>=20
> Thanks,
> Lorenzo
>=20
>>
>> Thanks,
>> Kefeng
>>
>> On 2015/12/3 18:41, Graeme Gregory wrote:
>>> On Wed, Dec 02, 2015 at 11:44:51AM +0100, Arnd Bergmann wrote:
>>>> On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
>>>>> This enables syscon with ACPI support.
>>>>> syscon_regmap_lookup_by_dev_property() function was added. With h=
elper
>>>>> device_get_reference_node() and acpi_dev_find_plat_dev(), it can =
be used
>>>>> in both DT and ACPI.
>>>>>
>>>>> The device driver can obtain syscon using _DSD method in DSDT, an=
 example
>>>>> is shown below.
>>>>>
>>>>>     Device(CTL0) {
>>>>>           Name(_HID, "HISI0061")
>>>>>           Name(_CRS, ResourceTemplate() {
>>>>>                   Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
>>>>>           })
>>>>>     }
>>>>>
>>>>>     Device(DEV0) {
>>>>>           Name(_HID, "HISI00B1")
>>>>>           Name(_CRS, ResourceTemplate() {
>>>>>                   Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
>>>>>                   Interrupt(ResourceConsumer, Level, ActiveHigh, =
Exclusive){ 192 }
>>>>>           })
>>>>>
>>>>>           Name (_DSD, Package () {
>>>>>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>>>>               Package () {
>>>>>                   Package () {"syscon",Package() {\_SB.CTL0} }
>>>>>               }
>>>>>           })
>>>>>     }
>>>>>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>
>>>> This sounds like a bad idea:
>>>>
>>>> syscon is basically a hack to let us access register that the SoC =
designer
>>>> couldn't fit in anywhere sane. We need something like this with de=
vicetree
>>>> because we decided not to have any interpreted bytecode to do this=
 behind
>>>> our back.
>>>>
>>>> With ACPI, the same thing is done with AML, which is actually nice=
r than
>>>> syscon (once you have to deal with all the problems introduced by =
AML).
>>>>
>>>> Use that instead.
>>>>
>>>
>>> I have to agree with Arnd here, this is specifically why it was cho=
sen
>>> to use ACPI on machines to move all these "hacks" to AML.
>>>
>>> This leaves your driver being generic and any "special" initialisat=
ion
>>> can be supplied by the OEM through the ACPI tables.
>>>
>>> Graeme
>>>
>>>
>>> .
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> .
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
