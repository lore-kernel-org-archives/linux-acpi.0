From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle SATA controller
Date: Mon, 06 Oct 2014 20:44:35 +0200
Message-ID: <2046349.jdtgG25KJR@wuerfel>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com> <2026795.jAP8HDLAZo@wuerfel> <20141006182153.GA31521@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52520 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbaJFSox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2014 14:44:53 -0400
In-Reply-To: <20141006182153.GA31521@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, graeme.gregory@linaro.org, marc.zyngier@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, astone@redhat.com, grant.likely@linaro.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, olof@lixom.net, jason@lakedaemon.net, "Duran, Leo" <leo.duran@amd.com>, Jon Masters <jcm@redhat.com>

On Monday 06 October 2014 19:21:53 Matthew Garrett wrote:
> On Mon, Oct 06, 2014 at 08:19:37PM +0200, Arnd Bergmann wrote:
> 
> > Interesting. Does this also define a way to get access to registers
> > that are normally in PCI config space, provided they are accessible at
> > all?
> 
> Unfortunately not. I'd assume that PM registers are expected to be 
> accessed via the _PS* methods instead. Does MSI make sense outside the 
> context of PCI interrupts?

Yes, the ARM GIC has a weird sense of what MSI is used for, and
apparently some SoC vendors have started using MSI by default for
all on-chip peripherals.

A patch series to extend MSI to platform devices is currently
under review.

	Arnd
