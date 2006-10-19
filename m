From: Dave Jones <davej@redhat.com>
Subject: Re: SMP broken on pre-ACPI machine.
Date: Thu, 19 Oct 2006 15:16:44 -0400
Message-ID: <20061019191644.GE26530@redhat.com>
References: <20061018222433.GA4770@redhat.com> <200610190133.40581.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:7880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946389AbWJSTRO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 15:17:14 -0400
Content-Disposition: inline
In-Reply-To: <200610190133.40581.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, Oct 19, 2006 at 01:33:40AM -0400, Len Brown wrote:
 > On Wednesday 18 October 2006 18:24, Dave Jones wrote:
 > > I've been chasing a bug that got filed against the Fedora kernel
 > > a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=199052
 > > This is a dual pentium pro from an era before we had ACPI, and
 > > it seems to be falling foul of this test in smpboot.c  ..
 > > 
 > >     if (!smp_found_config && !acpi_lapic) {
 > >         printk(KERN_NOTICE "SMP motherboard not detected.\n");
 > > 
 > > My initial reaction is that the !acpi_lapic test should be conditional
 > > on some variable that gets set if the ACPI parsing actually succeeded.
 > 
 > acpi_lapic isn't related to the problem at hand -- that  smp_found_config is not set.

Right, it just seemed odd to me when I was eyeballing this code.

 > That said, allowing acpi_lapic=1 to bail out of this check has the sole
 > function of allowing SMP/PIC configurations.  (smp_found_config
 > in ACPI mode is set if acpi_lapic and acpi_ioapic are set)
 > SMP/PIC configurations are not very interesting, except for debugging.
 > Indeed, MPS prohibits them by mandating an IOAPIC be present for SMP --
 > but ACPI has no such rule.

Why smp_found_config isn't set in that guys configuration is a mystery to me,
as his MPS tables look sane..

MP Table:
#	APIC ID	Version	State		Family	Model	Step	Flags
#	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381
#	 0	 0x10	 AP, usable	 6	 1	 7	 0xfbff

Hmm, wait, he has unpaired CPUs. I wonder if that's the reason.
I know *some* combinations of PPro's are valid to be paired, but I'll
need to dig out the old docs to be sure.

	Dave

-- 
http://www.codemonkey.org.uk
