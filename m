From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Disable ARB_DISABLE on platforms where it is not
	needed
Date: Fri, 22 May 2009 00:53:27 +0100
Message-ID: <20090521235327.GA2064@srcf.ucam.org>
References: <20090521234813.GA11561@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56602 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbZEUXxa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 19:53:30 -0400
Content-Disposition: inline
In-Reply-To: <20090521234813.GA11561@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, May 21, 2009 at 04:48:13PM -0700, Pallipadi, Venkatesh wrote:
> +	/*
> +	 * On all recent platforms, ARB_DISABLE is a nop.
> +	 * So, set bm_control to zero to indicate that ARB_DISABLE
> +	 * is not required while entering C3 type state on
> +	 * P4, Core and beyond CPUs
> +	 */
> +	if (c->x86_vendor == X86_VENDOR_INTEL &&

To me, "All recent platforms" is not quite the same as "All recent Intel 
platforms" :) Is this true of any other vendors? If not, the comment 
could be clarified a little.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
