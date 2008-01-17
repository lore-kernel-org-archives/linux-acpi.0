From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Thu, 17 Jan 2008 12:28:32 +0000
Message-ID: <20080117122832.GB32133@srcf.ucam.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:38010 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYAQM2u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 07:28:50 -0500
Content-Disposition: inline
In-Reply-To: <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Thu, Jan 17, 2008 at 05:24:50AM -0500, Len Brown wrote:

> +	{
> +	.callback = dmi_enable_osi_linux,
> +	.ident = "Lenovo ThinkPad T61",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> +		},
> +	},
> +

If we add it for specific devices, aren't vendors going to assume that 
future versions of that device will also be able to rely on this 
behaviour? I'm very reluctant to add whitelisting - I suspect it makes 
more sense for us to just be compatible with Windows. My experiments 
with the T61 suggested that it was possible to get everything working 
without this, but I'll need to go back and check what the behaviour 
actually was to be sure.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
