From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 04 May 2006 09:31:28 -0600
Message-ID: <m1ejz94xin.fsf@ebiederm.dsl.xmission.com>
References: <CFF307C98FEABE47A452B27C06B85BB656C800@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60395 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932077AbWEDPc2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 May 2006 11:32:28 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB656C800@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Thu, 4 May 2006 01:07:29 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>, Andi Kleen <ak@suse.de>, sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>>>> We should never have had a problem with un-connected interrupt lines
>>>> consuming vectors, as the vectors are handed out at run-time
>>>> only when interrupts are requested by drivers.
>>>
>>>Incorrect.  By being requested by drivers I assume you mean by
>>>request_irq.  assign_irq_vector is called long before request_irq
>>>and in fact there is currently not a call from request_irq to
>>>assign_irq_vector.  Look where assign_irq_vector is called in 
>>io_apic.c
>
> Hmmm, on Natalie's ping, I looked at this again.
>
> setup_IO_APIC_irqs() actually consumes only 16 vectors.
> This is because it only sets up the IRQs for pins
> found with find_irq_entry(), which searches mp_irqs[]
> which at this point contains only the legacy identify mappings.

In the case of ACPI.  I think the mptable case has all of information
in mp_irqs at that point.

> The PNP code then takes a swing at things, and it registers
> a handful of gsi's, but they are all duplicates of the legacy
> mappings already set-up, so no additional vectors are consumed.
>
> So on a big system, the large quantity of vectors will not be consumed
> at
> IOAPIC initialization time, but later at device probe time.
> Not via request_irq(), but via pci_enable_device():
>
> pci_enable_device()
>  pci_enable_device_bars()
>   pcibios_enable_device()
>    pcibios_enable_irq() -> acpi_pci_irq_enable()
>     acpi_register_gsi()
>      mp_register_gsi()
>       io_apic_set_pci_routing()
>        entry.vector = assign_irq_vector(irq)
>
> So except for the legacy IRQs, we are already allocating the vectors
> on-demand, and that doesn't need to be fixed.

I agree with the fact, we do allocate the vectors on-demand.
Since the allocation is not allowed to fail, and because
it seems to be an accident of the implementation rather
than a deliberate implementation detail I still think it
needs to be fixed so the code is less brittle.

But if we are not afraid of breaking machines with more
that 243 interrupt sources (which currently force ioapic/pin
combinations to share irqs today) it does mean we can move
the removal of the irq to gsi mapping up, in the patch series.  We
first need to raise the limit on the number of IRQs on x86.

We can't raise the limit on the number of IRQs when msi is
enabled but enabling CONFIG_PCI_MSI already has problem in this
area and that is an independent fix.

Since we unnecessarily break big machines I think this needs to sit
in -mm until the window for 2.6.18 opens up.  By that time we should
be able to get all of the pieces in to keep the largest of machines
working well into the future.

That includes fixing msi to allocate irqs, fixing the irq affinity
calls to be race free, and making the vector allocation to be
a per cpu allocation.

I still think we need to do everything I outlined previously if
for no other reason than to leave us with a maintainable code
base that works for obvious reasons.  But since the dependencies
are not as bad as they previously appeared, it does mean we can
take the patches in a different order.

Eric
