From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Mon, 22 Sep 2014 23:38:19 +0100
Message-ID: <20140922223819.GA10057@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140922194841.GA9868@amd>
 <20140922203136.GA32156@srcf.ucam.org>
 <2486199.jzqMgLksH8@vostro.rjw.lan>
 <20140922222810.GA9421@srcf.ucam.org>
 <5420A402.2060809@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42710 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaIVWih (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2014 18:38:37 -0400
Content-Disposition: inline
In-Reply-To: <5420A402.2060809@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>

On Tue, Sep 23, 2014 at 06:34:42AM +0800, Hanjun Guo wrote:
> On Sep 23, 2014, 06:28AM, Matthew Garrett wrote:
> > On Tue, Sep 23, 2014 at 12:46:24AM +0200, Rafael J. Wysocki wrote:
> >> On Monday, September 22, 2014 09:31:36 PM Matthew Garrett wrote:
> >>> Explicit Change Request. These can only be filed by paid-up members of 
> >>> the UEFI Forum, so I suspect this requirement is going to be unworkable 
> >>> (there's plenty of ACPI support code for large x86 vendors which isn't 
> >>> part of any ACPI spec).
> >> Why do you think so?
> > The IP rules in the membership agreements.
> 
> If I'm not mistaken, I think there is no IP issues for the _DSD bindings,
> it just some key value pairs.

That paragraph is talking about ACPI support in general, not just the 
_DSD code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
