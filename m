From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: some new unaligned access while booting ia64 (HP rx2620)
Date: Tue, 14 Mar 2006 16:59:49 -0700
Message-ID: <200603141659.49535.bjorn.helgaas@hp.com>
References: <200602021946.k12Jk446028921@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:12168 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932097AbWCNX75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Mar 2006 18:59:57 -0500
In-Reply-To: <200602021946.k12Jk446028921@agluck-lia64.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>

On Thursday 02 February 2006 12:46, Luck, Tony wrote:
> Booting a snapshot of Linus' tree this morning I saw a few (new?)
> kernel unaligned access warnings:
> 
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOSAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003af8c0
> kernel unaligned access to 0xe00000407ec5a23c, ip=0xa0000001003af8c0
> kernel unaligned access to 0xe00000407ec5a28c, ip=0xa0000001003af8c0
> kernel unaligned access to 0xe00000407ec5a1fc, ip=0xa0000001003ae6c1
> kernel unaligned access to 0xe00000407ec5a204, ip=0xa0000001003ae6d1
> ACPI: PCI Interrupt Routing Table [\_SB_.SBA0.PCI0._PRT]
> ACPI: PCI Root Bridge [PCI1] (0000:20)

Did we ever resolve this?  Are we just waiting for new ACPI bits
to trickle into -mm and mainline?

I'd like to see the patch for just this issue, because it affects
SLES10, and Novell might balk at a complete ACPI CA update, but
might take just the individual patch.

Bjorn
