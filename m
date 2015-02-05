From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v8 11/21] ARM64 / ACPI: Get PSCI flags in
 FADT for PSCI init
Date: Thu, 5 Feb 2015 17:49:04 +0000
Message-ID: <20150205174904.GA24468@red-moon>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-12-git-send-email-hanjun.guo@linaro.org>
 <20150204164328.GF22035@red-moon>
 <54D3A443.7050303@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42125 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbBERtB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 12:49:01 -0500
Content-Disposition: inline
In-Reply-To: <54D3A443.7050303@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Randy

Hi Al,

On Thu, Feb 05, 2015 at 05:11:31PM +0000, Al Stone wrote:
> On 02/04/2015 09:43 AM, Lorenzo Pieralisi wrote:
> > On Mon, Feb 02, 2015 at 12:45:39PM +0000, Hanjun Guo wrote:
> >> From: Graeme Gregory <graeme.gregory@linaro.org>
> >>
> >> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> >> the former signals to the OS that the firmware is PSCI compliant.
> >> The latter selects the appropriate conduit for PSCI calls by
> >> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
> >> (SMC).
> >>
> >> FADT table contains such information in ACPI 5.1, FADT table was
> >> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
> >> use the flags in struct acpi_gbl_FADT for PSCI init.
> > 
> > So you do rely on a global FADT being available, if you use it for PSCI
> > detection you can use it for ACPI revision detection too, right ?
> > 
> > Point is, either we should not use the global FADT table, or we use
> > it consistently, or there is something I am unaware of that prevents
> > you from using in some code paths and I would like to understand
> > why.
> 
> The FADT is a required table for arm64, as noted in the documentation
> and the SBBR.  While unfortunately the spec does not say it is mandatory,
> even x86 systems are pretty useless without it.  So yes, we rely on it
> being available, not only for the PSCI info, but other flags such as
> HW_REDUCED_ACPI.
> 
> I suppose it does not have to be globally scoped.  However, the FADT is
> frequently used, especially on x86, so it makes sense to me from an
> efficiency standpoint to have a global reference to it.
> 
> I'm not sure I understand what is meant by using FADT for ACPI revision
> detection; there are fields in the FADT that provide a major and minor
> number for the FADT itself, but I don't believe there's any guarantee
> those will be the same as the level of the specification that is being
> supported by the kernel (chances are they will, but it's not mandatory).
> 
> I've probably just missed a part of a thread somewhere; could you point
> me to where the inconsistency lies?  I'm just not understanding right this
> second....

Yes, it is my fault, I was referring to another thread/patch (9), where you
need to check the FADT revision to "validate it" (ie >= 5.1) for the arm64
kernel. What I am saying is: if the global FADT is there to parse PSCI
info, it is there to check the FADT revision too, I do not necessarily
see the need for calling acpi_table_parse() again to do it, the FADT
revision checking can be carried out as for PSCI, that's all I wanted
to say.

Thanks,
Lorenzo
