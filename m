From: Len Brown <lenb@kernel.org>
Subject: Re: Advice on result of using acpi_osi=Linux
Date: Wed, 23 Apr 2008 21:10:14 -0400
Message-ID: <200804232110.14301.lenb@kernel.org>
References: <480EBE51.1000408@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43471 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbYDXBKe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 21:10:34 -0400
In-Reply-To: <480EBE51.1000408@bigpond.net.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-acpi@vger.kernel.org

thanks for the report, peter.

please send me the output from dmidecode.

-Len

On Wednesday 23 April 2008, Peter Williams wrote:
> As requested via syslog message, I'm reporting the results I obtained 
> using acpi_osi=Linux on the boot command line:
> 
> Without this addition to command line, I get:
> 
> Apr 23 14:04:38 mudlark kernel: ACPI: BIOS _OSI(Linux) query ignored
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI System Vendor: 
> 
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI Product Name: 
> 
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI Product Version: 
> 
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI Board Name: DG31PR
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI BIOS Vendor: Intel Corp.
> Apr 23 14:04:38 mudlark kernel: ACPI: DMI BIOS Date: 09/28/2007
> Apr 23 14:04:38 mudlark kernel: ACPI: Please send DMI info above to 
> linux-acpi@vger.kernel.org
> Apr 23 14:04:38 mudlark kernel: ACPI: If "acpi_osi=Linux" works better, 
> please notify linux-acpi@vger.kernel.org
> 
> With this addition, I get:
> 
> Apr 23 14:13:57 mudlark kernel: ACPI: BIOS _OSI(Linux) query honored via 
> cmdline
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI System Vendor: 
> 
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI Product Name: 
> 
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI Product Version: 
> 
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI Board Name: DG31PR
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI BIOS Vendor: Intel Corp.
> Apr 23 14:13:57 mudlark kernel: ACPI: DMI BIOS Date: 09/28/2007
> Apr 23 14:13:57 mudlark kernel: ACPI: Please send DMI info above to 
> linux-acpi@vger.kernel.org
> 
> I'm not sure if this constitutes better but I thought I'd report it anyway.
> 
> Peter


