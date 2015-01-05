From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Mon, 05 Jan 2015 21:16:30 +0100
Message-ID: <1797489.PjmKzBFdQA@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <54A28B22.7090305@linaro.org> <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63096 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbbAEURo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 15:17:44 -0500
In-Reply-To: <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jcm@redhat.com" <jcm@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, graeme.gregory@linaro.or

On Monday 05 January 2015 13:13:02 Catalin Marinas wrote:
> 
> > since passing no DT tables to OS but
> > acpi=force is missing is a corner case, we can do a follow up patch to
> > fix that, does it make sense?
> 
> Not entirely. Why would no dtb and no acpi=force be a corner case? I
> thought this should be the default when only ACPI tables are passed, no
> need for an additional acpi=force argument.

We don't really support the case of only ACPI tables for now. The expectation
is that you always have working DT support, at least for the next few years
as ACPI features are ramping up, and without acpi=force it should not try
to use ACPI at all.

	Arnd
