From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 29/54] PNP: convert resource accessors to use pnp_get_resource(),
 not pnp_resource_table
Date: Sat, 26 Apr 2008 23:42:19 +0200
Message-ID: <4813A1BB.600@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183930.010114245@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:56948 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbYDZVmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 17:42:15 -0400
In-Reply-To: <20080425183930.010114245@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 25-04-08 20:38, Bjorn Helgaas wrote:

> +static inline resource_size_t pnp_port_flags(struct pnp_dev *dev,
> +static inline resource_size_t pnp_mem_flags(struct pnp_dev *dev,
> +static inline resource_size_t pnp_irq_flags(struct pnp_dev *dev,
> +static inline resource_size_t pnp_dma_flags(struct pnp_dev *dev,

These should return unsigned long.

Rene.
