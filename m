From: Zhangfei Gao <zhangfei.gao@gmail.com>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Fri, 11 Dec 2015 18:35:17 +0800
Message-ID: <CAMj5BkiAToBCvnOSkW=41po5OHpg5uSzxNTNJ_=gLK__BLa1Sw@mail.gmail.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
	<1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
	<2299982.06P4iKpkWk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36022 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbLKKfS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2015 05:35:18 -0500
Received: by qgcc31 with SMTP id c31so193292807qgc.3
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2015 02:35:17 -0800 (PST)
In-Reply-To: <2299982.06P4iKpkWk@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi, Arnd

On Wed, Dec 2, 2015 at 6:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
>> This enables syscon with ACPI support.
>> syscon_regmap_lookup_by_dev_property() function was added. With helper
>> device_get_reference_node() and acpi_dev_find_plat_dev(), it can be used
>> in both DT and ACPI.
>>
>> The device driver can obtain syscon using _DSD method in DSDT, an example
>> is shown below.
>>
>>     Device(CTL0) {
>>           Name(_HID, "HISI0061")
>>           Name(_CRS, ResourceTemplate() {
>>                   Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
>>           })
>>     }
>>
>>     Device(DEV0) {
>>           Name(_HID, "HISI00B1")
>>           Name(_CRS, ResourceTemplate() {
>>                   Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
>>                   Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive){ 192 }
>>           })
>>
>>           Name (_DSD, Package () {
>>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>               Package () {
>>                   Package () {"syscon",Package() {\_SB.CTL0} }
>>               }
>>           })
>>     }
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> This sounds like a bad idea:
>
> syscon is basically a hack to let us access register that the SoC designer
> couldn't fit in anywhere sane. We need something like this with devicetree
> because we decided not to have any interpreted bytecode to do this behind
> our back.
>
> With ACPI, the same thing is done with AML, which is actually nicer than
> syscon (once you have to deal with all the problems introduced by AML).
>
> Use that instead.
>

Would you mind clarifying AML method, still not understand.
Is is means realize the operation in uefi/bootloader and call some
interface from kernel?

The issue here is we want to access some common registers,
which we do not want to ioremap for many times in each driver.

In hisi platforms, we have many common registers shared by many components.

Thanks.


>> +               pdev = acpi_dev_find_plat_dev(adev);
>> +               if (!pdev)
>> +                       return ERR_PTR(-ENODEV);
>> +               syscon = platform_get_drvdata(pdev);
>
> This still requires the syscon device to be probed first, which is
> something we shouldn't really need any more.
>
> A lot of syscon users depend on the regmap to be available before
> device drivers are loaded, so we have changed the code to just look up
> the device_node that is already present and ignore the device.
>
> Once clps711x has been converted to DT, I think we can rip out the
> syscon_regmap_lookup_by_pdevname() interface and separate the syscon
> regmap handling from the device handling that we only really need
> for debugfs.
