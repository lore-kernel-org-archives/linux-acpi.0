From: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: How to "register" a GSI for a non PCI non ISA device
Date: Thu, 26 Jan 2012 16:07:19 +0100
Message-ID: <20120126160719.3b9be3b3@xilun>
References: <20120124184203.1b0878c2@xilun>
	<4F1F99A5.1000206@kernel.org>
	<20120125182314.7834c75b@xilun>
	<20120125190214.GC18606@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120125190214.GC18606@phenom.dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Guillaume Knispel <gknispel@proformatique.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Xavier Carcelle <xcarcelle@avencall.com>, =?ISO-8859-1?Q?No=E9?= Rubinstein <nrubinstein@avencall.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Jan 2012 14:02:14 -0500
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Wed, Jan 25, 2012 at 06:23:14PM +0100, Guillaume Knispel wrote:
> > On Wed, 25 Jan 2012 00:56:53 -0500
> > Len Brown <lenb@kernel.org> wrote:
> > 
> > > What is the benefit of implementing ACPI on this custom system?
> > 
> > For our short term project it seems to be more a necessity than a
> > benefit. ACPI is supported by the SoC, tables are already largely
> > provided by Coreboot, the whole x86 ecosystem including Linux is more
> > or less based around ACPI, and my whole interrogation comes from the
> > fact that *acpi*_register_gsi() seems to be necessary to configure a
> > GSI in the APIC but is not exported anymore, so my guess is that if I
> 
> Hm, isn't it __acpi_register_gsi?

__acpi_register_gsi exists on recent kernels, it is the pointer to
the underlying implementation of that function depending on the
platform (x86 / xen-x86) and on the variant of the platform (pic/apic).
acpi_register_gsi still exists and it calls __acpi_register_gsi.

> > can't call it explicitly from my LKM, there should better be a way to
> > make it be called when an ACPI thing is done, or maybe a legacy table
> > parsed.
> 
> Can you do it the way xen does? Look in arch/x86/xen/pci.c

Did not found this file. Besides, isn't Xen a separate architecture
from mainline x86, compiled built-in? My goal is to only touch LKM and
system firmware if necessary.

> > As we first target an unmodified (if possible) 2.6.32 kernel from
> > Debian Squeeze, I can't just re-export acpi_register_gsi() and call it
> > a day. (If I've no other choice I'll obviously do it, but this would be
> > quite bad for future maintenance).
> 
> Oh wow. That is ancient. 3.2?

3.2 when a Debian stable will feature 3.2 :)

-- 
Guillaume Knispel
Avencall - 10 bis, rue Lucien Voilin - 92800 Puteaux
