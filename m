From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on
 ARM64
Date: Sun, 18 Jan 2015 09:29:56 +0000
Message-ID: <20150118092955.GE6182@xora-haswell.xora.org.uk>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <54BB56CB.7040701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:57455 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbARJ3t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Jan 2015 04:29:49 -0500
Content-Disposition: inline
In-Reply-To: <54BB56CB.7040701@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Jon Masters <jcm@redhat.com>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Jan 18, 2015 at 02:46:35PM +0800, Hanjun Guo wrote:
> On 2015=E5=B9=B401=E6=9C=8818=E6=97=A5 14:31, Jon Masters wrote:
> >Hi Folks,
> >
> >Sorry for top posting from bed. The mainstream servers will all like=
ly do
> > PCIe but there are several that may not. They should not be exclude=
d. That
> said,
> >if we booted a previously built kernel on a system without an MCFG a=
nd
> > got no ECAM/root then things would probably still work.
> >
> >I think it'll work out either way but for the record there is no req=
uirement to do PCIe on ARM servers that conform to spec.
>=20
> OK, Catalin already said that was not the main point of the
> comments for this patch, I think the title and change log
> of the patch is inconsistent with the code makes Catalin confused,
> I will update them in next version.
>=20
Well what we are talking about is the presence of CONFIG_PCI=3Dy which =
even
in Jons case will be true as he wants to run the same kernel on both
sets of hardware.

Now the architecture has PCI support I think its safe to remove the mak=
e
PCI optional part of the patch as this should be handled runtime not
compile time.

Graeme

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
