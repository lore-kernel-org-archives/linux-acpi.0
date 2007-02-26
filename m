From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Mon, 26 Feb 2007 12:32:11 -0700
Message-ID: <200702261232.11947.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <20070225215922.GA28931@lists.us.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:52716 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030481AbXBZTcT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Feb 2007 14:32:19 -0500
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan_Hargrave@dell.com
Cc: Matt_Domsch@dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Monday 26 February 2007 11:30, Jordan_Hargrave@dell.com wrote:
>   Here is the patch (RHEL5 base code) I've been testing that detects
>   the ACPI namespace object.

I like this approach a lot.

Shouldn't acpi_ipmi_getresource() also look for IRQ descriptors?
The existing code that looks at the SPMI table can handle either
GPEs or regular IOxAPIC interrupts (i.e., a GSI).

You might also want to look for memory address ranges as well
as IO ranges.

I wish you could use pnp_register_driver() instead of
acpi_bus_register_driver().  That would let you get rid of all
the _CRS parsing.  But I forgot that IPMI devices often use GPEs
instead of regular interrupts, and GPEs require a different
path (acpi_install_gpe_handler() instead of request_irq(), etc),
so I guess you're stuck with grubbing through _CRS by hand.

Plus, it looks like you need the _IFT thing to figure out what
type of interface it is.  It might have been nicer if there
were separate PNP IDs for KCS vs SMIC vs BT.  But that's water
under the bridge.

Bjorn

