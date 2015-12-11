From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Fri, 11 Dec 2015 11:51:52 +0100
Message-ID: <21660867.NhUszMiexN@wuerfel>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com> <2299982.06P4iKpkWk@wuerfel> <CAMj5BkiAToBCvnOSkW=41po5OHpg5uSzxNTNJ_=gLK__BLa1Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:50847 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbLKKwi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2015 05:52:38 -0500
In-Reply-To: <CAMj5BkiAToBCvnOSkW=41po5OHpg5uSzxNTNJ_=gLK__BLa1Sw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, linux-acpi@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>

On Friday 11 December 2015 18:35:17 Zhangfei Gao wrote:
> On Wed, Dec 2, 2015 at 6:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
> >
> > This sounds like a bad idea:
> >
> > syscon is basically a hack to let us access register that the SoC designer
> > couldn't fit in anywhere sane. We need something like this with devicetree
> > because we decided not to have any interpreted bytecode to do this behind
> > our back.
> >
> > With ACPI, the same thing is done with AML, which is actually nicer than
> > syscon (once you have to deal with all the problems introduced by AML).
> >
> > Use that instead.
> >
> 
> Would you mind clarifying AML method, still not understand.
> Is is means realize the operation in uefi/bootloader and call some
> interface from kernel?
>
> The issue here is we want to access some common registers,
> which we do not want to ioremap for many times in each driver.
> 
> In hisi platforms, we have many common registers shared by many components.

Sorry, you'd have to ask someone who is more familiar with ACPI.

Basically, the idea of ACPI as I understand it is that you have a
interpreted bytecode language that is provided by the BIOS as tables
and executed in the context of the kernel. This byte code has access
to stuff like GPIO, PCI config space, MMIO registers, IPMI or the
embedded controller on a PC. This way, you can hide all the platform
specific details behind a function call from a generic device driver,
and the BIOS writer can provide the specific implementation for any
registers that are shared across components.

That's about all I know, but the ACPI specifications are available
publicly, please have a look there for more details.

	Arnd
