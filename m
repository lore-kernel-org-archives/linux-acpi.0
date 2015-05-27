From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
Date: Wed, 27 May 2015 10:47:02 +0100
Message-ID: <20150527094702.GE2175@e106497-lin.cambridge.arm.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
 <20150526165844.GD2175@e106497-lin.cambridge.arm.com>
 <5564AB68.6080502@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:55070 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbbE0JrH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 May 2015 05:47:07 -0400
In-Reply-To: <5564AB68.6080502@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Yijing Wang <wangyijing@huawei.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tue, May 26, 2015 at 06:20:40PM +0100, Jiang Liu wrote:
> On 2015/5/27 0:58, Liviu Dudau wrote:
> > On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
> >> ARM64 ACPI based PCI host bridge init needs a arch dependent
> >> struct pci_controller to accommodate common PCI host bridge
> >> code which is introduced later, or it will lead to compile
> >> errors on ARM64.
> >=20
> > Hi Hanjun,
> >=20
> > Two questions: why don't you introduce this patch next to the
> > one that is going to make use of it (or even merge it there)?
> > Second, why is the whole struct pci_controller not surrounded
> > by #ifdef CONFIG_ACPI as you are implying that this is needed
> > only for ACPI?
> >=20
> > Btw, looking through the whole series I'm not (yet) convinced
> > that this is needed at all.
> Hi Liviu,
> 	This structure is required by the requested patch set
> at http://patchwork.ozlabs.org/patch/472249/, which consolidates
> the common code to support PCI host bridge into ACPI core.
> Thanks!
> Gerry

Hi Jiang,

Thanks for pointing me on the right answer, I've missed that series!
Probably not the best place to comment on that series here, but I
wonder why did you not made the pci_controller structure available
in a more generic header file that can be included so that arches
don't have to redefine the structure every time. After all, you are
trying to consolidate things.

Oh, and pci_controller name throws a lot of false negatives, maybe
a more specific one (acpi_pci_controller?) would make things clear?

Best regards,
Liviu

>=20
> >=20
> > Best regards,
> > Liviu
> >=20
> >>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> CC: Arnd Bergmann <arnd@arndb.de>
> >> CC: Catalin Marinas <catalin.marinas@arm.com>
> >> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> >> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> >> CC: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/include/asm/pci.h | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm=
/pci.h
> >> index b008a72..7088495 100644
> >> --- a/arch/arm64/include/asm/pci.h
> >> +++ b/arch/arm64/include/asm/pci.h
> >> @@ -10,6 +10,16 @@
> >>  #include <asm-generic/pci-bridge.h>
> >>  #include <asm-generic/pci-dma-compat.h>
> >> =20
> >> +struct acpi_device;
> >> +
> >> +struct pci_controller {
> >> +#ifdef CONFIG_ACPI
> >> +	struct acpi_device *companion;	/* ACPI companion device */
> >> +#endif
> >> +	int		segment;	/* PCI domain */
> >> +	int		node;		/* NUMA node */
> >> +};
> >> +
> >>  #define PCIBIOS_MIN_IO		0x1000
> >>  #define PCIBIOS_MIN_MEM		0
> >> =20
> >> --=20
> >> 1.9.1
> >>
> >=20
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
