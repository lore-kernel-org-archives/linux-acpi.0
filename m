From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on
 ARM64
Date: Mon, 19 Jan 2015 10:37:39 +0000
Message-ID: <20150119103737.GD11835@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <54BB56CB.7040701@linaro.org>
 <20150118092955.GE6182@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:37658 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbASKhu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2015 05:37:50 -0500
Content-Disposition: inline
In-Reply-To: <20150118092955.GE6182@xora-haswell.xora.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infr>

On Sun, Jan 18, 2015 at 09:29:56AM +0000, Graeme Gregory wrote:
> On Sun, Jan 18, 2015 at 02:46:35PM +0800, Hanjun Guo wrote:
> > On 2015=E5=B9=B401=E6=9C=8818=E6=97=A5 14:31, Jon Masters wrote:
> > >Hi Folks,
> > >
> > >Sorry for top posting from bed. The mainstream servers will all li=
kely do
> > > PCIe but there are several that may not. They should not be exclu=
ded. That
> > said,
> > >if we booted a previously built kernel on a system without an MCFG=
 and
> > > got no ECAM/root then things would probably still work.
> > >
> > >I think it'll work out either way but for the record there is no r=
equirement to do PCIe on ARM servers that conform to spec.
> >=20
> > OK, Catalin already said that was not the main point of the
> > comments for this patch, I think the title and change log
> > of the patch is inconsistent with the code makes Catalin confused,
> > I will update them in next version.
>=20
> Well what we are talking about is the presence of CONFIG_PCI=3Dy whic=
h even
> in Jons case will be true as he wants to run the same kernel on both
> sets of hardware.
>=20
> Now the architecture has PCI support I think its safe to remove the m=
ake
> PCI optional part of the patch as this should be handled runtime not
> compile time.

I agree, if we never see a reason to build a kernel image with
!PCI && ACPI, we can simplify this patch.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
