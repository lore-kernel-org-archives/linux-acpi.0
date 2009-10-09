From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCIe AER: honor ACPI HEST FIRMWARE FIRST mode
Date: Fri, 09 Oct 2009 16:11:28 +0900
Message-ID: <4ACEE220.1020705@jp.fujitsu.com>
References: <20091006173311.GA15751@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56257 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078AbZJIHMQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2009 03:12:16 -0400
In-Reply-To: <20091006173311.GA15751@auslistsprd01.us.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Tom Long Nguyen <tom.l.nguyen@intel.com>, Zhang Yanmin <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org

Matt Domsch wrote:
> For review and comment.
> 
> Today, the PCIe Advanced Error Reporting (AER) driver attaches itself
> to every PCIe root port for which BIOS reports it should, via ACPI
> _OSC.
> 
> However, _OSC alone is insufficient for newer BIOSes.  Part of ACPI
> 4.0 is the new Platform Environment Control Interface (PECI), which is
> a way for OS and BIOS to handshake over which errors for which
> components each will handle.  One table in ACPI 4.0 is the Hardware
> Error Source Table (HEST), where BIOS can define that errors for
> certain PCIe devices (or all devices), should be handled by BIOS
> ("Firmware First mode"), rather than be handled by the OS.
> 
> Dell PowerEdge 11G server BIOS defines Firmware First mode in HEST, so
> that it may manage such errors, log them to the System Event Log, and
> possibly take other actions.  The aer driver should honor this, and
> not attach itself to devices noted as such.
> 
> 
> Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
> 

In the current AER driver implementation, correctable, non-fatal,
fatal, unsupported request reporting enable bits in PCIe device
control register can be changed by adapter card drivers through pci_enable_pcie_error_reporting() or pci_disable_pcie_error_reporting()
APIs, regardless of _OSC evaluation result.

I'm not sure, but I guess you might need to prevent those bits
from being changed in the Firmware First mode.

Thanks,
Kenji Kaneshige


