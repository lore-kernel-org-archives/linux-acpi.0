From: <Jordan_Hargrave@Dell.com>
Subject: RE: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Mon, 26 Feb 2007 14:06:31 -0600
Message-ID: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE07387A@ausx3mpc102.aus.amer.dell.com>
References: <200702102327.28312.lenb@kernel.org> <20070225215922.GA28931@lists.us.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com> <200702261232.11947.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:32520 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030630AbXBZUGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Feb 2007 15:06:37 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bjorn.helgaas@hp.com
Cc: Matt_Domsch@Dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Correct, the parseresource code really should look for IRQ/MEM, but I haven't yet seen any ACPI namespaces that use memory or IRQ resources with IPI0001 for testing. (I have a huge collection of DSDTs from my OpenBSD work). 

--jordan hargrave
Dell Enterprise Linux Engineering



-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
Sent: Mon 2/26/2007 1:32 PM
To: Hargrave, Jordan
Cc: Domsch, Matt; minyard@acm.org; alexey.y.starikovskiy@linux.intel.com; linux-acpi@vger.kernel.org; openipmi-developer@lists.sourceforge.net; lenb@kernel.org
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
 
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
