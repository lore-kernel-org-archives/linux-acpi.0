From: Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Wed, 1 Mar 2006 19:52:19 -0800
Message-ID: <20060301195218.A3539@unix-os.sc.intel.com>
References: <20060301224647.GD1440@redhat.com> <200603020155.46534.ak@suse.de> <20060302011959.GC19755@redhat.com> <200603020238.31639.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:54440 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWCBDwa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Mar 2006 22:52:30 -0500
Content-Disposition: inline
In-Reply-To: <200603020238.31639.ak@suse.de>; from ak@suse.de on Thu, Mar 02, 2006 at 02:38:31AM +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>

On Thu, Mar 02, 2006 at 02:38:31AM +0100, Andi Kleen wrote:
> 
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> > Processor #0 15:5 APIC version 16
> > ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> > Processor #1 15:5 APIC version 16
> > ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> > ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
> 
> It's because of the two disabled CPUs. We decreed at some point
> that disabled CPUs mean hotpluggable CPUs. But it's doing
> this for some time so you probably only noticed now.
> 
> All is ok. Sorry for blaming you wrongly, Ashok.


Phew!..

The ACPI hotplug code isnt in 2.6.15-rc* yet. It should be in the next
-mm when Andrew rolls the next mm.

But the 3 entries seem weird, we should only see 2 sysfs entries in 
/sys/devices/system/cpu and just 2 entries in proc/acpi/processor as well.



-- 
Cheers,
Ashok Raj
- Open Source Technology Center
