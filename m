From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Wed, 17 Sep 2014 20:59:32 +0100
Message-ID: <20140917195932.GA21910@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <4416582.iOjLNrLDZE@vostro.rjw.lan>
 <20140917192259.GA18980@srcf.ucam.org>
 <1628662.T2ReQ4irMm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52889 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840AbaIQT7s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2014 15:59:48 -0400
Content-Disposition: inline
In-Reply-To: <1628662.T2ReQ4irMm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rd>

On Wed, Sep 17, 2014 at 10:11:13PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 17, 2014 08:22:59 PM Matthew Garrett wrote:
> > Using the information should be fine, but my understanding of the UEFI 
> > forum rules is that any submissions to UEFI specs must be from UEFI 
> > forum members - there are concerns around accidentally including 
> > patented material.
> 
> The documents in question are not regarded as UEFI specs, however.  They
> are just hosted by UEFI.

There's arguably some precedent for that - the ACPI vendor IDs and EFI 
System Partition name repositories are hosted rather than specs. But it 
seems like there's some qualitative difference between that kind of raw 
data and something that actually defines behaviour. But if the UEFI 
people feel comfortable with this, it's not a problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
