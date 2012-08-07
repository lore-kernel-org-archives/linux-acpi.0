From: Joerg Roedel <joro@8bytes.org>
Subject: Re: IRQ remapping problem on Macbook Air 5,1
Date: Tue, 7 Aug 2012 22:10:30 +0200
Message-ID: <20120807201030.GJ1917@8bytes.org>
References: <20120807194837.GB23829@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120807194837.GB23829@thinkpad-t410>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Seth,

On Tue, Aug 07, 2012 at 02:48:37PM -0500, Seth Forshee wrote:
> This machine has a bug in its ACPI tables that's causing it to fail to
> boot unless intremap=off is passed to the kernel. The MADT defines a
> single IOAPIC with id 2, but the remapping unit defined in DMAR matches
> id 0. Thus interrupt remapping fails, and the kernel panics with the
> message "timer doesn't work through Interrupt-remapped IO-APIC." If I
> force the use of the non-matching ir hardware for the IOAPIC everything
> seems to works fine. dmesg for the working boot is below.

There are AMD systems with similar problems. For example I had a system
with 2 IO-APICs but only one was described in the IOMMU ACPI table.

> I'm looking at how to make this machine able to boot by default. OS X
> obviously boots, and Windows presumably boots as well since Apple
> officially supports running Windows on its hardware.

These operating systems probably don't support interrupt remapping, or
the IOMMU at all.

> I've got a patch to leave IRQ remapping disabled whenever any IOAPIC
> does not have a matching ir hardware unit. This gets it to boot, but I
> thought I'd check and see whether anyone had any better ideas for how to
> fix this.

This is exactly how I fixed this issue on the AMD side too. Mind to
submit the patch?


Thanks,

	Joerg
