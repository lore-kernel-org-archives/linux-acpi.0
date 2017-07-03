From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Mon, 3 Jul 2017 23:22:45 +0300
Message-ID: <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com> <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com> <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com> <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com> <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com> <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36801 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCUWr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 16:22:47 -0400
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "olof@lixom.net" <olof@lixom.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.ke>

On Mon, Jul 3, 2017 at 7:08 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:

JFYI: Mika on vacation.

> I had a look into the MFD framework. If my understanding is correct the mfd
> framework create a platform device for each declared mfd_cell that is passed
> to mfd_add_devices().

Right.

> However there is something that I do not quite understand:
> from
> http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/mfd-core.c#L207
> it seems that mfd_add_device() will create the platform device using the
> resources that are statically declared in the respective mfd_cell.

It's one possibility.

> In my case I'd like to have a platform device using the resources that are
> parsed from the ACPI table (i.e. as it is done now by
> acpi_create_platform_device()).

So far so good. Nothing prevents you to do that.

> If my understanding is correct, if I declared an mfd_cell for my IPMI child
> the mfd subsystem would create a platform device for such child and
> therefore acpi_create_platform_device() would fail to create a new platform
> device as adev->physical_node_count will be non zero.
> However as things stand now mfd_cell devices can only use the resources
> that are statically defined in the code (and therefore not the ones in the
> ACPI nodes)...am I right?

You may file resources first and then register MFD cells. See many
existing examples in the kernel.

-- 
With Best Regards,
Andy Shevchenko
