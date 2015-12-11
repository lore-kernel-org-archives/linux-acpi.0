From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Fri, 11 Dec 2015 10:59:44 +0000
Message-ID: <1449831584.680722.464515769.71BFC229@webmail.messagingengine.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <2299982.06P4iKpkWk@wuerfel>
 <CAMj5BkiAToBCvnOSkW=41po5OHpg5uSzxNTNJ_=gLK__BLa1Sw@mail.gmail.com>
 <21660867.NhUszMiexN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38784 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910AbbLKK7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2015 05:59:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 05D6220C03
	for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2015 05:59:44 -0500 (EST)
In-Reply-To: <21660867.NhUszMiexN@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, linux-acpi@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>



On Fri, 11 Dec 2015, at 10:51 AM, Arnd Bergmann wrote:
> On Friday 11 December 2015 18:35:17 Zhangfei Gao wrote:
> > On Wed, Dec 2, 2015 at 6:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
> > >
> > > This sounds like a bad idea:
> > >
> > > syscon is basically a hack to let us access register that the SoC designer
> > > couldn't fit in anywhere sane. We need something like this with devicetree
> > > because we decided not to have any interpreted bytecode to do this behind
> > > our back.
> > >
> > > With ACPI, the same thing is done with AML, which is actually nicer than
> > > syscon (once you have to deal with all the problems introduced by AML).
> > >
> > > Use that instead.
> > >
> > 
> > Would you mind clarifying AML method, still not understand.
> > Is is means realize the operation in uefi/bootloader and call some
> > interface from kernel?
> >
> > The issue here is we want to access some common registers,
> > which we do not want to ioremap for many times in each driver.
> > 
> > In hisi platforms, we have many common registers shared by many components.
> 
> Sorry, you'd have to ask someone who is more familiar with ACPI.
> 
> Basically, the idea of ACPI as I understand it is that you have a
> interpreted bytecode language that is provided by the BIOS as tables
> and executed in the context of the kernel. This byte code has access
> to stuff like GPIO, PCI config space, MMIO registers, IPMI or the
> embedded controller on a PC. This way, you can hide all the platform
> specific details behind a function call from a generic device driver,
> and the BIOS writer can provide the specific implementation for any
> registers that are shared across components.
> 
> That's about all I know, but the ACPI specifications are available
> publicly, please have a look there for more details.
> 

Basically in the DSDT you would create a common accessor method for the
register/registers in question. This function takes care of the register
in the multiple user cases.

each _RST() method would then call this function to set the bits they
required.

So in effect it is no different to what you would do in Linux, just done
in AML instead.

Graeme

