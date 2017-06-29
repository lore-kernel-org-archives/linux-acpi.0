From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Thu, 29 Jun 2017 17:16:15 +0100
Message-ID: <808a7db0-7844-b263-0216-1fe943ac819a@huawei.com>
References: <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:9253 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbdF2QRT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2017 12:17:19 -0400
In-Reply-To: <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "olof@lixom.net" <olof@lixom.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>"linux-acpi@vger.kernel.org" <lin>

On 16/06/2017 12:24, Rafael J. Wysocki wrote:
>>>> >> >
>>>> >> > It causes acpi_default_enumeration() to be called but it should be fine
>>>> >> > as we are dealing with platform device anyway.
>>> >>
>>> >> I do not quite understand how declaring such MFD cell above would make sure
>>> >> that the LPC probe is called before the IPMI device is enumerated...
>> >
>> > In fact it may be that it is not sufficient in this case because the
>> > ACPI core might enumerate child devices before the LPC driver even gets
>> > a chance to probe so you would need to add also scan handler to the
>> > child devices and mark them already enumerated or something like that.
> Or extend the special I2C/SPI handling to them.
>

For this, is it possible to just configure the ACPI table so we spoof 
that the LPC slave (IPI0001), is an i2c/spi slave? Could we just add a 
resource of type ACPI_RESOURCE_TYPE_SERIAL_BUS, and common serial bus 
type i2c/spi to solve this?

This resource would/should need to be ignored for other purposes.

John

> Thanks,
> Rafael


