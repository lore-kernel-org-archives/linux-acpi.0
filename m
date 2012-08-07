From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: IRQ remapping problem on Macbook Air 5,1
Date: Tue, 07 Aug 2012 13:53:33 -0700
Message-ID: <1344372814.27383.12.camel@sbsiddha-desk.sc.intel.com>
References: <20120807194837.GB23829@thinkpad-t410>
	 <20120807201030.GJ1917@8bytes.org>
	 <1344372472.27383.8.camel@sbsiddha-desk.sc.intel.com>
	 <20120807205519.GC23829@thinkpad-t410>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65277 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303Ab2HGU4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Aug 2012 16:56:51 -0400
In-Reply-To: <20120807205519.GC23829@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Yinghai Lu <yinghai@kernel.org>

On Tue, 2012-08-07 at 15:55 -0500, Seth Forshee wrote:
> On Tue, Aug 07, 2012 at 01:47:52PM -0700, Suresh Siddha wrote:
> > On Tue, 2012-08-07 at 22:10 +0200, Joerg Roedel wrote:
> > > Hi Seth,
> > > 
> > > On Tue, Aug 07, 2012 at 02:48:37PM -0500, Seth Forshee wrote:
> > > > This machine has a bug in its ACPI tables that's causing it to fail to
> > > > boot unless intremap=off is passed to the kernel. The MADT defines a
> > > > single IOAPIC with id 2, but the remapping unit defined in DMAR matches
> > > > id 0. Thus interrupt remapping fails, and the kernel panics with the
> > > > message "timer doesn't work through Interrupt-remapped IO-APIC." If I
> > > > force the use of the non-matching ir hardware for the IOAPIC everything
> > > > seems to works fine. dmesg for the working boot is below.
> > > 
> > > There are AMD systems with similar problems. For example I had a system
> > > with 2 IO-APICs but only one was described in the IOMMU ACPI table.
> > 
> > This issue should be caught by the current check in
> > parse_ioapics_under_ir()
> > 
> > if (ir_supported && ir_ioapic_num != nr_ioapics) {
> > ...
> 
> No, there's one IOMMU and one IOAPIC, so this check doesn't catch it.
> The problem is that the ids in the ACPI tables for the devices don't
> match.
> 

Seth, I am referring to the issue that Joerg raised. Not referring to
your current issue.

thanks,
suresh

