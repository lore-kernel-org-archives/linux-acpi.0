From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional
 for ACPI on ARM64
Date: Tue, 20 Jan 2015 15:10:57 +0000
Message-ID: <20150120151057.GG25575@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <20150119104240.GE11835@e104818-lin.cambridge.arm.com>
 <54BDBFD4.7050207@linaro.org>
 <20150120110045.GD25575@e104818-lin.cambridge.arm.com>
 <54BE4991.5040505@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:39179 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbATPLJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2015 10:11:09 -0500
Content-Disposition: inline
In-Reply-To: <54BE4991.5040505@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On Tue, Jan 20, 2015 at 12:26:57PM +0000, Tomasz Nowicki wrote:
> On 20.01.2015 12:00, Catalin Marinas wrote:
> > On Tue, Jan 20, 2015 at 02:39:16AM +0000, Hanjun Guo wrote:
> >> On 2015=E5=B9=B401=E6=9C=8819=E6=97=A5 18:42, Catalin Marinas wrot=
e:
> >>> On Sun, Jan 18, 2015 at 06:25:53AM +0000, Hanjun Guo wrote:
> >>>> On 2015=E5=B9=B401=E6=9C=8816=E6=97=A5 17:49, Catalin Marinas wr=
ote:
> >>>>> On Wed, Jan 14, 2015 at 03:04:54PM +0000, Hanjun Guo wrote:
> >>>>>> --- a/arch/arm64/kernel/pci.c
> >>>>>> +++ b/arch/arm64/kernel/pci.c
> >>>>>> @@ -10,6 +10,7 @@
> >>>>>>      *
> >>>>>>      */
> >>>>>>
> >>>>>> +#include <linux/acpi.h>
> >>>>>>     #include <linux/init.h>
> >>>>>>     #include <linux/io.h>
> >>>>>>     #include <linux/kernel.h>
> >>>>>> @@ -68,3 +69,30 @@ void pci_bus_assign_domain_nr(struct pci_bu=
s *bus, struct device *parent)
> >>>>>>     	bus->domain_nr =3D domain;
> >>>>>>     }
> >>>>>>     #endif
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * raw_pci_read/write - Platform-specific PCI config space ac=
cess.
> >>>>>> + *
> >>>>>> + * Default empty implementation.  Replace with an architectur=
e-specific setup
> >>>>>> + * routine, if necessary.
> >>>>>> + */
> >>>>>> +int raw_pci_read(unsigned int domain, unsigned int bus,
> >>>>>> +		  unsigned int devfn, int reg, int len, u32 *val)
> >>>>>> +{
> >>>>>> +	return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +int raw_pci_write(unsigned int domain, unsigned int bus,
> >>>>>> +		unsigned int devfn, int reg, int len, u32 val)
> >>>>>> +{
> >>>>>> +	return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +#ifdef CONFIG_ACPI
> >>>>>> +/* Root bridge scanning */
> >>>>>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root=
)
> >>>>>> +{
> >>>>>> +	/* TODO: Should be revisited when implementing PCI on ACPI *=
/
> >>>>>> +	return NULL;
> >>>>>> +}
> >>>>>> +#endif
> >>> [...]
> >>>>> When PCI is enabled and the above functions are compiled in, do=
 they
> >>>>> need to return any useful data or just -EINVAL. Are they ever c=
alled?
> >>>>
> >>>> They will be called if PCI root bridge is defined in DSDT, shoul=
d I
> >>>> print some warning message before it is implemented?
> >>>
> >>> My point: do they need to return real data when a PCI root bridge=
 is
> >>> defined in DSDT or you always expect them to always return some -=
E*? Can
> >>> you explain why?
> >>
> >> Not always return -E* or NULL;
> >>
> >> For raw_pci_read/write(), they are needed to access the PCI config=
 space
> >> before the PCI root bus is created. so they will return 0 if acces=
s to
> >> PCI config space is ok; pci_acpi_scan_root() will return root bus
> >> pointer if it is successfully created.
> >
> > OK. So what's the plan for implementing these functions properly. F=
or
> > the raw_pci_read/write, the comment states "replace with an
> > architecture-specific setup routine". What does this mean?
> raw_pci_read/write will use MMCONFIG code to access PCI config space.=
=20
> Please see my patch set:
> http://lkml.iu.edu/hypermail/linux/kernel/1411.2/02753.html
> which is going to refactor the x86 specific code so it would be usabl=
e=20
> for ARM64 too.

OK. Thanks for the information.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
