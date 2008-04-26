From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 50/54] ISAPNP: fold isapnp_read_resources() back into
 isapnp_get_resources()
Date: Sun, 27 Apr 2008 01:07:23 +0200
Message-ID: <4813B5AB.4060308@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183934.516655076@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:59377 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYDZXHS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 19:07:18 -0400
In-Reply-To: <20080425183934.516655076@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 25-04-08 20:38, Bjorn Helgaas wrote:

> +	for (i = 0; i < ISAPNP_MAX_MEM; i++) {
> +		ret = isapnp_read_word(ISAPNP_CFG_MEM + (i << 3)) << 8;
> +		if (!ret)
> +			continue;
> +		pnp_res = pnp_add_mem_resource(dev, ret, ret, 0);
> +		if (pnp_res)
> +			pnp_res->index = i;
> +	}
> +	for (i = 0; i < ISAPNP_MAX_IRQ; i++) {
> +		ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (i << 1)) >>
> +		     8);

Truly trivial, but if you kill the useless outer (), it fits on one line...

Rene
