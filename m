From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 4/5] ACPI video: support reversed _BCL method
Date: Tue, 10 Mar 2009 17:08:01 +0000
Message-ID: <20090310170801.GB2527@srcf.ucam.org>
References: <1236672211.2820.122.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49489 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbZCJRIH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 13:08:07 -0400
Content-Disposition: inline
In-Reply-To: <1236672211.2820.122.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Tue, Mar 10, 2009 at 04:03:31PM +0800, Zhang Rui wrote:
> +	} else if (max_level != br->levels[count - 1]) {
> +		ACPI_ERROR((AE_INFO,
> +			    "Brightness levels in _BCL is in a mess\n"));
> +		goto out_free_levels;

Again, I don't think failing here is the best thing - I think bizarre 
behaviour is preferable to entirely unworking.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
