From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
Date: Mon, 6 Oct 2014 19:47:25 +0100
Message-ID: <20141006184725.GA1152@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2026795.jAP8HDLAZo@wuerfel>
 <20141006182153.GA31521@srcf.ucam.org>
 <2046349.jdtgG25KJR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53583 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbaJFSrh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2014 14:47:37 -0400
Content-Disposition: inline
In-Reply-To: <2046349.jdtgG25KJR@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, graeme.gregory@linaro.org, marc.zyngier@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, astone@redhat.com, grant.likely@linaro.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, olof@lixom.net, jason@lakedaemon.net, "Duran, Leo" <leo.duran@amd.com>, Jon Masters <jcm@redhat.com>

On Mon, Oct 06, 2014 at 08:44:35PM +0200, Arnd Bergmann wrote:
> On Monday 06 October 2014 19:21:53 Matthew Garrett wrote:
> > Unfortunately not. I'd assume that PM registers are expected to be 
> > accessed via the _PS* methods instead. Does MSI make sense outside the 
> > context of PCI interrupts?
> 
> Yes, the ARM GIC has a weird sense of what MSI is used for, and
> apparently some SoC vendors have started using MSI by default for
> all on-chip peripherals.
> 
> A patch series to extend MSI to platform devices is currently
> under review.

Mm. Yeah, it doesn't seem like there's any ACPI-defined mechanism for 
MSI control. Let's chat about this next week?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
