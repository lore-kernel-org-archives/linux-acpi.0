From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Fri, 13 Apr 2007 11:44:31 -0600
Message-ID: <200704131144.32051.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org> <20070225215922.GA28931@lists.us.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:60975 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbXDMRom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Apr 2007 13:44:42 -0400
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan_Hargrave@dell.com
Cc: Matt_Domsch@dell.com, minyard@acm.org, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Monday 26 February 2007 11:30, Jordan_Hargrave@dell.com wrote:
>   Here is the patch (RHEL5 base code) I've been testing that detects the ACPI namespace object.
> The IPI0001 device doesn't contain the register spacing directly; it has a _CRS resource object that
> (for KCS) has two I/O port entries.  I save the first port in io.addr_data, then calculate the register spacing based on subtracting the 2nd port address and the 1st.

Whatever happened with this patch?  I think we should pursue it, but
I don't see it in -mm.

Bjorn
