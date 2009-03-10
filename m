From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 3/5] ACPI video: support _BCL packages that don't export brightness levels when machine is on AC/Battery
Date: Tue, 10 Mar 2009 17:06:39 +0000
Message-ID: <20090310170639.GA2527@srcf.ucam.org>
References: <1236672209.2820.121.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54078 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbZCJRGr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 13:06:47 -0400
Content-Disposition: inline
In-Reply-To: <1236672209.2820.121.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Tue, Mar 10, 2009 at 04:03:29PM +0800, Zhang Rui wrote:

> +	if (level_ac_battery > 2) {
> +		ACPI_ERROR((AE_INFO, "Two many duplicates in _BCL package\n"));
> +		goto out_free_levels;

Exiting here seems a little excessive? I'd just go with a warning and 
carry on. In future maybe we could strip duplicates. Also, s/two/too/.

>  	/* don't sort the first two brightness levels */
>  	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
>  		acpi_video_cmp_level, NULL);

I think the comment here needs to be clarified - it sounds like you'll 
ignore the first two in the package, even if they're actual values 
rather than the ac and battery ones.

Otherwise:

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
