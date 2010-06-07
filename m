From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
	detect IPMI system interface
Date: Mon, 7 Jun 2010 13:52:13 +0100
Message-ID: <20100607125213.GA8277@srcf.ucam.org>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com> <1275902842-19895-2-git-send-email-yakui.zhao@intel.com> <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33176 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab0FGMwe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2010 08:52:34 -0400
Content-Disposition: inline
In-Reply-To: <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: minyard@acm.org, lenb@kernel.org, openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

On Mon, Jun 07, 2010 at 05:27:22PM +0800, yakui.zhao@intel.com wrote:

> Use the ACPI detection mechanism firstly to detect the IPMI system interface
> so that we can know which IPMI system interface is detected in ACPI namespace and
> then install the IPMI opregion to enable ACPI to access the BMC controller.
> But the hardcode detection mechanism is still put in the first order.

This is less than ideal. I've seen several machines where the PCI IPMI 
device is the only one to provide interrupts, so using the ACPI one and 
refusing to register the PCI one isn't really an option.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
