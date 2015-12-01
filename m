From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7] ACPI, PCI, irq: support IRQ numbers greater than 256
Date: Tue, 1 Dec 2015 11:30:21 -0500
Message-ID: <565DCB1D.7030308@codeaurora.org>
References: <1448926742-24308-1-git-send-email-okaya@codeaurora.org>
 <20151201153031.GD9306@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46131 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbbLAQaY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 11:30:24 -0500
In-Reply-To: <20151201153031.GD9306@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 12/1/2015 10:30 AM, Bjorn Helgaas wrote:
> Not sure whether you saw my earlier response about this:
> 
Sorry, I missed it.

>   ACPI_MAX_IRQS is only used to size the acpi_irq_penalty[] table (and
>   after your patch, to validate IRQ numbers from ACPI).  But I think
>   the acpi_irq_penalty[] table is a design we've outgrown.  I *think*
>   we only care about penalties for IRQs 0-15, so even a 256-entry
>   table is more than we need.
> 
>   If we could make acpi_irq_penalty[] a fixed size of 16 entries or
>   replace it with a linked list, I think we could get rid of
>   ACPI_MAX_IRQS completely.  Then the validation checks you add below
>   would be unnecessary and we could handle any interrupt number
>   supplied from ACPI.
> 
> I think it would be really nice to get rid of the arbitrary maximum
> interrupt ID (1020).

Let me look and do some testing. I'll try to do less damage by using a
link list rather than 16 and try to replicate the existing functionality.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
