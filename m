From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 02:38:31 +0100
Message-ID: <200603020238.31639.ak@suse.de>
References: <20060301224647.GD1440@redhat.com> <200603020155.46534.ak@suse.de> <20060302011959.GC19755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35774 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751317AbWCBBgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 20:36:38 -0500
In-Reply-To: <20060302011959.GC19755@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>


> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)

It's because of the two disabled CPUs. We decreed at some point
that disabled CPUs mean hotpluggable CPUs. But it's doing
this for some time so you probably only noticed now.

All is ok. Sorry for blaming you wrongly, Ashok.

-Andi
