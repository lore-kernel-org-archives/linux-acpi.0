From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: EC driver registration (was: IPMI/ACPI: Locate the IPMI system interface in ACPI namespace)
Date: Tue, 27 Oct 2009 12:14:00 -0600
Message-ID: <200910271214.00839.bjorn.helgaas@hp.com>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com> <200910271105.10056.bjorn.helgaas@hp.com> <4AE73599.5050109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:43690 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548AbZJ0SN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 14:13:57 -0400
In-Reply-To: <4AE73599.5050109@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday 27 October 2009 12:02:01 pm Alexey Starikovskiy wrote:
> Currently EC driver work by doing either ECDT parse or acpi_walk_namespace,
> Do you think it will be appropriate to change it to use PNP layer?

I don't see this.  In acpi_ec_init(), there's an acpi_bus_register_driver().
There's also the ECDT parsing in acpi_ec_ecdt_probe().  There's a comment
near the acpi_ec_ecdt_probe() call that says it must happen before the EC
is found in the namespace.

There is an acpi_walk_namespace() inside acpi_ec_add(), but that's only
to find _Qx methods under an EC device we've already found.

It's conceivable that the EC driver could use PNP registration rather
than ACPI registration -- that would let you get rid of the
acpi_walk_resources() in ec_parse_device().  But I don't know that
it's worth it right now.

For IPMI, we're adding a bunch of new code and there are structural
problems that EC doesn't have.  So IPMI feels more urgent to me.

Bjorn
