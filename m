From: Vernon Mauery <vernux@us.ibm.com>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 08:44:00 -0800
Message-ID: <4214C9D0.1090707@us.ibm.com>
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <4214C3B8.30502@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> 1. A first step towards better DSDTs would be to make the ASL compiler
> complain about the same things which are complained about by the
> in-kernel ACPI interpreter. An example would be the following:
> 
> acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]
> 
> The ASL compiler will not complain about it, yet the kernel will
> refuse to do any processor throttling with a PBLK length of 7.

This is like getting gcc to complain about run-time bugs in a program.  The compiler of a language (ASL in this case) compiles the language, regardless of run-time bugs because it can only detect syntax errors.  And iasl does that pretty well.  

--Vernon
