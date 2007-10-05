From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: driver to support ACPI AML calls to native firmware
Date: Fri, 5 Oct 2007 14:25:40 -0600
Message-ID: <200710051425.41116.bjorn.helgaas@hp.com>
References: <200709201420.24023.bjorn.helgaas@hp.com> <200710051058.55141.bjorn.helgaas@hp.com> <617E1C2C70743745A92448908E030B2A029DAE89@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:51789 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761684AbXJEUZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Oct 2007 16:25:58 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A029DAE89@scsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday 05 October 2007 02:19:17 pm Luck, Tony wrote:
> > Ping!  Tony, can you let me know your plans for this patch?  I'd
> > like to get it into a distro release, and of course, it's best if
> > you accept it first.
> 
> I'll put it in soon.  My only vague concern is whether it should be more
> accessible for other OEMs who want to do the SAL/ACPI sharing thing. But
> I can wait and see whether we get a proliferation of OEM specific
> drivers doing the same kind of thing.  If we do, then we'll look at how
> to merge the common stuff.

OK, thanks.

Bjorn
