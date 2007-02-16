From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Thu, 15 Feb 2007 21:03:54 -0700
Message-ID: <200702152103.54960.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:52785 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423090AbXBPEED (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Feb 2007 23:04:03 -0500
In-Reply-To: <200702102327.28312.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: minyard@mvista.com, Corey Minyard <minyard@acm.org>, linux-acpi@vger.kernel.org

On Saturday 10 February 2007 21:27, Len Brown wrote:
> acpi_find_bmc() appears to be searching for 
> multiple SPMI tables in the RSDT and running
> try_init_acpi() on each of them
> until it doesn't find any more.

I can't remember why we look at the SPMI table(s) rather than
registering a normal ACPI (or even PNP) driver.  Unless we
need to poke the BMC very early, wouldn't it be better to
rely on the device description in the namespace?

Bjorn
