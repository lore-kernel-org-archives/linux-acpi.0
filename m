From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: rename pci HID constant
Date: Sat, 14 Jul 2007 23:37:13 +0100
Message-ID: <20070714223713.GC25782@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223351798-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38394 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXGNXGF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2007 19:06:05 -0400
Content-Disposition: inline
In-Reply-To: <11844223351798-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, Jul 14, 2007 at 11:12:04AM -0300, Henrique de Moraes Holschuh wrote:
> -	 .hid = IBM_PCI_HID,
> +	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.

Some rationale here would be good. There are no known devices where 
loading ibm-acpi is harmful.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
