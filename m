From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Mon, 26 Feb 2007 15:39:09 -0700
Message-ID: <200702261539.09324.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <200702261232.11947.bjorn.helgaas@hp.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE07387A@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:48480 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620AbXBZWjU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Feb 2007 17:39:20 -0500
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE07387A@ausx3mpc102.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan_Hargrave@dell.com
Cc: Matt_Domsch@dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

[This bounced from the list because I attached too much stuff.
If you want copies of the DSDTs I mentioned below, let me know
and I can mail them to you individually.]

On Monday 26 February 2007 13:06, Jordan_Hargrave@dell.com wrote:
> Correct, the parseresource code really should look for IRQ/MEM, but
> I haven't yet seen any ACPI namespaces that use memory or IRQ
> resources with IPI0001 for testing. (I have a huge collection of
> DSDTs from my OpenBSD work).    

Here are a couple for your collection :-)  These are from HP Itanium
boxes.  (Is that collection publicly available, by the way?)

These both use IRQ and MEM descriptors.

But they don't have _IFT or _SRV objects.  They do have "TYPE"
and "SPEC" methods.  These are essentially the same, but they
came from an internal HP document that looks like it eventually
got incorporated into the IPMI spec (with the names being
changed along the way).

Bjorn
