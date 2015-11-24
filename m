From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4] acpi: add support for extended IRQ to PCI link
Date: Tue, 24 Nov 2015 15:05:40 -0500
Message-ID: <5654C314.7050201@codeaurora.org>
References: <1447902818-15810-1-git-send-email-okaya@codeaurora.org>
 <20151124181150.GA27957@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54467 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbbKXUGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 15:06:00 -0500
In-Reply-To: <20151124181150.GA27957@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 11/24/2015 1:11 PM, Bjorn Helgaas wrote:
> 
> As Andy mentioned, please wrap this text to use more of an 80-column
> line.  I fill changelogs to 75 columns (vi textwidth=75), which fits
> perfectly when "git log" inserts 4 leading spaces.
> 

will do

> 
> These changes are basically all bounds-checking link->irq.possible[i]
> and link->irq.active.  What if you put that checking at the point
> where we *initialize* those fields instead, i.e., in
> acpi_pci_link_check_possible() and acpi_pci_link_get_current()?  Then 
> you'd only have to check each field in one place, and you could easily
> add a message if we see an ID that's too large.
> 

I'll post a patch soon.

> I think the current code for ACPI_RESOURCE_TYPE_EXTENDED_IRQ is buggy
> because it silently truncates IDs to 8 bits.
> 
> Bjorn
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
