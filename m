From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Thu, 07 Jan 2010 15:05:42 -0800
Message-ID: <4B4668C6.7000309@zytor.com>
References: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain> <1262894593-25563-1-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49450 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0AGXKu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2010 18:10:50 -0500
In-Reply-To: <1262894593-25563-1-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On 01/07/2010 12:03 PM, Christian Hofstaedtler wrote:
> Newer hardware is assumed to no longer reboot succesfully using the
> keyboard controller, but needs to use ACPI instead.
> To not cause problems with older hardware, only hardware with a BIOS
> date 2006 or newer is considered for this choice. Broken BIOSes
> reporting a BIOS date of 0 are not specially considered, and therefore
> get the KBD reboot behaviour.
> 
> Also unifiy reboot_type selection code.
> 
> Signed-off-by: Christian Hofstaedtler <ch@zeha.at>

Looks good to me.  Len: do you want to take it or should I?

	-hpa
