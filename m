From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core
 running without PCI on ARM64
Date: Mon, 9 Dec 2013 11:50:50 +0000
Message-ID: <20131209115050.GA19163@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052304.22302.arnd@arndb.de>
 <52A1E794.1040008@linaro.org>
 <201312061823.26481.arnd@arndb.de>
 <52A54328.3000709@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A54328.3000709@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "patches@linaro.org" <patches@linaro.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 09, 2013 at 04:12:24AM +0000, Hanjun Guo wrote:
> On 2013-12-7 1:23, Arnd Bergmann wrote:
> > On Friday 06 December 2013, Tomasz Nowicki wrote:
> >> On 05.12.2013 23:04, Arnd Bergmann wrote:
> >>> On Wednesday 04 December 2013, Hanjun Guo wrote:
> >>>> On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:41, Matthew Garrett wr=
ote:
> >>>>> Given the number of #ifdefs you're adding, wouldn't it make mor=
e sense
> >>>>> to just add stub functions to include/linux/pci.h?
> >>>>
> >>>> Thanks for the suggestion :)
> >>>>
> >>>> I can add stub functions in include/linux/pci.h for raw_pci_read=
()/
> >>>> raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_=
pci_configuration().
> >>>
> >>> Actually I wonder about the usefulness of this patch in either fo=
rm: Since ACPI
> >>> on ARM64 is only for servers, I would very much expect them to al=
ways come with
> >>> PCI, either physical host bridges with attached devices, or logic=
al PCI functions
> >>> used to describe the on-SoC I/O devices. Even in case of virtual =
machines, you'd
> >>> normally use PCI as the method to communicate data about the virt=
io channels.
> >>>
> >>> Can you name a realistic use-case where you'd want ACPI but not P=
CI?
> >>
> >> Yes you can describe SoC I/O devices using logical PCI functions o=
nly if=20
> >> they are on PCI, correct me if I am wrong. Also, devices can be pl=
aced=20
> >> only on IOMEM (like for ARM SoC) and it is hard to predict which w=
ay=20
> >> vendors chose. So way don't let it be configurable? ACPI spec says=
=20
> >> nothing like PCI is needed for ACPI, AFAIK.
> >=20
> > You are right that today's ARM SoCs basically never use PCI to desc=
ribe
> > internal devices (IIRC VIA VT8500 is an exception, but their PCI wa=
s
> > just a software fabrication).
> >=20
> > However, when we're talking about ACPI on ARM64, that is nothing li=
ke classic
> > ARM SoCs: As Jon Masters mentioned, this is about new server hardwa=
re following
> > a (still secret, but hopefully not much longer) hardware specificat=
ion that is
> > explicitly designed to allow interoperability between vendors, so t=
hey
> > must have put some thought into how to make the hardware discoverab=
le. It
> > seems that they are modeling things after how it's done on x86, and=
 the
> > only sensible way to have discoverable hardware there is PCI. This =
is
> > also what all x86 SoCs do.
>=20
> I think the concern here is that ACPI is only for server platform or =
not.
>=20
> Since ACPI has lots of content related to power management, I think A=
CPI
> can be used for mobile devices and other platform too, not only for A=
RM
> servers, and with this patch, we can support both requirement.

'Can be used' is one thing, will it really be used is another? I don't
think so, it was (well, is) difficult enough to make the transition to
=46DT, I don't see how ACPI would solve the current issues.

I see ACPI as a server distro requirement and there are indeed benefits
in abstracting the hardware behind standard description, AML. Of course=
,
this would work even better with probe-able buses like PCIe and I'm
pretty sure this would be the case on high-end servers. But even if a
server distro like RHEL supports a SoC without PCIe, I would expect the=
m
to only provide a single binary Image with CONFIG_PCI enabled.

This patch is small enough and allows ACPI build with !CONFIG_PCI for
the time being but longer term I would expect such SoCs without PCI to
be able to run on a kernel with CONFIG_PCI enabled.

--=20
Catalin
