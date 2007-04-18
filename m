From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Wed, 18 Apr 2007 09:32:47 -0600
Message-ID: <200704180932.48403.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <200704131144.32051.bjorn.helgaas@hp.com> <46254F1D.1050903@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:36776 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbXDRPdH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 11:33:07 -0400
In-Reply-To: <46254F1D.1050903@acm.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jordan_Hargrave@dell.com, Matt_Domsch@dell.com, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Tuesday 17 April 2007 16:50, Corey Minyard wrote:
> Bjorn Helgaas wrote:
> > On Monday 26 February 2007 11:30, Jordan_Hargrave@dell.com wrote:
> >   
> >>   Here is the patch (RHEL5 base code) I've been testing that detects the ACPI namespace object.
> >> The IPI0001 device doesn't contain the register spacing directly; it has a _CRS resource object that
> >> (for KCS) has two I/O port entries.  I save the first port in io.addr_data, then calculate the register spacing based on subtracting the 2nd port address and the 1st.
> >>     
> >
> > Whatever happened with this patch?  I think we should pursue it, but
> > I don't see it in -mm.
> >
> > Bjorn
> >   
> Sorry, I was under the impression that more work was required here
> dealing with the irqs.  Is that not the case?

I think there was a little more work required.  I just didn't want
it to be dropped altogether.
