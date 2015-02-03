From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for ACPI
Date: Tue, 03 Feb 2015 15:55:05 +0100
Message-ID: <2157836.CgDKH4QWp1@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <20150203121546.GD3677@e104818-lin.cambridge.arm.com> <54D0CD58.2000609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61439 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753473AbbBCOcM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 09:32:12 -0500
In-Reply-To: <54D0CD58.2000609@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.o>

On Tuesday, February 03, 2015 09:30:00 PM Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 20:15, Catalin Marinas wrote:
> > On Mon, Feb 02, 2015 at 12:45:34PM +0000, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index ce5836c..c17e7ea 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -10,6 +10,7 @@
> >>    *
> >>    */
> >>
> >> +#include <linux/acpi.h>
> >>   #include <linux/init.h>
> >>   #include <linux/io.h>
> >>   #include <linux/kernel.h>
> >> @@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *b=
us, struct device *parent)
> >>   	bus->domain_nr =3D domain;
> >>   }
> >>   #endif
> >> +
> >> +/*
> >> + * raw_pci_read/write - Platform-specific PCI config space access=
=2E
> >> + */
> >> +int raw_pci_read(unsigned int domain, unsigned int bus,
> >> +		  unsigned int devfn, int reg, int len, u32 *val)
> >> +{
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +int raw_pci_write(unsigned int domain, unsigned int bus,
> >> +		unsigned int devfn, int reg, int len, u32 val)
> >> +{
> >> +	return -EINVAL;
> >> +}
> >
> > You said you'll make these return -ENOSYS, which I think makes more
> > sense.
>=20
> I'm sorry, I missed that, my bad, I will fix that in next version.

Actually, -ENOSYS *specifically* means "not implemented system call".
It should not be used for anything other than that.  -ENXIO is what
should be used instead.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
