From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 4/8] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
Date: Mon, 20 Jul 2015 18:45:42 +0100
Message-ID: <55AD33C6.3000809@arm.com>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org> <1436525114-14425-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436525114-14425-5-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 10/07/15 11:45, Hanjun Guo wrote:
> For now, ACPI based GICv2 is using the irq_default_domain as the
> ACPI core domain which is not scalable, also we don't support
> stacked irq domains in ACPI, this patch is trying to implement that.
>=20
> Firstly, we need to find the irqdomain with GSI, because we use
> different model of mapping interrupt with device in ACPI than DT,
> in DT, we using the interrupt parent property to get the device
> node of irqchip for devices, that's why we need the matching function
> that match the device node with the one associated with the irqdomain=
=2E
> But for ACPI, we only can get the GSI which the device is using, no
> interrupt parent will be specified, then we need a mechanism to find
> GSI's (also the device's) irqdomain to make the code scalable.
>=20
> Thanks to the usage of GSI, it is a flat hwirq number which is unique
> in the system, then we can get its associated irq domain by matching
> the GSI supported by this irqchip (see drawings below), then we can
> live without the token pointer matching the interrupt controller as
> DT did.
>=20
>                   ------------      ---> gsi_base0
>                  |            |
>                  |            |
>   irqdomain <----| irqchip 0  |
>                  |            |
>                  |            |
>                  |____________|     ---> gsi_end0
>=20
>                   ------------      ---> gsi_base1 (probably gsi_end0=
+1)
>                  |            |
>                  |            |
>   irqdomain <----| irqchip 1  |
>                  |            |
>                  |            |
>                  |____________|     ---> gsi_end1
>=20
>                   .....
>=20
> if a device is using GSI n, then we can find GSI's irqdomain by match=
ing
> gsi_base <=3D n <=3D gsi_end.
>=20
> For GIC, we only have one GICD, but the above model still valid. GICD
> structure in ACPI MADT defines System Vector Base in the GICD entry,
> which means the global system interrupt number where this GIC
> Distributor=E2=80=99s interrupt inputs start, then we can get the hwi=
rq numbers
> supported by reading the register, so we can explictly get the GSI's
> associated irqdomain if the GSI is within the range of hwirq supporte=
d
> by this GICD.
>=20
> Secondly, pass the GSI as the arg for domain's ops alloc() function
> when register the GSI, then we can take advantage of stacked irqdomai=
ns.

I'm sorry, but this doesn't make much sense to me.

This patch doesn't only convert GICv2 ACPI support to stacked domains,
it adds a whole new concept of "banks of wired interrupts".

Why do we need this? How relevant is that to making the ACPI code
stacked-domain aware? As far as I understand, only SPIs provided by the
GIC can be expressed as a GSI. And you can only have one GIC.

I'm more and more puzzled by this series.

	M.
--=20
Jazz is not dead. It just smells funny...
