From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: sysfs regression on Supermicro X7DB8+
Date: Thu, 21 Dec 2006 21:10:09 -0700
Message-ID: <200612212110.09190.bjorn.helgaas@hp.com>
References: <200612210341.08394.lenb@kernel.org> <200612211454.04757.lenb@kernel.org> <1166757145.12505.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:52776 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806AbWLVEKR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 23:10:17 -0500
In-Reply-To: <1166757145.12505.78.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 21 December 2006 20:12, Zhang Rui wrote:
> Then I have an idea about the other ones. We can also convert the PNPids
> reserved in the spec to such kind of strings.
> E.g.	"PNP0C0D,PNP0C0C,PNP0C0E"	"button"
> 	"ACPI0003"			"ac_adapter"
> 	"PNP0C0A"			"battery"

I hesitate to hide the PNP IDs altogether.  They seem analogous
to PCI vendor/device IDs.  We expose the PCI IDs directly and
let user-space map them into human-readable strings.  In fact,
the mostly-forgotten lspnp package already has a pnp.ids file
with these mappings.  So I vote for keeping the mapping there.
