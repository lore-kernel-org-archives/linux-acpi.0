From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
Date: Mon, 2 Feb 2015 16:32:53 +0000
Message-ID: <20150202163253.GG21175@leverpostej>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
 <20150202134033.GR4278@bivouac.eciton.net>
 <20150202135051.GA3825@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40654 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932323AbbBBQde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 11:33:34 -0500
Content-Disposition: inline
In-Reply-To: <20150202135051.GA3825@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>

On Mon, Feb 02, 2015 at 01:50:52PM +0000, Graeme Gregory wrote:
> On Mon, Feb 02, 2015 at 01:40:33PM +0000, Leif Lindholm wrote:
> > On Mon, Feb 02, 2015 at 08:45:36PM +0800, Hanjun Guo wrote:
> > > When system supporting both DT and ACPI but firmware providing
> > > no dtb, we can use this linux,uefi-stub-generated-dtb property
> > > to let kernel know that we can try ACPI configuration data even
> > > if no "acpi=force" is passed in early parameters.
> > > 
> > > CC: Mark Rutland <mark.rutland@arm.com>
> > > CC: Jonathan Corbet <corbet@lwn.net>
> > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > CC: Will Deacon <will.deacon@arm.com>
> > > CC: Leif Lindholm <leif.lindholm@linaro.org>
> > > CC: Grant Likely <grant.likely@linaro.org>
> > > CC: Matt Fleming <matt.fleming@intel.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > ---
> > >  Documentation/arm/uefi.txt         |  3 +++
> > >  arch/arm64/include/asm/acpi.h      |  1 +
> > >  arch/arm64/kernel/setup.c          | 30 ++++++++++++++++++++++++++++++
> > >  drivers/firmware/efi/libstub/fdt.c |  8 ++++++++
> > >  4 files changed, 42 insertions(+)
> > > 
> > > diff --git a/Documentation/arm/uefi.txt b/Documentation/arm/uefi.txt
> > > index d60030a..5f86eae 100644
> > > --- a/Documentation/arm/uefi.txt
> > > +++ b/Documentation/arm/uefi.txt
> > > @@ -60,5 +60,8 @@ linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
> > >  --------------------------------------------------------------------------------
> > >  linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
> > >  --------------------------------------------------------------------------------
> > > +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB provided by
> > > +			       |      | firmware.
> > > +--------------------------------------------------------------------------------
> > 
> > Apologies for the late bikeshedding, but the discussion on this topic
> > previsously was lively enough that I thought I'd let it die down a bit
> > before seeing if I had anything to add.
> > 
> > That, and I just realised something:
> > One alternative to this added DT entry is that we could treat the
> > absence of a registered UEFI configuration table as the indication
> > that no HW description was provided from firmware, since the stub does
> > not call InstallConfigurationTable() on the DT it generates. This does
> > move the ability to detect to after efi_init(), but this should be
> > fine for ACPI-purposes.
> > 
> That would not work as expected in the kexec/Xen use case though as they
> may genuinely boot with DT from an ACPI host without UEFI.

I'm a little concerned by this case. How do we intend to pass stuff from
Xen to the kernel in this case? When we initially discussed the stub
prior to merging, we weren't quite sure if ACPI without UEFI was
entirely safe.

The linux,uefi-stub-kern-ver property was originally intended as a
sanity-check feature to ensure nothing (including Xen) masqueraded as
the stub, but for some reason the actual sanity check was never
implemented.

> > If that is deemed undesirable, I would still prefer Catalin's
> > suggested name ("linux,bare-dtb"), which describes the state rather
> > than the route we took to get there.
> > 
> I agree.

I guess this would be ok, though it would be nice to know which agent
generated the DTB.

Thanks,
Mark.
