From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: multiple APIC/MADT found
Date: Mon, 16 Nov 2009 10:40:18 -0600
Message-ID: <200911160940.24046.bjorn.helgaas@hp.com>
References: <200911131338.38528.ffl@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:36253 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZKPQkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2009 11:40:25 -0500
In-Reply-To: <200911131338.38528.ffl@aber.ac.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fred Labrosse <ffl@aber.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Friday 13 November 2009 06:38:38 am Fred Labrosse wrote:
> At some point, I discovered that I only had one processor active on my 
> laptop (A VAIO VGN-SZ2M) wich has a centrino duo in (2 cores).  I then 
> discovered in dmesg the lines that say:
> 
> ACPI: BIOS bug: multiple APIC/MADT found, using 0
> ACPI: If "acpi_apic_instance=2" works better, notify linux-
> acpi@vger.kernel.org
> 
> So I did that (acpi_apic_instance=2) and that did give me 2 processors.  
> Which is definitely better, hence my email to the suggested address.

I think we need a DMI or similar mechanism to do this automatically,
so you don't need to use "acpi_apic_instance=2" every time you boot.
Can you open a bug report at http://bugzilla.kernel.org, attach the
output of dmidecode, and post the bug URL here?

> There is one thing that does not quite work however and I don't know if this 
> is related: ACPI only sees one processor and therefore cpufreq only controls 
> the frequency of one processor.  I think this used to work but I don't know 
> when that stopped.

I assume you mean that with "acpi_apic_instance=2", Linux starts both
CPUs, but cpufreq only works with one.  If so, can you open another
bug report, attach the dmesg log, and post the URL here?

Thanks,
  Bjorn
