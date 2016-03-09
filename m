From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Date: Tue, 8 Mar 2016 19:45:04 -0500
Message-ID: <56DF7210.7020103@codeaurora.org>
References: <20160301194340.GA19783@localhost>
 <56D7317F.7090500@codeaurora.org> <56D7ABFB.3070302@codeaurora.org>
 <56D84EA9.3080900@codeaurora.org> <20160303151048.GA3290@localhost>
 <56D8546B.5040908@codeaurora.org> <56D8745D.70509@codeaurora.org>
 <20160304180959.GA4794@localhost> <56DDB28F.1040300@codeaurora.org>
 <20160308002558.GC26149@localhost> <20160308002909.GA13250@localhost>
 <56DF2258.8020004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56964 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbcCIApI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 19:45:08 -0500
In-Reply-To: <56DF2258.8020004@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, bhelgaas@google.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

Hi Bjorn,

On 3/8/2016 2:04 PM, Sinan Kaya wrote:
>>> The point here is that a PCI Interrupt Link can only use an IRQ that
>>> >> is level-triggered, active low.  If an IRQ is already set to any other
>>> >> state, whether for an ISA device or for an active-high SCI, we can't
>>> >> use it for a PCI Interrupt Link.
> Unfortunately, this still doesn't hold. 
> 
> A patch is long overdue for this series. I'll post v3. We can go from there.

I just posted a new series and changed the title. Let's continue the discussion there.

[PATCH 1/4] acpi,pci,irq: reduce resource requirements
...

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
