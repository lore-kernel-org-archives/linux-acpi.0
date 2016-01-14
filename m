From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 10:29:53 -0500
Message-ID: <1452785393.28109.16.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Wed, 2016-01-13 at 14:20 +0100, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into =
the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to=
 collect
> =C2=A0=C2=A0 PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host contro=
ller driver.
> 4. Enable above driver on ARM64
>=20
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>=20
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
>=20
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.
>=20
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
> =C2=A0 able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
> =C2=A0 Mathew's series:
> =C2=A0 https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4
>=20
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code

IO resources on Mustang get disabled unless I do:

@@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct resou=
rce *res, u64 len,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!acpi_dev_resource_=
len_valid(res->start, res->end, len, true))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0res->flags |=3D IORESOURCE_DISABLED | IORESOURC=
E_UNSET;
=C2=A0
+#if 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res->end >=3D 0x100=
03)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0res->flags |=3D IORESOURCE_DISABLED | IORESOURC=
E_UNSET;
-
+#endif

res->end is way beyond 0x10003 on Mustang:

=C2=A0 pci_bus 0000:00: root bus resource [io=C2=A0=C2=A00x0000-0xffff =
window] (bus address [0x10000000-0x1000ffff])
