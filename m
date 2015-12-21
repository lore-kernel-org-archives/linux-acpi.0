From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors against platfrom specific quirks.
Date: Mon, 21 Dec 2015 15:10:31 +0100
Message-ID: <201512211510.32029.arnd@arndb.de>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <1450278993-12664-23-git-send-email-tn@semihalf.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62997 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbLUOL4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2015 09:11:56 -0500
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "mw@semihalf.com" <mw@semihalf.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Wangyijing <wangyijing@huawei.com>, "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>

On Monday 21 December 2015, Gabriele Paoloni wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Tomasz Nowicki

> > Some platforms may not be fully compliant with generic set of PCI
> > config accessors. For these cases we implement the way to overwrite
> > accessors set before PCI buses enumeration. Algorithm that overwrite
> > accessors matches against platform ID (DMI), domain and bus number,
> > hopefully enough for all cases. All quirks can be defined using:
> > DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
> 
> I've got a couple of comments/questions about this patch..
> 
> 1) So according to this mechanism quirks would be supported only by 
>    vendors whose BIOS are SMBIOS compliant. Now personally I am ok
>    with this but I don't know if this is OK in general as it would 
>    narrow down the number of platforms that would be able to define
>    the quirks...
>    Lorenzo, Arnd what is your opinion here?

I'd rather not see the quirks in mainline at all, and only support
SBSA compliant machines, or require the BIOS to work around the hardware
quirks differently (e.g. by trapping config space access through secure
firmware, or going through an AML method to be defined). I'm certainly
ok with making it depend on SMBIOS if we are going to use something like this.

	Arnd
