From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 1/5] ACPI: move FADT resource reservations from motherboard driver to osl
Date: Thu, 18 Jan 2007 10:18:19 -0700
Message-ID: <200701181018.20148.bjorn.helgaas@hp.com>
References: <200701161028.10109.bjorn.helgaas@hp.com> <200701161033.34276.bjorn.helgaas@hp.com> <1168999176.26449.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:57469 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbXARRS0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 12:18:26 -0500
In-Reply-To: <1168999176.26449.4.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>

On Tuesday 16 January 2007 18:59, Shaohua Li wrote:
> >  acpi_status acpi_os_initialize1(void)
> >  {
> > +	acpi_reserve_resources();
> This sounds a little earlier. motherboard device usually returns a super
> set of the acpi io ports. reserving acpi io ports first might make some
> motherboard io port isn't reserved as there might be conflict.

That's true; this does reserve the FADT resources earlier, and there
are often conflicts.

I'll try to figure out a way to reserve the FADT resources later.
