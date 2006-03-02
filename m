From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Wed, 1 Mar 2006 22:13:48 -0500
Message-ID: <20060302031348.GE19755@redhat.com>
References: <20060301224647.GD1440@redhat.com> <200603020155.46534.ak@suse.de> <20060302011959.GC19755@redhat.com> <200603020238.31639.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751958AbWCBDOC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 22:14:02 -0500
Content-Disposition: inline
In-Reply-To: <200603020238.31639.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>

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

*boggle*, there really are only two single-core CPUs in there,
with no empty sockets. It's an early stepping of the motherboard
too that supposedly doesn't support dual-core.  So why these are present
at all, let alone 'disabled' is a mystery to me.

logrotate ate the old logs, so I don't have any old bootlogs
to grep through, but I'll take your word for it :)

Why ACPI decides to create 3 processor entries is still odd though.

		Dave

