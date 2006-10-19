From: Len Brown <len.brown@intel.com>
Subject: Re: SMP broken on pre-ACPI machine.
Date: Thu, 19 Oct 2006 01:33:40 -0400
Message-ID: <200610190133.40581.len.brown@intel.com>
References: <20061018222433.GA4770@redhat.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:28577 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161019AbWJSFbS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 01:31:18 -0400
In-Reply-To: <20061018222433.GA4770@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Wednesday 18 October 2006 18:24, Dave Jones wrote:
> I've been chasing a bug that got filed against the Fedora kernel
> a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=199052
> This is a dual pentium pro from an era before we had ACPI, and
> it seems to be falling foul of this test in smpboot.c  ..
> 
>     if (!smp_found_config && !acpi_lapic) {
>         printk(KERN_NOTICE "SMP motherboard not detected.\n");
>         smpboot_clear_io_apic_irqs();
>         phys_cpu_present_map = physid_mask_of_physid(0);
>         if (APIC_init_uniprocessor())
>             printk(KERN_NOTICE "Local APIC not detected."
>                        " Using dummy APIC emulation.\n");
>         map_cpu_to_logical_apicid();
>         cpu_set(0, cpu_sibling_map[0]);
>         cpu_set(0, cpu_core_map[0]);
>         return;
>     }
> 
> 
> My initial reaction is that the !acpi_lapic test should be conditional
> on some variable that gets set if the ACPI parsing actually succeeded.

acpi_lapic isn't related to the problem at hand -- that  smp_found_config is not set.

That said, allowing acpi_lapic=1 to bail out of this check has the sole
function of allowing SMP/PIC configurations.  (smp_found_config
in ACPI mode is set if acpi_lapic and acpi_ioapic are set)
SMP/PIC configurations are not very interesting, except for debugging.
Indeed, MPS prohibits them by mandating an IOAPIC be present for SMP --
but ACPI has no such rule.

-Len
