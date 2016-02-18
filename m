From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Date: Thu, 18 Feb 2016 11:43:32 -0500
Message-ID: <56C5F4B4.2080400@codeaurora.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hOrY3iP8QQMQxkNtY7vQcrShQuPBxyNBqY6DYaxhf1bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35665 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946357AbcBRQng (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2016 11:43:36 -0500
In-Reply-To: <CAJZ5v0hOrY3iP8QQMQxkNtY7vQcrShQuPBxyNBqY6DYaxhf1bA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com, Len Brown <lenb@kernel.org>, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2/18/2016 11:39 AM, Rafael J. Wysocki wrote:
>> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024
> Why do we need so many of them?
> 

The previous code supported 1024 max interrupts before 
"ACPI, PCI, irq: remove interrupt count restriction" change. 

I added back 1024 number but the limit is only for early IRQs now.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
