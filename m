From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Thu, 3 Dec 2015 10:41:31 +0000
Message-ID: <20151203104131.GA11655@xora-haswell.xora.org.uk>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
 <2299982.06P4iKpkWk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49678 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751712AbbLCKld (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 05:41:33 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id E8CA820A5B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Dec 2015 05:41:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <2299982.06P4iKpkWk@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 02, 2015 at 11:44:51AM +0100, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
> > This enables syscon with ACPI support.
> > syscon_regmap_lookup_by_dev_property() function was added. With helper
> > device_get_reference_node() and acpi_dev_find_plat_dev(), it can be used
> > in both DT and ACPI.
> > 
> > The device driver can obtain syscon using _DSD method in DSDT, an example
> > is shown below.
> > 
> >     Device(CTL0) {
> >           Name(_HID, "HISI0061")
> >           Name(_CRS, ResourceTemplate() {
> >                   Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
> >           })
> >     }
> > 
> >     Device(DEV0) {
> >           Name(_HID, "HISI00B1")
> >           Name(_CRS, ResourceTemplate() {
> >                   Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
> >                   Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive){ 192 }
> >           })
> > 
> >           Name (_DSD, Package () {
> >               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >               Package () {
> >                   Package () {"syscon",Package() {\_SB.CTL0} }
> >               }
> >           })
> >     }
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
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

I have to agree with Arnd here, this is specifically why it was chosen
to use ACPI on machines to move all these "hacks" to AML.

This leaves your driver being generic and any "special" initialisation
can be supplied by the OEM through the ACPI tables.

Graeme

