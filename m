From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 3/5] ACPI video: support _BCL packages that don't export brightness levels when machine is on AC/Battery
Date: Wed, 11 Mar 2009 14:57:45 +0100
Message-ID: <200903111457.47060.trenn@suse.de>
References: <1236672209.2820.121.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54544 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267AbZCKN5u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 09:57:50 -0400
In-Reply-To: <1236672209.2820.121.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 10 March 2009 09:03:29 Zhang Rui wrote:

> +	/*
> +	 * some buggy BIOS don't export the levels
> +	 * when machine is on AC/Battery in _BCL package.
> +	 * In this case, the first two elements in _BCL packages
> +	 * are also supported brightness levels that OS should take care of.
> +	 */
> +	for (i = 2; i < count; i++)
> +		if (br->levels[i] == br->levels[0] ||
> +		    br->levels[i] == br->levels[1])
> +			level_ac_battery++;
Hmm, I wonder whether this is what Len sees on one of his machine.
Do you remember when I added the patches to distinguish native vs
acpi brightness switching?
IIRC you missed some brightness levels with ACPI?
Wasn't this 6 vs 8, ACPI vs native?
Rui's patches should fix this then.
IIRC it was a panasonic.
Hmm both, panasonic and toshiba drivers seem to register for the
backlight interface unconditionally and miss the check whether the
ACPI video driver also might register for that one.
If above is true, I can add the check for them again.

    Thomas
