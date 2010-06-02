From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error messages
Date: Wed, 02 Jun 2010 08:59:22 +0800
Message-ID: <1275440362.9119.7219.camel@rzhang1-desktop>
References: <Pine.LNX.4.44L0.1006010906530.16754-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30498 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab0FBA6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jun 2010 20:58:54 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006010906530.16754-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-06-01 at 21:11 +0800, Alan Stern wrote:
> My kernel log is full of hundreds of messages like these:
> 
> ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000046) is beyond end of object (20090903/exoparg2-445)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node f701c918), AE_AML_BUFFER_LIMIT
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node f7017b58), AE_AML_BUFFER_LIMIT
> ACPI Error: Evaluating _BCM failed (20090903/video-528)
> 
This sounds like a win7 compatibility issue that I've seen before.
please try boot option acpi_osi="!Windows 2009" and see if it helps.

BTW, it would be great if you can attach the acpidump of this laptop and
the dmesg output after boot.

thanks,
rui

> This is on an ASUS UL20A laptop (ICH9 chipset) with Fedora-12 (kernel
> 2.6.32.12).  What is the reason for these error messages?  Can anything 
> be done to fix them?
> 
> Thanks,
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


