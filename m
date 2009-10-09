From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH] PCIe AER: honor ACPI HEST FIRMWARE FIRST mode
Date: Fri, 9 Oct 2009 13:28:11 -0500
Message-ID: <20091009182810.GB24889@mock.linuxdev.us.dell.com>
References: <20091006173311.GA15751@auslistsprd01.us.dell.com> <4ACEE220.1020705@jp.fujitsu.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ACEE220.1020705@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Tom Long Nguyen <tom.l.nguyen@intel.com>, Zhang Yanmin <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 09, 2009 at 04:11:28PM +0900, Kenji Kaneshige wrote:
> In the current AER driver implementation, correctable, non-fatal,
> fatal, unsupported request reporting enable bits in PCIe device
> control register can be changed by adapter card drivers through pci_enable_pcie_error_reporting() or pci_disable_pcie_error_reporting()
> APIs, regardless of _OSC evaluation result.
>
> I'm not sure, but I guess you might need to prevent those bits
> from being changed in the Firmware First mode.

You are correct.  Thank you for the catch.  I don't know if we can
prevent changing these bits via the raw operations, but we can prevent
them in these functions.  Patch to follow does so.

-- 
Matt Domsch
Technology Strategist, Dell Office of the CTO
linux.dell.com & www.dell.com/linux
