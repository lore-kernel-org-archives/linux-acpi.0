From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V5] acpi: add support for extended IRQ to PCI link
Date: Wed, 25 Nov 2015 13:28:06 -0500
Message-ID: <5655FDB6.1020608@codeaurora.org>
References: <1448395843-23112-1-git-send-email-okaya@codeaurora.org>
 <5655C55D.80206@codeaurora.org> <20151125172704.GE1380@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49382 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbKYS2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2015 13:28:09 -0500
In-Reply-To: <20151125172704.GE1380@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 11/25/2015 12:27 PM, Bjorn Helgaas wrote:
> Maybe reword the diagnostic to make it clear that we're ignoring this
> IRQ information.  It'd really be nice if the message had a clue about
> what it applies to, i.e., the ACPI device path or something,

Are we OK with print strings exceeding 80 characters to include detailed
information? Chris Covington pointed out to me that there are exceptions
to 80 characters when it comes to print format strings.

"The limit on the length of lines is 80 columns and this is a strongly
preferred limit. ... However, never break user-visible strings such as
printk messages, because that breaks the ability to grep for them."


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
