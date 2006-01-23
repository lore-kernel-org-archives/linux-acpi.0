From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.16-rc1  will not boot on msi rs480m2 when either acpi or apic is enabled
Date: Mon, 23 Jan 2006 10:00:46 -0700
Message-ID: <200601231000.46575.bjorn.helgaas@hp.com>
References: <43D4FE2F.5080700@clifford.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:6593 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964822AbWAWRAs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 12:00:48 -0500
In-Reply-To: <43D4FE2F.5080700@clifford.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raphael Clifford <raphael@clifford.net>
Cc: linux-acpi@vger.kernel.org

On Monday 23 January 2006 09:02, Raphael Clifford wrote:
> MSI rs480m2 system  (AMD64 processor) will not boot when either acpi or apic are
> enabled in the boot arguments.  This has been tested in many kernels (gentoo and vanilla) up
> to and including 2.6.16-rc1.  

Can you try "pci=routeirq"?  Can you capture the entire boot output
with a serial console or netconsole?  Are any BIOS updates available
for this box?

