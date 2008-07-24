From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature
 shutdowns
Date: Thu, 24 Jul 2008 08:42:56 -0700
Message-ID: <4888A300.1080808@linux.intel.com>
References: <200807241727.41715.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:56989 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751727AbYGXPm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jul 2008 11:42:59 -0400
In-Reply-To: <200807241727.41715.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Len Brown <lenb@kernel.org>, Christian Kornacker <ckornacker@suse.de>

Thomas Renninger wrote:
> This is the fix for this from Arjan:
> 
>     ACPI: Reject below-freezing temperatures as invalid critical temperatures
> 
>     My laptop thinks that it's a good idea to give -73C as the critical
>     CPU temperature.... which isn't the best thing since it causes a shutdown
>     right at bootup.
> 
>     Temperatures below freezing are clearly invalid critical thresholds
>     so just reject these as such.
> 

btw on my laptop, it wasn't 0 that was returned, but 2007.
This is suspected to be related to how windows finds some random other ACPI state to return,
but it significantly was an AML issue on the bios side.
Just the effect was a trainwreck so I added a check to the kernel (in addition to getting
full info to Robert for the ACPICA side of the issue).

