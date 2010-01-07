From: Christian Hofstaedtler <ch@zeha.at>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Thu, 7 Jan 2010 21:05:09 +0100
Message-ID: <201001072105.09665.ch@zeha.at>
References: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain> <1262894593-25563-1-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from percival.namespace.at ([77.244.242.130]:59335 "EHLO
	percival.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0AGUFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2010 15:05:50 -0500
In-Reply-To: <1262894593-25563-1-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On Thursday 07 January 2010 21:03:13 Christian Hofstaedtler wrote:
> Newer hardware is assumed to no longer reboot succesfully using the
> keyboard controller, but needs to use ACPI instead.
> To not cause problems with older hardware, only hardware with a BIOS
> date 2006 or newer is considered for this choice. Broken BIOSes
> reporting a BIOS date of 0 are not specially considered, and therefore
> get the KBD reboot behaviour.
> 
> Also unifiy reboot_type selection code.

So this is probably the patch with all comments addressed, except for doing 
some _OSI ACPI call detection. If someone wants to do something based on that 
idea, please do - I know too little about this stuff to be useful here.

  Christian
