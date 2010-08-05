From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Question regarding linux acpi
Date: Thu, 5 Aug 2010 12:55:25 +0100
Message-ID: <20100805115525.GA18337@srcf.ucam.org>
References: <20100804170236.GA32073@srcf.ucam.org> <BLU102-W143744C8470E5E9C2F4B8EEB900@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50592 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab0HELz3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Aug 2010 07:55:29 -0400
Content-Disposition: inline
In-Reply-To: <BLU102-W143744C8470E5E9C2F4B8EEB900@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Aug 05, 2010 at 04:21:36PM +0530, Raj Kumar wrote:

> {RAJ}: Does it mean then PCI bus driver code and ACPI driver will directly communicate
> with each other without any linux power management core?

Yes, but the bus driver will then call the power management core.

> {RAJ}: If system suspend/resumes and runtime_suspend/runtime_resume happens, as linux power management core(static/runtime)
> calls the bus driver code so when ACPI will be there, the bus driver will directly call the ACPI driver APIs.

When ACPI is available, yes.

> But still device driver's suspend and resume(static and runtime) calls will be called by bus driver as normal behaviour
> and if ACPI is there, then bus driver will inform the device driver and then inform the device power status to ACPI driver?

The device driver may call back into the bus driver, and that may in 
turn trigger an ACPI call. PCI is the best example of this - check out 
the pci_platform_pm_ops structure in pci-acpi.c for example.

> {RAJ}: Will the ACPI driver code also call the linux power management functions directly?

For runtime power management? No.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
