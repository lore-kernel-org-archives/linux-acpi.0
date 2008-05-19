From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 1/4] PNP: make pnp_{port,mem,etc}_start(), et al work
 for invalid resources
Date: Tue, 20 May 2008 00:23:02 +0200
Message-ID: <4831FDC6.3090709@keyaccess.nl>
References: <20080515220726.029505668@ldl.fc.hp.com> <20080515220754.366570486@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:49341 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761072AbYESXVV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 May 2008 19:21:21 -0400
In-Reply-To: <20080515220754.366570486@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 16-05-08 00:07, Bjorn Helgaas wrote:

> Some callers use pnp_port_start() and similar functions without
> making sure the resource is valid.  This patch makes us fall
> back to returning the initial values if the resource is not
> valid or not even present.
> 
> This mostly preserves the previous behavior, where we would just
> return the initial values set by pnp_init_resource_table().  The
> original 2.6.25 code didn't range-check the "bar", so it would
> return garbage if the bar exceeded the table size.  This code
> returns sensible values instead.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.

