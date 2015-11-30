From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V6] acpi: add support for extended IRQ to PCI link
Date: Mon, 30 Nov 2015 18:07:53 -0500
Message-ID: <565CD6C9.2020605@codeaurora.org>
References: <1448477558-12310-1-git-send-email-okaya@codeaurora.org>
 <20151130203823.GC29242@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57072 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbbK3XH6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 18:07:58 -0500
In-Reply-To: <20151130203823.GC29242@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 11/30/2015 3:38 PM, Bjorn Helgaas wrote:
>> > Additional checks have been placed to return an error when ACPI_MAX_IRQS
>> > is exceeded.
>> > 
>> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> I don't think the description is quite accurate -- I think the
> extended IRQ descriptor is required for IRQs of *16* and greater, not
> IRQs greater than 256.  Here's how I understand it:
> 
>   The ACPI IRQ Descriptor contains a 16-bit mask with a bit for each
>   IRQ, so it can describe interrupt numbers in the range [0-15].
>   Interrupt numbers greater than 15 must be described with an Extended
>   IRQ Descriptor, which contains a table of 32-bit interrupt numbers
>   and can describe interrupt numbers in the range [0-(2^32-1)].  See
>   ACPI 5.0, sections 6.4.2.1 and 6.4.3.6.
> 

You are right. I'm pasting from the spec.

"6.4.2.1 IRQ Descriptor
Type 0, Small Item Name 0x4, Length = 2 or 3
The IRQ data structure indicates that the device uses an interrupt level
and supplies a mask with bits set indicating the levels implemented in
this device. For standard PC-AT implementation there are 15 possible
interrupts so a two-byte field is used. This structure is repeated for
each separate interrupt required"


"6.4.3.6 Extended Interrupt Descriptor
Type 1, Large Item Name 0x9
The Extended Interrupt Descriptor is necessary to describe interrupt
settings and possibilities for systems that support interrupts above 15."

I'll reword correctly. This was a Linux implementation bug not a spec
compliance issue.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
